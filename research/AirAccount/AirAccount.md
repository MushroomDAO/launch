# AirAccount: A Semi-Custody & Recoverable Crypto Account Based on TEE and SDSS

## Title

A Semi-Custody & Recoverable Decentralized Crypto Account Based on TEE and SDSS

## Authors

Huifeng Jiao¹, Dr. Nathapon Udomlertsakul¹ and Dr. Anukul Tamprasirt¹, AAStar
Team ¹International College of Digital Innovation, Chiang Mai University, Chiang
Mai, 50200, Thailand E-mail: huifeng_jiao@cmu.ac.th, nathapon.u@icdi.cmu.ac.th,
anukul@innova.or.th, hi@aastar.io

## Keywords

Account Abstraction, ERC-4337, Smart Contract Wallet, Trusted Execution
Environment (TEE), Blockchain Usability, Key Management, Social Recovery,
Self-Custody, Standardized Decentralized Service System, SDSS

## Abstract

The management of over 3 trillion in digital assets on blockchains fundamentally relies on cryptographic accounts secured mostly by self-custodied private keys. However, from Human-Computer Interaction (HCI) and Technology Acceptance Model (TAM) perspectives, this paradigm presents significant usability and security challenges—including irrecoverable loss from lost keys, steep technical learning curves, vulnerability to operational errors, and a suboptimal user experience—thereby hindering mass adoption. This research introduces AirAccount, a novel crypto account framework designed to provide a secure, user-friendly, and cost-effective alternative essential for blockchain's broader accessibility. Leveraging the programmability of ERC-4337 Account Abstraction, AirAccount innovatively combines Trusted Execution Environment (TEE) technology with a community-driven Standardized Decentralized Service System (SDSS) architecture. This synergistic approach enables enhanced security features such as passkey (e.g., fingerprint) for user intent verification coupled with TEE for automated security enforcement, actualizing a semi-custody model where users retain ultimate control while TEE securely offloads partial key management complexities and risks. Furthermore, AirAccount ensures accounts are "Recoverable" through robust social recovery mechanisms facilitated by the SDSS, which also enhances usability and decentralization through features like social account binding and support for gasless transactions via standardized APIs. AirAccount aims to bridge the gap between complex blockchain technology and everyday users by offering a permissionless, resilient, and accessible account system, paving the way for safer and more intuitive interaction with decentralized applications.

## Introduction

### AirAccount lifecycle interaction flow description:
1. Create
   1. No guardian (need to select and pop up warning)
   2. Default one guardian (need to provide a backup fingerprint when creating, from another finger)
   3. 123：1自己,2亲朋,3社区，通过设置权重配置，满足签名+权重符合则恢复
      1. 例如恢复必须有1，如果丢失1，则需要2（例如两个超过5权重的亲朋）+3（例如5个超过权重3的社区朋友）
      2. 可以设置类别123有多个，在链上存储隐私保护的公钥，用于恢复
2. Query
   1. 查询余额、验证是否拥有SBT等
   2. 查询不同类型恢复流程
3. Transaction
   1. 三种：初始化账户部署交易（有credit的介绍和担保免gas或者先计算不部署挣积分，限量），转账（ETH，ERC20），部署合约和合约交互
4. Filter
   1. auto filter check: some basic checks, like transfer ETH to a contract address without a transfer method
   2. limitation check: some limitation checks, like transfer amount limit from your account settings.
   3. security check: three basic levels
      1. black list from open source community
      2. white list from your account settings
      3. AI model detection
5. Recovery
   1. 发起恢复（自己clone后部署run或者到AirAccount免费页面）
   2. 发email或者转发自己部署的URL来收集恢复签名
   3. 收集完毕后，发起恢复交易（页面不会提示你是否收集完毕，但初始化创建账户会告诉你你是哪个类型的恢复流程）
   4. Re-bind your Email and more credentials with your new account(same address and different private key)
6. Built-in features
   1. Issue points and specify the settlement contract (configurable) 
   2. 

### Development environment
1. Development tools：Cursor+CodeBuddy plugin+ Grok3（web version）
2. Local blockchain environment：Forge(Foundry), Anvil，
3. env config example，public testnet private key
4. Language：Solidity, TypeScript, Rust(Tauri), Go

#### Online deployment environment(test and production):
1. Backend
   1. Cloudflare Workers for edge deployment with global distribution
   2. Vercel if you're using Next.js
   3. Docker for maximum flexibility across any cloud provider
2. CDN
   1. Cloudflare
   2. IPFS
   3. Some pindata service
3. Database
   1. For test, use Bknd and Sqlite file db.
   2. For production, use Postgres and Bknd(or Supabase in Node N3)
4. Frontend
   1. Vercel for demo
   2. IPFS for production with Cloudflare CDN cache
   3. Node N1,2,3
5. Contract
   1. Sepolia/Optimism Sepolia
   2. Optimsm Mainnet/ Base Mainnet
6. RPC
   1. Free quota from Infura/Alchemy/QuickNode
   2. Our own lightclient mode and some paid RPC providers(Alchemy)
7. DevOps
   1.  GitHub actions: auto collect repos and action，auto test and deploy

### 分层安全机制：意愿和安全分离
* TEE如何具体实现“自动化安全执行”：交集
	* 社区维护的白名单
	* 个人行为模式匹配的白名单（可配置，默认日限额+几个常用合约）
	* 钓鱼和可以黑名单（自动补充，社区维护审核上链）
	* AI模型：持续学习，人工审核后喂案例+刻意训练学习的模型进行快速判断
	* 风险行为会会要求再次确认、输入确认和提醒后确认（数额分层）

### SDSS的具体架构、标准化API的定义、社区驱动模式的运作方式，以及它如何确保去中心化和低成本。
	* 独立论文
	* 行为链条和去中心的光谱
	* 

### 社交恢复机制的详细流程和安全性分析。
The ERC-4337 system provides the infrastructure for social recovery through its flexible validation system, but specific recovery mechanisms must be implemented in individual account contracts. The codebase shows examples like SimpleAccount and Simple7702Account, but none implement social recovery - that would be a custom implementation building on these base patterns.
	* 去中心
	* 可配置和默认配置
	* 快速和低成本：社区提供gas+credit+他人可支付（不同reuptation不同待遇）
	* 低损失：日限额+社交恢复+资产在链上+个人数据加密放在IPFS+SBT绑定Reputation

### 成本效益的具体分析和数据支撑。
	* HCI成本分析：当下方案和AirAccount对比
	* 比较优势理论 (Comparative Advantage Theory)
	* 要素禀赋理论 (Factor Endowment Theory / Heckscher-Ohlin Model, H-O Model)

### 与其他ERC-4337解决方案的详细对比，突出AirAccount在安全性、用户体验和去中心化方面的独特优势。
	* 独立分析的repo
	* demo和分析，特点分析
	* 持续维护

