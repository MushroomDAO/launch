好的，完全理解您的需求。您希望在一个位于校园内网、没有独立公网IP的Mac mini M4上部署 `claude-relay-service` 应用，并让外部用户能够访问到它。

这是一个非常典型的“内网穿透”或“NAT穿透”场景。我们将分两步解决这个问题：

1.  **在本地部署**: 首先，确保 `claude-relay-service` 应用能成功在您的Mac mini上运行起来。
2.  **暴露到公网**: 然后，使用一个安全可靠的隧道服务，将您本地的应用端口“映射”到一个公共的互联网地址上。

下面是为您量身定制的详细部署步骤。

-----

### 整体方案概览

  * **应用部署**: 我们将使用 **Docker** 来部署 `claude-relay-service`。这是最推荐的方式，因为它能处理好所有依赖和环境问题，尤其是在Apple Silicon (M4) 芯片上，Docker可以很好地构建和运行ARM架构的镜像。
  * **公网暴露**: 我们将使用 **Cloudflare Tunnel**。这是目前最强大、最稳定且**完全免费**的方案。它会为您生成一个 `https://` 开头的永久域名，并自动处理加密，比ngrok等临时工具更适合长期运行。

-----

### 第一阶段：在Mac mini上本地部署服务

在这一步，我们的目标是让服务在 `http://localhost:8000` 上成功运行。

#### **前提条件**

