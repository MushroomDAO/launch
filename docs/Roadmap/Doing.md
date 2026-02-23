# Doing
- CoS72 Admin：refactoring
- CoS72 Registry flow：Demo deving（SDK）
- MyTask：Deving
- MyShop：M1, 测试和refine
- MyVote：Deving（M1）
- CoS72 Plugin：Deving
- CometENS：Deving
- Sin90: Desiging
- N3XT：Deving（Aura infra）
- Aura AI Class：自学+整理ing
- Aura AI iDoris：自己训练模型，思考设计ing：基座可以换么？
- Aura AI iDoris：应用层：解决谁的什么问题，解决方式和流程，效果评测；架构层：Gears+Mycelium Network+链接个人AI和社区AI

## MyTask: make descision
用中文沟通
- What is the canonical “agentId” source of truth (SBT tokenId vs registry mapping vs derived)?
- Which payment authorization rails are mandatory for MVP:
  - ERC-2612, EIP-3009 (token-specific), or AA-only?
- What is the minimum viable dispute model:
  - “soft disputes” (reputation-only) vs “hard disputes” (slashing + onchain arbitration)?
- Where do receipts live and what is posted onchain (hash-only vs full URIs)?
## MyShop: all done
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
### todo
- Plaza 前端升级 ：设计里要求广场/列表/多入口购买，当前前端只有最小 demo 单页逻辑（仅 main.js 等 4 个文件） Solution.md:L314-L340 frontend/src
- SDK 整合与地址稳定 ：文档 M4 明确要把 MyShop 地址与 client 收敛进 aastar-sdk，但仓库内无对应实现 Solution.md:L402-L419
- Eligibility/资格校验插件化 ：设计里有 validator/EligibilityPermit 路线，但合约与服务端暂无对应实现 architecture.md:L71-L102
- 风险评估页与可视化风控 ：设计要求展示风控与发行统计，但前端未实现 Solution.md:L279-L293
- 售卖价格机制与 timelock ：设计提出预言机/滑点保护/变更延时，但现有售卖合约仅固定 rate 与上限 Solution.md:L259-L286

## N3XT
Forge for me.
- Task: Backlog
- Main coding: Claude Code / Anti + Trae + Codex
- Skills: github-kb and more
- Deep Research：clawPhD，DeerFlow2.0
- Agnet：Nano，Zero，Claw （testing）
### 多agent
自己以后就是充值买 Key，配配 Github 帐号了：macmini+macbook，双龙虾，接管了claude code，codex-cli和opencode，做了开发计划以后，这俩龙虾就通过飞书和ISSUE群聊+版聊开始工作，还能自己升级…等他俩学会全流程控制，基本上就没我啥事了。感觉以后只要我配好openclaw的KEY，我用的是Minimax coding plan max，还有Github的账户和gh auth，设定一下最初的项目目标，superpowers 的brainstorms，就可以交给他俩干，直接迭代出一个初始版本，目前推进到alpha状态，正在补齐用户文档，安装程序，自动测试环境，提升覆盖率…以前我弄3个AI-CLI和Codex要一周左右，现在龙虾1/2天吧。还需要用飞书干预。会卡住，需要人工纠正，主要还是提示，让他俩刷新，总结，重新执行任务，已经方便太多了，
### Skills
在 Claude Code 中执行：/plugin marketplace add anthropics/skills
https://github.com/OPPO-PersonalAI/Agent-KB
- Claude-review-loop
- Claude-code-notifier
- npx bmad-method install
- github-kb

/skill-creator 请帮我做一个 github-kb 的技能
我的本地有一个 github 目录，在 /vol2/1000/github，我希望你记住它，并且在其根目录创建 CLAUDE.md，每一个 repo 给一个一句话的摘要记录在里面。请在 SKILL.md 里用 @ 引用这个文件
如果没有找到这个目录，询问用户，并更新自己的 SKILL.md
当用户说下载一个 repo，请使用 git 命令下载到这个目录，下载完后请更新 CLAUDE.md
这个技能会在任何时候用户提到 github 或者 repo，或者仓库时触发，并优先在本地目录寻找用户提到的仓库，并分析查询，回答用户的问题。
你可以充分使用 gh 命令，在 github 上搜索 issue pr repository 等来回答用户问题

