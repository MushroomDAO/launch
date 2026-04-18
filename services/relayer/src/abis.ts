// Minimal ABIs — only functions the relayer calls

export const SALE_CONTRACT_ABI = [
  {
    name: 'buyTokens',
    type: 'function',
    stateMutability: 'nonpayable',
    inputs: [
      { name: 'usdAmount', type: 'uint256' },
      { name: 'paymentToken', type: 'address' },
      { name: 'minTokensOut', type: 'uint256' },
    ],
    outputs: [],
  },
  {
    name: 'availableInventory',
    type: 'function',
    stateMutability: 'view',
    inputs: [],
    outputs: [{ name: '', type: 'uint256' }],
  },
  {
    name: 'getCurrentPriceUSD',
    type: 'function',
    stateMutability: 'view',
    inputs: [],
    outputs: [{ name: '', type: 'uint256' }],
  },
  {
    name: 'getTokensForUSD',
    type: 'function',
    stateMutability: 'view',
    inputs: [{ name: 'usdAmount', type: 'uint256' }],
    outputs: [{ name: '', type: 'uint256' }],
  },
] as const

export const ERC20_ABI = [
  {
    name: 'balanceOf',
    type: 'function',
    stateMutability: 'view',
    inputs: [{ name: 'account', type: 'address' }],
    outputs: [{ name: '', type: 'uint256' }],
  },
  {
    name: 'allowance',
    type: 'function',
    stateMutability: 'view',
    inputs: [
      { name: 'owner', type: 'address' },
      { name: 'spender', type: 'address' },
    ],
    outputs: [{ name: '', type: 'uint256' }],
  },
  {
    name: 'nonces',
    type: 'function',
    stateMutability: 'view',
    inputs: [{ name: 'owner', type: 'address' }],
    outputs: [{ name: '', type: 'uint256' }],
  },
] as const

export const ENTRY_POINT_ABI = [
  {
    name: 'handleOps',
    type: 'function',
    stateMutability: 'nonpayable',
    inputs: [
      {
        name: 'ops',
        type: 'tuple[]',
        components: [
          { name: 'sender', type: 'address' },
          { name: 'nonce', type: 'uint256' },
          { name: 'initCode', type: 'bytes' },
          { name: 'callData', type: 'bytes' },
          { name: 'accountGasLimits', type: 'bytes32' },
          { name: 'preVerificationGas', type: 'uint256' },
          { name: 'gasFees', type: 'bytes32' },
          { name: 'paymasterAndData', type: 'bytes' },
          { name: 'signature', type: 'bytes' },
        ],
      },
      { name: 'beneficiary', type: 'address' },
    ],
    outputs: [],
  },
] as const

// ── Post SP-deploy: Registry + MPNTs ──────────────────────────────────────
// TODO: fill after Registry deployment

export const REGISTRY_ABI = [
  {
    name: 'safeMintForRole',
    type: 'function',
    stateMutability: 'nonpayable',
    inputs: [
      { name: 'roleId', type: 'bytes32' },
      { name: 'user', type: 'address' },
      { name: 'data', type: 'bytes' },
    ],
    outputs: [{ name: 'tokenId', type: 'uint256' }],
  },
] as const

export const XPNTS_ABI = [
  {
    name: 'mint',
    type: 'function',
    stateMutability: 'nonpayable',
    inputs: [
      { name: 'to', type: 'address' },
      { name: 'amount', type: 'uint256' },
    ],
    outputs: [],
  },
] as const

export const AIRACCOUNT_DELEGATE_ABI = [
  {
    name: 'initialize',
    type: 'function',
    stateMutability: 'nonpayable',
    inputs: [
      { name: 'guardians', type: 'address[]' },
      { name: 'dailyLimit', type: 'uint256' },
    ],
    outputs: [],
  },
] as const

// Multicall3 — aggregate3 for batched calls
export const MULTICALL3_ABI = [
  {
    name: 'aggregate3',
    type: 'function',
    stateMutability: 'payable',
    inputs: [
      {
        name: 'calls',
        type: 'tuple[]',
        components: [
          { name: 'target', type: 'address' },
          { name: 'allowFailure', type: 'bool' },
          { name: 'callData', type: 'bytes' },
        ],
      },
    ],
    outputs: [
      {
        name: 'returnData',
        type: 'tuple[]',
        components: [
          { name: 'success', type: 'bool' },
          { name: 'returnData', type: 'bytes' },
        ],
      },
    ],
  },
] as const
