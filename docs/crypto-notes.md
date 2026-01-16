每日课程：

**加密：**

https://www.bilibili.com/video/BV18T411k74f/?buvid=XY6A3076FC8AF0EE4A71B77D6CF3611AA03D0&is_story_h5=false&mid=g6RzLpMtPBiJJU8Mp3xC0A%3D%3D&p=1&plat_id=114&share_from=ugc&share_medium=android&share_plat=android&share_session_id=eb69eccc-8e5f-41f0-a9d0-81b7aebcbed0&share_source=WEIXIN&share_tag=s_i&timestamp=1695445900&unique_k=DVRwU0C&up_id=2145417872&vd_source=0a978d5cb963890b0cab49f66fae30af

10 月 24，第一课继续看

11-15 看完（可以略看，再看第二遍），出发去伊斯坦布尔

20 天看完



**英语 + 开发**

以太坊周会

以太坊 Layer2

相关开发 Devcon 等视频 

=============

DES（56bit) 已经是不安全的，密码强度是 2 的 56 次方，AES 建议了分组密码，每组 2 的 128 次方（Rijndael 算法）	，采用轮函数主持多轮加密，每次加密都基于密钥扩展的某个密钥进行加密，一般轮函数包含四种操作：Sub Bytes，Shift Rows，Mix Columns，AddRoundKey，每轮进行四个运算，进行 10 轮。

S 盒子是一大堆加密的数字对应表格

不可约多项式（本源多项式）

公钥密码学，保障信道不安全的前提下可以共享保密随机数 K，K 用来对称加密

通过 Diff Harman 协商出一个 DH 密钥作为 K

*AES*的全称是 Advanced Encryption Standard




好的，以下是关于数据保留、证明和验证的解释：

**数据保留**是指在规定的时间内存储数据的行为。数据保留是许多行业和监管机构的要求，例如金融服务、医疗保健和政府。数据保留有助于确保数据的完整性和可用性，并满足法律和监管要求。

**数据证明**是指对数据的真实性、完整性和有效性的声明。数据证明可以由数据所有者、数据处理者或第三方提供。数据证明有助于确保数据的安全性和可靠性，并满足合规要求。

**数据验证**是指对数据的真实性、完整性和有效性的检查。数据验证可以由数据所有者、数据处理者或第三方进行。数据验证有助于确保数据的可靠性和准确性，并满足合规要求。

以下是数据保留、证明和验证的具体定义：

- **数据保留**（Data retention）：指在规定的时间内存储数据的行为。数据保留可以是强制性的，也可以是自愿的。
- **数据证明**（Data attestation）：指对数据的真实性、完整性和有效性的声明。数据证明可以由数据所有者、数据处理者或第三方提供。
- **数据验证**（Data verification）：指对数据的真实性、完整性和有效性的检查。数据验证可以由数据所有者、数据处理者或第三方进行。

数据保留、证明和验证是三项相互关联的活动。数据保留是数据证明和验证的基础。数据证明和验证可以帮助确保数据保留的有效性。

---

如果用户手机可以**存储**一些 key 信息+**联网**，可以存储一些轮换信息，重要，但是作为辅助验证手段，

1. 存储本地 proof 的 raw 信息，如果有 index，则会被随机询问 raw 信息，然后 server 进行 proof 验证，是否和历史 proof 信息一致
2. 通信手段就是可联网基础上，主动发送 raw 信息（交互比较麻烦），ux 体验差，但可以用于紧急情况的验证？
3. 如果是**smartphone**，则可以用 app 来解决这个问题，短信验证（相信短信网关基础上）+ 本地 raw or proof 随机 index 验证，来证明你是你；（proof 和 server 端存储的对比，随机抽查或者随机 push 来验证）
4. 本地依然**不存储 keypair，只存储证明我是我的证据**
5. 可以联网就可以随时以第三方视角监控自己帐号的异动
6. 因为有证明来验证我是我，所以**keypair 随时可以被替换**，这样降低了用户保存 keypair 的成本，只需要证明我是我
7. 而**验证我是我**的过程，是依赖于**去中心化网络的共识机制**和互相制约的机制
8. worldcoin 是依赖人生理携带的虹膜**唯一数据，不会丢失**，在 key 上可以做到**一对一**绑定，但依然有被**伪造和中心化作恶/共谋、censorship 等风险**，因为鉴定你是你的过程，并没有依赖去中心化的共识（没深入验证，猜测），而 Seperation Key Method 给出了一个拥有证据（例如手机号和短信）、去中心化的验证证据、证明你是你然后操作 keypair、随时 keypair 可以转移更换
9. Seperation Key Method 的验证我是我的共识过程（这个得看下以太坊共识协议逻辑）
   1. 发短信指令给随机一个网关，网关必须转出短信内容 proof（加密内容后通过网络），同步给一个其他网关；用户手动/自动再随机两个网关，网上有三 - 四个 proof 即可
   2. 所有 proof 必须全部通过，才进行下一步
   3. 有一个不通过，则进入验证阶段，以有 raw 内容的网关生成的 proof 为准，不一致的则被 slash（被同步 proof 的是冗余执行保障，不会 slash）



-------

```
请借鉴以太坊共识协议逻辑，我们针对下述问题，设计一个共识机制，来保障共识结果像以太坊共识机制一样可信中立：用户持有一个设备，例如手机，可以发短信给短信网关，也可以积累记录基于设备关联的历史交易记录；用户基于和去中心化的短信网关通信，来发出指令，短信网关收到指令翻译为可执行的指令，再通知builder进行上链操作。
可以借鉴以太坊共识协议的逻辑，设计一个基于权益证明（PoS）机制的共识机制，来保障共识结果的可信中立。具体设计如下：

共识节点：由用户持有的设备担任，每个设备都需要抵押一定数量的代币来成为共识节点。
共识算法：使用随机算法来选择验证者，验证者使用自己的代币来投票，选择一个区块头。
共识结果：大多数验证者的投票决定了区块头的有效性。
具体实现如下：

用户将代币抵押到共识协议中，成为共识节点。
共识协议每隔一定时间生成一个区块，并选出一定数量的验证者来验证该区块。
验证者使用自己的代币来投票，选择一个区块头。
大多数验证者的投票决定了区块头的有效性。
区块头被添加到区块链中，并执行该区块中的交易。
为了保障共识结果的可信中立，可以采取以下措施：

将代币抵押作为成为共识节点的条件，可以降低恶意节点参与共识的可能性。
使用随机算法来选择验证者，可以防止某些节点获得过多的投票权。
使用拜占庭容错算法来确认区块头的有效性，可以抵御恶意节点的攻击。
针对上述问题，可以将共识协议与去中心化的短信网关结合起来，实现以下功能：

用户可以通过短信网关发送指令，短信网关将指令转换为可执行的指令，并通知builder进行上链操作。
短信网关使用共识协议来确定指令是否有效，并将有效指令上链。
通过这种设计，可以确保指令的有效性和可信性，并防止恶意攻击。

以下是具体的实现步骤：

用户发送指令给短信网关。
短信网关将指令转换为可执行的指令。
短信网关使用共识协议来确定指令是否有效。
如果指令有效，短信网关将指令上链。
builder根据指令进行上链操作。
这种设计可以确保指令的有效性和可信性，并防止恶意攻击，具体如下：

有效性：短信网关使用共识协议来确定指令是否有效，可以防止恶意用户发送无效指令。
可信性：共识协议使用随机算法来选择验证者，可以防止某些节点获得过多的投票权，并使用拜占庭容错算法来确认区块头的有效性，可以抵御恶意节点的攻击。
安全性：指令上链后，可以通过区块链的安全性来保障指令的安全性。
当然，这种设计还需要进一步完善，例如，可以考虑使用零知识证明等技术来提高效率。

个人资料照片
针对以上方案中，短信网关使用共识协议来确定指令是否有效，具体共识协议有具体的时序步骤么
查看其他草稿



针对上述方案中，短信网关使用共识协议来确定指令是否有效，具体共识协议的时序步骤如下：

1. 短信网关接收指令

短信网关接收到用户发送的指令，并将指令转换为可执行的指令。

2. 短信网关生成区块

短信网关将指令作为区块头，并生成一个区块。

3. 短信网关选出验证者

短信网关使用随机算法选出一定数量的验证者来验证该区块。

4. 验证者投票

验证者使用自己的代币来投票，选择一个区块头。

5. 大多数验证者的投票决定了区块头的有效性

如果大多数验证者的投票结果一致，则该区块头有效。

6. 短信网关将区块上链

如果区块头有效，则短信网关将区块上链。

7. 指令被执行

区块链上的指令被builder执行。

以下是具体的时序图：

用户 -> 短信网关 (指令)
短信网关 -> 验证者 (区块)
验证者 -> 短信网关 (投票)
短信网关 -> 区块链 (区块)
区块链 -> builder (指令)
这种设计可以确保指令的有效性和可信性，并防止恶意攻击。

有效性：短信网关使用共识协议来确定指令是否有效，可以防止恶意用户发送无效指令。

可信性：共识协议使用随机算法来选择验证者，可以防止某些节点获得过多的投票权，并使用拜占庭容错算法来确认区块头的有效性，可以抵御恶意节点的攻击。

安全性：指令上链后，可以通过区块链的安全性来保障指令的安全性。

当然，这种设计还需要进一步完善，例如，可以考虑使用零知识证明等技术来提高效率。
--------


以太坊共识协议是基于拜占庭协议么？请解释以太坊共识协议的交互过程

是的，以太坊共识协议是基于拜占庭协议的。拜占庭协议是用于解决拜占庭将军问题的一种协议，该问题描述了在一个网络中，如果超过一半的节点是恶意的，如何让这些节点达成一致。

以太坊共识协议使用了以下技术来解决拜占庭将军问题：

拜占庭容错算法：拜占庭容错算法可以确保即使超过一半的节点是恶意的，仍然可以达成一致。
随机验证者选举：以太坊使用随机验证者选举算法来选出验证者，可以防止恶意节点获得过多的投票权。
区块链：以太坊使用区块链来记录交易，可以防止恶意节点篡改历史数据。
以太坊共识协议的交互过程如下：

每个节点都会生成一个区块头，并将其发送给其他节点。
其他节点会验证该区块头的有效性。
如果该区块头有效，则该节点会投票给该区块头。
大多数节点投票的区块头将被添加到区块链中。
以下是具体的交互图：

节点 1 -> 节点 2,3,4,... (区块头)
节点 2 -> 节点 1,3,4,... (投票)
节点 3 -> 节点 1,2,4,... (投票)
节点 4 -> 节点 1,2,3,... (投票)
...

如果大多数节点投票的区块头相同，则该区块头将被添加到区块链中。
以太坊共识协议可以确保区块链的安全性，即使超过一半的节点是恶意的。

个人资料照片
请描述拜占庭将军问题和用来解决这个问题的PBFT协议
查看其他草稿


























拜占庭将军问题是指在一个分布式系统中，如果超过一半的节点是恶意的，如何让这些节点达成一致。这个问题是由Leslie Lamport在1982年提出的。

拜占庭将军问题的背景是，一群将军在围攻一座城池。如果所有将军都同意进攻，那么他们将有99%的胜率。但是，如果有将军叛变，那么叛变的将军可能会发送错误的信息，导致其他将军做出错误的决策。

为了解决拜占庭将军问题，需要使用一种协议，该协议可以确保即使超过一半的节点是恶意的，仍然可以达成一致。

PBFT协议是解决拜占庭将军问题的一种协议。PBFT协议使用了以下技术来解决拜占庭将军问题：

拜占庭容错算法：拜占庭容错算法可以确保即使超过一半的节点是恶意的，仍然可以达成一致。
消息认证：PBFT协议使用消息认证来防止恶意节点伪造消息。
领导者选举：PBFT协议使用领导者选举来确定一个节点作为领导者，负责协调其他节点的工作。
PBFT协议的工作原理如下：

每个节点都会选举一个领导者。
领导者生成一个区块头，并将其发送给其他节点。
其他节点会验证该区块头的有效性。
如果该区块头有效，则该节点会投票给该区块头。
大多数节点投票的区块头将被添加到区块链中。
如果有将军叛变，那么叛变的将军可能会发送错误的信息。但是，PBFT协议使用了拜占庭容错算法来确保即使超过一半的节点是恶意的，仍然可以达成一致。

PBFT协议是目前最有效的解决拜占庭将军问题的协议之一。PBFT协议被广泛应用于区块链系统中，包括比特币、以太坊等。
```

