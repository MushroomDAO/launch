# AirAccount: Email Account

Build an open-source and decentralized mechanism to support anyone who has an Email to get an Ethereum contract account in seconds.

Craft：

1. Raspberry pi board with Linux kernel，run an SMTP and POP3 service.(only accept the mail who have right signature) — by DKIM?
2. Get Email signals and translate them into Chain behavior instruments.
3. Send these to Gateway+Node, and execute it.
4. Learn something from ZKMail

### **AirAccount SDK，ENS，乃超沟通**

1. 基于当下的node npm（neal 版本），fork，讨论下name space
2. Feature 1(for end user): account的生命周期，从简单到复杂，提供**AA ability**服务
    1. 创建
    2. initiate code（模版），模块化
    3. 绑定（AirAccount特有）：新建，已有（两种，轻，重）
    4. 联合登陆：Email，Web2，Web3，ENS
    5. Gas sponsor（自动发现，默认，购买年卡等）
    6. Security: D2FA, Service contract
    7. 7702(EOA)
    8. Revoery, transfer
3. Feature 2: Gas Sponsor with ETHPaymaster， for Developer
    1. Same name space with ENS； Same contract address in cross chain;
        1. Basic paymaster
        2. Super Paymaster
            1. 需要自建bundler或者BD其他bundler多进行一次安全余额验证
            2. 获得集合信用和公共sponsor pool，开发面对一个社区公共池即可
4. Social Recovery方案：Alert+Public Guardian + Executor
5. D2F
6. ENS
    1. airaccount可解析op.ethpaymaster.eth，txt.op.ethpaymaster.eth(replay service ip,address)
    2. txt.tom.op.ethpaymaster.eth, txt.clark.op.ethpaymaster.eth
    3. airaccount创建的email account，分配（可设置）三级域名：bob.zParty.eth
    4. 路由合约和ens的半中心化服务启动，可配置（新增root域名，管理二级三级域名，切割域名，其他）

### Action

1. 看别人SDK，[SDK(Ecosystem)](https://www.notion.so/SDK-Ecosystem-b5de7ea771e04c15ad30f5ac2fca4846?pvs=21) 
2. 梳理核心能力，讨论声明周期
3. 提炼0.1版本AirAccount能力
    1. 可配置调用其他人的生命周期，支持3-4个主流
    2. 在gas sponsor（找服务器签名形成paymasterAndData，和ENS name space上嵌入我们流程
4. 其他能力建设
    1. 基于后端的社区节点能力：binding，execution等
    2. David Xu的时序图和设计文档 [David XU](https://www.notion.so/David-XU-f3e25c2005114641ab6bf1e0c4783ae2?pvs=21) 
5. 完成基础4337协议版本（支持0.6，0.7 版本entrypoint）
    1. 测试，alpha内测
    
    1. SDK(+ENS)（7月底EDCon）
    2. Website（一周）
    3. 合约修改，评估