/plugin marketplace add CloudAI-X/threejs-skills
/plugin install threejs-skills

https://github.com/CloudAI-X/claude-code-resources
https://github.com/CloudAI-X/claude-workflow-v2

又火了一个OPC项目！Skill安装达5.3k
Agent Skill for OPC一人公司
项目本身就是通过里面的Agent Skill边实现边优化的，包括Logo设计、页面设计、Banner设计、SEO&GEO优化。
opc dot dev目前包含以下Skill:
- seo-geo: 下载量达2.8k的SEO和GEO（推荐！）
- requesthunt: 获取来自reddit, x, github的真实用户需求、抱怨、反馈
- domain-hunter: 帮项目推荐、比较、购买最低价域名，还会自己找优惠码
- logo-creator: 通过nanobanan pro创建logo，可去除背景，转化成矢量图
- banner-creator: 生成符合GitHub, Twitter等要求的Banner
- and more

### 开发流程
https://github.com/affaan-m/everything-claude-code/blob/main/README.zh-CN.md
https://github.com/affaan-m/everything-claude-code/tree/main/skills
OpenSpec
worktree，并发

能否抑制住上下文熵增，决定成败
春节用Claude Code做了完整业务系统。头图是真实计费面板——1.9万次请求，10亿tokens，Opus4.6主力。
 
最大体会：AI代码能力不是瓶颈，上下文管理和需求质量才是。6条核心经验👇
 
🧠一、多模型对审，Plan阶段填坑
Opus4.6 plan mode出方案，Codex5.3 Extra High评审。每个需求点五六轮质疑补全，执行几乎一次通过。修改循环前移到纯文本阶段，最划算。
 
🗺️ 二、分形文档+强制同构
根目录全局地图，模块目录成员清单，文件头部声明依赖。三层折叠，AI三次Read拿到完整上下文。思路从@赵纯想 学的，CLAUDE.md强制加载播种文档，非常牛逼。每次代码变更必须回环检查，文档代码脱节AI就越写越离谱。
 
🚧三、Hook自动拦截
规范写成脚本挂hook，违规代码写入瞬间打回。prompt写一百遍不如拦一次。我用Hook强制Arco Design组件，全项目零逃逸。
 
💾四、Plan文件持久化
plan落到项目目录，加checklist跟踪，新会话读文件断点恢复。文件系统是唯一可靠状态源。
 
📏五、质量红线量化
文件≤800行，函数≤30行，嵌套≤3层，分支≤3个。硬阈值。AI对"要短"理解飘忽，对"≤30行"执行稳定。再cue赵纯想：让AI有洁癖几乎零成本。
 
📦六、渐进式上下文加载
改bug只加载目标模块，架构决策才加载全局。命中率比覆盖率重要。1M上下文缓解熵增但不根除，渐进加载是必修课。
 
6条对抗的都是——上下文的熵增。不治这个，迭代越快崩越快。

#### 黑奴模式
价值1000元/月的 Vibe Coding 技巧：如何用低成本套餐实现顶级 AI 编程体验

在 AI 编程工具百花齐放的今天，不一定要追求最昂贵的订阅服务。通过合理的工具组合和自动化配置，我们可以用最实惠的价格，换取最高效的开发产出。

我的配置清单（每月成本约 220 元）

1. **GLM Coding Pro** (约 100 RMB)：负责高强度编码，几乎不限流。
2. **ChatGPT Plus** (约 120 RMB)：通过苹果礼品卡订阅，量大且稳定。
核心实战技巧

1. 日常核心开发：Claude Code 自动化

进入 **Claude Code** 后，建议的操作流程如下：

* **开启 Plan 模式**：搭配 `AskUserQuestion`（参考 Anthropic 大佬 @trq212 的推文），实测非常有效。
* **使用 `/superpowers` 插件**：让 AI 深度理解你的完整诉求。
* **自动化执行**：计划 review 完后，使用 `claude --allow-dangerously-skip-permissions` 进行自动化执行，最后再手动验证功能。

2. 二次审核：ChatGPT Codex Review

由于全程主要使用 GLM 进行国产代码生成，为了稳妥起见，建议使用 **Codex** 的 `/review` 功能对改动进行二次审查。这种“双模型交叉验证”的方式能显著降低 Bug 率，让代码提交更加放心。

