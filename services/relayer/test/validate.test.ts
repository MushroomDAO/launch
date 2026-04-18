import { describe, it, expect } from 'vitest'
import { encodeFunctionData, parseAbi, type Address, type Hex } from 'viem'
import { validatePurchaseShape } from '../src/rules/purchaseShape.js'
import { validateRequest } from '../src/pipeline/validate.js'
import type { ChainConfig } from '../src/config.js'
import type { RelayRequest } from '../src/types.js'

const USDC: Address = '0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238'
const SALE: Address = '0x9cA2520D4Fa7e207211Ef5903E7918F06B3faDBA'
const DELEGATE: Address = '0xAirAccountDelegate00000000000000000000001'
const BUYER: Address = '0xBuyer0000000000000000000000000000000001'

const config: ChainConfig = {
  chainId: 11155111,
  saleContract: SALE,
  usdc: USDC,
  entryPoint: '0x0000000071727De22E5E9d8BAf0edAc6f37da032',
  registry: null,
  mpnts: null,
  airAccountDelegate: DELEGATE,
  mushroomCommunity: null,
}

// Build executeBatch callData helper
function buildExecuteBatch(
  approveAmount: bigint,
  usdAmount: bigint,
  paymentToken: Address = USDC,
): Hex {
  const EXECUTE_BATCH_ABI = parseAbi([
    'function executeBatch((address target, uint256 value, bytes data)[] calls)',
  ])
  const APPROVE_ABI = parseAbi(['function approve(address spender, uint256 amount)'])
  const BUY_ABI = parseAbi([
    'function buyTokens(uint256 usdAmount, address paymentToken, uint256 minTokensOut)',
  ])
  return encodeFunctionData({
    abi: EXECUTE_BATCH_ABI,
    functionName: 'executeBatch',
    args: [
      [
        {
          target: USDC,
          value: 0n,
          data: encodeFunctionData({ abi: APPROVE_ABI, functionName: 'approve', args: [SALE, approveAmount] }),
        },
        {
          target: SALE,
          value: 0n,
          data: encodeFunctionData({
            abi: BUY_ABI,
            functionName: 'buyTokens',
            args: [usdAmount, paymentToken, 0n],
          }),
        },
      ],
    ],
  })
}

// ── purchaseShape tests ────────────────────────────────────────────────────