拜占庭将军问题（Byzantine failures），是由莱斯利·兰伯特提出的点对点通信中的基本问题。含义是在存在消息丢失的不可靠信道上试图通过消息传递的方式达到一致性是不可能的

拜占庭假设是对现实世界的模型化，由于硬件错误、[网络拥塞](https://baike.baidu.com/item/网络拥塞/717895?fromModule=lemma_inlink)或断开以及遭到[恶意攻击](https://baike.baidu.com/item/恶意攻击?fromModule=lemma_inlink)，计算机和网络可能出现不可预料的行为

进一步将“拜占庭将军问题”延伸到技术领域中来，其内涵可概括为：在缺少可信任的中央节点和可信任的通道的情况下，分布在网络中的各个节点应如何达成共识

在中本聪发明比特币以前，世界上并没有一个非常完美的方法来解决“拜占庭将军问题” [5] 。

究其根底，“拜占庭将军问题”最终想解决的是互联网交易、合作过程中的四个问题： [5] 

（1）信息发送的身份追溯 [5] ；

（2）信息的私密性 [5] ；

（3）不可伪造的签名 [5] ；

（4）发送信息的规则 [5] 。

=====

拜占庭将军问题，核心是一致性问题（暗含正确的一致性，而非错误的），多个计算机节点通信如何达成一致的共识

解法 1:将军 - 副官模型

1.忠诚的副官遵循同一个命令，即副官会达成一致性

2.将军如果是忠诚的，则所有副官都会执行他的命令，即保证正确性

m：恶意个数，n：总数，需要满足 n>3m，m 要小于总人数的 1/3

解法 2:PBFT，即便有恶意节点，网络故障存在，依然可以达成共识

基于 PoW+ 数字签名不可伪造 + 可溯源 + 最长链 Hash+ 出块时间戳 + 出块奖励

难度由指数级降低到了多项式级别

利用通信次数换取可靠性，两两通信

解法 3: PoS 的 PBFT？

--------

EthStorage 联合 Hyper Oracle 和 Delphinus Lab 发布 zkGo 编译器。zkGo 基于 Go 最新的 1.21.0 基础上，是首个把常规的 Go 代码编译成 ZK 协议兼容的 Wasm 代码。生成的 Wasm 代码执行已经能够被 Delphinus Lab 的 zkWasm 工具进行零知识证明和链上验证。作为 zkGo 的一个重要应用，zkGo 已经成功编译 Optimism 的 Fraud Proof 的 L2 Geth（又称 op-program-client），生成与 ZK 协议兼容的 Wasm 代码。当前 Wasm 代码通过了 zkWasm 的试证明（dry run），将助力未来实现 ZK Fraud Proof 技术。



----

PKI（Public Key Infrastructure）即**公钥基础设施**，是提供公钥加密和数字签名服务的系统，目的是为了自动管理密钥和证书，保证网上数据信息传输的机密性、真实性、完整性和不可否认性。

-----

以下是 Ledger 硬件钱包后门漏洞的详细信息：

- 漏洞存在于 Ledger Nano X 和 Ledger Nano S Plus 两款硬件钱包中。
- 漏洞允许攻击者通过 USB 连接到钱包，并获取用户的私钥。
- 漏洞是由于 Ledger 供应链中的一个错误造成的。
- Ledger 已发布了固件更新，修复了该漏洞。

Ledger 硬件钱包是全球最受欢迎的硬件钱包之一。该漏洞的曝光，对 Ledger 的声誉和用户信心造成了一定的打击。

Ledger 表示，该漏洞仅影响少数硬件钱包。但是，用户应提高警惕，保护自己的资金安全。

以下是一些保护硬件钱包安全的建议：

- 始终使用最新的固件。
- 定期备份您的私钥。
- 不要将您的硬件钱包与不信任的设备连接。
- 不要将您的私钥保存在计算机或云端。



当然有。以下是一些历史上有过的硬件钱包安全新闻：

- 2017 年，一家名为 Trezor 的硬件钱包公司承认，其硬件钱包存在一个漏洞，允许攻击者通过 USB 连接到钱包，并获取用户的私钥。Trezor 表示，该漏洞是由于其软件中的错误造成的。Trezor 已发布了固件更新，修复了该漏洞。
- 2018 年，一家名为 KeepKey 的硬件钱包公司承认，其硬件钱包存在一个漏洞，允许攻击者通过物理攻击获取用户的私钥。KeepKey 表示，该漏洞是由于其硬件设计中的错误造成的。KeepKey 已发布了固件更新，修复了该漏洞。
- 2019 年，一家名为 BitBox02 的硬件钱包公司承认，其硬件钱包存在一个漏洞，允许攻击者通过软件攻击获取用户的私钥。BitBox02 表示，该漏洞是由于其固件中的错误造成的。BitBox02 已发布了固件更新，修复了该漏洞。

--------

区块链安全公司 Certik 在 2020 年 10 月发现了苹果 T2 安全芯片的漏洞。该漏洞允许攻击者绕过 T2 芯片的安全功能，从而获得对 Mac 系统的完全控制。

该漏洞存在于 T2 芯片的 Boot ROM 中，Boot ROM 是一段存储在 T2 芯片中的固件，用于启动 Mac 系统。攻击者可以通过物理攻击 T2 芯片，将恶意代码植入 Boot ROM，从而绕过 T2 芯片的安全功能。

一旦攻击者获得对 Boot ROM 的控制，他们就可以执行任意代码，包括安装恶意软件、窃取数据或完全禁用 Mac 系统。

Certik 在发现该漏洞后，将其报告给了苹果。苹果随后发布了 macOS Catalina 10.15.5 更新，修复了该漏洞。

以下是苹果安全芯片漏洞的详细信息：

- 漏洞存在于 T2 芯片的 Boot ROM 中。
- 漏洞允许攻击者绕过 T2 芯片的安全功能。
- 攻击者可以通过物理攻击 T2 芯片来利用该漏洞。
- 苹果已发布 macOS Catalina 10.15.5 更新，修复了该漏洞。

苹果安全芯片漏洞的曝光，表明即使是安全性最强的设备也存在安全风险。用户应注意以下安全措施，以保护自己的设备和数据：

- 始终使用最新的软件更新。
- 不要将您的设备与不信任的设备连接。
- 使用强密码和双因素认证。
- 定期备份您的数据。

-----

可信执行环境（Trusted Execution Environment，TEE）的设计目的是保护应用程序免受一种最具挑战性的攻击类型：那些甚至能够控制计算机操作系统的攻击方式。

一些最著名的 TEE 包括英特尔的 SGX、Arm TrustZone 和 AMD SEV。它们的工作原理是让 CPU 通过加密的方式证明特定的安全应用程序（enclave）已加载，并防止其他软件干扰它。

TEE 已经融入到数字生活的许多方面。像苹果 FileVault 这样的磁盘加密软件、谷歌 Authenticator 这样的两步验证应用程序都将密钥存储于 TEE 中，即使有人盗窃并拆解笔记本电脑或手机，密钥也能得到保护。

同时，在 Web 3 中，TEE 也变得越来越重要。数字货币钱包也使用 TEE 来更安全地存储加密密钥。分布式区块链预言机可以使用 TEE 来增加数据的真实性可信度。有提议将 TEE 用于“2-of-3 系统”以帮助从零知识证明的实现错误中的恢复。

还有一些区块链项目，如 LucidiTEE、SubstraTEE、Oasis Network 和 AntChain，则提议使用 TEE 为用户提供数据隐私保护。

-----

严格意义上来说，隐私计算目前没有一个明确的定义，行业里讨论比较多的隐私计算或者更准确的叫做隐私保护计算（Privacy-preserving Computation），是指在保证数据提供方不泄露原始数据的前提下，对数据进行分析计算的一系列信息技术，保障数据在流通与融合过程中的“可用不可见”，是一组技术的合集，包括多方安全计算 MPC、可信执行环境 TEE、联邦学习 FL、全同态加密 FHE、可信密态计算（TECC）等等。国内隐私计算起步较晚，近几年来投入在隐私计算上的公司，比如[蚂蚁集团](https://help.aliyun.com/product/356643.html)、微众银行、华控清交、洞见科技等，以开源或者闭源的形式，在这组技术合集中选择多项技术进行研发，取得了一定的成绩但也迎来了一些挑战。

---

“隐语”具备以下三个重要特性：



1. **支持多种隐私计算技术。**隐语支持目前几乎所有主流的隐私计算技术，如 MPC、TEE、FL、HE、DP 等，同时也在探索 TECC、受控匿名化等技术方向，并且积极支持互联互通。用户可基于不同业务场景来选择合适的技术方案。
2. **支持全链路的数据分析和处理能力。**可以满足用户在选定的技术方案下（MPC/FL/TEE 等），对数据进行数据分析、预处理，建模，预测的全流程数据处理需求。
3. **支持业务全生命周期的孵化。**隐语既支持业务在早期 PoC 阶段的快速迭代，也支持 PoC 验证成功后的业务的规模化推广，确保业务在规模化推广过程中的高可用。



技术演进的路线上来看，“隐语”的技术路线可以概括为几个阶段：最早的基于矩阵掩码的数据变换方案，到基于多方安全计算和可信执行环境的两套技术路线，发展到后来的多种技术融合的路线，并催生了可信隐私计算框架“隐语”。

----

**蚂蚁可信隐私计算开源框架“隐语”，和可信执行环境隐私计算操作系统 Occlum、蚂蚁隐私计算一体机技术一同承载了蚂蚁集团隐私计算技术体系**

----

为了在众多的业务场景中实现可用不可见、可算不可识，蚂蚁探索研究了几乎所有可能的隐私计算技术，包括：多方安全计算 MPC、可信执行环境 TEE、联邦学习 FL、全同态加密 FHE、差分隐私 DP 等；并且探索新的技术方向，比如首创了可信密态计算 TECC、受控匿名化技术等。同时蚂蚁在积极探索软硬件一体全栈可信、多协议互联互通、隐私计算与区块链融合 FAIR 等技术产品化方向。

多方安全计算和同态加密也是蚂蚁集团在 2018 年开始研究的，核心是为了解决性能的问题。早期“隐语”的计算技术主要专注在机器学习的一些算法上面。“多方安全计算现在一方面在研究如何提升计算性能，另外就是在研究如何与现有的机器学习框架等结合起来，复用众多的算法能力。”王磊谈道。



联邦学习则是为了解决大数据规模下的复杂机器学习问题而进行的探索，如 DNN，GNN 等。王磊举例，在一些数据量比较大、算法比较复杂的场景中，基于多方安全计算来做，存在一些性能上的瓶颈，如果基于联邦学习来做，则能通过安全退让 获得不错的性能提升，从而满足业务对性能和规模上的需求。



后来落地到业务中，联邦学习中间信息的隐私和安全问题凸显出来。隐语团队的做法是，在联邦学习中引入差分隐私技术，保护联邦学习中间信息的隐私，并将联邦学习和可信执行环境做更好的结合。

----

Messari named this DePIN

Decentralized Physical 

Infrastructure 

networks (DePIN) 

More see this:

#### DePIN sector notes Comment

Decentralized Physical Infrastructure networks (DePIN) Solve the chicken-and-egg dilemma associated with Web2 giants through token incentives, motivating individuals to bootstrap networks and eventually attracting end users. Valuations, Key Events, Infra Asset Screener.

个人感觉，一手信息来源于 Messari 的 2023 年 1 月的一个 twitter：https://twitter.com/MessariCrypto/status/1616082866622074883，是较早对这个赛道做划分的？

作为赛道/sector，相关从业者划分：https://messari.io/assets/depin

https://messari.io/report/the-depin-sector-map（这个要pro，谁有给down个pdf，感谢）

https://news.marsbit.co/20230121134431190480.html，国内报道



-----

Hash 是把任意长度的数据，mapping 为固定长度的数据，例如 256bit 随机数，成为消息摘要

特征：

1. 单向性
2. 弱强抗碰撞性

SHA2（就是 SHA256）

8+64 个常量，没有后门数据

SHA1 和 MD5 已经不安全了，NIST 于 2007 年开始征集 SHA3，2010 年 5 个入选：BLAKE（高效率算法，基于 MD5 优化，目前主流 hash 中最快的），Keccak（以太坊内置算法），Grest/JH/Skein

例如 BLAKE，8 个轮函数，进行 10 轮

Keccak，引入海绵体结构，吸入数据，处理，挤出数据，用一个轮函数 Keccak-f

AES 对称加密将数据排为平面矩阵，轮函数有四种：字节替代（S 盒子），行移位（线性变换），列混淆（线性变换）和轮密钥加

SHA3-Keccak，将数据排为立体 cube，轮函数包括 5 个：theta，rho，pi，chi，iota（实质是线性变换和非线性变化，轮常量加（轮密钥加），输出 1088，然后可以截取任意输出，例如 256

ZK friendly：Poseidon

ZK unfriendly：SHA2/BLAKE/Keccak

ZK 电路两个思路：

RICS：a*b=c

PlonkGate：a*b+a+b+c+constant=0

Poseidon Hash 在域上进行加法、乘法、电路门数较低

对称加密与 hash 函数：都是做线性变换、非线性变换、轮常量加

-----

PKI 是指公钥基础设施（Public Key Infrastructure），它是利用公钥加密技术为网上通信提供安全服务的基础设施。PKI 的核心元素是数字证书，数字证书由可信的证书颁发机构（CA）颁发，包含了用户的公钥信息和其他身份信息。

PKI 可以说是私钥相关的安全体系。PKI 通过使用公钥和私钥来实现数据的加密和解密，从而保证数据的安全性。

以下是 PKI 的一些主要功能：

- 身份验证：PKI 可以通过数字证书来验证用户的身份，从而防止用户冒充他人。（假设前提信任 CA，CA 是
- 数据加密：PKI 可以通过公钥加密来保护数据的安全性。
- 数字签名：PKI 可以通过数字签名来保证数据的完整性和不可否认性。

---


是的，PKI 体系颁发给普通用户的数字证书，包含了一个公钥和一个私钥。公钥用于加密数据，私钥用于解密数据。

在 PKI 体系中，用户需要持有自己的私钥，并将公钥保存在数字证书中。当用户需要与其他用户进行通信时，可以使用对方的公钥来加密数据，然后将数据发送给对方。对方可以使用自己的私钥来解密数据。

因此，在 PKI 体系中，用户需要自己保管好自己的私钥，避免泄露。如果私钥泄露，则对方的公钥可以用来加密数据，而对方可以使用自己的私钥来解密数据，从而获取用户的敏感信息。

为了保护用户的私钥安全，通常会使用以下措施：

- 将私钥存储在安全的设备中，例如 U 盘或硬盘。
- 使用强密码来保护私钥。
- 定期更换私钥。

以下是 PKI 体系颁发给普通用户的数字证书中包含的信息：

- 用户的身份信息，例如姓名、地址、电子邮件地址等。
- 用户的公钥。
- 证书颁发机构的签名。

证书颁发机构的签名用于保证数字证书的真实性和完整性。

------

BLAKE3 是 2020 年发布的一种哈希函数，由 Daniel J. Bernstein 设计。BLAKE3 是一种 keyed hash 函数，即在计算哈希值时需要使用一个密钥。BLAKE3 的哈希值长度为 256 位，并且是抗碰撞的。

BLAKE3 的设计目标是：

- 高效：BLAKE3 的计算速度比 SHA-256 快 20% 以上。
- 安全：BLAKE3 是抗碰撞的，并且可以抵御各种攻击。
- 简单：BLAKE3 的设计简单，易于实现和理解。

BLAKE3 已被广泛应用，包括：

- 以太坊 2.0 中的密码学算法
- Filecoin 中的密码学算法
- Zcash 中的密码学算法
- Chia 中的密码学算法

**BLAKE3 的算法流程**

BLAKE3 的算法流程如下：

1. 初始化：BLAKE3 哈希函数需要初始化一些变量，包括：
   - 一个 256 位的初始化向量
   - 一个 256 位的密钥
2. 消息分组：将消息分成 1024 字节的块。
3. 消息扩展：对消息块进行扩展，生成 1024 个 32 位字。
4. 压缩函数：对 1024 个 32 位字进行压缩，生成 16 个 32 位字。
5. 哈希值：将 16 个 32 位字连接起来，得到最终的哈希值。

**BLAKE3 的优点**

BLAKE3 具有以下优点：

- 高效：BLAKE3 的计算速度比 SHA-256 快 20% 以上。
- 安全：BLAKE3 是抗碰撞的，并且可以抵御各种攻击。
- 简单：BLAKE3 的设计简单，易于实现和理解。

**BLAKE3 的缺点**

BLAKE3 具有以下缺点：

- 未经审查：BLAKE3 是相对较新的算法，尚未经过长期的审查。

**结论**

BLAKE3 是一种高效、安全、简单的哈希函数，已被广泛应用。

-----


BIP39 是比特币改进提案 (BIP) 系列中的第 39 号提案，定义了一种生成和存储加密私钥的标准方法。BIP39 使用助记词来生成私钥，助记词是一系列容易记忆的单词。

BIP39 的目标是：

- 为用户提供一种安全、易于使用的私钥生成和存储方法。
- 使私钥可以跨平台、跨设备使用。

**BIP39 的工作原理**

BIP39 使用 2048 个单词的词库来生成助记词。助记词的长度可以是 12、15、18 或 24 个单词。助记词生成过程如下：

1. 使用随机数生成器生成一个 256 位的私钥。
2. 使用私钥计算一个 256 位的种子。
3. 使用种子生成一个助记词。

助记词可以通过多种方式存储，例如纸质、硬件设备或数字文件。

**BIP39 的优点**

BIP39 具有以下优点：

- 安全：助记词生成过程使用了随机数生成器和哈希函数，可以生成安全可靠的私钥。
- 易用：助记词是由容易记忆的单词组成的，可以方便用户存储和备份私钥。
- 跨平台：BIP39 是标准化的，可以跨平台、跨设备使用。

**BIP39 的缺点**

BIP39 具有以下缺点：

- 助记词长度越长，私钥越安全，但也越难记忆。
- 助记词需要仔细保管，如果丢失或泄露，可能会导致私钥丢失，从而导致资产损失。

**结论**

BIP39 是一种安全、易用、跨平台的私钥生成和存储标准。BIP39 已被广泛应用于加密货币、区块链和其他领域。

------

以太坊的 EOA 基于的助记词生成私钥原理，技术上是来源于 BIP39 的。BIP39 定义了一种生成和存储加密私钥的标准方法，包括助记词的生成、验证和使用。以太坊的 EOA 使用 BIP39 标准来生成助记词，然后使用助记词来生成私钥。

以太坊的 EOA 助记词生成原理如下：

1. 使用随机数生成器生成一个 256 位的私钥。
2. 使用私钥计算一个 256 位的种子。
3. 使用种子生成一个助记词。

这个过程与 BIP39 标准的助记词生成过程完全相同。

以太坊的 EOA 助记词生成原理使用了 BIP39 标准，因此具有 BIP39 标准的所有优点，包括安全、易用、跨平台。

此外，以太坊还发布了 EIP-55 提案，定义了以太坊钱包助记词的标准格式。EIP-55 提案要求以太坊钱包助记词必须使用 BIP39 标准生成，并且助记词的长度必须是 12、15、18 或 24 个单词。

因此，可以说以太坊的 EOA 基于的助记词生成私钥原理，技术上是来源于 BIP39 的，并遵循了 EIP-55 提案的标准。

----



Encryption Key History：密钥的历史（自己写一个课程或者 paper review）

```
Communications and Wars: Encryption
Communications and Financial: Privacy
Decentralized and Trustless: Protection
BIP39 and EIP55
Why the smartest guys focus on the encrypt and decrypt? 
Rights for human, you can use tool to protect the things your care about.
Quick review of Cryptography
The Keys is key to the protection

```



https://twitter.com/blockaid_ , https://www.blockaid.io/

```
Transaction Security
Simulation
Speed is critical for UX, which is why Blockaid provides the fastest simulations. Guaranteed.
Validation
By working with industry leaders, Blockaid analyzes the largest set of transaction data.
Full Coverage
Simulate offchain signatures as well as onchain transactions, across any chain.
---
dApp Security
Threat Prevention
Proactively protect users from interacting with malicious dApps.
Instant Detection
Proprietary technology powers Blockaid to be the first to detect any malicious dApp.
Robust Data
Securing industry leaders who serve millions of users ensures Blockaid has superior data.
---
Token Security
Wide range of attacks
From malicious airdrops to scam tokens, Blockaid detects any method of attack.
Real-time detection
Instantly block malicious tokens as soon as they are sent to your users.
Any Token Type
Whether it’s an NFT or other token, we’ve got you covered.
```

----

素数群，群定义：内部元素运算封闭性和每个元素都有逆元，存在单位元 e

若某个元素通过运算生成群内所有元素，则此元素为群的生成元

例如{0,1,2,3,4,5,6}模系数为 7，是一个加法素数群

基于群理论，若已知私钥 SK=5，生成元 g=3，PK=3^5，计算方式：PK=g 的 sk 次方

已知公钥 PK 和 g 生成元，计算私钥 SK，需要指数时间暴力搜索，若 SK 的空间为 256bit，则暴力搜索时间为 2 的 256 次方，理论上不可行。

密码学基础：**离散对数困难问题**，已知生成元 g 和公钥 PK，不能在多项式时间内求 SK（DL）

CDH 计算性 Diffle Hellman 问题，DDH，判断性 Diffle Hellman 问题，DL 是标准困难问题，是最安全的困难问题

素数群上有上述困难（DL，CDH，DDH）

椭圆曲线群几乎和素数群相同，计算速度不一样，相同安全等级下，需要的私钥程度更小

椭圆曲线不是椭圆，只因为和椭圆曲线方程类似，都是三次方程

y2+axy+by=x3+cx2+dx+e，椭圆曲线还有一个无穷远点（零点）的概念

Abel 群：

```
阿贝尔群（Abelian group）也称为交换群或可交换群，是满足其元素的运算不依赖于它们的次序的群。阿贝尔群推广了整数集合的加法运算。阿贝尔群以挪威数学家尼尔斯·阿贝尔命名。

阿贝尔群的定义如下：

一个集合 G 加上一个二元运算 * 构成一个群，如果满足以下条件：
结合律：对于任意的 a、b、c ∈ G，有 (a * b) * c = a * (b * c)。
有单位元：存在一个元素 e ∈ G，使得对于任意的 a ∈ G，有 e * a = a * e = a。
每个元素都有逆元：对于任意的 a ∈ G，存在一个元素 b ∈ G，使得 a * b = b * a = e。
如果一个群满足交换律，即对于任意的 a、b ∈ G，有 a * b = b * a，则称这个群为阿贝尔群。
阿贝尔群的特点是：

群运算满足交换律。
群元素有逆元。
群具有单位元。
阿贝尔群在数学中有着广泛的应用，包括：

模论
线性代数
抽象代数
群论
拓扑学
物理学
在计算机科学中，阿贝尔群也被用于：

密码学
数据结构
算法
以下是一些阿贝尔群的例子：

整数集合 Z 加上加法运算。
复数集合 C 加上加法运算。
实数集合 R 加上加法运算。
矩阵集合加上乘法运算。
对称矩阵集合加上乘法运算。
伽罗华群。
阿贝尔群是群论中的一个重要概念，它在数学和计算机科学中有着广泛的应用。
```





```
在密码学中，多项式时间是指复杂度是关于输入长度n的多项式函数。例如，一个复杂度为O(n^2)的算法，意味着随着输入长度的增加，算法的运行时间将会以n^2的速度增长。

离散对数困难问题是指，给定一个生成元g和一个公钥pk，计算私钥sk的算法不能在多项式时间内求解。如果存在一个多项式时间的算法，那么就可以用这个算法来破解基于离散对数的密码系统，例如RSA和ECC。

目前，尚未找到一个多项式时间的算法来破解离散对数困难问题。因此，基于离散对数的密码系统被认为是安全的。

在以太坊中，私钥是通过椭圆曲线数字签名算法（ECDSA）生成的。ECDSA使用椭圆曲线群来生成公钥和私钥。在椭圆曲线群中，生成元g和公钥pk是已知的，而私钥sk是未知的。

离散对数困难问题是基于椭圆曲线群的密码学系统的安全基础。如果存在一个多项式时间的算法来破解离散对数困难问题，那么就可以用这个算法来破解基于椭圆曲线群的密码学系统，例如以太坊的ECDSA签名。

因此，离散对数困难问题是一个重要的密码学问题，其安全性直接影响了基于离散对数的密码学系统的安全性。
```



公钥加密：利用群的困难问题，来构造

例如，基于素数群的 ElGamal 加密，

系统参数：素数群的阶数为 p，生成元为 g

密钥生成：选择随机数 alpha 属于 zp（下标），计算 g1=galpha（上标），则私钥和公钥为（alpha，g1）

加密：将消息编码为群元素 m 属于 G，公钥 g1，选择随机数 r 属于 zp（下标），计算密文：

群：加法运算 + 逆元-->环：加法 + 乘法运算，但不是都有乘法逆元-->域：加法 + 乘法运算，都有逆元

二次剩余（开平方）

1 平方 mod7=1

2 平方 mod7=4

3 平方 mod7=2

4 平方 mod7=2

...

二次非剩余，就是开根号开不了

扩张子群，域的扩张，引入 j

BLS 签名：包括三个算法，密钥生成，签名和验证，仅有一个随机因子作为私钥

因为 CDH 是困难问题，则签名不可伪造，规约损失为 qH，40bit 损失，384bit 密钥签名安全性为 344bit，仅用于共识投票，不用于交易签名

EcDSA 和 EDCSA，私钥长度仅为 256bit

BLS 的优点：

1.允许不同实体对不同消息的签名集合到一个签名中，且拥有所有签名的任意节点均能够聚集签名（所以用于共识投票签名）

2.允许加入新成员

3.任意两个签名集合后，允许第三个签名聚合到改签名中

----

区块链的上下区块的连接 hash 是通过哈希函数计算得到的。哈希函数是一种单向函数，将任意长度的输入数据转换为固定长度的输出数据。在区块链中，通常使用 SHA-256 哈希函数来计算连接 hash。

**比特币**

在比特币中，每个区块的连接 hash 是由该区块的头部信息计算得到的。区块头部信息包括以下内容：

- 前一个区块的连接 hash：这是上一个区块的连接 hash，用于将当前区块与上一个区块连接起来。
- 时间戳：这是当前区块生成的时间戳。
- 难度值：这是当前区块的难度值，用于控制生成新区块的难度。
- 随机数：这是用于生成新区块的随机数。
- 交易列表：这是当前区块中的交易列表。

比特币使用以下公式来计算连接 hash：

连接 hash = SHA-256(前一个区块的连接 hash || 时间戳 || 难度值 || 随机数 || 交易列表)

其中，|| 表示连接符。

**以太坊**

在以太坊中，每个区块的连接 hash 是由该区块的头部信息计算得到的。区块头部信息包括以下内容：

- 父区块的连接 hash：这是上一个区块的连接 hash，用于将当前区块与上一个区块连接起来。
- 时间戳：这是当前区块生成的时间戳。
- 难度值：这是当前区块的难度值，用于控制生成新区块的难度。
- 随机数：这是用于生成新区块的随机数。
- 状态根：这是当前区块的状态根，用于表示当前区块中所有状态的哈希值。

以太坊使用以下公式来计算连接 hash：

```
连接hash = SHA-3(父区块的连接hash || 时间戳 || 难度值 || 随机数 || 状态根)
```

其中，|| 表示连接符。

**技术细节**

在实际计算中，为了提高计算效率，通常会将区块头部信息转换为二进制格式，然后再进行哈希计算。

在比特币中，区块头部信息的大小为 80 个字节，因此转换为二进制格式后，大小为 640 个比特。

在以太坊中，区块头部信息的大小为 96 个字节，因此转换为二进制格式后，大小为 768 个比特。

**作用**

区块链的上下区块的连接 hash 具有以下作用：

- 用于将区块链中的区块连接起来，形成一个链式结构。
- 用于验证区块的有效性。
- 用于防止区块被篡改。

在区块链中，每个区块的连接 hash 都包含了上一个区块的连接 hash。因此，如果要篡改一个区块，就必须重新计算该区块的连接 hash，并使其与上一个区块的连接 hash 相匹配。这是一个非常困难的任务，因为哈希函数是一种单向函数。

---

在区块链中，状态根（state root）是指区块中所有状态的哈希值。状态包括了所有账户余额、合约状态、交易信息等。

在以太坊中，状态根是通过 Merkle 树来计算得到的。Merkle 树是一种二叉树，每个节点的值都是其子节点的哈希值。在以太坊中，状态根是 Merkle 树的根节点的哈希值。

具体的计算方式如下：

1. 将所有状态数据转换为二进制格式。
2. 将这些二进制数据构建成 Merkle 树。
3. 计算 Merkle 树的根节点的哈希值。

在实际计算中，为了提高计算效率，通常会使用 Merkle Patricia 树（MPT）来代替 Merkle 树。MPT 是一种带权 Merkle 树，可以更有效地存储和查询状态数据。

----

### Banana notes



Banana 什么：Smart contract wallet infrastructure for key management and 2FA solutions.

工作原理：https://docs.bananahq.io/overview/how-does-it-works



The Banana wallet SDK provides a set of modules to allow developers to initialize, deploy and interact with smart contract wallets. Under the hood, SDK leverages TypeScript, circom and ethers.js, webAuthn and certain other technologies to make the process secure and UX-friendly.

Devs can integrate banana wallet SDK in their dApp to enable easy onboarding of users and higher security for users. 

SDK 彼此独立（ZKP 部分还没有完全公开）



```
npm install @rize-labs/banana-wallet-sdk
yarn add @rize-labs/banana-wallet-sdk
```

两个方式验证：OTP 一次性密码和基于 TEE 的 passkey？

Our SDK provides two modes of transaction authentication which is OTP based two-factor authentication and touchID-based signing.

--------

**简介**
我们都知道，要运行 ERC-4337，通常需要一些集中式组件。我在这里用一种新方法来创建一个完全去中心化的、抽象的账户钱包。

只需使用用户名和密码即可创建和访问该钱包。只要使用正确的用户名和密码，就可以从任何外部拥有账户 (EOA) 发起资金支出交易。

您可以使用任何人的 EOA 来花费您的 sc 钱包中的资金，并且无论谁发起交易，都可以在同一笔交易中获得他们支付的汽油费。如果您的设备上没有设置 EOA，您可以使用后端服务从钱包进行交易，而不会影响安全性。这样花费资金只需要用户名、密码和互联网。

该钱包的安全性，包括密码验证和用户操作有效性，都是由 zk-SNARKs 支持的。其他功能包括从智能合约钱包支付 Gas 费和非原生 Gas 支付。

**1. 钱包创建**

- 用户可以通过提供用户名和密码来创建钱包。密码经过哈希处理，然后与用户名一起发送到工厂智能合约。哈希密码映射到用户名，并部署钱包合约，其地址与用户名和哈希密码映射。钱包合约归工厂所有，只有一个功能，即***multicall***，只能由工厂合约访问。

**2. 支出资金**

- 每当用户希望从钱包中支出资金时，他们需要提供用户名、确认实际密码的 zk 证明以及前端生成的 userOps。
- zk 证明生成需要三个输入：1) 密码、2) 哈希密码和 3) userOps。zk 约束检查用户是否知道与哈希密码相对应的密码（原像）。此外，该电路还会验证所提供的 userOps 是否符合用户的意图，从而消除抢先攻击的可能性。确认这些条件后，zk 证明就生成了，可以在链上验证。
- 当用户选择用户名、密码和 userOps（例如交换、转移代币、铸造 NFT 等）时，zk 证明会在前端生成。zk 证明生成后，将触发 Factory 合约中的“callWallet”功能。
- 该函数验证 zk 证明，存储证明的哈希值以防止重复使用，并在成功验证后检索与哈希密码关联的钱包合约的地址。随后，执行该钱包的*“multicall”*功能，并执行 userOps。