3. 任务提醒：Claude Code 运行通知

当并行处理多个任务时，Claude Code 的执行进度容易被忽略。可以使用开源库（如 `github.com/mylee04/claude...`）配置弹出提醒，任务跑完即刻知晓，无缝切换下一个任务。

4. “黑奴模式”：离位自动化

当你准备睡觉或长时间离开工位时，可以开启“黑奴模式”：

* **组合命令**：`/ralph-wiggum` + `/superpowers`。
* **流程**：利用 `/superpower` 快速脑暴并制定完整计划（包含详细测试流程）。Review 完计划后，交给 `/ralph-wiggum` 循环执行。
* **进阶**：可以尝试配合 `github.com/OthmanAdi/plan...` 进一步优化执行效果。

5. 高频操作自动化

针对重复性的工作流程，可以通过封装 **Skill** 或 **Command** 来解决：

* **封装 Skill**：例如作者负责后端开发，需同步接口到 **Apifox**。通过 Claude Code 根据 Apifox 开放接口封装一个 skill（参考：`github.com/eddiearc/apifo...`），即可实现接口修改后的自动同步。
* **封装 Command**：将 `git commit & push & sync api` 这种组合动作封装成一个特定的 Claude Code 命令，后续只需精准调用一个指令，即可自动化完成整套繁琐操作。

6. 提升文档维护质量

学习推特博主 @chunxiangai 的技巧：

* **局部 README**：在每个文件的头部维护一个简单的说明，或者在每个目录下维护目录级的 `README.md`。
* **作用**：将庞大的项目说明书“分而治之”。这能帮助 AI 和其他开发者快速理解模块作用，同时**避免大模型因为上下文过长而导致“失忆”或幻觉**。

---

**需要我帮你搜索文中提到的 GitHub 仓库具体地址，或者深入解释某个模式的操作步骤吗？**

### 工具
https://github.com/txtx/axel-app
https://github.com/GCWing/BitFun?tab=readme-ov-file

### Context/Communicate
- Mac Mini（CC） + Mac（Anti+CC） + Mobile（happy+telegram/slack）
- 除了和自己的agent，客服和团队的agent沟通协作呢？


### Research/科研模块
https://psantanna.com/claude-code-my-workflow/
https://psantanna.com/claude-code-my-workflow/workflow-guide.html
paperbanana

Claude Scholar：AI学术研究全流程助手
Claude Scholar 是一个面向 Claude Code CLI 的个人配置系统，提供丰富的技能、命令、代理和钩子，针对AI/CS的学术研究进行了特定优化。覆盖完整的学术研究生命周期（从构思到发表）和软件开发工作流，同时提供插件开发和项目管理能力。
 
核心工作流：
1. 研究构思：research-ideation skill + literature-reviewer agent/research-init
2. ML 项目开发：architecture-design skill + code-reviewer agent/plan, /commit, /tdd
3. 实验分析：results-analysis skill + data-analyst agent/analyze-results
4. 论文写作：ml-paper-writing skill + paper-miner agent
5. 论文自审：paper-self-review skill
6. 投稿与 Rebuttal：review-response skill + rebuttal-writer agent/rebuttal
7. 录用后处理：post-acceptance skill/presentation, /poster, /promote
 
辅助工作流：
1. 自动化执行: 5 个 Hook 在会话各阶段自动触发（技能评估、环境初始化、工作总结、安全检查）
2. 知识提取: paper-miner 和 kaggle-miner agent 持续从论文和竞赛中提取知识
3. 技能进化: skill-development → skill-quality-reviewer → skill-improver 三步改进循环
 
Claude Scholar 不仅仅是一个配置集合，它是一套完整的研究工作方法论。通过自动化钩子强制执行最佳实践，通过专业技能提供领域知识，通过智能代理处理复杂任务，通过知识进化持续改进。从今天开始，让 Claude Code 成为你研究工作的得力助手。
 
仓库地址：https://github.com/Galaxy-Dawn/claude-scholar

