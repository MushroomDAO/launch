import type { Hex, Address } from 'viem'

// ── Env bindings (from wrangler.toml + secrets) ────────────────────────────

export interface Env {
  // KV namespace for rate limiting
  RATE_LIMIT_KV: KVNamespace

  // Chain config
  CHAIN_ID: string
  SALE_CONTRACT: string
  USDC_ADDRESS: string
  ENTRY_POINT: string

  // Set after SP PR merge + deploy
  REGISTRY_ADDRESS?: string
  MPNTS_ADDRESS?: string
  AIRACCOUNT_DELEGATE?: string
  MUSHROOM_COMMUNITY?: string

  // Limits
  MAX_GAS_PER_TX_USD: string
  RATE_LIMIT_PER_ADDRESS_PER_HOUR: string
  RATE_LIMIT_GLOBAL_PER_HOUR: string

  // Secrets
  OPERATOR_PK: string
  RPC_URL: string
}

// ── EIP-7702 Authorization (signed by user's EOA) ─────────────────────────

export interface Authorization {
  chainId: number
  contractAddress: Address
  nonce: number
  r: Hex
  s: Hex
  yParity: 0 | 1
}

// ── ERC-4337 PackedUserOperation (v0.7) ───────────────────────────────────

export interface PackedUserOp {
  sender: Address
  nonce: Hex
  initCode: Hex
  callData: Hex
  accountGasLimits: Hex
  preVerificationGas: Hex
  gasFees: Hex
  paymasterAndData: Hex
  signature: Hex
}

// ── POST /relay request body ───────────────────────────────────────────────

export interface RelayRequest {
  /** EIP-7702 authorization signed by the user */
  authorization: Authorization
  /** ERC-4337 UserOperation (must be executeBatch shape) */
  userOp: PackedUserOp
  /** Hint: skip SBT mint if user already has one */
  skipSbt?: boolean
}

// ── Validation result ──────────────────────────────────────────────────────

export type ValidationResult =
  | { ok: true }
  | { ok: false; error: string; code: RelayErrorCode }

export type RelayErrorCode =
  | 'INVALID_SHAPE'
  | 'DEADLINE_EXPIRED'
  | 'CHAIN_ID_MISMATCH'
  | 'ZERO_BUYER'
  | 'INSUFFICIENT_USDC'
  | 'INSUFFICIENT_INVENTORY'
  | 'GAS_ESTIMATE_TOO_HIGH'
  | 'RATE_LIMITED'
  | 'RELAY_FAILED'
  | 'INFRA_NOT_READY'

// ── Relay response ─────────────────────────────────────────────────────────

export interface RelayResponse {
  txHash: Hex
  status: 'submitted'
}

export interface RelayErrorResponse {
  error: string
  code: RelayErrorCode
}

// ── Decoded callData shape we expect inside the UserOp ────────────────────

export interface PurchaseCallData {
  /** USDC amount in USD (6 decimals) */
  usdAmount: bigint
  /** Minimum GTokens to receive */
  minTokensOut: bigint
  buyer: Address
}