需要考虑的一个重要方面是，该钱包的安全性依赖于波塞冬哈希，该哈希用于根据密码创建哈希，并且对 snark 友好。我非常感谢社区的任何反馈，并欢迎社区成员对波塞冬哈希的见解。

https://ethereum-magicians.org/t/a-fully-decentralized-account-abstracted-zk-leveraged-smart-contract-wallet/16223

----

经验

1.ppt 展示时间 90 秒？

所以给出大字和关键词亮点

#### Why build AirAccount?

1.Gap and Benefits

There are so many barriers for Normal Guys to the Blockchain:

Bad UX, Tech Difficulty, No Internet or Smartphone and more.

Account Abstraction is a feature on Ethereum Roadmap to **mass adoption**.

It need get rid of all this problems with decntralized and diversity components.

So we create AirAccount **components** for Account Abstraction:

A Decentralized Ethereum Account Solution with **Easy, Affordable and Security**.



#### What is Air Account?

**AirAccount is an Ethereum application account framework built on Account Abstraction(EIP4337).**

It is an Opensource framework to **Bridge** Anyone with any applications to the Ethereum.

It is a Basic **Interface** for any Instructions from Any Network to the Blockchain.

We implemented an SMS module, an SMS Purse to test the idea and get feedback.

![](https://raw.githubusercontent.com/jhfnetboy/MarkDownImg/main/img/202311121038813.png)



#### Does it security?

1. Balance Alert in customization channels(SMS, Email and more).
2. Daily limitation in you EIP4337 Wallet Contract.
3. Large secondary validation(2FA) with your second mobile or second Email.
4. Every transaction with signatures and verifications by Gateways or Community Nodes who will stake.
5. Random number send by users and verified by random gateway and Community Nodes.
6. One key Social Recovery with Community Nodes being Guardians on a Layer2.5 with low cost.
7. More question or thoughts just touch our team...



#### Questions

1. Who should use AirAccount?
   1. Anyone can use AirAccount as **daily purse** which it's balance is lower than 1000U.
   2. And enjoy the convinience by AirAccount.
2. Where is my private key?
   1. It will be kept with multi-sig encryption by staking community nodes council.
   2. It will sign your transactions with a ZKP on-chain to verify if be authorizd by you.
3. If my private been stolen or Community Nodes Evil?
   1. Every transaction will be verified by random gateway and random Community Nodes.
   2. If the trasaction related gateway or Community Nodes be evil, random verifier will report and  get the reward which slashed from evil's stake.
4. The last Killer Characteristics
   1. One key Social recovery with daily limitation and low cost.
   2. Slash the evil nodes if verify failed.

#### How to use?

We can use the SMS module with conception product now.

1. Website: show a decentralized gateway list, or you can find gateways by p2p protocol
2. Use your mobile send a message to gateway: create account or click create account with your mobile on the website!
3. Then you will get a message: account created succesfully!
4. [Assume you have a AA with 137%&^,  your firends has 136^&* or address 0x*&^%#] Type "send 10u to 136 ^%&" in your mobile, send sms to any decntralized gateway(you can find in DApp homepage)
5. If be finished, you and your friend will get the result: Transfer successfully 
6. DApp operation: (picture)
   1. Who has no AirAcount can transfer tokens to any AirAcount using DApp
   2. Who has AirAccount can transfer to any other AirAccount

#### For developers

1. You can **fork**  or use **SDK** solution to build amazing wallet based on AA, like Email wallet, Application specified Wallet and more.
2. You can benefit from our **Decentralized** Gateway and Community Nodes **Network** with security and convenience.
3. We will support linking with any other AA wallet to provide AirAccount Services: **Easy, Affordable and Security** in the future.

2.图形传递更重要

估计 6-7 page，快速说下定位和价值，技术和产品交互

Done(craft, pic later)

3.Demo 演示，真实产品秀或者 video

这个一定要有，最好是 youtube 链接（可以点开演示）+ 现场秀（不一定有时间）

build a repo and begin to test

4.参赛期间完成内容

核心点：去中心化机制设计

问题列表讨论和设计



5.使用现成的模板，套装，效果不错

记得说明用了谁的模板和技术

Rory 建议下

Seplia test net?

vite，vercel



6.一些问题：去中心化的设计，为何用区块链来解决等

We need bridges like SMS, Email to down the cost of massadoption.

And we also need a decentralized way to guarantee the security.

So we get this idea: a decentralized framework to scale the Acount Abstraction.



#### TODO

1. (Register a domain), access the AirAccount.com? 

2. AI PPT?

3. 确定搭建的技术和平台

   1. Node+ GO，部署在 Vercel？https://www.xuthus.cc/go/vercel-run-go.html
   2. 前端 DApp 使用啥框架？vue+css tailwind
   3. 基于 Goerli/sepolia，有一点测试币了，晚上继续挖点

4. 增加一个 WebPage Adaptor，感觉需要增加 webassembly 的代码，来保障一些

5. 我们如果开发了 webpage adaptor，那基本上 metamask 的小狐狸有个 snap，我们可以在那上面开发二次插件

6. ENS Adaptor：免费 ens，给所有钱包，

7. MetaMask adaptor：任意 snap 插件可以调用我们

8. 商家钱包：定制，去中心化商家，AI 为引擎

9. ENS 的奖金：https://ethglobal.com/events/istanbul/prizes/ens，https://thorin.ens.domains/playroom

10. ```
    CCIP 是“Chainlink Context Info Protocol”
    {
      "holders": [
        {
          "address": "0x1234567890abcdef",
          "weight": 1
        },
        {
          "address": "0xabcdef0123456789",
          "weight": 2
        }
      ]
    }
    https://github.com/ensdomains/evmgateway
    https://docs.ens.domains/dapp-developer-guide/ens-l2-offchain
    ```

11. ```
    用 Rust 写智能合约
    https://www.youtube.com/watch?v=CF1hLTGnByM
    1. https://docs.arbitrum.io/stylus/stylus-quickstart
    2. https://arbitrum.notion.site/Arbitrum-Hacker-Tool-Kit-Stylus-375a142fcbee4e6a8c62bd0022f13138
    ```

    **AirAccount is an Ethereum application account framework built on Account Abstraction(EIP4337).**

    It is an Opensource framework to **Bridge** Anyone with any applications to the Ethereum.

    It is a Basic **Interface** for any Instructions from Any Network to the Blockchain.

    We implemented an SMS module, also a Purse to test the idea and get feedback.

    ![](https://raw.githubusercontent.com/jhfnetboy/MarkDownImg/main/img/202311121038813.png)

    How do you think about using your mobile to send an SMS and get an Ethereum account? 
    And you can get and transfer tokens with your mobile phone number.
    How about Email? Telegram? Discord? MetaMask Snap? ENS?  and more. Any applications that can bind with an Ethereum account based on account abstraction.
    We try to build an Ethereum application account framework for the mass adoption of the Ethereum human digital future.
    AirAccount comprises Adaptors, Gateways, and Community Nodes, forming a decentralized network that safeguards your wallet.

12. Welcome to AirAccount! :wave:

    AirAccount is an Ethereum application account framework built on Account Abstraction(EIP4337).

13. 引入 AI（本地化 AI，运行在社区节点上，用区块链安全知识和行为为基础的安全模块和意图指令模块）





````
Quick view

 Three repositories
 https://github.com/AAStarCommunity/Adapters/tree/main
 https://github.com/AAStarCommunity/Gateway/tree/main
 https://github.com/AAStarCommunity/CommunityNode
 
 TODO:
 Service Contract(this time we build based on Etherspot SDK)
 
npm run execute batch-create 5
Clear db old data

http://localhost:8000/swagger/index.html

User in Istanbul: 8613675883500 
send "create" to adapters
send "transfer 0.01 to 8613805720368" to to adapters
send "query" to adapters

Bind result:
0x0Af8828AFdCA47e6E7C570a41Efb763c9b5E3a96
0xda55b66a6d0b089a374d7b99e14ab67421c292e5060c3bb3e484410ceccd3d42
User in China: 8613805720368 0x1E22bb49c70E9c6D5106d572C5646C64dC8D2CA0
0x03c9e0c3b5e0fc56d875cf487f414ec0a7413b052ff371711305c78cf2665cfd

Manually transfer to 0x0Af8828AFdCA47e6E7C570a41Efb763c9b5E3a96 0.05ETH(Seplia)

Gateway: 
1. balance query confirm
2. tranfer 0.01 
```
{
  "receiver": "8613805720368",
  "value": "0.01"
}
```
3.balance query with output ophash
0xe44527b04387f8e20cf4bc78dbb35bee43811ca84c4435047cdf22608ccb1d0d

4. https://sepolia.etherscan.io/
query onchain balance 
or
use gateway query


Random SMS Adapter(fake): 8619858103329

0xf94603688eba64993493595c24868b470cf2e82b898443c7297e7a04f57f85a0

https://docs.google.com/presentation/d/1Iq-Nkw-e5mdOQ3kqHmAgnlYE-f0cyx0hak-UBn6gt6A/edit?usp=sharing
````

```
Here's what we built:

**Name**: ✈️ AirAccount
**Description**: AirAccount is an Ethereum application account framework built on Account Abstraction.
**Github**: https://github.com/AAStarCommunity/WebsiteAirAccount

Public URL: https://ethglobal.com/showcase/airaccount-swqix
```

-----

https://docs.google.com/presentation/d/1iM1PhLSYt_HIzQ4k0pjrTQDjXWu6MabhEU0Rh8q1L2w/edit?usp=sharing

入口：https://ethglobal.com/events

![👻](https://fonts.gstatic.com/s/e/notoemoji/15.0/1f47b/72.png) **LFGHO** (January 12-24, 2024)    

![🔌](https://fonts.gstatic.com/s/e/notoemoji/15.0/1f50c/72.png) **Circuit Breaker** (February 2-21, 2024)

![💂🏻](https://fonts.gstatic.com/s/e/notoemoji/15.0/1f482_1f3fb/72.png) **ETHGlobal London** (March 15-17, 2024)

![⚖️](https://fonts.gstatic.com/s/e/notoemoji/15.0/2696_fe0f/72.png) **Scaling Ethereum 2024** (April 5-26, 2024)

![🦘](https://fonts.gstatic.com/s/e/notoemoji/15.0/1f998/72.png) **ETHGlobal Sydney** (May 3-5, 2024)

![🇧🇪](https://fonts.gstatic.com/s/e/notoemoji/15.0/1f1e7_1f1ea/72.png) **ETHGlobal Brussels** (July 12-14, 2024)

![💻](https://fonts.gstatic.com/s/e/notoemoji/15.0/1f4bb/72.png) **ETHOnline 2024** (August 23-13, 2024)

![🇸🇬](https://fonts.gstatic.com/s/e/notoemoji/15.0/1f1f8_1f1ec/72.png) **ETHGlobal Singapore** (September 20-22, 2024)

![🌁](https://fonts.gstatic.com/s/e/notoemoji/15.0/1f301/72.png) **ETHGlobal San Francisco** (October 18-20, 2024)



1. OP Stack 是唯一选择么？Arbi 有一个游戏链，包括其他技术栈/生态的调研？
2. Savour 的架构图和开放性？
3. 除了当下缺少模块的 builder 身份加入，应用方，链方，或者其他合作方式？合作伙伴？
4. Blast 同样是 OP Stack 的，融资就 2000 万，我们项目定位是为这些 OP Stack 的 Layer2，提供 Layer3 的解决方案？，架构上是能够和任何 OP Stack 的 Layer2 共存和应用搭建，并且提供这一层之上的所有 Layer3 应用层的互通协议？

----



Privy 旨在通过 Web3 方案解决多钱包用户体验不佳与集成登录的隐私风险泄漏之间的矛盾。

据 Foresight News 报道，据《财富》杂志报道，Web3 初创公司 Privy 完成 1800 万美元 A 轮融资，Paradigm 领投，红杉资本等参投。Privy 是一个钱包公司，为餐饮服务 Blackbird 与体育卡网站 Courtyard 等公司提供支持。红杉资本前合伙人、Stripe 董事会成员 Huang 将加入 Privy 董事会。

https://savour-labs.github.io/

---

比特币的发展史可以分为以下几个阶段：

**早期阶段（2009-2013）**

比特币于 2009 年由中本聪发布，当时只是一个小众的实验项目。在这一阶段，比特币的技术和生态系统还处于早期发展阶段。

**快速发展阶段（2013-2017）**

2013 年，比特币的价格开始大幅上涨，吸引了越来越多的关注。这一阶段，比特币的技术和生态系统也得到了快速发展。

**成熟阶段（2017-至今）**

2017 年，比特币的价格再次大幅上涨，并达到了历史最高点。这一阶段，比特币的技术和生态系统已经相对成熟，并开始在一些领域得到应用。

**学术相关的进展**

比特币的诞生和发展，引起了学术界的广泛关注。学者们从不同角度对比特币进行了研究，主要包括以下几个方面：

- 比特币的经济学分析：学者们研究了比特币的供需关系、价格走势、以及对经济的影响等。
- 比特币的安全性分析：学者们研究了比特币的安全机制、以及可能存在的攻击手段等。
- 比特币的技术分析：学者们研究了比特币的技术原理、以及未来的发展趋势等

----

#### 请解释硬件设备上的指纹设备原理，这样理解对不对：指纹作为唯一随机数来源，和硬件的算法计算后，产生一个唯一的 keypair，然后使用这个私钥来给外部签名，公钥验证

您理解的硬件设备上的指纹设备原理是正确的。

硬件设备上的指纹设备通常由以下几个部分组成：

- 指纹传感器：用于采集用户的指纹信息。
- 指纹识别模块：用于识别用户的指纹信息。
- 加密模块：用于生成指纹密钥对。

当用户将手指按在指纹传感器上时，指纹传感器会采集用户的指纹信息，并将这些信息传递给指纹识别模块。指纹识别模块会对指纹信息进行分析，并验证是否与用户注册的指纹信息匹配。如果匹配成功，则表示用户已被验证。

如果用户验证成功，则加密模块会使用指纹信息作为随机数来源，并生成一个唯一的密钥对。这个密钥对包括一个私钥和一个公钥。私钥保存在硬件设备中，而公钥则可以通过某种方式提供给外部。

当用户需要使用指纹进行身份认证时，可以使用私钥对某些数据进行签名。外部可以使用公钥对这些数据进行验证，以确认签名者是谁。

具体来说，指纹作为唯一随机数来源，是指指纹信息具有高度的随机性。指纹的纹理、形状等特征都非常独特，即使是同一人的两个指纹也不完全相同。因此，指纹信息可以用来生成唯一的密钥对。

硬件的算法计算是指指纹识别模块在生成密钥对时使用的算法。这个算法通常需要考虑指纹信息的随机性、安全性等因素。

使用私钥来给外部签名是指用户可以使用私钥对某些数据进行加密。外部可以使用公钥对这些数据进行解密，以验证签名者是谁。

因此，您理解的硬件设备上的指纹设备原理是正确的。

---

## 如何构建一个软件 TEE 环境，有成熟方案么

edit

查看其他草稿

构建一个软件 TEE 环境需要以下步骤：

1. 选择一个 TEE 架构。TEE 架构定义了 TEE 的安全性和功能特性。常见的 TEE 架构包括：

   - ARM TrustZone

     [![ARM TrustZone TEE 架构的图片](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPKbeE9-u9X3clCdFsHeiV3oBDXA1pHKG2-ACvlo6LuNPXr4s7SqfoHvQfwa-E)在新窗口中打开](https://blog.csdn.net/weixin_38503885/article/details/102504814)[![img](https://encrypted-tbn2.gstatic.com/favicon-tbn?q=tbn:ANd9GcRMrh42tUEqnfDhcLTe47svm8Zyp0kpZuNxf662CZfkjYUZGMY4JdgkIZohnaRzZ3oGQ4xJi66NU5TssT8rkJEG_Zk1LDVA0A)blog.csdn.net](https://blog.csdn.net/weixin_38503885/article/details/102504814)

     ARM TrustZone TEE 架构

   - Intel SGX

     [![Intel SGX TEE 架构的图片](https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR1HQmgERXLTyq37chN52poDBP_3UpgLLGMnAlIT6F6HHObK0Tl_ONFeGoPWv4K)在新窗口中打开](https://blog.csdn.net/qq_41691212/article/details/133848112)[![img](https://encrypted-tbn2.gstatic.com/favicon-tbn?q=tbn:ANd9GcRMrh42tUEqnfDhcLTe47svm8Zyp0kpZuNxf662CZfkjYUZGMY4JdgkIZohnaRzZ3oGQ4xJi66NU5TssT8rkJEG_Zk1LDVA0A)blog.csdn.net](https://blog.csdn.net/qq_41691212/article/details/133848112)

     Intel SGX TEE 架构

   - AMD SEV

     [![AMD SEV TEE 架构的图片](https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSP9zysdLVAdkxdTNsdhrj27JbIrCP8D7BGNgBdsUewqVqew_HCxjbf1iHpZsN2)在新窗口中打开](https://blog.51cto.com/u_15308345/4992962)[![img](https://encrypted-tbn1.gstatic.com/favicon-tbn?q=tbn:ANd9GcQJC8ecLNMZc5BAeaL2qqHXC5RSr3GbnSR_DYscC64o-yWieizL5OZnuzTdMKBxH50OcEBt_a1gLnzcfKLWgNN87x2BZMHjevE)blog.51cto.com](https://blog.51cto.com/u_15308345/4992962)

     AMD SEV TEE 架构

2. 实现 TEE 软件。TEE 软件负责实现 TEE 的安全性和功能特性。常见的 TEE 软件包括：

   - OP-TEE 

     [![OPTEE TEE 软件的图片](https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTjAmyaKX240BZOvzhhR8qmSe-FAVv15OgXW3MOio6xu9ii_6J77pD49rCp165k)在新窗口中打开](https://blog.51cto.com/u_15075514/4316505)[![img](https://encrypted-tbn1.gstatic.com/favicon-tbn?q=tbn:ANd9GcQJC8ecLNMZc5BAeaL2qqHXC5RSr3GbnSR_DYscC64o-yWieizL5OZnuzTdMKBxH50OcEBt_a1gLnzcfKLWgNN87x2BZMHjevE)blog.51cto.com](https://blog.51cto.com/u_15075514/4316505)

     OPTEE TEE 软件

     

   - TrustZone-M

   - Intel SGX SDK 

     [![Intel SGX SDK TEE 软件的图片](https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQMVugRoYuhdxqO-bHWomcoDqQ-uWEe2ugUtBLvog8ckrGSnl5zhF7StKcutKDE)在新窗口中打开](https://www.secrss.com/articles/54023)[![img](https://encrypted-tbn0.gstatic.com/favicon-tbn?q=tbn:ANd9GcQqNZ9H219iRhMz2oP061kQ-Woa-96YTZitEwoFSfKBxt8cmjdPmz7dU68XKhW51fUzU2AhMfCVjLKPyriofkaJ0dvI6zsNqN0)www.secrss.com](https://www.secrss.com/articles/54023)

     Intel SGX SDK TEE 软件

     

3. 将 TEE 软件部署到目标硬件平台。TEE 软件需要部署到目标硬件平台，才能运行。常见的部署方法包括：

   - 固件部署
   - 操作系统部署
   - 应用程序部署

目前，有一些成熟的软件 TEE 方案，包括：

- OP-TEE：OP-TEE 是一个开源的、基于 ARM TrustZone 的 TEE 软件。它提供了丰富的功能特性，包括：
  - 安全启动
  - 内存隔离
  - 数据加密
  - 安全应用
- TrustZone-M：TrustZone-M 是 ARM TrustZone 的低功耗版本。它提供了基本的 TEE 功能特性，包括：
  - 安全启动
  - 内存隔离
- Intel SGX SDK：Intel SGX SDK 是一个用于开发和部署 Intel SGX TEE 软件的工具包。它提供了丰富的功能特性，包括：
  - 安全启动
  - 内存隔离
  - 数据加密
  - 安全应用

具体选择哪种方案，需要根据目标硬件平台和应用需求来决定。

----

是公钥密码学领域的一些经典论文：



- 

- **Diffie, Whitfield, and Martin Hellman. "New directions in cryptography." IEEE transactions on information theory 22.6 (1976): 644-654.**
- 



这篇论文提出了公钥密码学的基本概念，包括公钥密钥对、非对称加密和数字签名。



- 

- **Merkle, Ralph C. "A digital signature based on a linked list." Proceedings of the 1987 IEEE Symposium on Security and Privacy (S&P '87). IEEE, 1987.**
- 



这篇论文提出了 Merkle 树，用于实现数字签名。



- 

- **Rivest, Ronald L., Adi Shamir, and Leonard Adleman. "A method for obtaining digital signatures and public-key cryptosystems." Communications of the ACM 21.2 (1978): 120-126.**
- 



这篇论文提出了 RSA 算法，一种常用的公钥加密算法。



- 

- **ElGamal, Taher. "A public key cryptosystem and a signature scheme based on discrete logarithms." IEEE transactions on information theory 31.4 (1985): 469-472.**
- 



这篇论文提出了 ElGamal 算法，另一种常用的公钥加密算法。



- 

- **Schnorr, Claus Peter. "Efficient signature generation for the discrete logarithm problem." In Advances in cryptology-EUROCRYPT '89, 218-228. Springer, Berlin, Heidelberg, 1989.**
- 



这篇论文提出了 Schnorr 算法，一种数字签名算法。



- 

- **Boneh, Dan, and Matt Franklin. "Identity-based encryption from the Weil pairing." In Advances in cryptology-CRYPTO '01, 213-229. Springer, Berlin, Heidelberg, 2001.**
- 



这篇论文提出了身份认证加密，一种基于公钥密码学的身份认证方法。

https://sitn.hms.harvard.edu/flash/2017/2-x-prime-1-200-year-old-story-sophie-germain-21st-century-legacy/

https://www.ijcseonline.org/full_paper_view.php?paper_id=2107

https://aro.koyauniversity.org/index.php/aro/article/view/590

---

EOA 钱包地址的计算过程如下：



1. 

2. 将私钥转换为 256 位字节数组。
3. 

4. 使用 Keccak-256 哈希函数对字节数组进行哈希计算。
5. 

6. 将哈希值的前 20 个字节转换为十六进制字符串。
7. 

8. 将十六进制字符串添加到 0x 前缀。
9. 



例如，一个私钥为 1234567890123456789012345678901234567890，其 EOA 钱包地址为：



```
0x1234567890123456789012345678901234567890
```



EOA 钱包地址具有以下特点：



- 

- 长度为 42 个字符，以 0x 前缀开头。

- 

- 由十六进制字符组成。

- 

- 具有唯一性。

- ----


- ----

- 

- 请提供 TEE 和 ebpf 结合的使用方案
  View other drafts

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  


  TEE 和 eBPF 可以结合起来，为嵌入式系统提供更强大的安全保护。TEE 可以提供安全运行环境，而 eBPF 可以用于监控和控制系统。

  以下是一些 TEE 和 eBPF 结合的使用方案：

  安全启动：TEE 可以用于确保系统在启动时仅加载经过验证的软件。eBPF 可以用于监控启动流程，并检测任何异常情况。
  密钥管理：TEE 可以用于安全地存储和管理密钥。eBPF 可以用于监控密钥访问，并防止密钥被未经授权的用户访问。
  加密：TEE 可以用于加密数据。eBPF 可以用于监控数据流，并防止数据被窃取或篡改。
  其他安全功能：TEE 还可以提供其他安全功能，例如身份验证、访问控制和审计。eBPF 可以用于扩展 TEE 的功能，并提供更细粒度的安全控制。
  以下是一个具体的使用方案：

  使用 TEE 和 eBPF 进行安全启动

  在安全启动过程中，TEE 可以验证固件、操作系统和应用程序的签名。eBPF 可以用于监控启动流程，并检测任何异常情况。

  具体步骤如下：

  TEE 验证固件的签名。
  TEE 验证操作系统的签名。
  TEE 验证应用程序的签名。
  eBPF 监控启动流程，并检测任何异常情况。
  如果检测到任何异常情况，TEE 会阻止系统启动。

  使用 TEE 和 eBPF 进行密钥管理

  在密钥管理过程中，TEE 可以安全地存储密钥。eBPF 可以用于监控密钥访问，并防止密钥被未经授权的用户访问。

  具体步骤如下：

  TEE 安全地存储密钥。
  eBPF 监控密钥访问。
  如果检测到任何未经授权的密钥访问，TEE 会阻止访问。

  使用 TEE 和 eBPF 进行加密

  在加密过程中，TEE 可以用于加密数据。eBPF 可以用于监控数据流，并防止数据被窃取或篡改。

  具体步骤如下：

  TEE 加密数据。
  eBPF 监控数据流。
  如果检测到任何数据被窃取或篡改，TEE 会阻止数据进一步传输。

  其他安全功能

  TEE 还可以提供其他安全功能，例如身份验证、访问控制和审计。eBPF 可以用于扩展 TEE 的功能，并提供更细粒度的安全控制。

  例如，TEE 可以用于实现身份验证。eBPF 可以用于扩展身份验证功能，例如支持多因子身份验证。

  TEE 可以用于实现访问控制。eBPF 可以用于扩展访问控制功能，例如支持精细的访问控制。

  TEE 可以用于实现审计。eBPF 可以用于扩展审计功能，例如支持更细粒度的审计。

  总而言之，TEE 和 eBPF 可以结合起来，为嵌入式系统提供更强大的安全保护。

- **但是还没琢磨，就是嵌入系统 + 软件 TEE+ 可扩展的 ebpf，可以构造安全可信的执行环境，这样我们的安全有了基础保障，再加上其他例如日限额、合约锁定额度上限、2FA、多签等等来保障安全**

## 在可信执行环境，tee 和 linux 内核安全，ebpf 语境下，ebpf 全称是哪些英语词汇

edit

View other drafts

volume_up

![img](https://www.gstatic.com/lamda/images/sparkle_resting_v2_1ff6f6a71f2d298b1a31.gif)

![🚀](https://fonts.gstatic.com/s/e/notoemoji/latest/1f680/emoji.svg)

在可信执行环境、TEE 和 Linux 内核安全语境下，eBPF 全称是 **extended Berkeley Packet Filter**。



**Berkeley Packet Filter** 是 Linux 内核中的一个功能模块，用于过滤网络数据包。**Extended** 表示 eBPF 是 BPF 的扩展版本，它提供了更多的功能和灵活性。



eBPF 在可信执行环境、TEE 和 Linux 内核安全中都有重要应用。在可信执行环境中，eBPF 可以用于实现安全功能，例如内核态的安全监控和访问控制。在 TEE 中，eBPF 可以用于实现安全的网络通信和数据处理。在 Linux 内核安全中，eBPF 可以用于检测和防范安全漏洞。



以下是 eBPF 在可信执行环境、TEE 和 Linux 内核安全中的具体应用：



- 

- 可信执行环境

  

  - 

  - 内核态安全监控：eBPF 可以用于监控内核中的关键事件，例如内核模块的加载和卸载、系统调用的执行、内存的分配和释放等。通过监控这些事件，可以发现潜在的安全威胁。
  - 

  - 访问控制：eBPF 可以用于实现细粒度的访问控制。例如，可以使用 eBPF 来限制用户对内核资源的访问。
  - 

  

- 

- TEE

  

  - 

  - 安全的网络通信：eBPF 可以用于保护 TEE 中的网络通信。例如，可以使用 eBPF 来对网络数据包进行加密和解密，以及检测和防范网络攻击。
  - 

  - 数据处理：eBPF 可以用于在 TEE 中安全地处理数据。例如，可以使用 eBPF 来加密数据、解密数据、以及生成签名。
  - 

  

- 

- Linux 内核安全

  

  - 

  - 漏洞检测：eBPF 可以用于检测 Linux 内核中的漏洞。例如，可以使用 eBPF 来跟踪内核中的关键数据结构和函数，并检测是否存在异常访问或修改。
  - 

  - 安全审计：eBPF 可以用于审计 Linux 内核的安全行为。例如，可以使用 eBPF 来记录系统调用的执行情况，并分析是否存在安全风险。
  - 

  

- 



eBPF 是一项强大的技术，在可信执行环境、TEE 和 Linux 内核安全中都有重要应用。随着 eBPF 技术的不断发展，其应用范围将会更加广泛。

----

Merkle tree 和 Verkle tree 都是哈希树的一种，用于存储数据并提供数据完整性证明。两者的主要区别在于：



- 

- **Merkle tree 使用哈希函数，而 Verkle tree 使用向量承诺。**
- 

- **Merkle tree 的证明需要包含整个树的结构，而 Verkle tree 的证明只需要包含一条路径。**
- 



**Merkle tree 使用哈希函数**



Merkle tree 使用哈希函数来计算节点的值。每个节点的值都是它包含的子节点值的哈希。根节点是树的顶部节点，其值是所有叶子节点值的哈希。



Merkle tree 的证明使用哈希函数来证明数据项是否存在于树中。证明者需要提供包含数据项哈希的路径。验证者可以使用哈希函数来验证证明。



**Verkle tree 使用向量承诺**



Verkle tree 使用向量承诺来计算节点的值。向量承诺是一种密码学技术，用于证明数据项属于一个特定的集合。



Verkle tree 的证明使用向量承诺来证明数据项是否存在于树中。证明者需要提供包含数据项哈希的路径，以及一个向量承诺。验证者可以使用向量承诺来验证证明。



**Merkle tree 和 Verkle tree 的优缺点**



Merkle tree 的优点是简单易理解，并且可以使用现有的哈希函数来实现。Merkle tree 的缺点是证明的大小随着数据量的增加而增加。



Verkle tree 的优点是证明的大小随着数据量的增加而保持不变。Verkle tree 的缺点是实现复杂，并且需要使用向量承诺的密码学技术。



**Merkle tree 和 Verkle tree 的应用**



Merkle tree 和 Verkle tree 都被广泛应用于区块链技术中。Merkle tree 用于存储区块链中的交易数据，并提供数据完整性证明。Verkle tree 用于存储区块链中的状态数据，并提供数据完整性证明。



此外，Merkle tree 还被应用于其他领域，例如文件存储、数据验证等。

----

Vitalik 的 Verkle tree 与 Merkle tree 的主要区别在于：



- 

- **使用向量承诺来计算节点的值。**
- 

- **证明的大小与数据量的增加而保持不变。**
- 



这两个区别使得 Verkle tree 在存储大量数据时具有优势

----

向量承诺（Vector Commitment）是一种密码学技术，用于证明数据项属于一个特定的集合。向量承诺可以用于各种应用，例如数据验证、存储和隐私保护。



向量承诺的工作原理如下：



1. 

2. 首先，证明者选择一个随机向量，并将其与数据项一起哈希化。
3. 

4. 然后，证明者将哈希值公开，并将向量保密。
5. 

6. 验证者可以使用向量承诺的安全性来验证证明。
7. 



向量承诺具有以下优点：



- 

- 可以证明数据项属于一个特定的集合。
- 

- 证明的大小与数据量的增加而保持不变。
- 

- 可以提供隐私保护。
- 



向量承诺在区块链技术中被广泛应用，用于存储状态数据和隐私保护。



**向量承诺的实现**



向量承诺可以使用各种方法来实现。一种常见的方法是使用双线性函数。



双线性函数是一种具有以下性质的函数：



- 

- 它是双线性函数，即：
- 



```
f(a * b, c) = a * f(b, c)
f(a, b * c) = b * f(a, c)
```



- 

- 它是可逆函数，即：
- 



```
f(a, b) * f(a^{-1}, b^{-1}) = 1
```



使用双线性函数，可以将向量承诺实现如下：



1. 

2. 证明者选择一个随机向量 *v*，并将其与数据项 *m* 一起哈希化：
3. 



```
h(v, m) = x
```



1. 

2. 证明者将 *x* 公开，并将 *v* 保密。
3. 

4. 验证者可以使用以下方法来验证证明：
5. 



```
h(a * v, m) = a * x
```



如果验证结果为真，则证明成立。



**向量承诺的应用**



向量承诺可以用于各种应用，例如：



- 

- **数据验证**：向量承诺可以用于验证数据项是否属于一个特定的集合。例如，可以使用向量承诺来验证区块链中的交易是否有效。

- 

- **存储**：向量承诺可以用于存储大量数据。例如，可以使用向量承诺来存储区块链中的状态数据。

- 

- **隐私保护**：向量承诺可以提供隐私保护。例如，可以使用向量承诺来隐藏数据项的身份。

- ----

----

**4、[比特币](https://www.fx168news.com/quote/BINBTC)地址**

相较[以太坊](https://www.fx168news.com/quote/BINETH)，比特币地址有更多的细节需要解决。首先来看地址类型，比特地地址类型其实主要有四种：Legacy、Pay-to-Script-Hash、Segwit 和 Taproot。尽管比特币使用不同的会计方法——未消费交易输出（UTXO）模型——来跟踪链上的[加密货币](https://www.fx168news.com/info/001008)，但我们将重点关注下面几种不同的地址类型。

**（1）Legacy（P2PKH）地址**

这些地址包括[比特币](https://www.fx168news.com/quote/BINBTC)系统原始部署中使用的地址，并且很容易识别，这些地址是以“1”开头的。它们的生成方式与以太坊地址的生成方式非常相似，从公钥/私钥对的生成开始。

然后像以太坊一样，计算公钥的哈希值，但使用的是 SHA-256 算法。所得的 256 bit 序列随后使用 RACE 原始完整性校验消息摘要（RIPEMD-160）再次计算哈希值，得到 20 字节（160 bit）的序列。回过头看，这个过程与[以太坊](https://www.fx168news.com/quote/BINETH)非常相似，但是，显示为文本形式时，比特币通常使用的是 Base58CheckEncoding。这意味着 20 字节序列使用 58 个字符（1-9，A-H，J-N，P-Z，a-k，m-z）编码，而非十六进制编码中使用的 16 个字符。基本上，存储在计算机内存中的相同的 160 bit 的 0、1 序列会通过一组 16 字符或 58 字符呈现到屏幕上。当然还有很多其他编码，但这是特别为比特币选择的编码。

**（2）Pay-to-Script-Hash（P2SH）地址**

P2SH 地址以“3”开头，从技术上来说属于脚本，可用于要求多重签名的转账事宜等。[比特币](https://www.fx168news.com/quote/BINBTC)的“Pay-to-Script-Hash”的真实性质超出了我们的探讨范围，但简单来说，P2SH 地址是使用 Base58Check 对脚本代码哈希进行编码。因此，可以将 P2SH 地址概念化为脚本的 20 个字节哈希的编码，类似于公钥的 20 个字节哈希的编码。

**（3）SegWit 和 Taproot 地址**

为了提高区块空间的效率并改善费用，SegWit 在地址的构造方式上引入了一些变化。具体的算法细节计较乏味，因此我们在这里跳过细节，但是人们可以轻松地一眼看到这些以“bc1”开头的新地址。除了 SegWit 之外，以“bc1p”开头的 Taproot 地址进一步提高了交易效率，并提供了更好的隐私性。

与以太坊类似，下图显示了按地址的总余额大小汇总的比特币总余额。与以太坊类似，绝大多数比特币由价值最高的那些地址持有。然而，仔细检查数据以更好地理解分布结构是非常重要的。

----

**UTXO 模型&账户模型优缺点**

**UTXO 模型**

优点：

1、可以很容易地检查输出是否已经被花费，从而避免双花攻击；

2、交易可以轻松地并行处理，从而带来更好的可扩展性；

3、隐私性好，用户每次交易都可以使用一个新地址。

缺点：

1、新用户很难掌握；

2、更难实施智能合约，因为 UTXO 不跟踪任何状态。

**帐户模型**

优点：

1、易于实施智能合约；

2、交易更加紧密，节省空间。

缺点：

1、实现并发交易很棘手，因为存在受不同交易影响的全局状态；

2、隐私度低，交易都绑定在一个帐户中；

3、依靠 Nonces 来防止重放攻击。

从上述内容中我们可以看出，UTXO 模式使用起来会很复杂，而以太坊的账户模型相较简单。但实际上，UTXO 的模型会让整个账本非常“轻”，因为 UTXO 的数据不会因为账户的增加而膨胀，也不会因为每笔交易的更新而更新所有人的余额信息。这在很大程度上减少了比特币网络需要更新和保存的数据。而以太坊网络就因为保存了大量无用数据使得空间内存不够，从而造成交易速度缓慢。

但是在对交易进行验证时，**以太坊账户**模型效率却显得更高。因为 UTXO 模型中，如果交易中存在多个输入，则每个输入都需要分别签名，每次查询需要也要遍历相关的 UTXO，效率相对会低一些。而以太坊账户模型因为不用对过去的 UTXO 进行签名，所以可以从任何一个时间点开始更新区块链状态，让轻节点的验证更简单可行。

---

**外部账户**（Externally Owned Accounts，简称 EOA）和**合约账户**（Contracts Accounts，简称 CA）。

---

## 账户模型和 UTXO 的优缺点

账户模型优点：

合约以代码形式保存在 Account 中，并且 Account 拥有自身状态。这种模型具有更好的可编程性，容易开发人员理解，场景更广泛。

批量交易的成本较低。设想矿池向矿工支付手续费，UTXO 中因为每个 Input 和 Out 都需要单独 Witness script 或者 Locking script，交易本身会非常大，签名验证和交易存储都需要消耗链上宝贵的资源。而 Account 模型可以通过合约的方式极大的降低成本。



账户模型缺点：

Account 模型交易之间没有依赖性，需要解决重放问题。Ethereum 是怎么解决的，我们清楚 Ethereum 是采用的是唯一的 Nonce 值的方法，每个交易 Tx 中有一个 Nonce 字段，对于每个用户来说，这个 Nonce 都不能重复，从而避免了重放攻击。

对于实现闪电网络 / 雷电网络，Plasma 等，用户举证需要更复杂的 Proof 证明机制，子链向主链进行状态迁移需要更复杂的协议。



UTXO 优点：

计算是在链外的，交易本身既是结果也是证明。节点只做验证即可，不需要对交易进行额外的计算，也没有额外的状态存储。交易本身的输出 UTXO 的计算是在钱包完成的，这样交易的计算负担完全由钱包来承担，一定程度上减少了链的负担。

除 Coinbase 交易外，交易的 Input 始终是链接在某个 UTXO 后面。交易无法被重放，并且交易的先后顺序和依赖关系容易被验证，交易是否被消费也容易被举证。

UTXO 模型是无状态的，更容易并发处理。

对于 P2SH 类型的交易，具有更好的隐私性。交易中的 Input 是互不相关联的，可以使用 CoinJoin 这样的技术，来增加一定的隐私性。



UTXO 缺点：

无法实现一些比较复杂的逻辑，可编程性差。对于复杂逻辑，或者需要状态保存的合约，实现难度大，且状态空间利用率比较低。

当 Input 较多时，见证脚本也会增多。而签名本身是比较消耗 CPU 和存储空间的。



 5.账户模型和 UTXO 简要区别有哪些

账户余额

账户模型：可以简单明了的看到账户底下有多少钱。

UTXO 模型：统计该地址底下有多少个 UTXO，把他们汇总起来的结果才是余额。



当交易笔数指数级上升时

账户模型：会越来越吃力。

UTXO 模型：天然支持高并发。



从智能合约 / 开发者角度出发

账户模型符合开发者的逻辑习惯，相对容易写逻辑

UTXO 脚本编程较为复杂

---

为了建立交易，客户端从其控制的 UTXO 中选择具有足够价值的 UTXO 进行所请求的付款。有时候一个 UTXO 就足够了，有时候需要多个 UTXO。对于将用于进行此项付款的每个 UTXO，客户端将创建一个指向 UTXO 的输入，并使用解锁脚本将其解锁。

让我们更详细地看看输入的组成部分。输入的第一部分是指向 UTXO 的指针，引用交易的哈希值和输出索引，该索引标识该交易中特定的 UTXO。第二部分是一个解锁脚本，为了满足 UTXO 中设置的花费条件。大多数情况下，解锁脚本是证明比特币所有权的数字签名和公钥。但是，并非所有解锁脚本都包含签名。第三部分是序列号。

考虑交易背后中的示例，交易的输出是 vin 数组：

The transaction inputs in Alice’s transaction

```
复制代码"vin": [
  {
    "txid": "7957a35fe64f80d234d76d83a2a8f1a0d8149a41d81de548f0a65a8a999f6f18",
    "vout": 0,
    "scriptSig" : "3045022100884d142d86652a3f47ba4746ec719bbfbd040a570b1deccbb6498c75c4ae24cb02204b9f039ff08df09cbe9f6addac960298cad530a863ea8f53982c09db8f6e3813[ALL] 0484ecc0d46f1918b30928fa0e4ed99f16a0fb4fde0735e7ade8416ab9fe423cc5412336376789d172787ec3457eee41c04f4938de5cc17b4a10fa336a8d752adf",
    "sequence": 4294967295
  }
]
```

如你所见，列表中只有一个输入（因为这个 UTXO 包含足够的值来完成此次付款）。输入包含四个元素：

- 交易 ID，引用包含正在使用的 UTXO 的交易;
- 输出索引（vout），标识使用来自该交易的哪个 UTXO（第一个从 0 开始）;
- scriptSig，满足 UTXO 上的条件的脚本，用于解锁并花费;
- 一个序列号;

### 输出

在比特币中，输出是位于 vout 的数组中的。

```
复制代码"vout": [
  {
    "value": 0.01500000,
    "scriptPubKey": "OP_DUP OP_HASH160 ab68025513c3dbd2f7b92a94e0581f5d50f654e7 OP_EQUALVERIFY
    OP_CHECKSIG"
  },
  {
    "value": 0.08450000,
    "scriptPubKey": "OP_DUP OP_HASH160 7f9b1a7fb68d60c536c2fd8aeaa53a8f3cc025a8 OP_EQUALVERIFY OP_CHECKSIG",
  }
]
```

该交易包含两个输出。每个输出由一个值和一段指令组成。Value 值以比特币单位，但在交易本身中，它被记录为以聪为单位的整数。每个输出的第二部分是设置花费验证的脚本。scriptPubKey 并展示了该脚本的人类可读的表示。

通过上面的介绍可以总结归纳一下 UTXO 模型的特点；

- 除了 BTC 产生的交易外每一笔交易的输出都是另一笔交易输入；
- 如果丢失私钥丧失账户的控制权后，UTXO 会一直保存这个账户的余额，因为没有输出；
- 随着比特币的碎片化和账户私钥的丢失，UTXO 模型会越来越膨胀；
- 验证一笔交易的余额是否足够需要向上追溯；
- 通过 UTXO 模型可以一定程度上避免双花攻击；
- UTXO 通过找零设置新地址增加了一定的隐私性，因为除了你本人是不知道哪个地址是找零地址，哪个是收款地址。

### 比特币脚本

每一笔交易除了铸币交易（coinbase）外，每一笔交易都拥有至少一个输入（TxIn）和至少一个输出（TxOut），和我们直觉上理解的交易的 TxIn 和 TxOut 应该是数字不太一样，在比特币中是以脚本的形式存在。

---

此前 EigenLayer 创始人曾将“安全性”简单的细分为“交易不可逆转性（抗回滚性）、抗审查性、DA/数据发布可靠性、状态转换有效性

我们可以初步对主流 Layer2 安全模型中不同组件的重要程度/基础程度，进行如下优先级排序：

1. 合约/官方桥的控制权限是否被合理分散（多签控制权有多集中）
2. 是否有抗审查的提款功能（强制提款、逃生舱）
3. DA 层/数据发布形式是否可靠（DA 数据是否发布在比特币、以太坊上）
4. 是否在 Layer1 上部署了可靠的欺诈证明/有效性证明系统（比特币 L2 需要借助于 BitVM）

，无论是以太坊 Layer2 还是比特币 Layer2，很多都依赖于中心化的节点来充当排序器，或由少数节点组成侧链形式的“委员会”，这些趋于中心化的排序器/委员会如果不受限制，可以盗取用户资产并随时跑路，可以拒收用户的交易请求，导致资产被冻无法使用。这便涉及到前文 EigenLayer 创始人提到的状态转换有效性和抗审查性。



**Vitalik 曾表示，由于 Rollup 方案在早期启动时无法达到理论上的完善度，所以必须借助于一些辅助手段提升安全性，而这些辅助手段被称为“辅助轮”，并会引入信任假设。这些信任假设就是风险**



L2BEAT 对上述问题进行了总结，并归纳出了 Layer2 安全模型中几个核心的要素：

1. 状态验证/证明系统是否可靠（State Validation）

2 . DA 数据发布方式是否可靠（Data Avalibility）

3. 如果 Layer2 网络故意拒收你的交易/停机，你能否将资产强制撤出 Layer2（Sequencer Faliure、Proposer Failure）
4. Layer2 相关合约 - 官方跨链桥的控制权，是否足够分散。如果权力比较集中，发生“监守自盗”时，用户能否有足够的时间去应急（Exit Window）



用“木桶效应”分析 Layer2 安全问题，很容易看出，最短的一块木板就是上文有所提及的“合约可升级性”（主要针对以太坊 Layer2），或者更进一步的说，是“官方跨链桥的管理权”

目前看来，以太坊 Layer2 依赖合约实现的“去信任化的桥”，在比特币 L2 身上无法实现。这种“Trustless Bridge”需要在 Layer1 上部署专用合约，同时需要 DA+ 欺诈证明/ZK 证明系统的配合，本质类似于 Orbiter 那种“乐观桥”或 Polyhedra 这类 ZK 桥。

目前业界的主流观点是，若不考虑实践中可能存在的 bug，仅考虑理论模型，乐观桥和 ZK 桥的安全级别基本是最高的一档，只要合约代码不包含 bug，或者不能被恶意升级，基本就是去信任化的。

乐观桥只需要做到，N 个守望者中，有 1 个诚实，就可以保证安全，信任模型是 1/N） 

由于以太坊 Layer2 官方桥相关合约的“升级权限”，往往也集中在少数几个多签控制者手上，如果多签控制者串谋，以太坊 Layer2 的桥也会出问题，除非其合约不可升级，或是受到了很长的延时限制（目前只有 Degate 和 Fuel V1 如此）

（Degate 每次合约升级，都会给用户预留 30 天的安全逃离期，这期间只要大家发现新版合约代码有恶意逻辑，就可以通过强制提款/逃生舱功能安全逃离）

关于“官方桥”这部分，以太坊 Layer2 和比特币 Layer2 的信任模型基本一致：需要信任多签的控制者不会串谋作恶，这组多签可以控制 L2 官方桥，要么更改其代码逻辑，要么直接放行无效的提款请求，最后的结果都是：用户资产可能被盗。

两者唯一的区别是，以太坊 Layer2 只要合约不恶意升级/升级窗口期足够长，其官方桥就是去信任的

关于抗审查强制提款/逃生舱功能的重要性，Vitalik 在几个月前的文章“Different types of layer 2s”中曾强调，用户能否顺利的把资产从 Layer2 撤回至 Layer1，是一个非常重要的安全指标。

如果 Layer2 的排序器一直拒绝你的交易请求，或者长时间故障/宕机，你的资产将被“冻结”，什么都干不了。即便 DA 和欺诈证明/ZK 证明系统可用，如果没有抗审查方案，这样的 Layer2 也是不够安全的，随时可以把你的资产扣住。

以太坊基金会的 Dankrad 表示，Plasma 在 DA 故障 / 用户无法同步最新数据时，依然可以让用户资产安全撤离）

部分以太坊 Layer2，如 Loopring 和 StarkEx、dYdX、Degate 等，会在 Layer1 上设立一个抗审查的强制提款/逃生舱激活函数，以 Starknet 为例，如果用户在 Layer1 上提交的 Forced Withdrawal 请求，在 7 天窗口期结束时，未得到 Layer2 排序器响应，则可以手动调用 freeze Request 功能让 L2 进入冻结状态，激活逃生舱模式。

此时，排序器无法向 L1 上的 Rollup 合约提交数据，整个 Layer2 将冻结一年。然后，用户可以提交 merkle proof，证明自己在 Layer2 上的资产状态，并在 Layer1 上直接提款（其实就是从官方桥的充提款地址中，把属于自己的等额资金拿走）

但单纯声明“强制提款请求”，要比直接激活逃生舱方便的多。前者只需要让用户在 Layer1 上向指定地址提交一笔交易，并在交易的附加数据中，声明自己想提交给全体 Layer2 节点的数据（这样可以直接绕开排序器，向其它 Layer2 节点传达请求）。如果“强制提款”长时间得不到响应，用户再去触发逃生舱模式，是一种比较合理的设计。

（参考资料：对 Layer2 而言，强制提款与逃生舱功能到底有多重要？

https://mp.weixin.qq.com/s/EheKZWDcJHYZ7vBZZPOMDA）

---

，以太坊 Rollup 会强行要求排序器在 Layer1 上发布交易数据/状态转换参数，这一点是通过有效性证明/欺诈证明来保证的。

ZK Rollup 的排序器在 Layer1 上发布交易数据后，会触发合约逻辑生成一个 datahash，而验证器合约要确认，Proposer 提交的有效性证明和 datahash 有对应关系。

这等价于：确认 Proposer 提交的 zk Proof 和 Stateroot，与 Sequencer 提交的 Tx data，是关联在一起的，即 New Stateroot=STF(Old Stateroot，Txdata)。STF 就是 state transition function 状态转换函数。

---

关于 DA 数据发布与证明验证系统哪个更基础，以太坊/Celestia 社区早已进行过充分讨论，普遍结论是：DA 层是否可靠，要比欺诈证明/有效性证明系统的完备性更重要。比如说，Plasma、Validium、Optimium 这类——DA 层在以太坊链下、结算层在以太坊链上的方案，容易遭遇“数据扣留攻击”，就是指：

Sequencer/Proposer可以与ETH链下的DA层节点串谋，在Layer1上更新stateroot，但扣住状态转换对应的输入参数不发出来，让外人无法判断新的stateroot是否正确，成为“睁眼瞎”。

---

## 总结

经过简单的木桶模型分析，我们可以初步得出结论：主流的 Layer2 安全模型中，按照重要程度/基础程度，可以进行如下排序：

1. 合约/官方桥的控制权限是否被合理分散
2. 是否有抗审查的提款功能
3. DA 层/数据发布形式是否可靠
4. 是否在 Layer1 上部署了可靠的欺诈证明/有效性证明系统 

当然，我们并没有对闪电网络/状态通道及 ICP 生态的 ckBTC、铭文索引协议等方案进行分析，因为它们与典型的 Rollup、Plasma、Validium 或客户端验证方案存在较大差异。由于时间关系，我们还难以对其安全性与风险要素进行审慎的评估，但考虑到它们的重大意义，日后相关的评估工作必将如期进行。

------



from 是发送方，to 是收款方，value 是转账金额，这笔交易数据的构建还是很简单的。

如果在以太坊链上通过合约转账 erc20 的代币，那就需要针对合约中的转账方法构建一笔转账交易数据。

from 仍然是发送方，而 to 则变成了该 erc20 代币的合约地址，具体的 erc20 转账数量则在 input Data 中。这笔交易数据最核心的点就在 inputData 中，以太坊执行合约代码需要依赖于 evm 虚拟机，而 evm 只能执行字节码 bytecode，上面的 input Data 是整齐明了的字节码，看上去一目了然。

其中 MethodID 是函数 transfer(address _to, uint256 _value) 的函数签名，函数签名我在之前的文章中介绍过，并且也有方便的

ethSignUtil

脚本生成合约中的函数签名，后面两个参数值：000000000000000000000000d0292fc87a77ced208207ec92c3c6549565d84dd，

0000000000000000000000000000000000000000000000000de0b6b3a7640000，则是 transfer 函数的 address 收款方地址和 value 转账的 erc20 数量。erc20 合约中一般转账交易数据就是**函数签名 + 收款方地址 + 转账数量。**

最终的交易数据是这样的

0xa9059cbb

000000000000000000000000d0292fc87a77ced208207ec92c3c6549565d84dd

0000000000000000000000000000000000000000000000000de0b6b3a7640000

---

**我生成的账户安全吗？**

和一般的网站申请账户不同， **加密货币的账户仅需要可靠的软件在离线状态下生成** ，而不需要去特殊网站进行注册。很多虚拟货币交易所的管理大额虚拟货币的账户都是通过上述方法在一台离线的计算机上生成的。那么，如何保证每次生成的私钥不是已经被他人生成过的？在现实中，两个私钥碰撞的概率有多大呢？

我们已知：私钥地址空间有 2 256，而宇宙中的已知原子总数有 10 80, 两者比较谁大谁小？我们做一个除法。

2256÷1080=1.1579209𝑒+69=10692256÷1080=1.1579209�+69=1069

安全评估

----

“为承载大规模应用而存在的 Layer3，不仅可以处理海量数据，更是构建了未来链上大规模应用的基石，覆盖了社交、游戏，金融管理系统等。其数据可用层模块确保了数据的不可修改性和可信度，为 AI 提供了可靠的训练基础。通过 Dapplink 的模块化可组合 Layer3 技术解决方案，将会促进数据与 AI 之间的深度融合，使得基于海量数据训练的 AI 模型更加智能，推动个性化服务和智能决策进入新纪元。”

你可以用这个开头，然后再拆分详细说说：

1. 为什么这样说；
2. 怎样可以做到；
3. 用 Layer3 的技术解决方案训练 AI 的切实好处
4. 这样将怎样推动 AI 和 web3 的结合发展

配图可以选一个最近比较火的 AI 或者 AI&Crypto 结合的大佬的推文，或者 AI meme 表明你发这条的原因是为了对最近大火的 AI 一些感受；

---

Let's have a look at some of them based on proof size, verification time, arithmetization, field specifics, post-quantum security, and prover time. **✦ Groth 16**: Constant proof size, O(ℓ) verification time, R1CS arithmetization, curve-specific fields, not post-quantum secure, O(n log n) prover time. **✦ Plonk+KZG**: Constant proof size, O(ℓ) verification time, Plonkish arithmetization, curve-specific fields, not post-quantum secure, O(n log n) prover time. **✦ STARKs**: O(log2 n) proof size, O(log2 n) verification time, AIR arithmetization, small fields, post-quantum secure, O(n log n) prover time. **✦ HyperPlonk**: O(log n) proof size, O(ℓ) verification time, Plonkish arithmetization, curve-specific fields, not post-quantum secure, O(n) prover time. **✦ Binius**: O(√n) proof size, O(√n) verification time, Plonkish arithmetization, binary fields, post-quantum secure, O(n) prover time.


