进展：1-14

1. 一周内发布beta-1版，内测版在sepolia
    1. 合约封码，测试稳定了，我会再发布一版后稳定，防止有小毛刺 
    2. SDK发布0.17.x版本，+ 基础体验场景页面（Demo），包括用户、社区运营
    3. 
2. 要求1月底之前啊完成optimism链上的发布，完成贝beta-2版。
    1. 增加社区基础工具：MyNFT
    2. 增加GToken销售曲线为社区去中心LaunchPad
    3. 发行NFT/MYSBT
3. 而要求销售曲线和GToken合约绑定，在sepolia这个贝塔一和贝塔二版本，都要完成对应的回归和测试，提供页面入口。
4. 呃，要求给出完整的这个五步走的计划，包括到第三步还是第四步时候要成立啊一个MyceliumDAO。
5. 那对应的五步走计划实际上呃是有一些呃类似于承诺或者里程碑的规划的那这些对应的里程碑和规划也有对应的文档和页面产出。
6. 呃，完成Wamao的topic的PPT的初稿。
    1. MyTask（适配社区服务器）
    2. Snapshot国内版（社区自有服务器，保存所有数据；自动同步链上并提供验证机制）
    3. AirAccount：绑定登录，登录插件
    4. COS72：提供基础流程定义和管理和角色定义（自动NFT，钱包，gas，身份等等）


三个问题：

1. 你是谁？ - 背景：AAStar，一个以太坊开源建设小组，来自于Plancker^的建设小组（AAStar），2024年11月独立运营。
2. 你从哪来？ - 概述：23年4月Zuzalu与Vitalik沟通后，建立的AAStar（账户抽象）的小组，目前定位于赋能社区的基建小组。
3. 你要到哪去？ - 未来：聚焦区块链面临的动机问题，倡导和探索建立Mycelium开放协议，邀请社区参与共建共创。 
2026 Q1:
内部：参考阶段里程碑
外部：开放社区合作，反馈和抽象需求，为社区提供基建




对于一个新的加密项目，定位是加密公共物品，是否最低成本就是基于uniswap发行一个交易对？或者他们有类似luanpad的范例或者合约么？请帮我给出一个luanpad简单调研和适合公共物品的推荐，然后给出一步步实现uniswap冷启动的步骤（操作和技术开发都要），指导我完成冷启动
https://docs.google.com/document/d/1-81sszx8dTGhJvaXiUnGnwgdPxXPHzS6UpnNvqgIhoc/edit?tab=t.0


公共物品启动手册：引导社区所有型加密项目冷启动的战略与技术指南


第一部分：公共物品启动的战略基础

本初始部分旨在为后续所有决策奠定核心原则。它将界定“公共物品”在加密货币领域的含义，并以此定义为框架，评估各种启动策略和代币经济模型，确保项目的根基与其宣称的使命保持一致。

1.1. 加密公共物品：原则与实践

在深入探讨具体的启动策略之前，我们必须首先为“加密公共物品”建立一个清晰且可操作的定义。传统经济学将公共物品定义为具备两大核心特性的事物：非排他性（non-excludable）和非竞争性（non-rivalrous）。非排他性意味着无法阻止任何人使用该物品，而非竞争性则指一个人的使用不会减损他人使用的价值。典型的例子包括清洁的空气或国防安全 1。
当我们将这些原则应用于 Web3 领域时，它们会转化为更具体、更具技术性的表现形式。一个真正的加密公共物品应具备以下特征：
无需许可的访问（Permissionless Access）：任何人，无论其身份、地理位置或财富如何，都应能自由地使用该协议或网络，无需得到任何中心化实体的批准 2。
开源代码（Open-Source Code）：项目的全部代码库都应公开，供任何人审查、复刻和贡献。这不仅是透明度的基石，也是数字时代公共基础设施的重要组成部分，正如开源软件（OSS）为全球经济贡献了数十亿美元的价值一样 1。
去中心化治理（Decentralized Governance）：项目的控制权不应集中在少数创始人或投资者手中，而应随着时间的推移，逐步、可验证地转移给由其代币持有者组成的社区 4。
社区为中心的价值捕获（Community-Centric Value Accrual）：项目产生的价值（例如，协议费用）应主要回流至其生态系统，用于资助持续的开发、奖励贡献者，并最终由社区通过治理来决定其用途，而非被少数内部人士攫取。
对于一个声称自己是公共物品的新加密项目而言，其启动机制的选择，远不止是一个简单的募资策略。它是该项目对其核心原则的首次、也是最关键的“工作量证明”。一个充满排他性、需要许可或偏袒内部人士的启动过程，会立即制造出一种叙事上的矛盾，这种矛盾可能会永久性地损害社区信任——而信任，正是一个公共物品最宝贵的资产。加密社区，尤其是那些被公共物品理念吸引的成员，对项目的真实意图极为敏感。任何“挂羊头卖狗肉”的行为，即口头上宣称公共物品，行动上却追求内部利益最大化，都会被迅速识破，导致项目启动失败，或者只能吸引到纯粹的投机者，而非价值一致的长期共建者 6。因此，评估启动机制的首要标准，必须是其“原则一致性”，而非单纯的财务效率。

1.2. 启动机制比较分析

