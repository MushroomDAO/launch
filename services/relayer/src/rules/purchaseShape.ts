/**
 * Validates that the UserOp callData has the expected shape:
 *   executeBatch([
 *     USDC.approve(SaleContract, amount),
 *     SaleContract.buyTokens(usdAmount, USDC, minTokensOut)
 *   ])
 *
 * This is the shape rule: the relayer ONLY sponsors this specific operation.
 * Future: generalize to a plugin-based rule system for bundler evolution.
 */

import {
  decodeFunctionData,
  decodeAbiParameters,
  parseAbi,
  type Address,
  type Hex,
} from 'viem'
import type { PurchaseCallData, ValidationResult } from '../types.js'
import type { ChainConfig } from '../config.js'

// AirAccountDelegate.executeBatch(Call[] calls)
// Call = { target: address, value: uint256, data: bytes }
const EXECUTE_BATCH_ABI = parseAbi([
  'function executeBatch((address target, uint256 value, bytes data)[] calls)',
])

// ERC20.approve(spender, amount)
const APPROVE_ABI = parseAbi(['function approve(address spender, uint256 amount)'])

// SaleContract.buyTokens(usdAmount, paymentToken, minTokensOut)
const BUY_TOKENS_ABI = parseAbi([
  'function buyTokens(uint256 usdAmount, address paymentToken, uint256 minTokensOut)',
])

export function validatePurchaseShape(
  callData: Hex,
  config: ChainConfig,
  sender: Address,
): { result: ValidationResult; purchase?: PurchaseCallData } {
  // 1. Must be executeBatch
  let calls: readonly { target: Address; value: bigint; data: Hex }[]
  try {
    const decoded = decodeFunctionData({
      abi: EXECUTE_BATCH_ABI,
      data: callData,
    })
    calls = decoded.args[0] as typeof calls
  } catch {
    return {
      result: { ok: false, error: 'callData must be executeBatch', code: 'INVALID_SHAPE' },
    }
  }

  // 2. Must have exactly 2 calls
  if (calls.length !== 2) {
    return {
      result: {
        ok: false,
        error: `executeBatch must have exactly 2 calls (approve + buyTokens), got ${calls.length}`,
        code: 'INVALID_SHAPE',
      },
    }
  }

  const [approveCall, buyCall] = calls as [typeof calls[0], typeof calls[0]]

  // 3. First call: USDC.approve(SaleContract, amount)
  if (approveCall.target.toLowerCase() !== config.usdc.toLowerCase()) {
    return {
      result: {
        ok: false,
        error: `First call target must be USDC (${config.usdc}), got ${approveCall.target}`,
        code: 'INVALID_SHAPE',
      },
    }
  }
  if (approveCall.value !== 0n) {
    return {
      result: { ok: false, error: 'approve call must have value=0', code: 'INVALID_SHAPE' },
    }
  }
  let approveSpender: Address
  let approveAmount: bigint
  try {
    const decoded = decodeFunctionData({ abi: APPROVE_ABI, data: approveCall.data })
    approveSpender = decoded.args[0] as Address
    approveAmount = decoded.args[1] as bigint
  } catch {
    return {
      result: { ok: false, error: 'First call data is not approve()', code: 'INVALID_SHAPE' },
    }
  }
  if (approveSpender.toLowerCase() !== config.saleContract.toLowerCase()) {
    return {
      result: {
        ok: false,
        error: `approve spender must be SaleContract (${config.saleContract})`,
        code: 'INVALID_SHAPE',
      },
    }
  }

  // 4. Second call: SaleContract.buyTokens(usdAmount, USDC, minTokensOut)
  if (buyCall.target.toLowerCase() !== config.saleContract.toLowerCase()) {
    return {
      result: {
        ok: false,
        error: `Second call target must be SaleContract (${config.saleContract})`,
        code: 'INVALID_SHAPE',
      },
    }
  }
  if (buyCall.value !== 0n) {
    return {
      result: { ok: false, error: 'buyTokens call must have value=0', code: 'INVALID_SHAPE' },
    }
  }
  let usdAmount: bigint
  let paymentToken: Address
  let minTokensOut: bigint
  try {
    const decoded = decodeFunctionData({ abi: BUY_TOKENS_ABI, data: buyCall.data })
    usdAmount = decoded.args[0] as bigint
    paymentToken = decoded.args[1] as Address
    minTokensOut = decoded.args[2] as bigint
  } catch {
    return {
      result: { ok: false, error: 'Second call data is not buyTokens()', code: 'INVALID_SHAPE' },
    }
  }
  if (paymentToken.toLowerCase() !== config.usdc.toLowerCase()) {
    return {
      result: {
        ok: false,
        error: `buyTokens paymentToken must be USDC (${config.usdc})`,
        code: 'INVALID_SHAPE',
      },
    }
  }

  // 5. approve amount must match usdAmount (allow +1 for rounding)
  if (approveAmount < usdAmount) {
    return {
      result: {
        ok: false,
        error: `approve amount (${approveAmount}) < buyTokens amount (${usdAmount})`,
        code: 'INVALID_SHAPE',
      },
    }
  }

  return {
    result: { ok: true },
    purchase: {
      usdAmount,
      minTokensOut,
      buyer: sender,
    },
  }
}