1.  **安装 Homebrew**: 如果您的Mac上没有安装，这是必不可少的包管理器。

    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2.  **安装 Docker Desktop for Mac**: Docker是运行此应用的核心。请从官网下载并安装适配Apple Silicon的版本。

      * [Docker Desktop 官网下载](https://www.docker.com/products/docker-desktop/)
      * 安装后，请启动Docker Desktop并确保它在菜单栏正常运行。

3.  **安装 Git**:

    ```bash
    brew install git
    ```

#### **部署步骤**

1.  **克隆项目代码**
    打开“终端” (Terminal) 应用，执行以下命令将项目代码下载到您的Mac mini上。

    ```bash
    git clone https://github.com/Wei-Shaw/claude-relay-service.git
    cd claude-relay-service
    ```

2.  **配置环境变量**
    应用需要一些密钥才能工作。您需要创建一个 `.env` 文件来存放它们。

    a. 复制示例文件：

    ```bash
    cp env.example .env
    ```

    b. 编辑 `.env` 文件：
    使用文本编辑器打开刚刚创建的 `.env` 文件（例如 `nano .env` 或用VS Code打开）。

    ```dotenv
    # .env 文件内容

    # 必填：您的Claude API密钥
    # 从Anthropic官网获取，以 sk-ant-*** 开头
    CLAUDE_API_KEY="sk-ant-xxxxxxxxxxxxxxxxxxxx"

    # 必填：您自定义的访问密码（令牌）
    # !! 重要：请设置一个长且随机的复杂字符串，这是保护您服务的唯一密码 !!
    AUTH_TOKEN="your_super_secret_and_long_password_here"

    # 可选：其他配置可以暂时保持默认
    CLAUDE_API_BASE=https://api.anthropic.com
    CLAUDE_API_VERSION=2023-06-01
    PORT=8000
    HOST=0.0.0.0
    LOG_LEVEL=INFO
    ```

    **安全提示**: `AUTH_TOKEN` 是访问您这个中继服务的“主密码”。任何人只要知道您的公网地址和这个令牌，就能消耗您的Claude API额度。**务必设置一个难以猜测的复杂密码**。

3.  **使用 Docker Compose 构建并运行**
    在项目根目录 (`claude-relay-service`) 下，执行以下命令：

    ```bash
    docker-compose up --build -d
    ```

      * `docker-compose up`: 启动服务。
      * `--build`: 强制重新构建镜像。这很重要，因为它会根据您Mac mini M4的 `arm64` 架构来构建，确保兼容性。
      * `-d`: 后台运行 (detached mode)。

4.  **本地验证**
    等待命令执行完毕后，服务应该已经在后台运行了。我们可以通过 `curl` 命令来测试它是否正常工作。

    打开**新的**终端窗口，执行：

    ```bash
    curl http://localhost:8000/v1/messages \
      -H "Content-Type: application/json" \
      -H "x-api-key: ${CLAUDE_API_KEY}" \
      -H "Authorization: Bearer your_super_secret_and_long_password_here" \
      -d '{
        "model": "claude-3-opus-20240229",
        "messages": [{"role": "user", "content": "Hello, world"}],
        "max_tokens": 1024
      }'
    ```

    **请替换**:

      * `CLAUDE_API_KEY`: 替换成您自己的Claude API密钥。
      * `your_super_secret_and_long_password_here`: 替换成您在 `.env` 文件中设置的 `AUTH_TOKEN`。

    如果终端返回了类似Claude的JSON格式回复，那么恭喜您，第一阶段成功了！服务已在您的Mac mini上正常运行。

-----

### 第二阶段：使用Cloudflare Tunnel暴露到公网

现在，我们要把运行在 `localhost:8000` 的服务安全地暴露给互联网。

1.  **注册 Cloudflare 账户**
    如果您还没有账户，请前往 [Cloudflare官网](https://www.google.com/search?q=https://dash.cloudflare.com/sign-up) 免费注册一个。

2.  **安装 `cloudflared` 工具**
    在您的Mac mini终端中，使用Homebrew安装Cloudflare Tunnel的命令行工具。

    ```bash
    brew install cloudflared
    ```

3.  **授权 `cloudflared`**
    执行以下命令，它会打开一个浏览器窗口，让您登录Cloudflare并授权此工具。

    ```bash
    cloudflared tunnel login
    ```

    登录并选择一个网站进行授权（即使您没有域名也可以，随便选一个即可）。

4.  **启动临时隧道进行测试 (Quick Tunnels)**
    这是最快看到效果的方式。执行以下命令：

    ```bash
    cloudflared tunnel --url http://localhost:8000
    ```

      * 此命令会告诉Cloudflare：“请把所有发送到一个公共地址的请求，都转发给我本机的8000端口”。

    命令执行后，终端会显示类似下面的输出：

    ```
    2025-08-11T08:15:00Z INF |  Your quick Tunnel has been created! Visit it at (it may take a few minutes):
    2025-08-11T08:15:00Z INF |  https://some-random-words-and-letters.trycloudflare.com
    ```

    **这个 `https://some-random-words-and-letters.trycloudflare.com` 就是您服务的公共网址！**

5.  **公网访问验证**
    现在，您或您的朋友可以在**任何地方**，使用这个新的URL来访问您的服务了。例如，使用 `curl`：

    ```bash
    curl https://some-random-words-and-letters.trycloudflare.com/v1/messages \
      -H "Content-Type: application/json" \
      -H "x-api-key: ${CLAUDE_API_KEY}" \
      -H "Authorization: Bearer your_super_secret_and_long_password_here" \
      -d '{
        "model": "claude-3-opus-20240229",
        "messages": [{"role": "user", "content": "Hello from the internet!"}],
        "max_tokens": 1024
      }'
    ```

    **注意**: 只要运行 `cloudflared tunnel` 命令的终端窗口开着，您的服务就能从公网访问。关闭窗口，隧道就会断开。

### (可选) 第三阶段：创建永久隧道并作为服务运行

如果您希望隧道在Mac mini开机后自动运行，而不是每次都手动开启一个终端窗口，可以创建一个“永久隧道”。

1.  **创建一个命名的隧道**: `cloudflared tunnel create my-claude-relay`
2.  **配置隧道指向本地服务**
3.  **将隧道作为系统服务来运行**: `cloudflared service install`

这部分内容相对进阶，您可以先使用第二阶段的临时隧道。当您确认一切工作正常并希望服务稳定运行时，可以再查阅 [Cloudflare Tunnel的官方文档](https://www.google.com/search?q=https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/run-tunnel/run-as-service/) 来完成这一步。

### 总结

您现在已经成功地在校园内网的Mac mini上部署了 `claude-relay-service`，并通过Cloudflare Tunnel提供了一个安全的公共访问地址。

**您的工作流**:

1.  确保Docker Desktop正在运行。
2.  在 `claude-relay-service` 目录下运行 `docker-compose up -d` 启动服务。
3.  运行 `cloudflared tunnel --url http://localhost:8000` 开启公网隧道。
4.  将 `https://....trycloudflare.com` 地址和您设置的 `AUTH_TOKEN` 分享给您的用户。

> **网络策略提醒**：绝大多数校园网允许正常的HTTPS出站连接（到Cloudflare服务器），所以此方案成功率极高。如果遇到问题，请检查是否有特殊的网络防火墙策略。