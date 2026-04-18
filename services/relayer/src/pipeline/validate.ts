/**
 * Pipeline step 1: validate the relay request structure and basic fields.
 * No on-chain calls — pure local checks.
 */

import type { RelayRequest, ValidationResult } from '../types.js'
import type { ChainConfig } from '../config.js'
import { validatePurchaseShape } from '../rules/purchaseShape.js'
import { MIN_PURCHASE_USD } from '../config.js'
import type { PurchaseCallData } from '../types.js'

export function validateRequest(
  req: RelayRequest,
  config: ChainConfig,
  nowMs: number,
): { result: ValidationResult; purchase?: PurchaseCallData } {
  const { authorization: auth, userOp } = req

  // 1. buyer address must be non-zero
  if (!userOp.sender || userOp.sender === '0x0000000000000000000000000000000000000000') {
    return { result: { ok: false, error: 'userOp.sender is zero address', code: 'ZERO_BUYER' } }
  }

  // 2. chainId must match
  if (auth.chainId !== config.chainId) {
    return {
      result: {
        ok: false,
        error: `authorization chainId ${auth.chainId} !== expected ${config.chainId}`,
        code: 'CHAIN_ID_MISMATCH',
      },
    }
  }

  // 3. authorization contractAddress must be AirAccountDelegate.
  // Guard is skipped when airAccountDelegate is not yet deployed (INFRA_NOT_READY phase).
  // In that phase, steps A-C in build.ts are also skipped, so the authorization is a no-op.
  if (
    config.airAccountDelegate &&
    auth.contractAddress.toLowerCase() !== config.airAccountDelegate.toLowerCase()
  ) {
    return {
      result: {
        ok: false,
        error: `authorization must delegate to AirAccountDelegate (${config.airAccountDelegate})`,
        code: 'INVALID_SHAPE',
      },
    }
  }

  // 4. paymasterAndData must reference our operator (future: validate SuperPaymaster address)
  if (!userOp.paymasterAndData || userOp.paymasterAndData === '0x') {
    return {
      result: { ok: false, error: 'userOp has no paymasterAndData (must use SuperPaymaster)', code: 'INVALID_SHAPE' },
    }
  }

  // 5. callData shape: executeBatch([approve, buyTokens])
  const shapeCheck = validatePurchaseShape(userOp.callData, config, userOp.sender)
  if (!shapeCheck.result.ok) return shapeCheck

  const purchase = shapeCheck.purchase!

  // 6. minimum purchase amount
  if (purchase.usdAmount < MIN_PURCHASE_USD) {
    return {
      result: {
        ok: false,
        error: `Purchase amount ${purchase.usdAmount} is below minimum ${MIN_PURCHASE_USD} (6-dec USDC)`,
        code: 'INVALID_SHAPE',
      },
    }
  }

  return { result: { ok: true }, purchase }
}
