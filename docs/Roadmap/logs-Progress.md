# Progress
每日更新  🚧Desinging，⏳Working，✅Done
## 近期todo
1. MyNFT单页面版本设计，基于文档，repo建立上，算是COS72的第一个应用 ⏳ 5%
2. 部署OP测试网，进行全面测试，然后添加NFT合约，部署和验证；⏳ 30%，Op-sepolia部署+测试ok
3. EOA bridge 项目推动（期望快速进展）⏳
4. 硬件设备的部署迁移，找老师确认网卡硬件地址如何连接？然后部署上，测试 🚧
5. 联合测试，OP测试网，包括account测试，🚧
6. 关键合约UUIP+proxy，然后发布OP主网 🚧
7. 销售合约和launchpad ⏳20%
8. Task黑客松测试出demo 🚧
1. 增加NFT和AI基础模块，然后发布OP主网合约+发布一次SDK（带主网合约）；
2. 附带youtube视频demo+bilibili视频demo，教建设者/builder用起来
- M的诉求，M的障碍（概念，上下文，开发环境，测试token和ETH等），M的需求
- 拆解为诉求，讨论，确定几个解决方案的方式：一键部署自己的社区网站框架+集成的infra？嵌入式部署infra？插件支持？
3. 建立天使用户群，邀请制，大家提需求，给反馈，讨论想要的帮助和产品feat
4. AI（社区AI+个人AI+AI workshop）, bot(tele第一位，wechat第二位，找个技术栈），以赋能社区，自由个体为目标；
account repo继续思考和完善；sp提供社区面板，改进registry repo；


## 2-12,13,14,15
1. 最近几天完成了论文数据生成和修改，初稿ok，需要review一次（paper3,7）
2. SDK也做了一些fix，一定阶段提交一次；
3. MyShop和MyTask到了一定阶段，需要check验收一次，修正设计，继续完善
### 近期todo
1. keeper 跑起来，给sepolia，op-sepolia和op定时update，梳理清楚update规则，评估最好情况和最坏情况。
- op主网我们合约设置过期时间是4200秒（check确定下，paymasterv4和superpaymaster合约）
- 在例如4100秒的时候更新，检测频率是3分钟check一次,每次确保还有至少5分钟有效时间，否则则自动更新，则实际大约有效时间是60-65分钟之间；
- sepolia和op-sepolia的chainlink更新时间我不确定，需要变动的符合实际；
- 因为任何人都可以提交updatePrice 交易，所以这个keeper接受任何在对应链有eth，test eth的eoa account作为参数，就能跑起来
2. 论文收尾
- 今日review，估计要两天
- 多轮check和audit，fix
- 导师反馈的：移除usd，模拟图，格式，都fix
- 论文发arcvix，3,7
- 找导师确认：我期望是3-7投稿CommunityFi，修改几次，发表（评估下发表概率，别老拒稿）；提交格式、确认accept时间和缴费方式、署名要求、投稿流程、费用和报销流程，准备好论文pdf，确认后发布；3-17自己投稿paper3；3-7开始写EOA，两周完成，3-27投稿老师推荐或者其他刊物；3-27开始写AA

3. MyTask，MyShop测试和refine，启动MyVote和AA的插件
### MyTask: make descision
用中文沟通
- What is the canonical “agentId” source of truth (SBT tokenId vs registry mapping vs derived)?

- Which payment authorization rails are mandatory for MVP:
  - ERC-2612, EIP-3009 (token-specific), or AA-only?
- What is the minimum viable dispute model:
  - “soft disputes” (reputation-only) vs “hard disputes” (slashing + onchain arbitration)?
- Where do receipts live and what is posted onchain (hash-only vs full URIs)?
### MyShop: all done
- P0：D1 定义环境与地址版本结构（状态：进行中）
- P1：D4 发布流程落地（含预检清单落地执行）
- P2：D2 最小 CI（合约 build/test、worker check/test、前端 build/check/e2e）
- P3：C5 交易生命周期体验完善（approve/buy/pending/success/fail）
- P4：C7 全角色最小 E2E 自动化补齐
- P5：D3 SDK 整合（地址源对齐 + MyShop client）
已覆盖的核心能力

- 社区准入、店铺注册与费用配置：合约已有 registry gating、平台费、上架费与角色控制 MyShops.sol
- 商品上架与购买闭环（含串号与风控签名）：合约已实现 SerialPermit/RiskAllowance 验证、购买原子执行、Action 白名单 MyShopItems.sol
- Worker 监听、Webhook/Telegram 通知、Query API 与索引：已实现购买事件 enrich、通知、API/metrics 与索引持久化 watchPurchased.js apiServer.js
- aPNTs/GToken 售卖基础规则（白名单支付、rate、上限/日限/单笔限）：合约已实现 APNTsSale.sol GTokenSale.sol
设计中明确但代码里尚未覆盖的部分
#### todo
- Plaza 前端升级 ：设计里要求广场/列表/多入口购买，当前前端只有最小 demo 单页逻辑（仅 main.js 等 4 个文件） Solution.md:L314-L340 frontend/src
- SDK 整合与地址稳定 ：文档 M4 明确要把 MyShop 地址与 client 收敛进 aastar-sdk，但仓库内无对应实现 Solution.md:L402-L419
- Eligibility/资格校验插件化 ：设计里有 validator/EligibilityPermit 路线，但合约与服务端暂无对应实现 architecture.md:L71-L102
- 风险评估页与可视化风控 ：设计要求展示风控与发行统计，但前端未实现 Solution.md:L279-L293
- 售卖价格机制与 timelock ：设计提出预言机/滑点保护/变更延时，但现有售卖合约仅固定 rate 与上限 Solution.md:L259-L286

## 丢失了10天左右log
md，被reset了，傻叉ai

## 2-4
1. close MyExDraw： https://hub.docker.com/repository/docker/aastar/myexdraw-excalidraw/general， ✅
2. launch继续整理，争取到阶段成果，满足下一步
3. SDK registry设计最简单的界面
4. AI整理到一个repo（社区和个人的）

## 2-3
1. 建立了半个DApp示范：MyExDraw，数字公共物品，改了点东西，能用了；
- 后面要：添加账户认证（SBT）和订阅 or Shops购买、Reputation和Credit显示
- 到期自动销毁的NFT（例如订阅制度）
- 自动支付订阅，扣款失败发email提醒
2. 冷启动repo继续维护和完善，晚上继续；
3. 更新slogan：Empower Community, Unleash Humanity🍄
迁移aastar.io网站从github pages到cloudflare



## 2-2
黑客松结束
5. 反思黑客松：由别人定义的规则，如果你想协作，就要check和遵守，否则得不到你想要的结果；当然，如果想original的hack精神，那我们绝对符合：创造点好玩的

## 2-1
1. NFT设计了一下,独立分支，社区快速发放nft，独立可运行，包括前端和输入（json输入空投地址列表，json输入nft meta data），operator支付gas（未来扩展为免gas支付）✅
2. ppt初稿整理了✅ 初稿ok，声纹识别看情况
3. AI流程基础完成 ✅ 不改了
4. 晚上碰下，打磨下，明天绚子或者我来demo show？需要录制一个video 2-3分钟叙事:问题，解决方案，流程演示

## 1-31
1. 黑客松：爬虫（停止了），合约今天初稿（初步ok）；黑客松ppt：Oscar+绚子来，5页，展示演讲：绚子（全英文）
2. 下午去数字游民大会

## 1-30
1. 黑客松开发，目标完成几个核心：Bot，AI语音，分析结果上链，全程可信可验证
2. 完善明天的分享ppt
3. 黑客松基础流程ok；Oscar的几个建议：有用户，有反馈，迭代

## 1-29
1. Dev的活动，全天

## 1-28
1. hackathon 开幕
2. iridescent，support
3. echoRank，event reputation和加权NFT信用的简单的公共物品和社区bot

## 1-27
1. 外面一天，办理驾照和年检

## 1-26
1.体检，准备材料，驾照换本准备✅
2.下午3:15活动✅
3.lifecycle API测试，看是否合并到SDK
4. 销售合约今日一定开始，开始这个(开了个头)

## 1-25
1. 完成了两个分享的ppt，就这样吧
2. 分析模块继续推动，到一个小版本，暂停，稍候从论文角度分析是否足够（明天推进）
3. 销售合约
4. MyNFT？


## 1-24
1. 所有合约稳定在4.3.1，已发布和验证ok；sdk和docs稳定在0.16.14, npm已经发布
2. 分析模块明天进行，如果结果能接受，就开始发布op主网（需要稳定几个核心合约为proxy？）
3. 明天和david碰下进展（近期他没空。。。推后

## 1-23
1. 终于测试全通过，合约和sdk打死也不动了，发op-sepolia，测试，然后发op ✅
2. https://gateway.pinata.cloud/ipfs/bafybeiait3ds2fn42kmnu3ofp73ycujgppks3ma3zzvxnedthunpsrvn7e
## 1-22
1. 优化部署脚本，为部署op-sepolia和op主网准备，昨天一天优化了xpnts和sp；sepolia test 通过；
2. 准备ppt（25晚上的分享），推掉了主持人的角色；
## 1-21
1. NFT设计了一下，没开始
2. OP测网部署了，优化了xpnts
3. 销售合约进展了一点
## 1-20
1. 数字游民大会分享（赋能社区和个体，ppt准备10 page）+邀请人文学院老师分享✅
2. demo稳定到了faucet+本地demo✅
3. 25号瓦猫+26号（两个活动），31号菩提小院（两个活动），28开始的ETHChiangMai黑客松，29号Dev的全天黑客松
## 1-19
1. SDK 测试全面通过：ABI覆盖、单元测试、SDK回归、Gasless回归、技术债和bundler抽象都已经完成。提交了0.16.11的tag ✅ 
2. 分支在进行analytics模块的初始化，分析历史交易，给出全面gas成本分析，为未来优化、用户知情、博士paper数据准备，P1,持续✅
3. 今日会发布一版SDK，在gpt5.2完成review和claude评估后✅
4. 完成一个手写demo测试(独立repo），然后迭代这个demo repo✅

## 1-14进展：
1. SP系列合约已经稳定版本，gasless测试和回归测试已稳定，已发布sepolia
2. AAStar SDK封装ABI和API已经稳定，已发布npm 0.16.8
3. 和Oscar沟通，未来期望加入Mycelium，成都社区提供社区试用和反馈

## 1-15进展：
1. Wamo确定主持一个talk+一个分享，邀请老师ing
2. 数字游民大会，继续跟进，要准备一个问题-->思考-->方向-->协议-->实践的ppt，内容简单快速直白，然后就一些话题聊天
3. 完成docs网站迁移和新版本发布： docs.aastar.io

## 1-15进展：
1. SDK refine（credit+reputation test）, 不发布；docs完善quick start+发布；学术会议做了SP的ppt+分享（韩国教授来访）
2. Reputation设计的整理和独立文档
3. demo repo使用quick start完成一个gasless交易，完全开发者角度。

## 1-16进展
1. Refine SDK and Sp 合约
2. Try to use SDK to launch a demo project（doing）

## 1-17进展
1. 出去确定了两个event和海报、规划，发布了
2. Fix Sp合约（语言机价格更新fix）
3. SDK优化，API对ABI覆盖率到95%；单元测试覆盖率和line覆盖率到100%和85%；更新文档，尝试一个demo

## 1-18
1. 发布beta1版本，在sepolia，包括基础Demo：如何构建你的gasless AA；大部分时间在对SDK进行100%函数覆盖单元测试和line测试覆盖率85%。
2. 整理launch repo，和david沟通会议
