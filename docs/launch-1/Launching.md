# 启动

## 概述

启动和目标、计划，团队有关系，更和初始化的资金有关。

1. 中期目标

- 三年资金自循环稳定（盈亏平衡），流水到 5000 为美元，估值 1 亿美元。

2. 短期目标：

- 团队：2 人核心团队 + 社区协作成员（可纳入公司兼职，则更偏向于指令执行），3-6 人

3. 产品目标：

- 一个基础：COS72，社区开源公共物品，包括 SuperPaymaster 和 AirAccount，xRich 平台，以及众多插件
- 两个探索：Play2B2E 和跨国贸易（多方）

## 渠道

## 渠道 1：公司融资

1. 建立 HyperCaptial 合法公司，投资人投资，目标是 Web3 落地盈利，业务面向全球
2. 估值 1000WU，募资 50-100WU，出让股份 5-10%（初步估值）
3. 公司海外主体，营业公司放泰国，算是全资子公司，合法纳税，从事加密基础设施开发和运维业务。
4. 国内可以设置全资子公司，主要是招聘和社保，以及实体业务对接运营（例如采购发货）

## 渠道 2：IDO

协议发行代币，提供协作创新的关系创造服务。

1. 迪拜（首选，其他待选）成立合法的 DAO
2. 建立简单但有效的工作流程，应对链上的去中心过程（合约和执行，签名和投票等）
3. 建立 2100 万 G-token，只能用来治理的 token，拥有投票权和社区协议使用参与等权利，没有任何直接利益来源（通过 Howey 测试，非证券）
4. 20% 归属 HyperCapital，签署有效合法的文件和链上协议，另外 20% 进行 IDO，分三次，计划每年一次，用来启动社区
5. 剩余 60% 归属社区，但不贵国库支配，而是进入特定合约，保障社区长期稳定可持续（借贷，支付积分）

发行方式向更去中心化、低门槛的方向发展。可选：Uniswap、Hyperliquid、Pump.fun
等平台打破准入壁垒，使项目可以低成本、快速上市，但同时也带来了更高波动性与欺诈风险。代币发行路径的变化，本质上是加密行业对
「效率 vs.合规」这一永恒主题的不同阶段回答。
美国即将出台的稳定币法案与更清晰的联邦监管框架，以及欧盟 MiCA 法规的实施，将推动加密融资行为逐步纳入合规轨道。在这种背景下，
发行机制不再仅是技术选择，更是投资者关系、社区信任与资本治理结构的体现。可以预见，未来小型项目将倾向于使用 IDO
进行社区启动，而中大型项目则更青睐 IEO 或
STO 以满足审慎投资者的合规需求。最终，决定项目成功的，将是其如何在安全性、开放性与投资者保护之间建立稳健的发行模型，这也标志着
加密市场逐渐走向成熟资本市场的路径。

## 渠道 3：积分发行

1. 社区还会发行 PNTs，但同样为了合规，此 Token 为协议内的记账单位，不可直接交易，不同 token 如何和 PNTs 进行换算的合约规则
2. 因为 Gtoken 资金投资到了社区，而为了获得回报，我们提供了公司合规业务的投资资格（同样需要资金）
3. 所有发行自己 PNTs 的，都需要购买一定量（1/3) 的 PNTs（stake
   Gtoken，购买 PNTs，承诺服务或产品兑换，各一定比例）
4. 为避免定义为稳定币，只记账，通过计算不同 ratio，协议收取转化服务费
5. 我们所有的项目和服务对象，都假设自己会发行自己的 xPNTs（各种名字），用于客户忠诚度，会员参与度，粉丝投入度等
6. PNTs 就是 Asset3 的计量单位，但实际是以各自发行的 xPNTs 来计量，但涉及换算，都用 PNTs
7. PNTs 的定位和计价来源：付出的（劳动）时间，标准个人生活维持成本，当地 GDP 和物价系统（这个会变动）
8. 我们会建立 xRich 的 Asset3 交易市场，主要针对个体发行的 xPNTs，也会涉及其他几个协议

## 依赖

以上渠道，依赖：
![](https://raw.githubusercontent.com/jhfnetboy/MarkDownImg/main/img/202505211258373.png)
0. 2+6 团队成立，三个月资金到位（理想和最低的平均：10k-15k/月*3）

1. 产品的设计和基础 demo：
2. 天使用户和持续反馈和改进：1000 个用户
3. 适度的内容和宣传：10 个合作社区，100 篇业界媒体文章和 1000 个 article 或者内容输出
4. 协议白皮书
5. 社区成立（DAO 进行中），开始提供一些服务，组织初始化（重要的是不能花钱)
6. roadmap 三年规划清晰，一年里程碑
7. 建立项目制度，投票就是表示支持，要 stake 票的；对于 MIP，则不需要 stake，拥有的投票权进行二次方投票即可

