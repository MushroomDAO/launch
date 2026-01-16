# Control Your Assets: A Decentralized Social Recovery Mechanism

**Title**: `A Multi-Layered, Weighted, and Privacy-Preserving Social Recovery System for Decentralized Accounts`

**Keywords**: Social Recovery, Account Abstraction, Zero-Knowledge Proofs (ZKP), Trusted Execution Environment (TEE), Multi-Sig, Collusion Resistance

---

### **Abstract**
*(This section will summarize the problem of existing recovery mechanisms, the proposed multi-layered artifact, and its evaluated advantages in security and privacy.)*
基于 passkey 操作 TEE 节点，使用合约进行验证签名，未来加入 zk proof（需要链上或者基础设施支持）
---

### **1. Introduction**
1.1. **Problem Motivation**: Detail the critical problem of key loss in self-custody wallets. Analyze the security and privacy flaws in existing social recovery solutions, such as single-points-of-failure, susceptibility to collusion, and the public exposure of guardians' identities (privacy risk).
1.2. **Research Objectives**: State the goal: to design, build, and evaluate a novel social recovery mechanism that is flexible, collusion-resistant, and privacy-preserving.
1.3. **Core Contribution**: Introduce the **three-layered, weighted guardian model** (self, social, community). Briefly state that privacy is achieved through ZKP or TEE, and security is enhanced via flexible weight-based thresholds.
1.4. **Research Methodology**: State the use of the Design Science Research (DSR) methodology.
1.5. **Paper Structure**: Outline the paper's sections.

### **2. Literature Review & Related Work**
2.1. **Analysis of Existing Recovery Mechanisms**: In-depth review of recovery solutions from Argent, Loopring, Gnosis Safe, and other smart accounts. Create a comparative table based on criteria like guardian structure, privacy, cost, and security assumptions.
2.2. **Privacy-Enhancing Technologies**: Review the fundamentals of ZK-SNARKs/STARKs and TEEs as they apply to on-chain privacy and verifiable computation.
2.3. **Game Theory in Security**: Briefly touch upon concepts related to collusion and deterrence that inform the mechanism's design.

### **3. Research Methodology**
3.1. **Design Science Research (DSR) Framework**: Detail the DSR process model being followed.
3.2. **Artifact Description**: The artifact is the **Multi-Layered Recovery Mechanism**, including its configuration rules, on-chain contracts, and off-chain privacy components.

### **4. The Recovery Mechanism: Artifact Design and Development**
4.1. **Design Principles**:
    - Principle 1: Layered Trust.
    - Principle 2: Configurable and Weighted Thresholds.
    - Principle 3: Verifiable Anonymity (Privacy of Guardians).
    - Principle 4: Collusion Resistance.
4.2. **System Architecture**:
    - **Guardian Configuration**: How a user defines the three categories of guardians and assigns weights.
    - **Privacy-Preserving Storage**: Detail the chosen method for storing guardian configurations.
        - **Option A (ZK-based)**: Storing a cryptographic commitment (hash) of the configuration on-chain.
        - **Option B (TEE-based)**: Storing encrypted configuration on-chain, with the TEE holding the decryption key.
    - **Recovery Process Flow**: Diagram the steps from initiating a recovery request to collecting signatures and final execution.
4.3. **Key Mechanisms**:
    - **Weighted Signature Aggregation**: The logic within the smart contract for verifying that the collected signatures meet the required weight threshold.
    - **Privacy-Preserving Verification**: How the ZK-Proof or TEE attestation is generated and verified on-chain to prove the validity of guardian signatures without revealing their identities.
    - **Anti-Collusion Measures**: Detail the implementation of time-locks, reputation scores, or other mechanisms designed to deter or prevent guardian collusion.

### **5. Demonstration: Proof-of-Concept Implementation**
5.1. **Technical Stack**: Describe the tools used (e.g., Circom/SnarkJS for ZK, Solidity, etc.).
5.2. **Functionality**: Showcase the implementation of a recovery scenario:
    - A user, having lost their primary key, successfully recovers their account by gathering the required weighted signatures from their social and community guardians.

### **6. Evaluation**
6.1. **Evaluation Strategy**: Define criteria: security (collusion resistance), privacy, and performance (cost).
6.2. **Security Evaluation**:
    - **Game-Theoretic Analysis**: Model different collusion scenarios (e.g., a subset of social guardians colluding) and analyze the cost and difficulty of a successful attack compared to other systems.
6.3. **Privacy Evaluation**: Qualitatively and quantitatively assess the privacy guarantees. What information is leaked on-chain versus other systems?
6.4. **Performance Evaluation**:
    - **Gas Cost**: Measure the on-chain gas cost for setup and recovery.
    - **Computational Overhead**: Measure the off-chain time required for ZK-proof generation, if applicable.

### **7. Discussion**
7.1. **Implications**: Discuss how this flexible and private recovery model can increase user trust and become a new standard for account security.
7.2. **Trade-offs**: Discuss the trade-offs between the ZK-based and TEE-based approaches in terms of trust assumptions, performance, and complexity.
7.3. **Limitations**: Acknowledge any assumptions made in the security model and the limitations of the PoC.

### **8. Conclusion and Future Work**
8.1. **Conclusion**: Summarize the novel recovery mechanism and its evaluated benefits.
8.2. **Future Work**: Suggest future research, such as formal verification of the mechanism, large-scale user studies on guardian selection, and integration with decentralized identity (DID) systems for the community layer.

### **References**
*(Placeholder for all cited works.)*
