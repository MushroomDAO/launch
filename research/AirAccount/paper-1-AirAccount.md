# Paper 1: A Semi-Custodial Smart Account Framework (v3)

**Title**: `AirAccount: A Semi-Custodial Smart Account Framework Leveraging TEE and Community-Driven Services for Enhanced Usability and Security`

**Authors**: Huifeng Jiao¹, Dr. Nathapon Udomlertsakul¹ and Dr. Anukul Tamprasirt¹, AAStar Team ¹International College of Digital Innovation, Chiang Mai University, Chiang Mai, 50200, Thailand E-mail: huifeng_jiao@cmu.ac.th, nathapon.u@icdi.cmu.ac.th, anukul@innova.or.th, hi@aastar.io

**Keywords**: Account Abstraction, ERC-4337, Smart Contract Wallet, Trusted Execution Environment (TEE), Blockchain Usability, Key Management, Human-Computer Interaction (HCI), Standardized Decentralized Service System (SDSS)

---

### **Abstract**
The management of over 3 trillion in digital assets on blockchains fundamentally relies on cryptographic accounts secured mostly by self-custodied private keys. However, from Human-Computer Interaction (HCI) and Technology Acceptance Model (TAM) perspectives, this paradigm presents significant usability and security challenges—including irrecoverable loss from lost keys, steep technical learning curves, vulnerability to operational errors, and a suboptimal user experience—thereby hindering mass adoption. This research introduces AirAccount, a novel crypto account framework designed to provide a secure, user-friendly, and cost-effective alternative. Leveraging the programmability of ERC-4337 Account Abstraction, AirAccount innovatively combines Trusted Execution Environment (TEE) technology with a community-driven Standardized Decentralized Service System (SDSS) architecture. This synergistic approach actualizes a **separation of concerns**, where user **intent** is verified via a simple Passkey signature, while automated **security execution** is enforced by a TEE co-signer. This semi-custody model grants users ultimate control while offloading the complexities of key management and transaction security, paving the way for safer, more intuitive interaction with decentralized applications.

---

### **1. Introduction**
1.1. **Problem Motivation**: The adoption of blockchain technology is significantly hampered by the user experience of its fundamental component: the cryptographic account. From the perspectives of Human-Computer Interaction (HCI) and the Technology Acceptance Model (TAM), existing self-custody models (like Externally Owned Accounts, EOAs) present major hurdles: the catastrophic risk of irrecoverable asset loss from lost keys, a steep technical learning curve for non-expert users, and a high cognitive load for transaction security, which often leads to operational errors and theft.
1.2. **Research Objectives**: This research aims to design, build, and evaluate a novel crypto account framework, named AirAccount. The primary objectives are to: (1) Enhance usability to the level of modern Web2 applications; (2) Strengthen security beyond traditional self-custody models by automating threat prevention; and (3) Ensure the supporting infrastructure is decentralized and censorship-resistant.
1.3. **Core Contribution**: The core contribution of this work is a new design paradigm for smart accounts: **"separating user intent from security execution."** AirAccount realizes this by employing a dual-verification mechanism. A user's intent is captured via a simple, low-friction Passkey signature (e.g., fingerprint), while a co-signing Trusted Execution Environment (TEE) provides automated, rule-based security enforcement, acting as an invisible, programmatic co-signer.
1.4. **Research Methodology**: We adopt the Design Science Research (DSR) methodology to construct and evaluate the AirAccount framework as an innovative IT artifact designed to solve the identified problems.
1.5. **Paper Structure**: The remainder of this paper is organized as follows: Section 2 reviews related work. Section 3 details the DSR methodology. Section 4 presents the design and architecture of the AirAccount artifact. Section 5 demonstrates its proof-of-concept implementation. Section 6 evaluates the artifact, and Section 7 concludes the paper.

