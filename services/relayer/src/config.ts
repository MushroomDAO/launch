import type { Address } from 'viem'
import type { Env } from './types.js'

// Multicall3 — same address across all EVM chains
export const MULTICALL3: Address = '0xcA11bde05977b3631167028862bE2a173976CA11'

// ROLE_ENDUSER keccak256("ENDUSER")
export const ROLE_ENDUSER =
  '0xd4cae3a4d6e5d7e2e0e42e1f01a3a6d826e6e8f3b5d1e7c9f6b2a4e8d0c5f7a2' as const

// Sanity: relayer only sponsors ops up to this USD gas cost
export const MAX_GAS_COST_USD = 5

// Minimum USDC the user must spend (prevent dust spamming)
export const MIN_PURCHASE_USD = 5n * 1_000_000n // $5 in 6-decimal USDC

export function getChainConfig(env: Env) {
  return {
    chainId: parseInt(env.CHAIN_ID, 10),
    saleContract: env.SALE_CONTRACT as Address,
    usdc: env.USDC_ADDRESS as Address,
    entryPoint: env.ENTRY_POINT as Address,
    // Available after SP PR merge + deploy:
    registry: (env.REGISTRY_ADDRESS ?? null) as Address | null,
    mpnts: (env.MPNTS_ADDRESS ?? null) as Address | null,
    airAccountDelegate: (env.AIRACCOUNT_DELEGATE ?? null) as Address | null,
    mushroomCommunity: (env.MUSHROOM_COMMUNITY ?? null) as Address | null,
  }
}

export type ChainConfig = ReturnType<typeof getChainConfig>