基于上述公共物品原则，我们对当前主流的代币启动模型进行详细的分解与评估。
首次代币发行（ICO）：这是最早期的模型，项目方直接向公众出售代币。其优点在于团队拥有完全的控制权，且设置过程相对简单快捷。然而，其弊端也同样显著：ICO 模式缺乏第三方监督，导致诈骗风险极高，投资者保护缺失。对于一个新项目，若无大量的市场营销投入，很难从零开始建立信任和初始流动性 8。其中心化的控制模式和对营销的重度依赖，与公共物品的去中心化和开放精神常常背道而驰。
首次交易所发行（IEO）：项目通过中心化交易所（CEX）进行代币销售。IEO 的主要优势在于能够借助交易所的信誉背书和尽职调查，增加项目的可信度，并直接触达交易所庞大的用户基础，从而获得内置的流动性和曝光度。然而，这种模式的代价高昂，不仅包括高昂的上市费用，还意味着项目方将丧失对募资条款和流程的大部分控制权 8。更重要的是，IEO 是一个典型的需要许可的、中心化的过程，投资者必须满足交易所的 KYC 要求并拥有账户才能参与。这种“守门人”模式与公共物品的开放、无门槛原则存在根本性冲突。
首次 DEX 发行（IDO）：IDO 在去中心化交易所（DEX）上进行，通常借助 Launchpad（发射台）平台。相比 IEO，IDO 更强调去中心化、无需许可的访问和即时流动性，这使其在哲学上更贴近公共物品 8。然而，大多数 IDO 发射台本身也扮演了“守门人”的角色。它们会对项目进行筛选，并要求参与者满足特定条件，例如持有并质押发射台自身的原生代币，或通过白名单抽签获得参与资格 12。这虽然比 IEO 更为开放，但仍是一种形式上的“门槛”，未能实现完全的公平与开放。
公平启动 / 直接 DEX 上市（Fair Launch / Direct DEX Listing）：该模式是加密世界理想主义的极致体现，其鼻祖是比特币。在公平启动中，不存在任何预售、私募或内部人/团队的预先分配。所有代幣都从零开始，通过公开、透明的机制（如比特币的挖矿或 Yearn.Finance 的流动性挖矿）分发给所有参与者 7。这种模式在哲学上与公共物品的原则完美契合，因为它确保了从第一天起就实现开放、包容的分配和机会均等 6。然而，其最大的挑战在于“冷启动”问题：在没有初始资金的情况下，如何为 DEX 上的交易对提供初始流动性，这是一个巨大的障碍 6。
社区众筹（Community Crowdfund）：以 Juicebox、Mirror 等平台为代表，这种模式允许项目通过透明的、完全上链的方式直接从社区筹集资金。贡献者通常会获得项目的治理代币或某种形式的“股权”，而无需通过任何中心化的中介机构 17。这种模式在透明度和社区建设方面表现卓越，所有资金的流动和分配规则都由智能合约预先设定并公开执行，极大地增强了信任。
为了更清晰地展示这些模型的优劣，下表从对公共物品至关重要的几个维度进行了对比分析。
表1：加密项目启动机制针对公共物品的比较分析

启动机制
成本与费用
准入公平性 (无需许可 vs. 门槛)
控制权去中心化
信任与透明度
冷启动难度
社区一致性
ICO
低 (技术成本)
较高 (依赖营销触达)
低 (团队完全控制)
非常低 (易发欺诈)
非常高
低
IEO
非常高
非常低 (交易所守门)
非常低 (交易所控制)
中等 (依赖交易所信誉)
低
中等
IDO (Launchpad)
高
低 (平台守门，需质押/白名单)
中等 (平台部分控制)
中等 (依赖平台信誉)
中等
中等
公平启动
非常低 (仅Gas费)
非常高 (完全开放)
非常高 (社区驱动)
非常高 (过程全透明)
非常高
非常高
社区众筹
低 (平台费用低或无)
非常高 (完全开放)
高 (规则由合约定义)
非常高 (资金和规则上链)
高
非常高


1.3. 实现长期可持续性的代币经济学

对于公共物品而言，代币经济学（Tokenomics）的设计并非仅仅为了募资或炒作，它本身就是一份“社会契约”，用代码和规则定义了项目与社区之间的权利、责任和激励关系。一个将大部分代币分配给团队和早期投资者的模型，无论其宣传口号多么响亮，都从根本上违背了公共物品的“社区所有”精神，这是一份从第一天起就已撕毁的社会契约 4。因此，设计必须优先考虑那些能够可验证地将权力和价值随着时间推移转移给社区的机制。
代币分配与分发：公共物品的代币分配应遵循“社区最大化”原则。这意味着要将最大份额的代币（例如，超过50%）分配给由社区控制的财库（Treasury），用于未来的生态系统发展、开发者激励和贡献者奖励 19。对创始团队和早期投资者的分配应保持在最低限度，并采用比简单线性解锁更复杂的、与项目进展挂钩的归属时间表（Vesting Schedule），例如基于关键绩效指标（KPI）的解锁或S曲线解锁，以确保长期利益绑定，而非短期套现离场 20。此外，向早期贡献者、测试用户或相关社区进行空投（Airdrop）也是一种有效的、符合公共物品精神的初始分发方式。
代币供应模型：关于供应模型，存在通胀与通缩两种主要模式 5。通缩模型（如通过燃烧机制减少总供应量）往往会鼓励投机和囤积行为。相比之下，对于一个需要长期、持续维护和发展的公共物品而言，一个温和、可预测的通胀模型可能更为适宜。类似于区块链通过区块奖励来持续激励矿工或验证者维护网络安全，公共物品也可以通过一个小的年通胀率（例如1-5%）来持续地资助核心开发、研究和社区贡献，确保项目的生命力。
代币效用：代币的效用必须有意义，并深度整合到项目的核心功能中 4。对于公共物品，最强大、最核心的效用无疑是
治理。代币应赋予持有者对项目未来方向、财库资金使用等关键决策的投票权 4。这不仅仅是一种象征性的权利，而是将“社区所有”这一抽象概念转化为具体、链上现实的关键。除了治理，其他效用可以包括：用于支付网络内的服务费用、质押以参与网络验证或获得特定权限等。效用的设计目标应是激励那些对项目长期健康发展有益的行为，即参与、贡献和治理，而非纯粹的交易和投机。

第二部分：评估募资平台与制定最优策略

本部分将从理论转向实践，对具体的募资平台进行调研，并基于前文的分析，为您的公共物品项目制定一个清晰、可执行的最优启动策略。

2.1. IDO 发射台概览：一次批判性审视

