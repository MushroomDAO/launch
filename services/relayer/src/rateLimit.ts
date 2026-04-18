/**
 * Rate limiting via Cloudflare KV.
 * Keys: "rl:addr:{address}:{windowEpoch}"  → count (per-address)
 *       "rl:global:{windowEpoch}"           → count (global)
 *
 * TTL = 3600s (auto-expires each window).
 */

import type { Env } from './types.js'
import type { Address } from 'viem'

function windowEpoch(): number {
  return Math.floor(Date.now() / 3_600_000) // 1-hour window
}

export async function checkRateLimit(
  buyer: Address,
  env: Env,
): Promise<{ allowed: boolean; reason?: string }> {
  const epoch = windowEpoch()
  const addrKey = `rl:addr:${buyer.toLowerCase()}:${epoch}`
  const globalKey = `rl:global:${epoch}`

  const maxPerAddr = parseInt(env.RATE_LIMIT_PER_ADDRESS_PER_HOUR, 10)
  const maxGlobal = parseInt(env.RATE_LIMIT_GLOBAL_PER_HOUR, 10)

  const [addrCountStr, globalCountStr] = await Promise.all([
    env.RATE_LIMIT_KV.get(addrKey),
    env.RATE_LIMIT_KV.get(globalKey),
  ])

  const addrCount = addrCountStr ? parseInt(addrCountStr, 10) : 0
  const globalCount = globalCountStr ? parseInt(globalCountStr, 10) : 0

  if (addrCount >= maxPerAddr) {
    return { allowed: false, reason: `Address rate limit: ${maxPerAddr}/hour exceeded` }
  }
  if (globalCount >= maxGlobal) {
    return { allowed: false, reason: `Global rate limit: ${maxGlobal}/hour exceeded` }
  }

  // Increment both counters (TTL = 3600s)
  await Promise.all([
    env.RATE_LIMIT_KV.put(addrKey, String(addrCount + 1), { expirationTtl: 3600 }),
    env.RATE_LIMIT_KV.put(globalKey, String(globalCount + 1), { expirationTtl: 3600 }),
  ])

  return { allowed: true }
}
