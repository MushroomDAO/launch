/**
 * Pipeline step 3: build the Type-4 (EIP-7702) transaction.
 *
 * The tx includes:
 *   authorizationList: [user's 7702 auth → delegates EOA to AirAccountDelegate]
 *
 *   calldata: Multicall3.aggregate3([
 *     A: Register user as ENDUSER in Registry   (post SP deploy)
 *     B: Mint MPNTs to user for gas             (post SP deploy)
 *     C: Initialize AirAccountDelegate on EOA   (post SP deploy)
 *     D: EntryPoint.handleOps([userOp])          (always)
 *   ])
 *
 * Steps A-C require infra addresses configured in env. Until then, only D runs.
 * Structured as a pipeline stage so future bundler can append more UserOps.
 */

import {
  encodeFunctionData,
  encodeAbiParameters,
  parseAbiParameters,
  type Address,
  type Hex,
} from 'viem'
import type { Authorization, PackedUserOp } from '../types.js'
import type { ChainConfig } from '../config.js'
import {
  REGISTRY_ABI,
  XPNTS_ABI,
  AIRACCOUNT_DELEGATE_ABI,
  ENTRY_POINT_ABI,
  MULTICALL3_ABI,
} from '../abis.js'
import { MULTICALL3, ROLE_ENDUSER } from '../config.js'

interface MulticallItem {
  target: Address
  allowFailure: boolean
  callData: Hex
}

export interface BuiltTx {
  to: Address
  data: Hex
  authorizationList: Authorization[]
}

export function buildTx(
  auth: Authorization,
  userOp: PackedUserOp,
  config: ChainConfig,
  predictedXPNTs: bigint,
  hasSbt: boolean,
): BuiltTx {
  const calls: MulticallItem[] = []

  // ── A: Register ENDUSER SBT ──────────────────────────────────────────────
  if (!hasSbt && config.registry && config.mushroomCommunity) {
    calls.push({
      target: config.registry,
      allowFailure: false,
      callData: encodeFunctionData({
        abi: REGISTRY_ABI,
        functionName: 'safeMintForRole',
        args: [ROLE_ENDUSER as Hex, userOp.sender, encodeEndUserData(config.mushroomCommunity)],
      }),
    })
  }

  // ── B: Mint MPNTs to user ────────────────────────────────────────────────
  if (config.mpnts) {
    calls.push({
      target: config.mpnts,
      allowFailure: false,
      callData: encodeFunctionData({
        abi: XPNTS_ABI,
        functionName: 'mint',
        args: [userOp.sender, predictedXPNTs],
      }),
    })
  }

  // ── C: Initialize AirAccountDelegate (idempotent) ────────────────────────
  // Called on user's address after 7702 delegation activates AirAccountDelegate code.
  // allowFailure=true: reverts harmlessly if already initialized.
  // TODO: confirm initialize() is externally callable (not restricted to self/EP).
  if (config.airAccountDelegate) {
    calls.push({
      target: userOp.sender,
      allowFailure: true,
      callData: encodeFunctionData({
        abi: AIRACCOUNT_DELEGATE_ABI,
        functionName: 'initialize',
        args: [[], 0n],
      }),
    })
  }

  // ── D: handleOps — always present ────────────────────────────────────────
  calls.push({
    target: config.entryPoint,
    allowFailure: false,
    callData: encodeFunctionData({
      abi: ENTRY_POINT_ABI,
      functionName: 'handleOps',
      args: [
        [
          {
            sender: userOp.sender,
            nonce: BigInt(userOp.nonce),
            initCode: userOp.initCode,
            callData: userOp.callData,
            accountGasLimits: userOp.accountGasLimits as `0x${string}`,
            preVerificationGas: BigInt(userOp.preVerificationGas),
            gasFees: userOp.gasFees as `0x${string}`,
            paymasterAndData: userOp.paymasterAndData,
            signature: userOp.signature,
          },
        ],
        // Beneficiary set to zero here; submit.ts replaces with hot wallet address.
        '0x0000000000000000000000000000000000000000' as Address,
      ],
    }),
  })

  return {
    to: MULTICALL3,
    data: encodeFunctionData({
      abi: MULTICALL3_ABI,
      functionName: 'aggregate3',
      args: [calls],
    }),
    authorizationList: [auth],
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────

function encodeEndUserData(communityAddress: Address): Hex {
  // Registry.safeMintForRole expects abi.encode(address community, string ensName, bytes metadata)
  return encodeAbiParameters(
    parseAbiParameters('address, string, bytes'),
    [communityAddress, '', '0x'],
  )
}