## 基础设施

COS72

1. 开源的公共物品和基础设施
2. 建立基本的激励制度，让节点运行起来
3. 免 gas 服务和无侵入社区工具
4. 自定义的客户端，依赖于你的社区节点
5. 可搬迁的加密账户，完全自托管

### 开源

1. SuperPaymaster: a universal open source paymaster contract for account
   abstraction. https://github.com/AAStarCommunity/SuperPaymaster
2. SDSS: an architecture for decentralized service sponsor system.
   https://github.com/AAStarCommunity/SDSS
3. AirAccount: an open source account abstraction contract.
   https://github.com/AAStarCommunity/AirAccount/tree/aastar-develop
4. AirAccount-Rust-Relay: an open source relay server for AirAccount.
   https://github.com/AAStarCommunity/AirAccount-Rust-Relay
5. OpenPNTs: an open source token solution for community senarios like gas
   sponsorship and more. https://github.com/AAStarCommunity/OpenPNTs
6. CometENS: an open source ENS for AirAccount and SDSS.
   https://github.com/AAStarCommunity/CometENS
7. Multi OS client framework: https://github.com/AAStarCommunity/COS72-Tauri
8. A quick demo can be found here: https://github.com/AAStarCommunity/AAStar_SDK

## 忠诚度积分：Play2B2E

1. 社区提供基础设施：SDSS 和 OpenPNTs 等协议、服务
2. 社区提供孢子计划并跑出范例
3. 社区开发示范版本游戏
4. 整体运转和协作
5. 商业公司建立商业服务，对接实际商业

## 进出口贸易：Container

1. 以集装箱为单位卖货的国际淘宝，面向亚非拉
2. 解决移民国外汇款问题 + 国内物价奇高问题
3. 采用公司和社区结合，众包完成全流程，公司并非利润主体，让利消费者和参与服务者
4. 可以去中心化 can


美国《CLARITY 法案》明确 SEC 监管证券型代币，CFTC 监管商品型代币（如 BTC、ETH）。引入「成熟区块链系统」（mature blockchain system）的概念，通过认证可实现监管转换 —— 去中心化、源代码开源、基于预设规则自动化运行的区块链项目，通过认证（如提交证明无集中控制的材料）后，将被认定为「成熟」，即可完成从「证券」到「商品」的监管合规进阶，即监管主导权完全归 CFTC，SEC 不再对其行使证券监管权。此外，还对 DeFi 提供部分豁免 —— 如编写代码、运行节点、提供前端界面以及非托管钱包等行为通常不被认定为金融服务，豁免 SEC 监管。只需要遵守反欺诈和反操纵等基础条款
## 07 几个社区社交网络与社区商业结合的尝试

在基于区块链的社区社交网络 —— Steem（以及其分叉链 Hive）之上，已经有子社区在进行此类尝试。尝试案例有：

- 咖啡社区（Hive） - https://coffeeshop.gifts/
    
- 咖啡社区（Steem） - https://v0-tosspay-clone-preview.vercel.app/
    
- 旅行分享社区（Hive） - https://worldmappin.com/
    
- 孟加拉在地社区（Steem） - https://puss.meme/


## zu.coffee
- 任何社区都可以加入，使用 zu.coffee 的基础设置，建立和加入基于以太坊的社区和社交网络
- 积分：社区提供代币模板和基于模板的基础服务
- 变现：提供 1.5% 的 Mycelium AD 基于 CPS 模式，分享->影响->成交的去中心化商业模型，任何人都可以发布
- 创作：stake 1 GToken，发帖，获得点赞/踩=积分
- 纠纷：去中心化 Jurry 来评理和处理纠纷，记录到链上；
- 内容审查：AI 识别全球禁止内容 + 去中心化授权每个人进行内容审查：踩和猛踩
- 匿名机制保障没有针对
## OpenPNTs, OpenCards
1. 持有一个以上 GToken，stake 获得 lpToken，然后 mint NFT（白板加油卡）
2. 加入任何社区，只要支持 OpenPNTs 的协议的，完成任务，获得积分
3. 无论是 EOA 还是 AirAccount 或者任何账户，加入加油卡白名单（不同账户，不同操作，AirAccount 默认设置即可，EOA 需要 delegate 合约）
4. 目前支持 Layer1 mint NFT，积分代扣支付 gas，直接 mint 即可
5. 任何社区可以发行自己的加油卡 NFT，基于 OpenCards 协议（接受其他社区的 gas 积分，本质所有 gas card 都绑定在一个 AirAccount）
6. 针对刚需：社区需要活力和粘性，个人需要 gas 代付（mint NFT，transfer token and more），提供工具解决这个问题，跨链跨社区提供解决方案