### **2. Literature Review & Related Work**
2.1. **Evolution of Ethereum Accounts**: We trace the progression from EOAs to the programmability enabled by EIP-4337, which standardizes Account Abstraction without requiring consensus-layer changes.
2.2. **Existing Account Abstraction Solutions**: We analyze current AA solutions (e.g., Gnosis Safe, Argent, ZeroDev). While powerful, they often still require users to manage complex key setups or rely on centralized off-chain services, failing to fully solve the usability-decentralization trade-off.
2.3. **Trusted Execution Environments in Blockchain**: We review the application of TEEs for confidential computation and secure key management (e.g., in projects like Oasis Protocol or Phala Network), establishing the precedent for its use in enhancing account security at the individual user level.

### **3. Research Methodology**
3.1. **Design Science Research (DSR) Framework**: This study follows the DSR process model, involving problem identification, objective definition, artifact design and development, demonstration, evaluation, and communication.
3.2. **Artifact Description**: The primary artifact is the **AirAccount framework**. This encompasses its design principles, its hybrid on-chain/off-chain architecture, and its proof-of-concept (PoC) instantiation.

### **4. AirAccount: Artifact Design and Development**
4.1. **Design Principles**:
    - **Principle 1: Separation of Intent and Security**: The user is only responsible for expressing their high-level intent (e.g., "I approve this purchase"). The system is responsible for securely executing it.
    - **Principle 2: Semi-Custody for User Control and Reduced Burden**: Users retain ultimate control of their assets via social recovery (detailed in a subsequent paper). The operational burden of per-transaction risk assessment is offloaded to the TEE.
    - **Principle 3: Community-Driven Decentralization**: The supporting infrastructure (Bundlers, TEE Validators) is designed to be run by a permissionless, Standardized Decentralized Service System (SDSS), ensuring censorship resistance and long-term alignment.