describe('validatePurchaseShape', () => {
  it('accepts valid executeBatch([approve, buyTokens])', () => {
    const callData = buildExecuteBatch(50_000_000n, 50_000_000n)
    const { result } = validatePurchaseShape(callData, config)
    expect(result.ok).toBe(true)
  })

  it('rejects non-executeBatch callData', () => {
    const APPROVE_ABI = parseAbi(['function approve(address spender, uint256 amount)'])
    const badData = encodeFunctionData({ abi: APPROVE_ABI, functionName: 'approve', args: [SALE, 100n] })
    const { result } = validatePurchaseShape(badData, config)
    expect(result.ok).toBe(false)
    expect((result as { ok: false; code: string }).code).toBe('INVALID_SHAPE')
  })

  it('rejects wrong number of calls (1 call)', () => {
    const EXECUTE_BATCH_ABI = parseAbi([
      'function executeBatch((address target, uint256 value, bytes data)[] calls)',
    ])
    const APPROVE_ABI = parseAbi(['function approve(address spender, uint256 amount)'])
    const callData = encodeFunctionData({
      abi: EXECUTE_BATCH_ABI,
      functionName: 'executeBatch',
      args: [
        [
          {
            target: USDC,
            value: 0n,
            data: encodeFunctionData({ abi: APPROVE_ABI, functionName: 'approve', args: [SALE, 100n] }),
          },
        ],
      ],
    })
    const { result } = validatePurchaseShape(callData, config)
    expect(result.ok).toBe(false)
  })

  it('rejects wrong approve target (not USDC)', () => {
    const EXECUTE_BATCH_ABI = parseAbi([
      'function executeBatch((address target, uint256 value, bytes data)[] calls)',
    ])
    const APPROVE_ABI = parseAbi(['function approve(address spender, uint256 amount)'])
    const BUY_ABI = parseAbi([
      'function buyTokens(uint256 usdAmount, address paymentToken, uint256 minTokensOut)',
    ])
    const callData = encodeFunctionData({
      abi: EXECUTE_BATCH_ABI,
      functionName: 'executeBatch',
      args: [
        [
          {
            target: '0x0000000000000000000000000000000000000001' as Address,
            value: 0n,
            data: encodeFunctionData({ abi: APPROVE_ABI, functionName: 'approve', args: [SALE, 100n] }),
          },
          {
            target: SALE,
            value: 0n,
            data: encodeFunctionData({
              abi: BUY_ABI,
              functionName: 'buyTokens',
              args: [100n, USDC, 0n],
            }),
          },
        ],
      ],
    })
    const { result } = validatePurchaseShape(callData, config)
    expect(result.ok).toBe(false)
  })

  it('rejects wrong payment token in buyTokens', () => {
    const callData = buildExecuteBatch(
      50_000_000n,
      50_000_000n,
      '0x0000000000000000000000000000000000000001' as Address,
    )
    const { result } = validatePurchaseShape(callData, config)
    expect(result.ok).toBe(false)
  })

  it('rejects approve amount < usdAmount', () => {
    const callData = buildExecuteBatch(10_000_000n, 50_000_000n) // approve < buy
    const { result } = validatePurchaseShape(callData, config)
    expect(result.ok).toBe(false)
  })
})

// ── validateRequest tests ──────────────────────────────────────────────────

function makeValidRequest(overrides: Partial<RelayRequest> = {}): RelayRequest {
  return {
    authorization: {
      chainId: 11155111,
      contractAddress: DELEGATE,
      nonce: 0,
      r: '0x' + 'a'.repeat(64),
      s: '0x' + 'b'.repeat(64),
      yParity: 0,
    },
    userOp: {
      sender: BUYER,
      nonce: '0x0',
      initCode: '0x',
      callData: buildExecuteBatch(50_000_000n, 50_000_000n),
      accountGasLimits: '0x' + '0'.repeat(64),
      preVerificationGas: '0x5208',
      gasFees: '0x' + '0'.repeat(64),
      paymasterAndData: '0x' + 'ff'.repeat(52),
      signature: '0x' + 'cc'.repeat(65),
    },
    ...overrides,
  }
}

describe('validateRequest', () => {
  it('accepts a valid request', () => {
    const { result } = validateRequest(makeValidRequest(), config, Date.now())
    expect(result.ok).toBe(true)
  })

  it('rejects zero sender', () => {
    const req = makeValidRequest()
    req.userOp.sender = '0x0000000000000000000000000000000000000000'
    const { result } = validateRequest(req, config, Date.now())
    expect(result.ok).toBe(false)
    expect((result as { code: string }).code).toBe('ZERO_BUYER')
  })

  it('rejects wrong chainId', () => {
    const req = makeValidRequest()
    req.authorization.chainId = 1 // mainnet
    const { result } = validateRequest(req, config, Date.now())
    expect(result.ok).toBe(false)
    expect((result as { code: string }).code).toBe('CHAIN_ID_MISMATCH')
  })

  it('rejects missing paymasterAndData', () => {
    const req = makeValidRequest()
    req.userOp.paymasterAndData = '0x'
    const { result } = validateRequest(req, config, Date.now())
    expect(result.ok).toBe(false)
  })

  it('populates purchase.buyer from userOp.sender', () => {
    const { purchase } = validateRequest(makeValidRequest(), config, Date.now())
    expect(purchase?.buyer.toLowerCase()).toBe(BUYER.toLowerCase())
  })
})