IDO 发射台作为一种流行的代币发行渠道，吸引了众多项目。我们在此对几个主流平台进行审视，以评估其是否适合公共物品项目。
主流平台及其运作模式：像 DAO Maker、Seedify 和 Red Kite 这样的平台，其核心商业模式是作为项目方和投资者之间的“策展人”和“中介” 12。它们会对申请的项目进行严格筛选，然后将通过筛选的“优质”项目推荐给它们自己的社区 14。投资者若想参与这些项目的早期销售，通常必须购买并质押该发射台的原生代币（如 $DAO, $SFUND, $PKF），根据质押数量的不同，被划分为不同等级，从而获得抽签机会或保证的额度 12。
成本与代价：项目方选择与发射台合作，需要付出的成本是多方面的。这通常包括将募集资金的一部分或项目代币总供应量的一定比例作为平台费用，以及为发射台社区提供具有吸引力的代币折扣 10。这本质上是一种利益交换，项目方用未来的价值换取发射台所提供的初始流动性、营销推广和社区资源。
对公共物品的适用性：经过审慎评估，我们认为 IDO 发射台通常不适合真正的公共物品项目。其根本原因在于，发射台的模式是内在地、结构性地具有排他性的。它构建了一个“付费游戏”（Pay-to-Play）的环境，优先服务于那些持有其平台代币的“内部”投资者，而非广大的公众或项目自身的潜在社区 8。这种模式与公共物品所追求的开放、平等、无需许可的准入原则形成了直接的冲突。

2.2. 公共物品募资工具箱：与理念一致的替代方案

幸运的是，Web3 生态中也涌现出了一批专为透明、社区驱动的募资和协作而设计的工具。这些工具更像是“基础设施”而非“守门人”，与公共物品的理念高度契合。
Gitcoin Grants：Gitcoin 的核心机制是二次方募资（Quadratic Funding, QF），其精髓在于“贡献者的数量比贡献的金额更重要” 1。一个获得100个用户每人1美元捐赠的项目，将比一个只获得1个用户100美元捐赠的项目，从匹配资金池中获得多得多的匹配资金。对于公共物品项目而言，Gitcoin 不应被视为主要的募资渠道，而是一个极其强大的
社区验证和信号工具。成功参与一轮 Gitcoin Grants，意味着项目获得了广泛的、真实的社区支持，这是一个极具说服力的积极信号 28。此外，通过 Gitcoin Passport 机制，项目可以有效抵御女巫攻击（Sybil attacks），确保支持者是真实、独立的用户。
Juicebox 协议：Juicebox 是一个可编程的、完全上链的财库协议 17。任何人都可以为 Juicebox 上的项目贡献 ETH，并按照预先设定的规则自动获得该项目的代币。其最大的特点是
极致的透明度：项目的募资目标、代币分发比例、资金支出限额（Payouts）、赎回机制等所有规则，都预先写在智能合约中，对所有人公开可见且不可随意篡改 30。这使得贡献者信任的是代码逻辑，而非项目团队的口头承诺，非常适合需要建立高度信任的公共物品项目进行初始资金的透明募集 17。
Mirror.xyz：Mirror 将内容发布与众筹功能紧密结合 33。项目方可以通过撰写文章来阐述项目愿景和故事，并在文章中直接嵌入众筹模块。支持者贡献 ETH 后，同样会获得项目发行的 ERC20 代币，从而形成一个围绕共同叙事建立起来的“链上集体” 18。这种模式非常适合那些具有强大叙事能力、希望在启动前就围绕一个共同故事凝聚核心社区的项目 35。
表2：IDO 发射台与公共物品募资平台对比分析

平台
核心功能
成本/费用
准入模式
主要用例
公共物品理念契合度
DAO Maker
策展式代币销售
高 (代币分成+费用)
需质押平台币
为项目进行筛选和募资
低
Seedify
策展式代币销售 (侧重游戏)
高 (代币分成+费用)
需质押平台币
为游戏项目募资和孵化
低
Gitcoin
二次方募资
无 (捐赠驱动)
完全开放
社区验证，获取小额赠款
非常高
Juicebox
可编程链上财库
低 (协议收取少量费用)
完全开放
透明的社区财库和募资
非常高
Mirror
叙事驱动的众筹
低 (平台收取少量费用)
完全开放
围绕内容和故事构建社区
高


2.3. 推荐策略：混合式公平启动 (Hybrid Fair Launch)

综合以上分析，我们为您的公共物品项目推荐一种兼具成本效益、理念契合和可操作性的启动策略：两阶段混合式公平启动。
直接在 Uniswap 上市是成本最低的方式，但如前所述，它面临着严峻的“冷启动”流动性难题 8。纯粹的公平启动在理念上最为契合，但同样受困于此。而 IDO 发射台虽然能解决流动性问题，却以牺牲公平性和开放性为代价。我们的混合式策略旨在吸取各方之长，规避其短。
策略详解：
阶段一：启动前社区引导 (Pre-Launch Community Bootstrap)
在代币公开交易之前，通过 Juicebox 平台发起一个有时间限制、有明确募资上限的透明众筹活动。本次众筹的核心目标并非最大化融资金额，而是实现两个具体目的：
(1) 募集初始流动性：筹集一笔预先设定的、合理的以太坊（ETH）资金（例如 20-50 ETH），这笔资金将专门用于在 Uniswap 上创建初始流动性池。
(2) 分发初始治理权：将项目代币的初始部分，以公平、透明的方式分发给一群真正的信徒和早期支持者，他们将成为社区治理的基石。
阶段二：公开公平启动 (Public Fair Launch)
在 Juicebox 众筹活动结束后，立即将筹集到的全部 ETH 以及与之对应的、按预定比例计算的项目代币，投入到 Uniswap V3 中，创建一个全新的流动性池。这一刻，即是项目的“公平启动”事件。代币正式面向所有公众开放交易，其初始价格完全由市场发现，没有任何内部人享有价格优势 6。
策略优势分析：
这种混合模型巧妙地解决了公平启动的核心困境。它利用一个透明、社区优先的工具（Juicebox）来攻克纯粹公平启动模式难以逾越的“冷启动”流动性障碍，同时又完全避免了 IDO 发射台所带来的门槛、排他性和激励不一致等问题。
更深层次地，这一策略本身就构成了一个强大且极具说服力的项目叙事。项目方并非以一种不透明的方式为自己的“战争基金”向社区索要资金，而是公开、透明地邀请社区与自己共同创建这个市场。社区贡献的每一分钱，都将直接、可验证地投入到“提供一个流动的公开市场”这一公共物品中。这种做法极大地建立和巩固了信任，完美契合了公共物品项目的内在精神。

第三部分：Uniswap 冷启动完整实践手册

本部分是报告的操作核心，旨在提供一份颗粒度极细的、按部就班的指南，以确保您能成功执行前述的“混合式公平启动”策略。