4.2. **System Architecture**:
    The AirAccount framework is a hybrid on-chain/off-chain system designed for modularity and decentralization. The following diagram illustrates the primary components and their relationships.

    ```mermaid
    graph TD
        subgraph User-Facing
            DApp[dApp Example]
        end

        subgraph AAStar SDK
            SDK[NPM Package SDK]
        end

        subgraph Backend Services - SDSS Network
            subgraph AirAccount Service
                AA_Core[Core Account Logic]
                AA_Utils[Utils - e.g., PubKey Storage]
                AA_SDK_Backend[Backend SDK for TEE]
                AA_TEE_Wallet[Hardware Wallet]
            end

            subgraph SuperPaymaster Service
                SP_Relay[SuperRelay]
                SP_Contract[SuperPaymaster Contract Logic]
                SP_Server[Server - e.g., Price Feeds]
            end

            subgraph Passkey + TEE Validators
                NodeA[Node A]
                NodeB[Node B]
                NodeC[Node C]
            end
        end

        subgraph On-Chain Contracts
            AirAccountContract[AirAccount.sol]
            SuperPaymasterContract[SuperPaymaster.sol]
            EntryPoint[EntryPoint.sol]
        end

        DApp --> SDK
        SDK --> AirAccount-Service
        SDK --> SuperPaymaster-Service
        AirAccount-Service --> TEE-Validator-Node
        SuperPaymaster-Service --> SuperPaymasterContract
        TEE-Validator-Node --> EntryPoint
        EntryPoint --> AirAccountContract

        style TEE-Validator-Node fill:#f9f,stroke:#333,stroke-width:2px
    ```

    - **On-Chain Components**:
        - **AirAccount.sol**: The user's primary smart contract wallet. It is a modified version of a standard `SimpleAccount` that implements the core dual-validation logic.
        - **AirAccountFactory.sol**: A factory contract that utilizes the `CREATE2` opcode. This enables counterfactual account deployment, allowing a deterministic address to be generated and funded before the contract is deployed on-chain, thus saving gas and improving the onboarding experience.
        - **AirAccountUtil.sol**: A utility contract that serves as an on-chain registry for the public keys of authorized TEE Validator nodes, among other helper functions.
        - **SuperPaymaster.sol**: An ERC-4337 compliant Paymaster contract designed to sponsor transactions, enabling gasless experiences for the user.
        - **EntryPoint.sol**: The standard singleton contract from ERC-4337 that acts as the central coordinator for all `UserOperations`.

    - **Off-Chain Components (The SDSS Network)**:
        The off-chain services operate within the Standardized Decentralized Service System (SDSS), a network of community-run nodes.
        - **TEE Validator Node**: This is the core of the security model. It's a service running within a Trusted Execution Environment (TEE) that exposes a secure API. Its primary function is to receive a user-signed `UserOperation`, apply a robust security policy (see Section 4.3), and, if all checks pass, co-sign the operation with its TEE-protected private key. The key is generated within and never leaves the enclave.
        - **SuperRelay Service**: A node that acts as an ERC-4337 Bundler, packaging dual-signed `UserOperations` into a transaction and submitting it to the `EntryPoint` on the blockchain.

    - **Interaction Flow (UserOperation Lifecycle)**:
        The end-to-end process for a typical transaction highlights the separation of intent and security. The following sequence diagram details the steps involved.

        ```mermaid
        sequenceDiagram
            participant DApp
            participant User
            participant AirAccount Service
            participant Validator_Nodes as Validator Nodes (>=3)
            participant SuperPaymaster
            participant Blockchain

            User->>DApp: Initiate action (e.g., Buy NFT)
            User->>DApp: 1. Press Fingerprint (signs message)
            DApp->>AirAccount Service: 2. Passkey Sign
            AirAccount Service->>Validator_Nodes: 3. Invoke TEE for co-signature
            Validator_Nodes-->>Validator_Nodes: Multi-node verification (BLS)
            Validator_Nodes->>AirAccount Service: 4. TEE Signature
            AirAccount Service->>SuperPaymaster: 5. Request Gas Sponsorship (with dual-signed UserOp)
            SuperPaymaster->>SuperPaymaster: 6. Verify NFT/Rules, provide Gas Signature
            SuperPaymaster->>Blockchain: 7. Submit UserOperation to EntryPoint
            Blockchain->>Blockchain: 8. EntryPoint verifies transaction
            Blockchain->>Blockchain: 9. Validate and execute transaction on AirAccount contract
        ```

        1.  **Intent**: The user interacts with a dApp, which constructs a `UserOperation`. The user signs the `UserOperation` hash with their device's Passkey (e.g., fingerprint, FaceID), signaling their approval.
        2.  **Validation & Co-Signing**: The dApp sends the `UserOperation` and the user's Passkey signature to a TEE Validator node in the SDSS network. The TEE first verifies the user's signature. It then executes its automated security policy. If the operation is deemed safe, the TEE co-signs the `UserOperation` with its enclave-protected key.
        3.  **Gas Sponsorship**: The dual-signed `UserOperation` is sent to the SuperPaymaster, which verifies it against its own policies (e.g., sponsoring rules for a specific NFT mint) and provides a gas-sponsoring signature.
        4.  **Execution**: The `UserOperation`, now carrying the user's signature, the TEE's signature, and the Paymaster's signature, is submitted to the `EntryPoint` via a Bundler. The `EntryPoint` verifies all signatures and finally executes the transaction by calling the user's `AirAccount.sol` contract.
4.3. **Key Mechanisms**:
    - **User Intent Verification**: Achieved via a Passkey (WebAuthn) signature. This leverages existing, user-friendly biometric or device-based authentication, abstracting away the concept of a "private key" from the user.
    - **Automated Security Enforcement**: The TEE co-signer acts as an automated security guard, enforcing a dynamic, multi-layered policy based on an "Onion Security Model," where security measures scale with transaction risk.
        - **Static Analysis**: Checking the target contract address against community-maintained blacklists and user-managed whitelists.
        - **Dynamic Analysis**: Simulating the transaction to detect malicious outcomes or unintended side-effects, such as re-entrancy attacks or unexpected balance changes.
        - **Policy Enforcement**: Enforcing user-configured policies, such as daily or per-transaction spending limits. These are checked off-chain by the TEE before co-signing and re-verified on-chain by the `AirAccount` contract.
        - **Heuristic Analysis (Future Work)**: Employing simple AI/ML models to detect anomalous behavior that might indicate phishing or social engineering attacks.
        - **Exit Mechanism**: Users retain the ability to opt-out of the TEE-based security by deploying their own validator node, ensuring they are never locked into the semi-custodial model.

