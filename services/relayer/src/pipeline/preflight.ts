/**
 * Pipeline step 2: on-chain preflight checks.
 * Reads chain state before spending gas on submission.
 */

import { createPublicClient, http, type Address } from 'viem'
import type { ValidationResult, PurchaseCallData } from '../types.js'
import type { ChainConfig } from '../config.js'
import { SALE_CONTRACT_ABI, ERC20_ABI } from '../abis.js'

export async function preflightChecks(
  purchase: PurchaseCallData,
  config: ChainConfig,
  rpcUrl: string,
): Promise<ValidationResult> {
  const client = createPublicClient({ transport: http(rpcUrl) })

  const [inventory, usdcBalance, expectedTokens] = await Promise.all([
    client.readContract({
      address: config.saleContract,
      abi: SALE_CONTRACT_ABI,
      functionName: 'availableInventory',
    }),
    client.readContract({
      address: config.usdc,
      abi: ERC20_ABI,
      functionName: 'balanceOf',
      args: [purchase.buyer],
    }),
    client.readContract({
      address: config.saleContract,
      abi: SALE_CONTRACT_ABI,
      functionName: 'getTokensForUSD',
      args: [purchase.usdAmount],
    }),
  ])

  // User must have enough USDC
  if (usdcBalance < purchase.usdAmount) {
    return {
      ok: false,
      error: `Buyer USDC balance ${usdcBalance} < required ${purchase.usdAmount}`,
      code: 'INSUFFICIENT_USDC',
    }
  }

  // SaleContract must have enough inventory
  if (expectedTokens > inventory) {
    return {
      ok: false,
      error: `Inventory ${inventory} < required ${expectedTokens} for $${purchase.usdAmount / 1_000_000n}`,
      code: 'INSUFFICIENT_INVENTORY',
    }
  }

  return { ok: true }
}