3.1. 阶段一：启动前基础建设 (第1-3个月)

在进行任何募资或代币发行之前，必须完成所有关键的准备工作。这一阶段是项目成功与否的基石。

3.1.1. 技术开发：创建和部署您的 ERC-20 代币

这是所有后续步骤的技术前提。我们将提供一个基于行业最佳实践的详细流程。
环境设置：
安装一个主流的以太坊开发框架，如 Hardhat 或 Foundry。Hardhat 对于初学者更友好，拥有丰富的插件生态 37。
安装 Ganache 用于本地测试，它能快速启动一个本地的以太坊区块链，并提供多个预置了测试 ETH 的账户 37。
安装并设置 MetaMask 浏览器钱包插件，用于与测试网和主网进行交互 37。
编写代币合约：
为了安全和标准化，强烈建议使用 OpenZeppelin 提供的经过严格审计的合约库。直接继承其 ERC20 合约可以避免重复造轮子和引入不必要的安全漏洞 37。
创建一个新的 Solidity 文件（例如 PublicGoodToken.sol），并写入以下基础代码：
Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; // 可选，用于后续的增发管理

/**
 * @title PublicGoodToken
 * @dev 一个基础的、可增发的 ERC-20 代币，用于公共物品项目。
 * 初始供应量将铸造给合约部署者。
 * 只有合约所有者 (owner) 才能调用 mint 函数增发代币。
 */