## iDoris
逻辑组件：信息、决策、行动
角色拆分：表达者，建设者，创造者
工具强化：传播，构建，探索
行动部分:
- 依赖Agent，通过接通信息和决策模式，人工介入来决定行动（规划、能力、资源、分配和收集并持续反馈）
- 智库团队：每天阅读前沿的论文和市场信号，并指导制定项目的机会方向和OKR
- 产品团队：除了写码维护已上线产品，还能自己创建demo视频，部署到prod再利用reddit、PH等分发平台go to market
- 创新团队：主要是做新的事儿，要求90天内$，怎么搞都行，于是他们自行开发了5个项目一起赛马，目前回了Max20的本
- 运营团队：譬如根据我绿卡排期网站客户的留言自动回复、屏蔽垃圾留言，管理日常数据、文档运营等
- 内容团队：目前可帮剪视频，再剪映
- 理财团队：譬如要出手G家，团队分析了Fed开会内容并告知我最佳出手点，出掉后就📉
 
以上团队全靠一个人类语言沟通的助理就能协调动员，把每个团队要做的事情写到文档里，再让助理去监督团队每天就按照这些基本任务去发展。
我作为人类老板，把关最后一道红线

### 技术栈
UI：https://github.com/jhfnetboy/pi-mono
Bot：https://github.com/sipeed/picoclaw/blob/main/README.zh.md
Agent infra：https://github.com/memohai/Memoh， https://github.com/openonion/connectonion/tree/main
Model：https://github.com/AuraAIHQ/nanochat
讨论： [model-talk.md](model-talk.md)


## Sin90
Designing, Aura Infra
- Personal collection Mobile App: 转发被调用，发图文，语音，视频；作为元数据，酵母，从海量中过滤和提取
- Auto Collection：数据结构化：历史数据和动态数据，共建，提供API，社区可加入
-流程：信息--决策--行动的loop
- 组件：插件，app，iDoris 个人，iDoris 社区，MyTask+Agent接入
### 信息
Source：[Infor-source.md](Infor-source.md)
RSS
https://github.com/77AutumN/Intel_Briefing
https://github.com/Thysrael/Horizon/
浏览器：Get started with Actionbook in under 2 minutes:

Step 1: Install the CLI

npm install -g @actionbookdev/cli
The Rust-based CLI uses your existing system browser (Chrome, Brave, Edge, Arc, Chromium), so no extra browser install step is required.

Step 2: Use with any AI Agent

When working with any AI coding assistant (Claude Code, Cursor, etc.), add this to your prompt:

Use Actionbook to understand and operate the web page.
The agent will automatically use the CLI to fetch action manuals and execute browser operations.

Step 3 (Optional): Add the Skill

For enhanced agent integration, add the Actionbook skill:

npx skills add actionbook/actionbook
https://github.com/actionbook/actionbook

### Mobile App
https://github.com/BlockRunAI/ClawRouter

### 创作者
路径：一本书+一个小时，我用AI做了一款策略游戏
一个人，一台电脑，一个小时。
用 Claude Code
做了一款叫《枢纽：天下之道》的历史策略游戏，828行代码，浏览器打开就能玩。
	
秘密是两样东西：
1️⃣  把《游戏设计的100个原理》这本书，用 pdf2skills
转成了22个AI技能文件（Skill）
2️⃣  把施展老师的《枢纽》也转成了9个分析框架
然后对 Claude Code 说了一句"帮我设计一个游戏"。
它自己组了个 Agent Team：
一个解析书、一个做设计、三个写内容、自己写引擎。
并行干活，一小时交付。
游戏有七大空间（中原/草原/西域/高原/海洋...），每个历史事件给你三个选项，你的
每个决策都在回答一个问题：何谓中国？
整个工作流就四步：
一本书 → 一套Skill → 一个大师级助手 → 一个完整作品
游戏设计Skill我公开了，拿走直接用。
游戏也能在线玩。
	
Skill 在线地址： https://gist.github.com/OrangeViolin/53ad898cdbc8734d8bb5c6a6ddf5cec4
	
游戏地址在这里: 《枢纽：天下之道》更新了一个版本：https://orangeviolin.github.io/pivot-game/

## Security
https://github.com/zakirkun/guardian-cli


## Research/科研
https://github.com/HughYau/AcademicForge

## TODOs
1. kin，放置mini和iot（先迁移完成）
2. 每日增加Happy LLM, Happy Agents课程学习
3. theworldlabs，three.js
4. open alice
5. crewly借鉴
6. 微软litebox
7. 理性的仪式：人类合作需要共同知识
