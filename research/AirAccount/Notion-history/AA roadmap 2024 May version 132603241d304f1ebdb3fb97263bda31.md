# AA roadmap 2024 May version

## 背景

在经历了[3074争吵和共识](https://docs.zerodev.app/blog/3074-governance)后，Yoav给出了一个[AA roadmap汇总](https://notes.ethereum.org/@yoav/AA-roadmap-May-2024)，AAStar翻译和解析了此文档，分享给相关研究员和开发者。

## 翻译和解析

*Special thanks to Vitalik and the AA team for feedback and review.特别感谢 Vitalik 和 AA 团队的反馈和审查。*

- [Notes on the Account Abstraction roadmap关于帐户抽象路线图的注释](https://notes.ethereum.org/@yoav/AA-roadmap-May-2024#Notes-on-the-Account-Abstraction-roadmap)
    - [The past: where we started过去：我们开始的地方](https://notes.ethereum.org/@yoav/AA-roadmap-May-2024#The-past-where-we-started)
    - [The present: where we are now现在：我们现在在哪里](https://notes.ethereum.org/@yoav/AA-roadmap-May-2024#The-present-where-we-are-now)
    - [The future: where we are heading未来：我们前进的方向](https://notes.ethereum.org/@yoav/AA-roadmap-May-2024#The-future-where-we-are-heading)
        - [Native AA - a modular roadmapNative AA - 模块化路线图](https://notes.ethereum.org/@yoav/AA-roadmap-May-2024#Native-AA---a-modular-roadmap)
        - [What about L1  L1呢](https://notes.ethereum.org/@yoav/AA-roadmap-May-2024#What-about-L1)
        - [How can we assist EOAs in the meantime与此同时，我们如何帮助 EOA](https://notes.ethereum.org/@yoav/AA-roadmap-May-2024#How-can-we-assist-EOAs-in-the-meantime)

---

以上是目录链接，无需解析

## **The past: where we started过去：我们开始的地方**

Three years ago (2021) Vitalik [proposed](https://notes.ethereum.org/@vbuterin/alt_abstraction) a new account-abstraction model and we started brainstorming what later became [ERC-4337](https://eips.ethereum.org/EIPS/eip-4337).三年前（2021 年）Vitalik 提出了一种新的账户抽象模型，我们开始集思广益，后来成为 ERC-4337。

---

一转眼AA都三岁了啊，岁月催人老，不过上面两个链接和内容，从业者应该都耳熟能详才对。

We had set on a [long journey](https://notes.ethereum.org/@vbuterin/account_abstraction_roadmap), with the goal of achieving full AA (abstracting [all](https://notes.ethereum.org/@yoav/erc-4337-vs-eip-3074-false-dichotomy#What-is-Account-Abstraction) aspects of the [account](https://erc4337.mirror.xyz/vYwclVbG6CR1o8DOCWDj8cFVfFSJ07FhWTDgQ5NQROY): authentication, authorization, replay protection, gas payment, execution) without sacrificing decentralization and censorship resistance.我们踏上了漫长的旅程，目标是在不牺牲去中心化特性和抗审查的情况下实现完整的 AA（抽象账户的所有方面：身份验证、授权、重放保护、gas 支付、执行）。

---

第一版Roadmap：

[The road to account abstraction - HackMD](https://notes.ethereum.org/@vbuterin/account_abstraction_roadmap)

看起来里面一些发生了变化，但调整不大，需要对比阅读下。

authentication, authorization, replay protection, gas payment, execution

这几个关键词会对应了AA roadmap的具体feature或者组合。

Yoav的一个概述：

[ERC-4337 vs EIP-3074: False dichotomy - HackMD](https://notes.ethereum.org/@yoav/erc-4337-vs-eip-3074-false-dichotomy#What-is-Account-Abstraction)

Dror的描述（记得后来有一个ppt）：

[What's in an Account](https://erc4337.mirror.xyz/vYwclVbG6CR1o8DOCWDj8cFVfFSJ07FhWTDgQ5NQROY)

The rabbit hole turned out deeper than we anticipated. Censorship resistance required a permissionless mempool, but full AA opens up a lot of DoS vectors that make this a [challenge](https://notes.ethereum.org/@yoav/unified-erc-4337-mempool).兔子洞比我们预想的还要深。审查制度的抵抗需要一个无需许可的内存池，但完整的 AA 会带来大量 DoS 向量，这使得这成为一个挑战。

---

这里面关于无需可的mempool，就是4337中任何人都可以提交交易并汇总的机制，针对bundler的DoS和DDoS攻击，这里有分析：

[Unified ERC-4337 mempool - HackMD](https://notes.ethereum.org/@yoav/unified-erc-4337-mempool)

We quickly realized that we need to separate validation from execution, and then apply certain restrictions during validation. EOA does that naturally and has very strict validation rules (exactly one ECDSA signature check of an unrevocable key, one nonce check, one balance check, no external dependencies). We wanted AA to enable as many use cases as possible while remaining DoS resistant and without resorting to permissioned methods such as whitelisting.我们很快意识到我们需要将验证与执行分开，然后在验证期间应用某些限制。 EOA 自然地做到了这一点，并且具有非常严格的验证规则（对不可撤销密钥进行一次 ECDSA 签名检查、一项随机数检查、一项余额检查，没有外部依赖性）。我们希望 AA 能够启用尽可能多的用例，同时保持 DoS 抵抗力，并且不诉诸白名单等许可方法。

---

遵从类似Layer2的机制，验证者独立于执行者，拆分工作量和职责，控制验证规则。

The process started with figuring out a minimal set of validation rules that prevent cheap DoS. We got there but it was quite restrictive. Then came the harder part - figuring out what exceptions can be made safely, enabling more use cases without introducing DoS vectors. This ultimately resulted in [ERC-7562](https://eips.ethereum.org/EIPS/eip-7562). The rules have been extracted from ERC-4337 in order to enable AA use cases that don’t use the mempool (e.g. intents) and to support native forms of AA that do not use ERC-4337.该过程首先要确定一套最小的验证规则，以防止廉价的 DoS。我们到达了那里，但那里的限制非常严格。接下来是更困难的部分 - 弄清楚可以安全地做出哪些例外，从而在不引入 DoS 向量的情况下启用更多用例。这最终产生了 ERC-7562。这些规则是从 ERC-4337 中提取的，以便启用不使用内存池（例如意图）的 AA 用例，并支持不使用 ERC-4337 的 AA 的本机形式。

---

## **The present: where we are now现在：我们现在在哪里**

ERC-4337 launched on all major EVM networks in March 2023 and has been gaining [traction](https://www.bundlebear.com/overview/all) among users and developers. At the time of this writing 4.1M accounts have been deployed and 18.2M UserOps have been sent, and there’s a thriving ecosystem of [projects](https://github.com/4337Mafia/awesome-account-abstraction) built on ERC-4337…ERC-4337 于 2023 年 3 月在所有主要 EVM 网络上推出，并受到用户和开发人员的关注。截至撰写本文时，已部署 410 万个帐户并发送了 1820 万个 UserOps，并且基于 ERC-4337 构建了一个蓬勃发展的项目生态系统……

The accumulated data revealed some insights on how users use AA. In particular, the vast majority of the UserOps uses paymasters, indicating that our design choice of making gas abstraction a core feature has been the right one.积累的数据揭示了有关用户如何使用 AA 的一些见解。特别是，绝大多数 UserOps 使用 Paymasters，这表明我们将 Gas 抽象作为核心功能的设计选择是正确的。

We recently shipped v0.7 which we hope to be the last breaking change.我们最近发布了 v0.7，我们希望这是最后一个重大更改。

The mempool itself (the p2p network) has [launched](https://twitter.com/etherspot/status/1768717020047020471) on testnet with several bundler implementations participating, but is not live on mainnet yet. Being a multi-client architecture (like Ethereum itself), it requires a lot of interop and stress testing. Bundlers on mainnets are currently operating as private mempools but that will change soon, as the mempool goes live.mempool 本身（p2p 网络）已在测试网上启动，并有多个捆绑器实现参与，但尚未在主网上上线。作为一个多客户端架构（就像以太坊本身一样），它需要大量的互操作和压力测试。主网上的捆绑器目前作为私有内存池运行，但随着内存池上线，这种情况很快就会改变。

Over the past couple of years we discovered that there is demand for an enshrined protocol-level version of ERC-4337. Some L2 networks (e.g. [zksync’s native AA](https://docs.zksync.io/build/developer-reference/account-abstraction.html#design)) implemented their own versions of it. This caused inevitable wallet fragmentation, where some wallets only work on certain networks. We realized that certain things need to be standardized across L2 chains - beyond just AA, and started the RIP (Rollup Improvement Proposals, aka RollCall) process to facilitate this. Since then we’ve been working on [RIP-7560](https://github.com/ethereum/RIPs/blob/master/RIPS/rip-7560.md), a native version of ERC-4337 for L2 chains.在过去几年中，我们发现存在对 ERC-4337 协议级版本的需求。一些 L2 网络（例如 zksync 的原生 AA）实现了自己的版本。这不可避免地导致钱包碎片化，一些钱包只能在某些网络上运行。我们意识到 L2 链中的某些事情需要标准化 - 不仅仅是 AA，并启动了 RIP（Rollup Improvement Proposals，又名 RollCall）流程来促进这一点。从那时起，我们一直致力于 RIP-7560，这是 L2 链的 ERC-4337 的原生版本。

## **The future: where we are heading未来：我们前进的方向**

### **Native AA - a modular roadmapNative AA - 模块化路线图**

Our current focus is a set of RIPs to help L2 chains migrate to native AA. RIP-7560 started as a monolithic RIP but it won’t stay that way. We’ve been [stripping](https://github.com/eth-infinitism/RIPs/pull/4/files) it down to its bare minimum usable form, moving parts of it to separate optional RIPs. The PRs are still early [drafts](https://github.com/eth-infinitism/RIPs/pulls) but will be published as RIPs in the near future.我们当前的重点是一组 RIP，以帮助 L2 链迁移到本机 AA。 RIP-7560 最初是一个整体 RIP，但它不会一直这样。我们一直在将其剥离到最低限度的可用形式，将其部分移动到单独的可选 RIP。 PR 仍处于早期草案，但将在不久的将来作为 RIP 发布。

Some things that have been moved out:一些已被移出的东西：

- [All validations before any execution](https://github.com/eth-infinitism/RIPs/pull/3/files) - not needed on single-sequencer rollups but highly recommended on decentralized chains to ensure DoS resistance, and mandatory if aggregation is used.
    
    任何执行之前的所有验证 - 单序列器汇总不需要，但强烈建议在去中心化链上进行，以确保 DoS 抵抗力，如果使用聚合，则必须进行验证。
    
- [2D nonces](https://github.com/eth-infinitism/RIPs/pull/5/files) - not mandatory but enables multi-tenant accounts, parallelization and other use cases.
    
    2D nonces - 不是强制性的，但支持多租户帐户、并行化和其他用例。
    
- [Aggregation](https://github.com/eth-infinitism/RIPs/pull/2/files) - enables signature aggregation as well as advanced use cases such as transaction atomicity for intent solvers.
    
    聚合 - 支持签名聚合以及高级用例，例如意图求解器的事务原子性。
    
- [All EOA related extensions](https://github.com/eth-infinitism/RIPs/pull/1/files) - incrementally adding certain AA capabilities to EOA, and ultimately migrating EOA to AA.
    
    所有 EOA 相关扩展 - 逐步向 EOA 添加某些 AA 功能，并最终将 EOA 迁移到 AA。
    
- [Getting rid of the ABI](https://github.com/eth-infinitism/RIPs/pull/6/files) - becomes possible when EOF is included.
    
    当包含 EOF 时，摆脱 ABI 成为可能。
    

L1 core devs, L2 devs, and the entire community are invited to collaborate and provide feedback.邀请 L1 核心开发人员、L2 开发人员和整个社区进行协作并提供反馈。

### **What about L1 L1呢**

The roadmap has been focused on L2 but there is value in [enshrining](https://vitalik.eth.limo/general/2023/09/30/enshrinement.html) AA on Ethereum L1 as well.该路线图主要关注 L2，但在以太坊 L1 上实现 AA 也很有价值。

We expect that this will take longer but it shouldn’t delay L2 adoption. RIP-7560 and the extracted RIPs are compatible with the ERC-4337 account model, so it’ll be possible to deploy the same account on different chains, where some work natively and some use ERC-4337. It is likely that Ethereum L1 will keep using ERC-4337 much longer while L2 chains gradually move to RIP-7560, but users and projects will work the same on both. ERC-4337 and RIP-7560 may live alongside each other for years until the migration is completed.我们预计这将需要更长的时间，但不应延迟 L2 的采用。 RIP-7560 和提取的 RIP 与 ERC-4337 账户模型兼容，因此可以在不同的链上部署相同的账户，其中一些在本机工作，一些使用 ERC-4337。以太坊 L1 可能会继续使用 ERC-4337 更长的时间，而 L2 链则逐渐转向 RIP-7560，但用户和项目在两者上的工作方式是相同的。 ERC-4337 和 RIP-7560 可能会并存多年，直到迁移完成。

One trade off that RIP-7560 had to make, which may not fit L1, is the solidity ABI dependency. Ideally, EIPs should avoid depending on solidity, and this has been mostly the case on L1 (with the exception of the [deposit contract](https://etherscan.io/address/0x00000000219ab540356cbb839cbe05303d7705fa#code) which introduced a solidity dependency to stake the consensus layer). L2 chains don’t try to avoid such dependency, and most of them use [precompiles](https://arbiscan.io/address/0x0000000000000000000000000000000000000064#code)/[predeploys](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000015#code) with an ABI.RIP-7560 必须做出的一项权衡（可能不适合 L1）是对 Solidity ABI 的依赖。理想情况下，EIP 应避免依赖于可靠性，而 L1 上的情况大多如此（存款合约除外，它引入了可靠性依赖来质押共识层）。 L2 链不会尝试避免这种依赖性，并且大多数都使用带有 ABI 的预编译/预部署。

A cleaner way to implement RIP-7560 would be to use EOF, and leave ABIs to a higher abstraction layer (e.g. solidity). However, as we’ve seen above some L2 chains are not going to wait for L1 to include EOF, and wish to enshrine AA sooner. Therefore RIP-7560 currently makes use of an ABI.实现 RIP-7560 的一种更简洁的方法是使用 EOF，并将 ABI 留给更高的抽象层（例如 Solidity）。然而，正如我们在上面看到的，一些 L2 链不会等待 L1 包含 EOF，并希望更快地实现 AA。因此，RIP-7560 目前使用 ABI。

L1 is less likely to make the same trade off, and has a longer time horizon for introducing features like native AA. For L1 there is the [EOF version of RIP-7560](https://github.com/ethereum/EIPs/pull/8516/files) which will make a clean separation between the protocol side and the user-facing side. It’s still work in progress but feedback from EOF devs would be appreciated.L1 不太可能做出同样的权衡，并且有更长的时间范围来引入原生 AA 等功能。对于 L1，有 RIP-7560 的 EOF 版本，它将协议侧和面向用户的侧之间进行清晰的分离。该工作仍在进行中，但我们将不胜感激 EOF 开发人员的反馈。

### **How can we assist EOAs in the meantime与此同时，我们如何帮助 EOA**

There has been demand for adding certain AA capabilities to EOA. While the goal should be full AA rather than [further enshrining EOA](https://ethereum-magicians.org/t/we-should-be-moving-beyond-eoas-not-enshrining-them-even-further-eip-3074-related/6538), the need for features like batching and gas abstraction has been obvious and well demonstrated by recent debates around EIP-3074.人们需要在 EOA 中添加某些 AA 功能。虽然目标应该是完整的 AA，而不是进一步体现 EOA，但对批处理和气体提取等功能的需求是显而易见的，并且最近围绕 EIP-3074 的争论充分证明了这一点。

The roadmap does not ignore this demand, but these features should be added as part of a strategy that leads us to AA rather than making ad-hoc improvements to EOA and introducing future technical debt.路线图并没有忽视这一需求，但这些功能应该作为引导我们实现 AA 的战略的一部分添加，而不是对 EOA 进行临时改进并引入未来的技术债务。

Many AA capabilities become available to EOAs using the same TransactionType4 used by the other RIPs above, via the [EOA extensions RIP](https://github.com/eth-infinitism/RIPs/pull/1/files) that has been extracted from RIP-7560. It has some advantages over the immediate adoption of EIP-3074:通过从 RIP-7560 中提取的 EOA 扩展 RIP，使用与上述其他 RIP 使用的相同 TransactionType4 的 EOA 可以使用许多 AA 功能。与立即采用 EIP-3074 相比，它具有一些优势：

- Consistent with the native AA roadmap. Wallets won’t need to support two standards.
    
    与原生 AA 路线图一致。钱包不需要支持两种标准。
    
- Enables EOAs to use the existing paymasters. The paymaster doesn’t care that the sender is an EOA.
    
    使 EOA 能够使用现有的出纳员。付款人并不关心发件人是 EOA。
    
- Requires less trust than EIP-3074 for most common use cases. Gas abstraction and batching don’t require entrusting a contract with full account access. Therefore no whitelisting required.
    
    对于大多数常见用例，需要的信任度低于 EIP-3074。 Gas 提取和批量处理不需要委托具有完全帐户访问权限的合约。因此不需要白名单。
    
- Enables EOA migration to AA using paymasters (as opposed to [EIP-7377](https://eips.ethereum.org/EIPS/eip-7377)).
    
    使用付款主管（而不是 EIP-7377）启用 EOA 迁移到 AA。
    
- Enables signature aggregation for EOAs (combined with the [aggregation RIP](https://github.com/eth-infinitism/RIPs/pull/2/files)), which could save significant amount of network fees for rollups.
    
    启用 EOA 签名聚合（与聚合 RIP 相结合），这可以节省大量的汇总网络费用。
    
- No need for relays or specially-crafted 4337 invokers. EOAs will use the AA mempool.
    
    无需继电器或特制的 4337 调用器。 EOA 将使用 AA 内存池。
    
- Not introducing further technical debt that will slow us down when we move to quantum-resistant signatures.
    
    当我们转向抗量子签名时，不会引入进一步的技术债务，这会减慢我们的速度。
    

As an intermediate step, this RIP could also be adopted without RIP-7560 so it doesn’t introduce native AA but uses the same transaction type so it is forward-compatible with it. This would include EOAs in the AA roadmap rather than start a parallel improvement path.作为中间步骤，该 RIP 也可以在没有 RIP-7560 的情况下采用，因此它不会引入本机 AA，但使用相同的事务类型，因此与其向前兼容。这会将 EOA 纳入 AA 路线图，而不是启动并行改进路径。