contract PublicGoodToken is ERC20, Ownable {
    /**
     * @dev 构造函数，在部署时执行一次。
     * @param initialOwner 合约的初始所有者地址。
     */
    constructor(address initialOwner) ERC20("Public Good Token", "PGT") Ownable(initialOwner) {
        // 初始铸造 1,000,000 个代币给合约部署者
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    /**
     * @dev 增发代币函数，只能由合约所有者调用。
     * @param to 接收代币的地址。
     * @param amount 增发的代币数量。
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}


代码解释 38：
import "@openzeppelin/contracts/token/ERC20/ERC20.sol": 导入 OpenZeppelin 标准的 ERC20 合约实现。
import "@openzeppelin/contracts/access/Ownable.sol": 导入所有权管理合约，它提供了一个 onlyOwner 修饰符，确保只有合约所有者能执行特定函数（如 mint）。
constructor(address initialOwner) ERC20("Public Good Token", "PGT") Ownable(initialOwner): 构造函数在部署时设置代币的名称（"Public Good Token"）、符号（"PGT"）以及初始所有者。将所有权设置为一个独立的地址（而非部署者地址）是良好的安全实践。
_mint(msg.sender, 1000000 * 10 ** decimals()): _mint 是一个内部函数，用于创建新代币。这里在部署时为部署者地址铸造了100万个代币。10 ** decimals() 用于处理代币精度，ERC20 代币通常有18位小数。
function mint(...) public onlyOwner: 这是一个公开的增发函数。onlyOwner 修饰符确保了只有合约所有者才能调用它来增发新代币。对于公共物品，增发权限最终应移交给社区DAO。如果项目计划采用固定供应量，则可以移除 Ownable 和 mint 函数。
编译与部署：
使用 Hardhat 或 Remix IDE 编译合约。确保编译器版本与代码中 pragma 指令指定的版本兼容 40。
编写一个部署脚本（在 Hardhat 中通常放在 scripts 目录下），用于将合约部署到测试网（如 Sepolia）进行全面测试 38。
通过 MetaMask 连接到 Sepolia 测试网，并使用从水龙头获取的测试 ETH 支付部署所需的 Gas 费用 39。

3.1.2. 安全协议：智能合约审计指南

对于任何旨在建立长期信任的项目，尤其是公共物品，智能合约审计都是一项不可协商的强制性步骤。一份公开的、由信誉良好的公司出具的审计报告是建立社区信心的基石 41。
审计流程 41：
准备阶段：向审计公司提供完整的项目文档，包括白皮书、技术架构图、代码库以及所有外部依赖项的说明。文档越清晰，审计效率越高 43。
自动化分析：审计员会使用 Slither、MythX 等静态分析工具对代码进行初步扫描，以发现常见的漏洞模式 41。
手动审查：这是审计的核心。经验丰富的审计员会逐行审查代码逻辑，寻找自动化工具无法发现的业务逻辑漏洞、重入攻击风险、整数溢出等问题 42。
测试与验证：审计团队会编写并运行单元测试、集成测试和模糊测试，以验证合约在各种极端情况下的行为 41。
出具报告：审计结束后，审计公司会提供一份详细的报告，其中列出了所有发现的漏洞（按严重性分类：严重、主要、次要、信息性），并提供修复建议。项目方修复问题后，审计公司会出具最终报告 42。
审计准备清单 44：
完备的文档：提供清晰的 NatSpec 格式的函数注释。
整洁的代码：遵循 Solidity 官方风格指南，保持代码模块化和可读性。
高测试覆盖率：单元测试覆盖率应至少达到90%以上。
公开审计报告：在项目网站和社区渠道显著位置公布最终的审计报告，这是建立透明度的关键一步 46。

3.1.3. 社区架构：构建您的数字城市广场

在代码开发的同时，必须开始构建社区。对于公共物品，社区不仅是用户，更是未来的所有者和治理者。
战略与叙事：首先要有一个清晰、引人入胜的故事。人们追随的是一个明确的目标和愿景，而不仅仅是技术特性 47。您的“为什么”远比“是什么”更重要。
平台选择：
Discord：用于结构化的、深入的讨论。可以创建不同的频道，如#announcements, #general, #development, #governance-proposals 等，适合开发者和核心贡献者 47。
Telegram：用于快速、广泛的互动和信息传播。更适合日常交流和保持社区活跃度 47。
X (Twitter)：用于对外发布重要更新、合作伙伴关系和吸引新成员 47。
初期增长与互动：
质量优先：初期追求一个虽小但活跃的核心群体，远胜于一个庞大而沉寂的群体 47。
内容为王：持续分享高质量、有价值的内容，如项目进展更新、技术原理解释、行业见解等，而非单纯的广告或炒作信息 48。
积极参与：在其他相关的、价值一致的社区中建立声誉，真诚地参与讨论，在获得认可后，再适时介绍自己的项目 47。
激励互动：定期举办 AMA（问答会）、投票、小规模竞赛等活动。大力鼓励并奖励社区生成的内容（UGC），如表情包、教程文章、解说视频等，这能极大地培养社区成员的归属感和主人翁意识 49。

3.1.4. 基础文档：打造透明的白皮书和项目网站

白皮书：这是项目的“宪法”。一份优秀的白皮书应包含以下部分 52：
摘要/简介：清晰地阐述项目要解决的问题、提出的解决方案及其独特性。
技术架构：详细说明项目的技术实现，包括所使用的区块链、共识机制、智能合约设计等。
代币经济学：这是对公共物品项目最重要的部分。必须极其详尽和透明地说明代币的总量、分配方案、归属时间表、效用（特别是治理）和价值捕获机制 53。
路线图：提供一个清晰、现实的开发和发展里程碑。
团队介绍：公开团队核心成员的背景和经验，附上可验证的链接（如 LinkedIn），以建立信任。
法律与风险声明：明确相关的法律合规性考虑和投资风险。
项目网站：这是项目的“门面”，应专业、清晰、安全。
核心要素 55：
清晰的价值主张：在首页用一句话说清楚项目是做什么的。
用户友好的导航：包含“关于我们”、“产品/技术”、“代币经济学”、“路线图”、“社区”、“文档”等关键部分。
安全信任标志：在显著位置展示 SSL 证书、审计报告徽章等。
文档入口：提供白皮书、审计报告和开发者文档的便捷下载链接。
社区链接：清晰地引导用户加入 Discord、Telegram、X 等社区。
移动端优先：确保网站在移动设备上有良好的响应式体验 55。
表3：全面的启动前核对清单

类别
核对项
状态 (未开始/进行中/已完成)
技术
ERC-20 代币合约编写完成




合约在 Sepolia 测试网成功部署和测试




确定最终的代币经济模型参数




Juicebox 项目参数配置完成


安全
智能合约审计公司已接洽并确定




审计所需文档准备齐全




初步审计报告已收到并完成问题修复




最终审计报告已收到


社区
Discord 和 Telegram 服务器创建并配置完成




社区版主和管理规则已建立




制定了为期14天的初始内容和互动计划




在相关社区建立了初步声誉


文档
白皮书 v1.0 版本撰写并发布




项目网站上线并包含所有核心要素




公布了最终审计报告




3.2. 阶段二：启动活动 (启动周)

这是执行“混合式公平启动”策略中，将项目推向公众的关键一周。每一步操作都必须精确无误。

3.2.1. 技术执行：创建 Uniswap v3 流动性池

在 Juicebox 众筹成功结束后，立即执行以下步骤。这个过程最好在 Gas 费用较低的时间段进行。
访问 Uniswap 界面：打开 Uniswap 官方 Web 应用，并连接您的项目钱包（该钱包应持有从 Juicebox 筹集的 ETH 和项目方的代币）58。
创建新仓位：导航至“Pool”（资金池）部分，点击“New Position”（添加流动性）58。
选择代币对：
在第一个代币下拉菜单中，选择 ETH（或 WETH）。
在第二个代币下拉菜单中，粘贴您的 ERC-20 代币合约地址，然后选择它 58。
选择费用等级：Uniswap v3 提供多个费用等级（0.01%, 0.05%, 0.3%, 1%）。对于一个全新的、预计波动性较高的代币与 ETH 的交易对，选择 0.3% 或 1% 的费用等级是比较合适的。较高的费用可以更好地补偿早期流动性提供者（LP）所承担的无常损失风险 58。
设定价格范围：这是 Uniswap v3 的核心特性——集中流动性。对于初始启动，为了确保流动性池在价格剧烈波动时依然能够提供交易，最简单和安全的选择是设定一个非常宽的范围，甚至是“Full Range”（全范围）。虽然这会降低资本效率，但在项目初期，保证市场的可交易性比追求高额手续费收入更重要 58。
存入资产：输入您希望提供的 ETH 数量（应为 Juicebox 筹集到的全部数额）和您的项目代币数量。Uniswap 会根据您设定的价格范围自动计算出另一个代币所需的数量，以保持正确的比例 58。
批准与创建：这个过程需要两笔独立的链上交易：
批准（Approve）：首先，您需要授权 Uniswap 的路由器合约可以动用您钱包中的项目代币。点击“Approve PGT”（假设代币符号为PGT），然后在 MetaMask 中确认交易。
创建（Create）：批准交易确认后，点击“Preview”，然后点击“Add”或“Create Pool”按钮，在 MetaMask 中确认第二笔交易。这笔交易将正式创建流动性池并将您的资产存入 58。
交易确认后，您将收到一个 NFT，它代表您在这个流动性池中的仓位所有权。

3.2.2. 建立信任：锁定流动性池 (LP) 代币指南

这是整个启动流程中建立信任最关键的一步，必须执行。 未能锁定初始流动性是“Rug Pull”（卷款跑路）骗局最典型的特征，任何疏忽都将立即摧毁社区对项目的全部信任 60。
工作原理：当您向 Uniswap 添加流动性后，您会收到代表您在池中份额的 LP 代币。锁定这些 LP 代币，意味着将它们发送到一个有时间锁的智能合约中。在该时间锁到期之前，包括项目方在内的任何人都无法取出这些 LP 代token，从而无法撤走池中的初始流动性 60。
选择锁定服务：市面上有多个成熟的服务平台可以简化这一过程，如 UNCX Network (原 Unicrypt) 和 DxSale。这些平台提供了用户友好的界面，并被社区广泛认可 61。
锁定流程 60：
访问您选择的锁定服务平台（例如 UNCX）。
连接您的钱包。
在锁定功能区，选择您刚刚从 Uniswap 获得的 LP 代币。
设置锁定时长：这是一个向社区传递信号的关键参数。对于一个严肃的长期项目，建议锁定时长至少为 6 个月，最好是 12 个月或更长。
执行锁定交易：确认并将您的 LP 代币发送到该平台的锁定合约中。
公开透明：锁定交易确认后，立即将证明该笔锁定交易的哈希链接（从 Etherscan 获取）发布到您所有的社区渠道（Discord, Telegram, X）。这是一个极其有力的营销和信任建设事件，务必大张旗鼓地宣传。

3.2.3. 推向市场：宣布并协调公开发布

在 LP 代币锁定的那一刻，立即在所有社区渠道同步进行公开发布。公告内容应清晰、简洁，并包含所有关键信息：
项目代币已在 Uniswap 上线并可公开交易。
提供直接的 Uniswap 交易链接。
提供代币的 Etherscan 合约地址链接，提醒用户核对，谨防假冒。
提供 LP 代币锁定的证明链接。
团队成员应在 Discord 和 Telegram 中保持高度活跃，准备好回答社区涌入的各种问题。

3.3. 阶段三：启动后增长与去中心化 (前6个月)

成功的启动只是开始。接下来的六个月是维持项目势头、促进有机增长并真正走向社区所有权的关键时期。

3.3.1. 维持流动性：设计有效的流动性挖矿计划

初始流动性池可能很浅，容易产生高滑点，影响交易体验。因此，需要激励更广泛的社区成员来提供流动性，这就是流动性挖矿（Liquidity Mining）的目的 64。
计划设计：从社区财库中分配一部分代币作为奖励。用户将他们在 Uniswap 上的 LP 代币质押（Stake）到项目方部署的一个奖励合约中，即可按其贡献的流动性份额和质押时长，持续获得项目原生代币作为奖励 67。
避免“雇佣兵资本”陷阱：设计不当的流动性挖矿计划会吸引大量追求短期高收益的“农民”（Yield Farmers）。他们提供流动性仅仅是为了挖取代币奖励，一旦挖到就会立即抛售，对代币价格造成巨大压力，这种现象在早期 UNI 的分发中就曾出现过 68。为了避免这种情况，激励计划必须
奖励长期承诺者。
最佳实践：
奖励归属/锁定：不要立即发放挖出的代币奖励，而是设置一个归属期（Vesting Period），例如，奖励在3个月内线性解锁。
长期质押加成：为那些承诺将其 LP 代币锁定质押更长时间（例如3个月、6个月）的用户提供奖励加成（Boost）66。
与治理权挂钩：将流动性挖矿奖励与治理权深度绑定。例如，质押 LP 代币不仅能获得代币奖励，还能获得用于治理投票的“投票权权重”，让流动性提供者成为项目真正的利益相关者，而不仅仅是寻求收益的雇佣兵。

3.3.2. 从团队到社区：实施链上治理

这是将项目控制权逐步移交给社区的实质性步骤。
工具选择：使用 Snapshot 这样的工具进行链下（Gas-less）投票。Snapshot 通过读取特定区块高度的代币持有快照来计算投票权重，社区成员无需支付 Gas 费即可参与提案投票，大大降低了治理门槛。
建立框架：制定并公布一套清晰的治理流程，包括：提案的提交标准和格式、进入投票阶段所需的讨论和支持度门槛、投票的法定人数（Quorum）要求、投票通过后的执行机制等。
执行机制：初期，提案的执行可以由一个受社区信任的多签钱包（Multi-sig Wallet）来完成，多签成员可以由社区选举产生的代表担任。最终，随着项目成熟，可以过渡到完全由代码执行的链上 DAO 治理模式。

3.3.3. 健康与分析：监控您的链上生态系统

持续监控链上数据对于理解项目健康状况和做出明智的治理决策至关重要。
DEX 筛选器：使用 DEXTools 或 DexScreener 等工具，实时监控代币价格、24小时交易量、流动性池深度和交易历史 62。这有助于了解市场对代币的反应。
区块链浏览器：定期使用 Etherscan 等浏览器分析代币的“Holders”（持有人）分布。密切关注头部持有者的变化，警惕少数地址积累过多代币的中心化风险。一个健康的公共物品项目，其持有人分布应随着时间的推移变得越来越分散 61。
数据驱动决策：将这些链上数据作为社区治理讨论的重要依据。例如，如果发现流动性增长停滞，社区可以提案调整流动性挖矿的奖励参数。

结论与建议

对于一个定位为“加密公共物品”的新项目，其启动方式不仅是技术和财务决策，更是一次深刻的价值观陈述。最低成本的路径——直接在 Uniswap 上创建交易对——因其固有的“冷启动”流动性难题而风险极高。而看似高效的 IDO 发射台，其排他性和中心化的“守门人”模式，则与公共物品的开放、公平精神背道而驰。
本报告提出的**“混合式公平启动”**策略，是为公共物品项目量身定制的最优解。它通过两个精心设计的阶段，系统性地解决了理念与现实之间的矛盾：
以 Juicebox 进行透明的社区众筹，其唯一目的在于为即将到来的公平启动募集初始流动性。这一步将社区从被动的投资者转变为主动的市场共建者，从一开始就建立了深刻的信任和一致性。
将众筹所得资金 100% 用于创建 Uniswap 流动性池，并永久锁定 LP 代币。这一步是公平启动的最终实现，确保了对所有市场参与者的机会均等，并以不可篡改的链上行动证明了项目团队的长期承诺。
最终建议如下：
坚守原则：始终将公共物品的原则（无需许可、开放、去中心化、社区所有）作为所有决策的最高准则。您的启动方式就是您的第一次品牌宣传。
拥抱透明：从代码、审计报告到资金的每一次流动，都应做到极致的公开透明。这是在去信任环境中建立信任的唯一途径。
分阶段执行：严格遵循本报告提出的三个阶段（基础建设、启动活动、启动后增长），稳扎稳打。仓促的启动是失败的主要原因。
社区为本：在启动之前就开始构建您的社区。一个由价值驱动、积极参与的社区，是您的项目能够穿越牛熊、实现长期可持续发展的最坚固护城河。
通过遵循这一详尽的战略与技术手册，您的公共物品项目不仅能够成功完成冷启动，更重要的是，能够以一种与其高尚使命相匹配的方式，开启其去中心化的征程。
Works cited
Gitcoin Grants – Quadratic Funding for the World | Gitcoin Blog, accessed June 23, 2025, https://www.gitcoin.co/blog/gitcoin-grants-quadratic-funding-for-the-world
How Permissionless DEX Provide Opportunities for Traders? - Nadcab Labs, accessed June 23, 2025, https://www.nadcab.com/blog/permissionless-in-dex
The role of liquidity pools in cryptocurrency markets - Kraken, accessed June 23, 2025, https://www.kraken.com/learn/crypto-liquidity-pool
How To Design Tokenomics, In A World Where Pump.fun Is Writing The Rules - TDeFi, accessed June 23, 2025, https://tde.fi/founder-resource/blogs/business-models/how-to-design-tokenomics-in-a-world-where-pump-fun-is-writing-the-rules/
How to Design a Sustainable Tokenomics Model in a Defi Project? - Nextrope - Your Trusted Partner for Blockchain Development and Advisory Services, accessed June 23, 2025, https://nextrope.com/how-to-design-a-sustainable-tokenomics-model-in-a-defi-project/
Explained: What Is a Fair Launch Crypto? - OSL, accessed June 23, 2025, https://www.osl.com/hk-en/academy/article/explained-what-is-a-fair-launch-crypto
Fair Launch Is Crypto's Answer to Wall Street Corruption—Or Is It? | HackerNoon, accessed June 23, 2025, https://hackernoon.com/fair-launch-is-cryptos-answer-to-wall-street-corruptionor-is-it
ICO vs IEO vs IDO: What's the Difference? - TrustSwap, accessed June 23, 2025, https://trustswap.com/blog/crypto-fundraising-models-explained/
Token Launch: ICO vs IDO vs ILO vs Launchpad - Scaling Parrots, accessed June 23, 2025, https://www.scalingparrots.com/en/token-launch/
Top 10 Best Crypto Launchpads for Token Projects in 2025 - Empirica, accessed June 23, 2025, https://empirica.io/blog/top-10-best-crypto-launchpads-for-token-projects-in-2025/
Initial DEX offering (IDO): A beginner's guide on launching a cryptocurrency on a decentralized exchange - Cointelegraph, accessed June 23, 2025, https://cointelegraph.com/learn/articles/initial-dex-offering-ido
Best Crypto Launchpads & IDO Platforms For 2025 - 99Bitcoins, accessed June 23, 2025, https://99bitcoins.com/best-crypto-launchpads/
Top Crypto IDO/ICO Launchpads for Enterprise in 2025 - Slashdot, accessed June 23, 2025, https://slashdot.org/software/crypto-ido-ico-launchpads/f-enterprise/
What are the pros and cons of using a crypto launchpad? - Genius Academy, accessed June 23, 2025, https://academy.geniusyield.co/articles/what-are-the-pros-and-cons-of-using-a-crypto-launchpad-genius-academy
Fair Launch Mechanism - UEEx, accessed June 23, 2025, https://blog.ueex.com/crypto-terms/fair-launch-mechanism/
Fair Launch Crypto: A Comprehensive Guide | Bitbond, accessed June 23, 2025, https://www.bitbond.com/resources/fair-launch-crypto-a-comprehensive-guide/
Juicebox | Crypto Fundraising & DAO Management, accessed June 23, 2025, https://juicebox.money/
Measuring the Success of Mirror Crowdfunding - Graeme, accessed June 23, 2025, https://g.mirror.xyz/GBj7emzIN5NBNFPLV6FGfN1c7GjSaZ_wEkjm5KQy2UE
Tokenomics Design: An Ultimate Guide for Crypto Founders, accessed June 23, 2025, https://4irelabs.com/articles/tokenomics-design-guide/
How to Design Tokenomics: Your Blueprint for a Winning Web3 Project, accessed June 23, 2025, https://blacktokenomics.com/how-to-design-tokenomics/
Tokenomics Design: Tokenomics Model Guide - GrowthChain, accessed June 23, 2025, https://www.growthchain.io/blog/tokenomics-design-101-how-to-design-a-perfect-tokenomics-model
Top 5 Crypto Launchpads to Watch in 2025, accessed June 23, 2025, https://www.cryptotimes.io/articles/explained/top-5-crypto-launchpads-to-watch-in-2025/
Develop IDO Launchpad Like DAO maker - Blockchain Technologies, accessed June 23, 2025, https://blockchaintechs.io/ido-launchpad-like-dao-maker/
How To Create A Promising IDO Launchpad Like DAO Maker? - Antier Solutions, accessed June 23, 2025, https://www.antiersolutions.com/blogs/building-the-ultimate-ido-launchpad-clone-script-inspired-by-dao-makers-proven-model/
DAO Maker Launchpad Review - Bitbond, accessed June 23, 2025, https://www.bitbond.com/resources/dao-maker-launchpad-review/
Quadratic Voting: A How-To Guide | Gitcoin Blog, accessed June 23, 2025, https://www.gitcoin.co/blog/quadratic-voting-a-how-to-guide
An Introduction to Gitcoin Grants and Quadratic Funding - Crypto Altruism, accessed June 23, 2025, https://www.cryptoaltruism.org/blog/an-introduction-to-gitcoin-grants-and-quadratic-funding
BioFi Gitcoin Grants, accessed June 23, 2025, https://www.biofi.earth/biofi-gitcoin-grants
The Evolution and Mechanisms of Juicebox in DAO Financing | MIDAO, accessed June 23, 2025, https://www.midao.org/blog-posts/the-evolution-and-mechanisms-of-juicebox-in-dao-financing
Setting Up Your Project | Juice Docs, accessed June 23, 2025, https://docs.juicebox.money/user/project/
Customizing your Juicebox project's tokenomics pt 1: Total Issuance Rate & Reserved Rate (TUTORIAL) - YouTube, accessed June 23, 2025, https://www.youtube.com/watch?v=edPZOxTLaYA
Juicebox for charities and non-profits - the power of onchain funding explained - Juice Docs, accessed June 23, 2025, https://docs.juicebox.money/blog/jb-for-charity/
Mirror - Center for a Digital Future, accessed June 23, 2025, https://www.centerforadigitalfuture.org/blog/60kqfdgb4f8kljqy1j4ujvaqr1bx5y-364pg-bskhw-cy52b-x37dz
G4G Crowdfunding - Google Docs, accessed June 23, 2025, https://docs.google.com/document/d/17oKVg45N2m7fqcfeyP0dop9biSKknwtCxieWi3x2YnM/edit
Grand Opening: Crowdfunds Go Public — dev.mirror.xyz, accessed June 23, 2025, https://dev.mirror.xyz/kkpmBMFAeKlCv4zi2HcyO0MfmpguVqTHoo-DL0WxwS8
Crowdfunding Writing with NFTs — dev.mirror.xyz, accessed June 23, 2025, https://dev.mirror.xyz/llJ_AboiDJwB_ZAFz-CXU7fL2p8v5Wz6MjfluLafewQ
Create ERC-20 Token in 5 Steps - Krayon Digital, accessed June 23, 2025, https://www.krayondigital.com/blog/create-erc-20-token-in-5-steps
How to Create an ERC-20 Token (4 Steps) - Alchemy, accessed June 23, 2025, https://alchemy.com/docs/how-to-create-an-erc-20-token-4-steps
Create an ERC20 Token in 3 Steps and Deploy It | QuickNode Guides, accessed June 23, 2025, https://www.quicknode.com/guides/ethereum-development/smart-contracts/how-to-create-and-deploy-an-erc20-token
How to Create an ERC20 Token: Complete Solidity Tutorial | Speed Run Ethereum, accessed June 23, 2025, https://speedrunethereum.com/guides/how-to-create-erc20
How To Audit A Smart Contract? A Beginner's Guide, accessed June 23, 2025, https://coinbureau.com/guides/how-to-audit-smart-contract/
How To Audit a Smart Contract? | Chainlink, accessed June 23, 2025, https://chain.link/education-hub/how-to-audit-smart-contract
10 Steps to Systematically Approach A Smart Contract Audit - Cyfrin, accessed June 23, 2025, https://www.cyfrin.io/blog/10-steps-to-systematically-approach-a-smart-contract-audit
Smart Contract Audit Readiness Guide - Quantstamp, accessed June 23, 2025, https://quantstamp.com/audit-readiness-guide
Smart Contract Audit Readiness Guide - Learn - OpenZeppelin, accessed June 23, 2025, https://learn.openzeppelin.com/security-audits/readiness-guide
Smart Contract Audit - CertiK, accessed June 23, 2025, https://www.certik.com/products/smart-contract-audit
How do you guys usually build the first community for a new blockchain project? - Reddit, accessed June 23, 2025, https://www.reddit.com/r/BlockchainStartups/comments/1k8kgll/how_do_you_guys_usually_build_the_first_community/
14 Tips for Building & Growing a Crypto Community - Lunar Strategy, accessed June 23, 2025, https://www.lunarstrategy.com/article/14-tips-for-building-growing-a-crypto-community
Building a Strong Crypto Community from Scratch [2025] - SAG IPL, accessed June 23, 2025, https://blog.sagipl.com/crypto-community-building/
10 Methods to Build Your Telegram Crypto Community | HackerNoon, accessed June 23, 2025, https://hackernoon.com/10-methods-to-build-your-telegram-crypto-community
blog.sagipl.com, accessed June 23, 2025, https://blog.sagipl.com/crypto-community-building/#:~:text=The%20most%20effective%20way%20to,project%20and%20participate%20in%20discussions.
Crypto Whitepaper – How To Write It - Bitbond, accessed June 23, 2025, https://www.bitbond.com/resources/crypto-whitepaper-how-to-write-it/
How to Write a White Paper: A Step-by-Step Guide for Blockchain Startups - B2BinPay, accessed June 23, 2025, https://b2binpay.com/en/news/how-to-write-a-white-paper-a-step-by-step-guide-for-blockchain-startups
How to Write a Crypto Whitepaper? Complete Guide | Coinbound, accessed June 23, 2025, https://coinbound.io/write-a-crypto-whitepaper/
Crypto Website Design for Success: Key Elements, Best Practices, and Industry Insights, accessed June 23, 2025, https://community.nasscom.in/communities/mobile-web-development/crypto-website-design-success-key-elements-best-practices-and
Crypto Web Design: Outstanding Design Ideas for Your Project - Qubstudio, accessed June 23, 2025, https://qubstudio.com/blog/crypto-web-design/
Crypto Web Design: Main Elements, Best Practices, and Real-World Examples - Arounda, accessed June 23, 2025, https://arounda.agency/blog/crypto-web-design-main-elements-best-practices-and-real-world-examples
How to add liquidity to Uniswap v3 – Uniswap Labs, accessed June 23, 2025, https://support.uniswap.org/hc/en-us/articles/7423194619661-How-to-add-liquidity-to-Uniswap-v3
Guide: Providing Liquidity on Uniswap - Lido: Help, accessed June 23, 2025, https://help.lido.fi/en/articles/8395367-guide-providing-liquidity-on-uniswap
What Is Locked Liquidity? | Bitbond, accessed June 23, 2025, https://www.bitbond.com/resources/what-is-locked-liquidity/
How to Analyze Liquidity Pools and Other Factors to Avoid Being a Victim of Rug Pulls, accessed June 23, 2025, https://www.datadriveninvestor.com/2022/10/25/how-to-analyze-liquidity-pools-and-other-factors-to-avoid-being-a-victim-of-rug-pulls/
Where to Buy a Meme Coin in 2025: Complete Guide - WunderTrading, accessed June 23, 2025, https://wundertrading.com/journal/en/learn/article/where-to-buy-meme-coin
UNCX Network Reviews - 2025 - Slashdot, accessed June 23, 2025, https://slashdot.org/software/p/UNCX-Network/
Liquidity Incentive: How to Create and Leverage Liquidity Incentives - FasterCapital, accessed June 23, 2025, https://fastercapital.com/content/Liquidity-Incentive--How-to-Create-and-Leverage-Liquidity-Incentives.html
Top 8 Ways to Use Liquidity Incentives in DEXs - Nadcab Labs, accessed June 23, 2025, https://www.nadcab.com/blog/liquidity-incentives-in-dex
How to Attract Liquidity for Your DEX - Rock'n'Block, accessed June 23, 2025, https://rocknblock.io/blog/how-to-attract-liquidity-for-your-dex
How to Design a Token Incentive Program for Crypto Exchanges? - SDLC Corp, accessed June 23, 2025, https://sdlccorp.com/post/how-to-design-a-token-incentive-program-for-crypto-exchanges/
Liquidity Mining - How Does It Work? - Empirica, accessed June 23, 2025, https://empirica.io/blog/liquidity-mining/