### **5. Demonstration: Proof-of-Concept Implementation**
5.1. **Technical Stack**:
    - **Contracts**: Solidity, tested with Foundry.
    - **TEE Validator**: Rust, using the Intel SGX SDK.
    - **Frontend & SDK**: TypeScript, using `viem` to interact with the contracts and TEE service.
    - **Deployment**: Contracts deployed on Sepolia testnet; off-chain services run on a cloud provider.
5.2. **Functionality**: The PoC demonstrates the core user journey:
    - **User Story 1: Onboarding**: A user visits a webpage, registers their Passkey, and an AirAccount address is generated and displayed counterfactually in under 5 seconds.
    - **User Story 2: Gasless Transaction**: The user clicks "Mint NFT." They are prompted for their fingerprint/FaceID. Upon successful authentication, the transaction is executed on-chain without the user needing testnet ETH or seeing a complex wallet pop-up.

### **6. Evaluation**
6.1. **Evaluation Strategy**: The artifact is evaluated against the research objectives using three criteria: security, usability, and performance.
6.2. **Security Evaluation**: We conduct a qualitative threat model analysis, comparing AirAccount's resilience to common attack vectors (phishing, malware, social engineering) against both standard EOAs and multi-sig wallets. We argue that by automating security, AirAccount mitigates risks associated with user error.
6.3. **Usability Evaluation**: We perform a cognitive walkthrough for the onboarding and transaction tasks. We compare the number of steps, decision points, and required technical knowledge against the same tasks using a traditional wallet like MetaMask.
6.4. **Performance Evaluation**: We measure the gas overhead of the dual-validation logic in the `AirAccount` contract and benchmark the end-to-end latency of the TEE co-signing process. The target non-functional requirements are:
    - **Gas Overhead**: The additional gas cost for dual-signature verification in `validateUserOp` should not exceed 30,000 gas units compared to a standard ECDSA verification.
    - **API Latency**: The P95 latency for the end-to-end TEE `validateAndSign` API call must be under 750ms.

### **7. Discussion & Conclusion**
7.1. **Implications**: The "intent-security separation" paradigm offers a new path forward for wallet design that can significantly improve the safety and accessibility of Web3. The semi-custodial model, secured by a TEE, provides a pragmatic balance between user control and ease of use. The SDSS concept further ensures that this enhanced usability does not come at the cost of decentralization.
7.2. **Limitations**: This study's primary limitations are the trust assumption in the TEE hardware manufacturer and the nascent state of the decentralized SDSS network. The evaluation is also based on a PoC and does not include large-scale user studies.
7.3. **Conclusion**: This paper introduced and demonstrated AirAccount, a novel semi-custodial smart account framework. By separating user intent from security execution, AirAccount presents a significant and practical step towards solving the critical usability and security challenges that currently prevent widespread blockchain adoption.

### **8. References**
*(A placeholder for formal citations to be added, including EIP-4337, WebAuthn standards, and related academic work.)*

---

### **Appendix**

#### **A.1. Gas Overhead Analysis**
*Detailed table showing gas costs for `validateUserOp` in AirAccount vs. a standard `SimpleAccount`.*

#### **A.2. TEE Validator API Specification**
- **Endpoint**: `POST /v1/validateAndSign`
- **Description**: Receives a user-signed UserOperation, validates it against security policies, and returns a TEE co-signature if valid.
- **Request Body**:
  ```json
  {
    "userOp": {
      "sender": "0x...",
      "nonce": "0x...",
      "initCode": "0x...",
      "callData": "0x...",
      // ... all UserOp fields
    },
    "userSignature": "0x...", // Signature from the user's Passkey
    "chainId": 8453 // Example: Base Mainnet
  }
  ```
- **Success Response (200 OK)**:
  ```json
  {
    "teeSignature": "0x..."
  }
  ```
- **Error Responses**:
  - `400 Bad Request`: Invalid request body.
  - `401 Unauthorized`: Invalid user signature.
  - `403 Forbidden`: Transaction violates a security policy (e.g., `PolicyViolation_SpendingLimitExceeded`).
    ```json
    { "error": "PolicyViolation", "reason": "SpendingLimitExceeded" }
    ```
  - `500 Internal Server Error`: TEE service internal error.