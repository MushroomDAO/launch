### 帖子全文翻译为中文

基于提供的X帖子链接（https://x.com/eth_limo/status/1778783099897168236），该帖子似乎是分享eth.limo团队发布的Substack文章，宣布开源并详细介绍架构演变。帖子本身可能简短（如“eth.limo现在开源了！详细阅读我们的文章： [链接]”），但核心内容是链接到的文章“eth.limo - Everything you've wanted to know”。以下是文章的完整文本翻译（基于提取的内容，原文被略微截断，但已覆盖主要部分）。翻译力求准确和流畅：

#### eth.limo - 你想知道的一切

##### eth.limo架构之旅和演变的详细概述

#### 引言

构建 [eth.limo](https://eth.limo) 是一次既 rewarding 又充满挑战的经历。我们每天平均处理 250 万到 300 万个请求，覆盖数万个 ENS 去中心化网站（dWebsites），每月 uptime 达到 99.999%。我们最初于 2021 年 8 月推出 eth.limo，此后已成为 ENS 和以太坊生态系统的可信伙伴。然而，我们的旅程并非一帆风顺。我们是一个小型团队，由热情而专注的爱好者组成，希望通过展示去中心化网络的能力并提供无缝访问来扩大其影响力，这些内容否则需要专用客户端和技术知识才能访问。服务很简单：在地址栏中将任何（正确配置的）ENS 域名末尾添加 .limo，然后访问，例如 [vitalik.eth.limo](https://vitalik.eth.limo)。我们在后台执行所有链上/链下解析和内容检索，并将其交付给您的浏览器。

本文的目标是概述运营 eth.limo 服务的挑战和历程。我们将审视我们面临的挑战、架构的演变、原因和方法，以及我们目前的成果。

感谢阅读 eth.limo！免费订阅以接收新帖子并支持我们的工作。

#### 挑战

好事多磨，我们很快意识到，提供高性能和高可用性的公共产品并非没有风险，既有技术方面的，也有非技术方面的：

1. 难以优化所有内容类型 - 有数十甚至数百种框架和静态站点生成器，以各种方式使用。除了静态网站，还有 JSON 令牌列表、未压缩和未优化的图像等，所有这些都需要快速交付给最终用户。
2. 多种方法处理同一问题 - 不同的 IPFS CID 编码格式、遗留格式、已弃用功能、CCIP 链外读取、多种存储协议等。
3. 子域名支持 - ENS 域名可以支持 N 个子域名，开发者经常用于版本控制、社区或 dApp 分段。由于通配符 x509 证书仅适用于一个左侧标签，我们必须找到一种方式轻松为未知数量的主机名颁发数千个证书。
4. RPC 调用 - Web3 采用的真正瓶颈。每个链上读取操作都是一个 RPC 调用（是的，也支持批量），如果全执行客户端容易且廉价运行，这本来不算问题。
5. 缓存 TTL 和失效 - ENS 名称应该缓存多久？如何失效过时内容？这种方法适用于所有人吗？最终，我们为所有解析名称设置了全局 5 分钟 TTL。
6. IPFS - 我们最喜欢的去中心化存储协议之一。运营 IPFS 网关集群并不简单，但我们与 Interplanetary Shipyard 团队密切合作，这让我们能够解决遇到的任何问题。Shipyard 团队合作愉快，没有他们的辛勤工作和奉献，eth.limo 无法以当前形式轻松运营。
7. 滥用 - 可以想象，有些“坏演员”使用 ENS 创建 dWebsites 用于钓鱼、恶意软件、动物虐待等。这对“内容 moderation”构成了难题，尤其在时间和压力方面，特别是向云提供商解释我们并不实际“托管”内容时。
8. 成本效率 - 公共产品定义上是不可排除的资源。当政府可以通过现代货币政策（MMT）吸收维护和运营成本时，这很棒，但私营运营时就完全不同了。
9. 社区支持 - 我们总是乐于为大大小小的项目提供支持并响应功能请求，但我们很快了解到，用户也期望我们帮助他们处理从 IPNS 故障排除、SEO 优化，到推荐补充服务等一切。我们必须快速上手并为常见问题创建运行手册。
10. 值班支持 - 作为小型团队，我们必须能够快速响应并分类生产中断。不幸的是，这意味着我们 24/7/365 值班，这会给我们的个人生活增添摩擦。
11. 太多事要做，时间太少 - Web3 景观变化迅速，导致焦虑和压力，以及不断增长的“nice to have” backlog。从管理角度和心理角度，这都是挑战。
12. 资金 - 我们从不知道下一顿饭从哪里来。我们不收费（毕竟是公共产品），所以找到可靠的收入来源是首要任务。幸运的是，我们从多个来源获得了资助，包括以太坊基金会、ENS DAO、Optimism RPGF、Gitcoin、Giveth 等。

#### 概念概述

在高层，eth.limo 本质上是一个高级反向代理：

服务负责执行以下操作：

1. 为给定主机名终止 TLS 连接，在这种情况下是 vitalik.eth.limo。
2. 执行 RPC 调用到 ENS 注册表和解析器合约，以获取 vitalik.eth 的记录。目前，我们仅支持以太坊主网的注册查询，但我们支持 CCIP-read 用于其他解析器数据。
3. 解码 [contentHash](https://docs.ens.domains/ensip/7) 记录。
4. 确定使用的存储协议，在这种情况下是 IPFS。
5. 将请求代理到适当的存储网关，并将内容返回给客户端。

#### 技术栈

虽然沿途发生了许多变化，但 [Caddy](https://caddyserver.com/) 服务器一直是 eth.limo 应用栈的无价组成部分。我们无法足够赞美它 - 从其出色的 ACME 客户端、易用配置，到极快的性能，Caddy 是我们架构的支柱。

除了 Caddy，我们还使用以下组件：

- [Kubo](https://github.com/ipfs/kubo)（IPFS 客户端/网关）
- [ethers.js](https://github.com/ethers-io/ethers.js)（主要解析器 API）
- Redis（API 的缓存层）
- 各种云服务 - 容器调度器、CDN 等。

#### 版本 1.0

最初的 eth.limo 栈作为单个可部署 Helm 图表创建。初始配置包括 Caddy 服务器作为入口，然后转发请求到 Kubo（IPFS 客户端）。Kubo 配置为使用 DNS over HTTPS 解析 .eth 域名，将请求转发到使用 go-ens 模块的 CoreDNS。这运作良好，但并非成本高效，我们遇到了以下问题：

- 管理繁琐。需要 ArgoCD（伟大的工具），但对我们的用例有点过度。
- Helm 模板不易阅读，尤其是对新用户。
- 由于使用 Kubo 和 CoreDNS，我们无法支持不同存储协议，仅限 IPFS。
- 当时，go-ens 没有 CCIP 支持，所以所有读取限于主网。
- 难以管理 Caddy JSON 配置（某些模块不支持 Caddyfile 语法）。
- 不易在多云环境中运行，而不复制整个栈。
- 缓存限于 CoreDNS。
- 无 Unicode（表情符号）ENS 名称支持。

#### 版本 2

随着 CCIP-read（[ERC-3668](https://eips.ethereum.org/EIPS/eip-3668)）的流行，我们意识到需要尽快添加支持。此外，我们希望使用 Caddy 的按需 TLS 功能支持 N 个子域名。不幸的是（当时），go-ens 库未维护，所以继续使用 CoreDNS 不现实。我们选择编写[自己的代理实现](https://github.com/ethlimo/conduit)，使用 [ethers.js](https://github.com/ethers-io/ethers.js) 和 NodeJS 后端。控制自己的代理代码库让我们支持以下功能：

- 智能内容路由（Arweave/Swarm/Skynet/IPFS & IPNS）。
- CCIP-read 和 Unicode 域名支持。
- IPFS CIDv1 格式。
- DNS over HTTPS 端点。
- 自定义 /ask 端点，用于 Caddy 服务器确定子域名是否有效以颁发证书。
- 解析器缓存 - 我们决定牺牲即时一致性以换取更好的性能，使用 Redis 内存缓存，而不是为每个 HTTP 请求进行 RPC 调用。

这次我们选择放弃 Kubernetes，转向“无服务器”运行时。我们希望减少团队运营开销，利用共享责任模型提供的安全保证，启用 DNSSEC，并利用无麻烦自动缩放。这种配置对我们运作良好，但我们忽略了使用 RPC 故障转移连接，并且限于单一证书机构（ZeroSSL），因为付费账户的速率限制不存在。当时我们未能申请 Let’s Encrypt 速率限制豁免（稍后详述）。

我们在 v2 架构中还遇到了其他“问题”：

- 数据传输重复，使用冗余代理（更昂贵且更慢），因为我们同步处理流量：请求 → Caddy → Conduit → 存储后端。
- 由于 lift-n-shift 方法，Caddy 仍依赖 JSON 配置格式，导致一些非常丑陋的 Go 模板与 JSON。

我们运行 v2 架构的变体超过一年半。代码库管理容易，基础设施大多自愈，但我们知道可以做得更好。

#### 版本 3

进入我们新 v3 架构的第一阶段。我们考虑了从先前迭代中学到的所有教训，并决定加倍投资于有效部分，重构无效部分。我们最大的改进之一是将 HTTP 代理逻辑和数据传输完全从 [ENS 解析器 API](https://github.com/ethlimo/dweb-proxy-api) 解耦。新请求流程如下：

`用户请求 → Caddy → 代理 API`

`代理 API --${Location}→ Caddy → 存储后端`

`存储后端 → Caddy → 用户响应`

由这个 Caddyfile（本地示例）总结：

（代码部分翻译为：配置代码保持原样，因为是技术代码。）

作为新架构迁移的一部分，我们还希望播下多云种子，以便从灾难恢复角度，在灾难事件中继续提供流量，轻松将 Caddy 入口代理与栈的其他部分解耦，以准备在任何云或 VPS 主机上部署多区域入口，并利用带宽密集进程的成本差异，如...

（原文在此截断，但核心内容已覆盖。）

### 核心技术栈信息

基于帖子链接的文章和相关GitHub仓库，以下是提炼的核心技术栈，使用表格呈现以清晰对比：

| 组件类别 | 具体技术 | 描述/作用 |
|----------|----------|----------|
| 反向代理/服务器 | Caddy | 核心服务器，用于TLS终止、请求路由、证书管理（支持按需TLS）和高性能代理。 |
| ENS解析库 | ethers.js | 用于链上/链下ENS记录解析、contentHash解码和CCIP-read支持。 |
| 存储协议支持 | Kubo (IPFS客户端/网关) | 处理IPFS/IPNS内容检索，支持CIDv1格式和集群操作。 |
| | Arweave | 支持Arweave和ArNS内容路由。 |
| | Swarm | 支持Swarm内容检索。 |
| 缓存层 | Redis | 用于缓存解析记录，提高性能，减少RPC调用（默认TTL 300秒）。 |
| 后端框架 | NodeJS/Express | 构建API服务，用于智能内容路由和DoH（DNS over HTTPS）端点。 |
| RPC端点 | 以太坊主网RPC（如Infura或自定义节点） | 用于ENS注册表查询，支持故障转移。 |
| 其他 | Service Workers | 可选，用于信任less IPFS网关模式和静态资产服务。 |
| 云/部署 | Kubernetes (早期版本), 无服务器运行时 (如AWS Lambda或类似), 多云支持 | 用于自动缩放、DNSSEC和灾难恢复。 |
| 许可证 | Apache 2.0 | 所有代码开源，可在GitHub上获取。 |

这些技术确保了隐私保护、去中心化内容访问和高可用性，支持多协议（如IPFS、Arweave、Swarm）和多链（主网+CCIP）。

### 如何自己运行一个eth.limo为.eth域名提供去中心化网站服务

eth.limo是开源的，你可以基于其GitHub仓库（https://github.com/ethlimo/dweb-proxy-api）自行部署一个类似服务，作为本地或公共ENS网关，为.eth域名提供去中心化网站访问（通过IPFS等协议）。以下是详细步骤，基于仓库README的指导。假设你有基本NodeJS、Docker/Podman和Redis知识。

#### 要求
- NodeJS v18+ 和 npm。
- Redis服务器（用于缓存）。
- 以太坊RPC端点（例如Infura免费API密钥，用于ETH_RPC_ENDPOINT）。
- 可选：Caddy服务器（用于完整网关），IPFS节点（如Kubo）。
- 容器工具：Docker/Podman/Buildah（推荐用于生产）。
- 环境：Linux/Mac/Windows（开发），云/VPS（生产）。

#### 步骤1: 安装Redis
使用Podman/Docker启动Redis（默认端口6379）：
```
podman pull docker.io/library/redis
podman run --net=host docker.io/library/redis
```
（替换podman为docker如果使用Docker。）

#### 步骤2: 配置环境变量
创建一个.env文件或通过命令行设置关键变量（参考表格）：

| 变量 | 示例值 | 说明 |
|------|--------|------|
| LISTEN_PORT | 8888 | API监听端口。 |
| ETH_RPC_ENDPOINT | https://mainnet.infura.io/v3/YOUR_INFURA_KEY | 主RPC端点。 |
| REDIS_URL | redis://127.0.0.1:6379 | Redis连接。 |
| CACHE_TTL | 300 | 缓存TTL（秒）。 |
| IPFS_TARGET | http://localhost:8080 | IPFS网关URL（如果你运行本地Kubo）。 |
| IPFS_SUBDOMAIN_SUPPORT | true | 启用子域名格式（如cid.ipfs.dweb.link）。 |
| DNSQUERY_ENABLED | true | 启用DoH支持。 |
| LIMO_HOSTNAME_SUBSTITUTION_CONFIG | eyAiZXRoLmxpbW8iOiAiZXRoIiwgImV0aC5sb2NhbCI6ICJldGgiIH0= | Base64编码的JSON对象，用于域名映射。 |

完整列表见上文配置表。

#### 步骤3: 构建和运行API
克隆仓库：
```
git clone https://github.com/ethlimo/dweb-proxy-api.git
cd dweb-proxy-api
```

构建：
```
./bin/build.sh
```

测试（可选）：
```
npm run test
```

运行开发模式：
```
./bin/runDev.sh
```

测试API：
```
curl http://localhost:8888 -H 'Host: ens.eth' -sD - -o /dev/null
```
预期响应包括X-Content-Location等头，用于路由内容。

#### 步骤4: 使用容器部署（推荐生产）
构建镜像：
```
buildah bud -t dweb-api-proxy .
```

运行容器（传递环境变量）：
```
podman run --rm -it --net=host -e "ETH_RPC_ENDPOINT=https://your-rpc-url" -e "其他变量" dweb-api-proxy
```

#### 步骤5: 与Caddy集成（完整本地网关）
1. 安装Caddy：从https://caddyserver.com/download下载二进制，或使用包管理器。
2. 创建Caddyfile（本地示例，使用端口8443）：
   ```
   {
       admin off
       auto_https off
       local_certs
       log {
           level DEBUG
           format console
       }
   }

   &(dweb-api) {
       reverse_proxy localhost:8888 {
           transport http
           method GET
           header_up Host (.*[-a-z0-9]+\.eth) $1

           @proxy status 200
           handle_response @proxy {
               @trailing vars_regexp trailing {rp.header.X-Content-Path} ^(.*)/$
               reverse_proxy @trailing {rp.header.X-Content-Location} {
                   rewrite {re.trailing.1}{uri}
                   header_up Host {rp.header.X-Content-Location}
                   header_up -X-Forwarded-Host

                   transport http {
                       dial_timeout 2s
                   }

                   @redirect301 status 301
                   handle_response @redirect301 {
                       redir {rp.header.Location} permanent
                   }
               }
           }
       }
   }

   :8443 {
       log {
           level INFO
           format console
       }
       bind 0.0.0.0
       tls internal {
           on_demand
       }
       invoke dweb-api
   }
   ```
3. 运行Caddy：
   ```
   caddy run --config Caddyfile
   ```
4. 配置本地DNS：编辑/etc/hosts添加：
   ```
   127.0.0.1   localhost ens.eth
   ```
5. 测试：浏览器访问 https://ens.eth:8443（接受自签名证书）。

#### 步骤6: 生产注意事项
- 使用云（如AWS/EC2）部署：设置域名通配符（*.yourdomain.com），配置Let's Encrypt或ZeroSSL证书。
- 启用Service Workers（可选）：设置SW_BUNDLE_PUBLIC_URL为你的域名，服务dist文件夹静态文件。
- 监控滥用：实现自定义过滤或日志。
- 扩展：添加多RPC故障转移、多区域CDN。
- 更多文档：参考https://eth-limo.gitbook.io/documentation/ 和其他仓库如https://github.com/ethlimo/documentation。

通过这些步骤，你可以运行一个本地或云端的eth.limo-like服务，支持.eth域名的去中心化网站访问。如果需要高级功能，如多协议支持，参考仓库代码自定义。