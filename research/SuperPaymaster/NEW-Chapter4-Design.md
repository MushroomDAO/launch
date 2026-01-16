## Chapter 4: System Design: SuperPaymaster

To address the challenges and fulfill the solution requirements identified in Chapter 3, we propose SuperPaymaster, a novel gas payment system. This chapter details the system's design, articulating the core principles and the architectural decisions made to create a user-centric, competitive, and robust artifact. Each design choice is deliberately mapped to the previously established requirements.

### 4.1 Design Principles

To satisfy the solution requirements, the design of SuperPaymaster is guided by four sets of core principles that ensure a holistic approach, balancing usability, decentralization, economic viability, and technical soundness.

- **Human-Centered Design Principles**: To fulfill the requirement for a user-friendly interface, we adopted principles like *Familiar Metaphors* and *Invisible Complexity*.
- **Community Collaboration Principles**: To meet the need for an open and fair market, we integrated principles of *Permissionless Participation* and *Community Token Support*.
- **Economic Design Principles**: To ensure long-term viability and cost-effectiveness, our design relies on *Market-Driven Pricing* and *Aligned Incentives*.
- **Technical Architecture Principles**: To guarantee a robust and maintainable system, we followed principles of *Modular Design* and *Security by Design*.

### 4.2 Quantifiable Objectives and Success Metrics

This section is retained from the original, as it provides an excellent DSR-compliant framework of measurable goals that directly inform the evaluation in Chapter 6.

### 4.3 Core Requirements Table for the SuperPaymaster System

This table is retained as a crucial bridge, summarizing the link between the problems analyzed and the design goals of the system.

### 4.4 System Architecture Overview

SuperPaymaster is an artifact designed upon the ERC-4337 standard to create a competitive and resilient marketplace for gas sponsorship. The architecture, depicted in Figure 8, comprises several key actors and on-chain/off-chain components that work in concert to deliver a seamless gas payment experience. The following sections detail the implementation of each core component, justifying the design choices against the requirements from Chapter 3.

<img src="https://raw.githubusercontent.com/jhfnetboy/MarkDownImg/main/img/202506191105106.png" width="70%" />

*Figure 8: SuperPaymaster System Flow Overview*

### 4.5 Core Architectural Components

#### 4.5.1 Competitive Quoting & Cost Saving Mechanism

To address the requirements for **Economic Efficiency** and **Censorship Resistance**, we designed a competitive quoting mechanism. Instead of a dApp being locked into a single paymaster's pricing, our system allows it to query multiple, independent sponsor nodes for gas sponsorship quotes. The dApp's backend or SDK can then programmatically select the most favorable quote (e.g., lowest cost, highest reputation). This design directly fosters a market-driven pricing environment, preventing monopolistic behavior and driving down costs for the end-user.

#### 4.5.2 Self-Custodial AirAccount Integration

To fulfill the requirements for a **Secure** and **User-Friendly** system, SuperPaymaster is designed to integrate with smart contract wallets like AirAccount. This component leverages device-based biometrics (via Secure Enclave/TEE) as a decentralized second-factor authentication (D2FA). This enhances security beyond traditional private key models while simultaneously improving usability through intuitive actions like fingerprint authorization, directly addressing the high cognitive load identified in our problem analysis.

#### 4.5.3 Open Community Mode & Multi-Token Support

To meet the requirements for **Multi-Token Support** and foster an open, permissionless ecosystem, we designed the Open Community Mode. This component, realized through OpenPNTs (ERC-20 community tokens) and OpenCards (NFT-based gas cards), allows any community to participate in the gas market using its own native token. This design directly empowers communities, reduces asset fragmentation for users, and enhances the system's overall utility and network effect by creating a flexible and inclusive gas payment framework.