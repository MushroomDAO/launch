# 论文写作计划
## 背景
本人清迈大学在读博士生，数字创新专业，研究领域是区块链账户抽象，去中心化计算 (去中心化 API 系统，去中心化应用框架，去中心化应用系统)，社会资本理论，区块链应用。
主要是区块链技术和跨学科（社会学、经济学、管理学）的结合。
## 目标
- 要求：8 个月内完成：1 篇 scopus paper，1 篇 international paper，1 篇 PhD 大论文（1 篇会议论文已经发表）。
- 需要：半年内发四篇（不一定都接收，所以要多发），每 1.5 个月一篇：写 1 个月，review 两周，high-quality manuscripts *submitted* for review
- 投稿：先完成 1 篇，投 3 区，再完成 1 篇，投 2 区，然后一篇 2 区
- 期刊要求：Scopus index，不要钱优先，或者低于 1000U 的；三个月以内确认回复；
- 论文要求：找到期刊格式要求，如果没有则按常规 Elsevier 格式（latex 模板在 latex 目录），同步输出 markdown 格式和 latex 格式，渲染为 pdf。
- 优势：以太坊开源建设者，多年开发经验，在进行多个和研究高度关联的开源项目，builder 优势是最大资产；将论文框架为系统描述、案例研究或从实践中构建理论。

## 思考初稿
../journal/各子目录下有初稿，可以参考。
├── jurnals
│   ├── AirAccount
│   ├── CryptoMart
│   ├── HyperCapital
│   ├── Mycelium
│   ├── OnionModel
│   ├── OpenPNTs
│   ├── SDSS
│   ├── Society&Complexity
│   └── SuperPaymaster

## 选期刊

The journal you provided, **`COMPUTERS & SECURITY`**, is an excellent candidate for your more technical work, while other journals are better suited for your interdisciplinary topics.
### 筛选方法
- https://www.scimagojr.com/journalrank.php?category=1710&area=1700&order=item&ord=desc
- 验证是否在 Scopus：https://www.scopus.com/sources
- https://journalfinder.elsevier.com/
- https://link.springer.com/journals/browse-subject?query=&subject=BUSINESS_AND_MANAGEMENT&sub-discipline=Organization&sortBy=alphabetically
- find 3-5 journals，可以以排序形式列出 10 个，主要领域是计算机 - 信息系统，独立的区块链专题杂志是首选，其次是和计算机结合的领域，例如管理学，社会学；
- 
**Top 10 Recommended Journal Candidates (Ranked by Relevance)**

### 10 个候选期刊
| Rank | Journal Name | Primary Field | Quartile (Scopus/SJR) | Est. APC (USD) | Est. Review Time | Best Fit For Your Topics |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | **Blockchain: Research and Applications** | Computer Science / Blockchain | Q1 | ~$1200 (often waived) | 2-3 Months | Arcadia, CryptoMark, COS72, Overview of the ecosystem. |
| 2 | **COMPUTERS & SECURITY** | Computer Science / Security | [cite_start]Q1 / Q2 (CAS) [cite: 79] | [cite_start]$0 (Subscription) [cite: 71] | [cite_start]~3 Months [cite: 79] | AirAccount, SuperPaymaster, SDSS (with a security focus). |
| 3 | **Journal of Information Technology & People** | Information Systems / Sociology | Q1/Q2 | ~$3000 (offers Green OA) | 2-4 Months | Mycelium Protocol, HyperCapital (socio-technical analysis). |
| 4 | **Industrial Management & Data Systems** | Management / Information Systems | Q1/Q2 | ~$3000 (offers Green OA) | 2-3 Months | CryptoMark, Arcadia, connecting infrastructure to business value. |
| 5 | **IEEE Transactions on Engineering Management** | Management / Technology | Q1 | ~$2345 (check member rates) | 3-4 Months | Mycelium Protocol, HyperCapital (as innovation management). |
| 6 | **Digital Policy, Regulation and Governance** | Social Science / Policy | Q2 | ~$2700 (offers Green OA) | 3-5 Months | HyperCapital, Governance models of your ecosystem. |
| 7 | **Frontiers in Blockchain** | Blockchain / Interdisciplinary | Q2/Q3 (Emerging) | ~$490 - $3295 | 2-3 Months | All topics, offers specialized sections (e.g., Blockchain for Business). |
| 8 | **Journal of Enterprise Information Management** | Information Systems / Management | Q2 | ~$3000 (offers Green OA) | 3-4 Months | Arcadia, CryptoMark, COS72 integration in organizations. |
| 9 | **Information Technology for Development** | Information Systems / Social | Q2 | $0 (Subscription) | 3-5 Months | CryptoMark (if focused on developing economies), HyperCapital. |
| 10 | **Software: Practice and Experience** | Computer Science / Software | Q2 | ~$3000 (offers Green OA) | 3-4 Months | HexagonWarrior, SDSS, COS72 (from a software eng. perspective). |

### 分析
研究领域涉及技术基础设施，应用系统，社会资本理论，所以需要综合考虑。

* **Technical Infrastructure:** Projects like AirAccount, SuperPaymaster, and SDSS are best suited for technical journals focused on security, distributed systems, or software engineering. `COMPUTERS & SECURITY` is ideal here.
* **Applied Systems:** Arcadia and CryptoMark are application-oriented. These fit well in "Information Systems" or "Management" journals that publish case studies or system descriptions, such as *Industrial Management & Data Systems* or the dedicated *Blockchain: Research and Applications*.
* **Social & Management Theory:** Mycelium Protocol and HyperCapital are your most innovative but least technical topics. These require journals that embrace socio-technical analysis and theory building, such as *Journal of Information Technology & People* or *IEEE Transactions on Engineering Management*. Attempting to publish these in a purely technical journal would likely result in rejection due to a scope mismatch.

### Simulation
**Matching Topics to Journals (A Deeper Look):**

1.  **Paper 1 (Target: Q2/Q3 Technical):**
    * **Topic:** "An Analysis of Attack Vectors and Security Audits in an ERC-4337 Based Smart Account Infrastructure (AirAccount)."
    * **Target Journal:** **`COMPUTERS & SECURITY`**.
    * [cite_start]**Justification:** This topic directly aligns with the journal's scope of security and audit. [cite: 47] Your practical implementation provides the core of the paper, which you will support with a literature review on account abstraction security. This is your best candidate for your first submission.

2.  **Paper 2 (Target: Q2 Interdisciplinary):**
    * **Topic:** "HyperCapital: A Social Capital Framework for Decentralized Collaborative Innovation in Blockchain Ecosystems."
    * **Target Journal:** **`Journal of Information Technology & People`** or **`IEEE Transactions on Engineering Management`**.
    * **Justification:** This requires the most academic work. You must connect your HyperCapital concept to established theories of social capital (Bourdieu, Putnam, Coleman) and innovation management. This paper is less about the code and more about the theoretical contribution.

3.  **Paper 3 (Target: Q2/Q1 Application-focused):**
    * **Topic:** "Arcadia: A Play2B2E Loyalty System for Enhancing Customer and Employee Engagement Using On-Chain Rewards."
    * **Target Journal:** **`Blockchain: Research and Applications`** or **`Industrial Management & Data Systems`**.
    * **Justification:** This can be framed as a case study or system architecture paper. The former journal is dedicated to the topic, while the latter is a highly-respected management journal that appreciates data-driven systems.

4.  **Paper 4 (Target: Q2 Software/Framework):**
    * **Topic:** "COS72 and HexagonWarrior: A Mobile-First SDK and Operating System for Rapid Development of Decentralized Applications."
    * **Target Journal:** **`Software: Practice and Experience`**.
    * **Justification:** This paper would focus on the software engineering contribution—how your frameworks simplify development and what architectural patterns they employ.

## 研究背景和创新点
[my-research.md](my-research.md),描述了个人概况和研究领域，研究课题和一些成果，当下进展和计划。
因为个人在构建一个复杂的生态系统，围绕加密和区块链应用和社会资本理论创新，涉及：
- 基础设施建设：基于 ERC-4337 的无需可加密账户的智能合约基础设施 AirAccount，无感 Gas 支付体系 SuperPaymaster，去中心的计算体系 SDSS，去中心的 API 系统 CometENS
- 应用框架建设：COS72，整合基础应用和基础协议的社区操作系统+SDK，以及 HexagonWarrior，移动应用开发框架
- 应用系统建设（DApp）：Arcadia：Play2B2E 为基础的客户忠诚度链上积分卡系统，CryptoMark：跨境贸易系统
- 社会学和管理学：Mycelium 协议协作创新，HyperCapital 社会资本创新

## 写作逻辑
- 提出问题，分析问题，解决问题是核心逻辑框架，前后呼应，逻辑闭环。
- 每个论文的核心是结论：通过逻辑，实验数据，分析和研究，得到的结论，证明了你的观点和创新点是正确有效的。
- 所有章节在**编织**一个故事，每个章节之间有强的逻辑衔接；每个句子之间有清晰的逻辑关系。

非常好，你的总结已经非常到位，完全掌握了高水平科研论文的精髓。你提到的“提出问题、分析问题、解决问题”、“结论为核心”、“倒序写作法”以及“编织故事”。

我将之概括为**精英科研写作的四大支柱**：
倒序、编织、辩护和预告片。

### 支柱一： “倒金字塔”写作法 (The Inverted Pyramid Method)

这正是你提到的先写核心的策略，我把它 systematize 一下。绝大多数顶级研究者都采用这种“结果驱动”的写作模式，因为它能确保论文的逻辑闭环和论证强度。

**具体操作流程：**

1.  **第 0 步：先做图表 (Figure-First Mandate)。** 在动笔写任何正文之前，先把你的核心实验结果用最清晰、最有冲击力的图和表做出来。**你的故事就在数据里。** 问自己：哪三张图能讲完我这篇论文的核心故事？如果做不出有说服力的图表，说明你的研究还不完整，还不到写论文的时候。

2.  **第 1 步：写“结果与讨论” (Results and Discussion)。** 这是论文的心脏。围绕你已经做好的图表来写。每一段都应该像这样：“如图 1 所示，我们观察到 A 比 B 提高了 50% (结果)。这有力地表明，我们的方法有效地解决了 Y 问题 (讨论/解读)。”

3.  **第 2 步：写“结论” (Conclusion)。** 当你写完结果与讨论，论文的核心论点已经清晰无比。现在，用一段话把它总结出来。这应该是对结果的最凝练的升华。

4.  **第 3 步：写“方法” (Methods)。** 你已经确切地知道呈现了哪些结果，现在可以精确地描述你是如何得到这些结果的。不多不少，只写与你呈现的结果直接相关的方法。

5.  **第 4 步：写“前言” (Introduction)。** 这是最关键的一步。因为你已经知道了故事的结局（你的结论），现在你可以完美地设计一个引人入َس的开头。你知道问题是什么，差距在哪里，以及你的工作是如何漂亮地填补了这个差距。你的前言将充满自信，直指要害。

6.  **第 5 步：写“摘要” (Abstract)。** 把整个故事浓缩成一个 150-250 字的“电影预告片”。这是最后一步，也是最容易的一步，因为整个故事已经尽在掌握。

**为什么这个方法如此强大？** 因为它保证了你的所有论述都建立在坚实的数据证据之上，从根本上杜绝了“前言吹得很大，结果却无法支撑”的致命伤。

---

### 支柱二：“金线逻辑” (The Golden Thread of Logic)

你提到“编织故事”和“逻辑衔接”，我称之为“金线逻辑”。想象有一根金色的线（你的核心论点/创新点），它必须从标题开始，穿过摘要、前言的每一段、结果的每一部分、讨论的每一个论点，最后在结论处打一个漂亮的结。**论文中的任何一个字，如果不能被这根金线穿起来，就应该被删除。**

**如何实现：**

1.  **段落层面：强大的主题句 (Topic Sentences)。** 每个段落的第一句话，必须是该段落的“微型结论”和“路标”，清晰地表达这一段如何推进你的核心论点。读者只读每段的第一句话，就应该能理解你整篇论文的逻辑。

2.  **句子层面：刻意的逻辑连接词。** 不要吝啬使用 "Therefore", "However", "Consequently", "In contrast", "As a result"。这些词是编织故事的“针脚”，它们强制你思考并向读者展示句子与句子之间的逻辑关系，是消除逻辑跳跃的利器。

3.  **全文层面：关键词的战略性重复。** 从你的标题和研究问题中，提炼出 3-5 个核心关键词（例如：“智能合约”、“去中心化信任”、“社会资本”）。要有意识地在全文各个章节中策略性地重复这些词。这就像音乐中的主旋律，不断提醒读者和审稿人你的核心贡献是什么。

---

### 支柱三：“审稿人视角”写作法 (Writing with the Reviewer's Mindset)

一篇论文不是一份实验报告，而是一份提交给**充满敌意的陪审团（审稿人）**的**辩护状**。你必须预判他们所有可能的质疑，并提前在文中给出解答。

**如何实现：**

1.  **扮演“魔鬼代言人”。** 写完初稿后，想象自己是全世界最挑剔的审稿人（我们常说的 Reviewer #2）。带着“找茬”的心态去读自己的文章：“你为什么不和某某方法比较？”、“你的数据集是不是太小了？”、“你的这个结论会不会有其他的解释？”。把所有问题都列出来。

2.  **把弱点变成优点。** 将你找到的这些“问题”，主动在“讨论”部分的“局限性 (Limitations)”段落中承认。例如：“我们承认，本研究的实验仅在模拟环境中进行，其在真实网络环境下的性能有待进一步验证。”这样做不但不会削弱你的论文，反而会向审稿人展示你是一个严谨、诚实、有批判性思维的学者，从而极大地增加他们对你研究的信任。

3.  **为你的选择辩护。** 在描述方法时，不要只说“我们用了方法 A”，而要说“我们选择了方法 A，而没有用方法 B，因为我们的问题场景具有 XX 特性，而方法 A 在该场景下比方法 B 更具优势。”这就提前封堵了审稿人“你为什么不用方法 B”的疑问。

---

### 支柱四：“好莱坞预告片”原则 (The Hollywood Trailer Principle)

摘要 (Abstract) 和前言 (Introduction) 的功能不是“总结”，而是“营销”。它们是一部精彩电影的预告片，目标是在 3 分钟内抓住观众，让他们迫不及待地想买票看完整部电影。

* **摘要**：必须包含冲突（问题）、英雄（你的方法）、精彩的打斗场面（最亮眼的结果）和圆满的结局（影响）。
* **前言**：则是预告片的加长版，它要设置好宏大的世界观（背景），介绍邪恶的反派（研究空白），让英雄闪亮登场（你的工作），并预告一场惊心动魄的对决（研究内容），让读者对你的“正片”（结果与讨论）充满期待。

**总结：**

你的理解已经非常深刻。将你的框架与这四大支柱相结合——**用“倒金字塔法”搭建骨架，用“金线逻辑”贯穿血肉，用“审稿人视角”加固盔甲，最后用“好莱坞预告片”原则进行包装**——这套组合拳，是我指导学生并让他们在顶级期刊上不断取得成功的核心秘诀。



## Structure
Of course. As a reviewer who has seen thousands of submissions, I can confirm that a clear, logical structure is the single most important factor for a paper's success, often even more so than the raw novelty of the idea. A well-structured paper is a gift to a reviewer; it makes their job easier and predisposes them to view your work favorably.

### Universal Success Template (The Core Logic)

Regardless of the template, every successful paper answers five questions in order:

1.  **Why should I care?** (Introduction: The big problem)
2.  **What, specifically, is your claim?** (Introduction: The contribution/research question)
3.  **How do I know you're right?** (Methodology & Results: The proof, the evidence)
4.  **So what? What does this mean?** (Discussion: The interpretation and implications)
5.  **What's next?** (Conclusion: The take-home message and future work)

By mastering these structures, you make your research legible and compelling, dramatically increasing your chances of success.

### Template 1: The Core Technical Paper (e.g., CS/Blockchain System or Algorithm)
**Goal:** Convince experts in your field that you have created a technically novel and superior solution to a known problem. The focus is on **performance, security, and scalability**.

#### **`Title: Clear, Concise, and Contains Keywords`**
* **Good:** "AirAccount: A Scalable and Secure Smart Account Infrastructure Based on ERC-4337"
* **Bad:** "A New System for Blockchain"

#### **`Abstract`**
*(Write this last, but it's the most important paragraph. 4-5 sentences max.)*
* **Sentence 1 (Context):** State the broad problem area. "Scalability in blockchain systems remains a critical challenge, hindering widespread adoption."
* **Sentence 2 (Problem):** Narrow down to the specific gap. "Existing solutions, such as plasma chains, suffer from high data availability costs and centralization risks."
* **Sentence 3 (Solution/Contribution):** State your proposed solution. "In this paper, we propose AirAccount, a novel smart contract infrastructure that leverages ERC-4337 and introduces a decentralized computation layer to ensure both scalability and security."
* **Sentence 4 (Results):** State the single most impressive quantitative result. "Our experimental evaluation shows that AirAccount achieves a 5x increase in transaction throughput compared to existing models while reducing gas fees by 70%."
* **Sentence 5 (Impact):** Briefly state the implication. "Our work provides a viable pathway for building complex, high-throughput decentralized applications."

---

#### **`1. Introduction`**
* **Paragraph 1: The Grand Challenge.** Start broad. What is the big, important problem in computer science that everyone in your sub-field cares about? (e.g., blockchain trilemma, MEV, state bloat). Provide context for a non-specialist expert.
* **Paragraph 2: The Specific Problem.** Zoom in. How have others tried to solve this? Name the dominant approaches (e.g., Rollups, Sidechains). Briefly, what is their fundamental limitation? This is the *Problem Statement*.
* **Paragraph 3: The Research Gap.** Get very specific. State precisely what existing work has failed to do. "While ZK-Rollups improve scalability, they introduce computational bottlenecks for provers. No existing system has effectively balanced prover efficiency with on-chain security." This is the niche you will fill.
* **Paragraph 4: Your Contribution.** This is the most crucial paragraph for a reviewer. Use a bulleted list.
    * **Sentence 1:** "To address this gap, we make the following contributions:"
    * **Bullet 1:** "We design and propose `[Name of Your System]`, a novel architecture that `[describe its key innovation in one phrase]`."
    * **Bullet 2:** "We introduce a new algorithm, `[Algorithm Name]`, for `[what it does, e.g., decentralized scheduling of computations]`."
    * **Bullet 3:** "We implement a full prototype of `[Name of Your System]` using `[key technologies, e.g., Rust and Solidity]` and open-source our code for reproducibility."
    * **Bullet 4:** "We conduct an extensive experimental evaluation that demonstrates the superiority of our approach over state-of-the-art baselines in terms of `[metric 1]`, `[metric 2]`, and `[metric 3]`."
* **Paragraph 5: Structure.** "The remainder of this paper is organized as follows. Section 2 reviews related work. Section 3 details our system design..."

#### **`2. Related Work`**
*(Do not just list papers. Create themes and arguments. The goal is to prove your novelty.)*
* **Structure by Theme, not by Paper.** For example, have subsections like "2.1 Layer-2 Scaling Solutions", "2.2 Account Abstraction Models", "2.3 Decentralized Sequencers".
* **For each theme/subsection:**
    * **Sentence 1:** Introduce the class of solutions.
    * **Sentence 2-N:** Describe key works (e.g., [Author, Year]). What was their approach? What were their results?
    * **Final Sentence (Crucial):** Conclude the paragraph by stating how your work is different or superior. "While these approaches improve X, they fail to address Y, which is the primary focus of our system."

#### **`3. System Design and Architecture`**
*(This is the "how it works" section. Use diagrams.)*
* **Section 3.1: Overview.** Present a high-level architecture diagram. Explain what each major component does and how they interact. Guide the reader through the diagram.
* **Section 3.2: Component/Algorithm 1.** Deep dive into the first key component. Use pseudo-code for algorithms. Explain the design choices you made and why.
* **Section 3.3: Component/Algorithm 2.** Deep dive into the next component. Explain its inputs, outputs, and internal logic.
* **Use formal notation where appropriate** ($T_{total} = T_{compute} + T_{commit}$) to add rigor.

#### **`4. Implementation`**
*(Brief but important for credibility.)*
* **Paragraph 1: Technology Stack.** "We implemented our prototype, AirAccount, in ~5,000 lines of Rust and 500 lines of Solidity. It uses the `[X]` library for cryptography and the `[Y]` framework for smart contracts."
* **Paragraph 2: Open Sourcing.** "To foster reproducibility and future research, we have made our entire codebase and experimental scripts publicly available at `[Link to GitHub/Zenodo]`."

#### **`5. Evaluation`**
*(The "proof" section. Be ruthlessly scientific.)*
* **Section 5.1: Experimental Setup.**
    * **Hardware/Software:** What machines did you use? (CPU, RAM, Network). What OS/software versions?
    * **Datasets/Workloads:** What data did you use to test? (e.g., a real-world transaction trace from Ethereum, a synthetic workload with specific characteristics).
    * **Baselines:** Which other systems are you comparing against? You MUST compare against the state-of-the-art.
* **Section 5.2: Research Questions & Metrics.** Explicitly state what you are measuring. "Our evaluation seeks to answer the following questions: (1) How does AirAccount scale with an increasing number of users? (2) What is the end-to-end latency per transaction? We measure performance using throughput (TPS) and latency (ms)."
* **Section 5.3: Results: `[Name of First Experiment]`**
    * State the goal of the experiment.
    * Present the result in a clear graph or table. The caption should fully explain the graph.
    * In the text, state the main finding. "As shown in Figure 1, the throughput of AirAccount scales linearly, while the baseline systems plateau at 500 TPS."

#### **`6. Discussion`**
*(Interpret your results. Why do they matter?)*
* **Paragraph 1: Summary of Findings.** In prose, summarize your key results. "Our experiments revealed that our decentralized computation approach significantly reduces bottlenecks, leading to superior scalability."
* **Paragraph 2: Implications.** What is the broader meaning? "This suggests that our architecture is not only technically feasible but also economically viable for hosting large-scale applications like decentralized social media or games."
* **Paragraph 3: Limitations.** Be honest. This builds trust. "We acknowledge that our prototype has not been tested in a fully adversarial public environment. Furthermore, our model currently assumes a synchronous network."

#### **`7. Conclusion and Future Work`**
* **Paragraph 1: Conclusion.** A concise recap of the paper: problem, solution, main result. Mirror the abstract.
* **Paragraph 2: Future Work.** Be specific. "In the future, we plan to extend our work in three directions: first, developing a more robust economic incentive model; second, integrating privacy-preserving features using ZK-proofs; and third, deploying a public testnet."

---

### Template 2: The Interdisciplinary Paper (e.g., Blockchain + Management/Sociology)
**Goal:** Convince experts from two different fields that you are using technology to understand a social/managerial phenomenon in a novel way, or that your understanding of a phenomenon informs better technology design. The focus is on **implications, insights, and theoretical contribution**.

#### **`Title: Bridge the two fields`**
* **Good:** "HyperCapital: A Framework for Measuring and Fostering Social Capital in Decentralized Autonomous Organizations (DAOs)"
* **Bad:** "A Study of DAOs"

#### **`Abstract`**
* **Sentence 1 (Context):** State the problem from the *social/management* perspective. "Effective collaboration in decentralized organizations (DAOs) is hampered by a lack of trust and quantifiable social capital."
* **Sentence 2 (Problem):** Introduce the technology and the gap. "While blockchain provides tools for governance, it lacks mechanisms to measure the relational aspects of collaboration, a gap in both organizational theory and system design."
* **Sentence 3 (Solution/Contribution):** State your framework or case study. "This paper develops HyperCapital, a socio-technical framework for measuring social capital on-chain, and analyzes its application within the Mycelium Protocol, a real-world collaborative ecosystem."
* **Sentence 4 (Results):** State the key qualitative finding or insight. "Our findings indicate that transparently measuring and rewarding relational work significantly increases contributor engagement and perceived trust."
* **Sentence 5 (Impact):** State the theoretical and practical impact. "This work contributes a novel, quantifiable dimension to social capital theory and provides actionable design principles for building more effective decentralized organizations."


#### **`1. Introduction`**
* **Paragraph 1: The Real-World Problem.** Start with the compelling business or social problem. "The future of work is increasingly decentralized... however, this shift poses significant challenges to traditional models of management and collaboration..." Use citations from the management/sociology field.
* **Paragraph 2: Technology as a Double-Edged Sword.** Introduce blockchain/DAOs. Explain how it's seen as a potential solution (e.g., enabling trustless coordination) but also how it creates new problems or misses key human elements (e.g., it focuses on voting, not relationships).
* **Paragraph 3: The Theoretical and Practical Gap.** State the gap in knowledge. "Organizational theories like Social Capital Theory provide a lens to understand these issues, but have rarely been applied or operationalized in a digitally native, decentralized context. Consequently, current DAO platforms are designed without regard for these crucial social dynamics."
* **Paragraph 4: Research Questions and Objectives.** Use "How" or "What" questions.
    * **RQ1:** "How can social capital be defined and measured within a blockchain-based collaborative environment?"
    * **RQ2:** "What are the effects of making social capital visible and rewardable on contributor behavior and organizational outcomes?"
* **Paragraph 5: Structure.** Same as before.

#### **`2. Theoretical Background / Literature Review`**
*(This section is much more extensive than in a technical paper. You must prove mastery of both fields.)*
* **Section 2.1: The Social/Management Theory.**
    * Explain the core concepts of the theory you are using (e.g., Social Capital Theory). What are its key dimensions (e.g., structural, relational, cognitive)? Who are the key authors?
* **Section 2.2: The Technological Phenomenon.**
    * Explain the relevant technical concepts (e.g., DAOs, governance tokens, on-chain voting). What are the current "state-of-the-art" designs? What are their known limitations from a social/organizational perspective?
* **Section 2.3: Synthesis and Research Framework.**
    * This is the critical part. Bridge the two sections above. How are you combining the theory and the technology? "By synthesizing these two streams, we propose a research framework that operationalizes the dimensions of social capital using on-chain metrics..."

#### **`3. Research Methodology`**
*(This is not about code, but about how you studied the problem.)*
* **Paragraph 1: Research Approach.** State your method clearly. "We employ a single-case study methodology, as it is well-suited for investigating contemporary phenomena in-depth within a real-life context." (Other options: Action Research, Survey, Qualitative Interviews). Justify your choice.
* **Paragraph 2: Case Selection and Description.** Why did you choose to study the Mycelium Protocol? What is it, what does it do, and why is it a good example of the phenomenon you're investigating?
* **Paragraph 3: Data Collection.** How did you get your data? "We collected data from three sources over a six-month period: (1) on-chain transaction data from the protocol's smart contracts, (2) 15 semi-structured interviews with core contributors, and (3) archival data from public Discord channels and governance forums."
* **Paragraph 4: Data Analysis.** How did you analyze the data? "On-chain data was analyzed quantitatively to derive metrics for our HyperCapital framework. Interview transcripts and archival data were analyzed qualitatively using thematic analysis..."

#### **`4. Findings / Results`**
*(Present the evidence, organized by your research questions or emerging themes.)*
* **Section 4.1: Finding Theme 1.** (e.g., "Operationalizing Social Capital On-Chain").
    * Present the finding. You might present a table showing the theoretical dimension, your proposed on-chain metric, and an example.
* **Section 4.2: Finding Theme 2.** (e.g., "The Impact of Visibility on Contribution").
    * Present another finding. Use powerful, anonymous quotes from your interviews as evidence. "As one contributor noted, 'Seeing my reputation score go up was more motivating than the financial reward... it felt like recognition.'" Weave this qualitative data with your quantitative on-chain data.

#### **`5. Discussion`**
*(This is the most important section. Move from "what we found" to "what it means".)*
* **Section 5.1: Interpretation of Findings.** Connect your findings back to your research questions and the literature review. "Our first finding, that on-chain activity can serve as a proxy for structural social capital, extends the work of [Author, Year] into a digital context..."
* **Section 5.2: Theoretical Contribution.** State your contribution to *theory* explicitly. "This study makes two key contributions to Social Capital Theory. First, it introduces a fourth, quantifiable 'digital' dimension. Second, it challenges the assumption that trust requires interpersonal history by demonstrating a form of calculative, system-based trust."
* **Section 5.3: Practical / Managerial Implications.** What should people in the real world *do*? "For DAO operators, our findings suggest they should actively design systems that reward non-financial, relational contributions. For managers in traditional firms, our work provides a template for how to foster collaboration in remote teams."
* **Section 5.4: Limitations.** (e.g., "Our findings are from a single case study and may not be generalizable... The contributors were early adopters and may not represent typical users.")

#### **`6. Conclusion`**
* **Paragraph 1:** Briefly summarize the entire research journey: the problem, the theoretical lens, the method, the key insight, and the main contribution.
* **Paragraph 2:** End with a powerful, forward-looking statement about the future of decentralized work or the integration of social science and system design.

### 写作流程
所有文档都在 docs 目录。
1. research 文档：产品系统同名文档，从学术角度分析和论证，规划和设计，以及 AI 辅助的分析。
2. Solution 文档：系统设计思考输入和分析，外部信息，个人思考和繁细，
3. Features 文档：问题和痛点是什么，当下解决方案的缺点，未来的趋势，本产品/系统的创新点，具体 feature 的表现和交互，user case 描述，产品架构图
4. Design 文档：针对 feature 文档的设计，进入到技术和实现阶段，系统模块设计，底层架构，核心组件，API 和函数，等设计；针对产品 user case 的具体交互实现，操作流程和交互数据结构等设计
5. Plan 文档：针对设计文档的实现，进入到计划和执行阶段，包括任务拆分，版本划分，时间计划，人员分工，资源需求，风险评估，等计划
6. Changes 文档：针对计划文档的执行，进入到变更和调整阶段，包括变更原因，变更内容，变更影响，变更时间，变更人员，变更资源，变更风险，等变更。
7. Deploy 文档：针对发布文档的执行，记录如何进行测试和生产环境的部署、监控和维护，产品的发布。
8. Release 文档：针对变更文档的执行，进入到 beta，alpha，release，对外公开的包括发布时间，发布内容、版本，文档等。
9. GitHub repo：产品代码和文档对应的 repo，包括代码，文档，issue，pr，等。
10. Demo 和 snapshot：产品 demo 和关键 use case snapshot，包括视频，截图，等。

----
### 大论文

### structure



#### step
Five tips for efficiently writing a doctoral dissertation include 
1. setting daily goals, 
2. communicating with your advisor,
3. focusing on content over details in the first draft, 
4. breaking the dissertation into smaller tasks for motivation, 
5. and scheduling regular breaks to enhance productivity. These strategies aim to help students graduate on time.

Writing the initial draft should prioritize content expression over grammatical accuracy. It's essential to get ideas down first before revising later.





## 行动计划
### **Extended Meaning and Outlook: A 6-Month Roadmap**

Here is a proposed strategic plan for the next six months:

* **Months 1-2:** Write and submit Paper 1 (AirAccount security) to **`COMPUTERS & SECURITY`**. This is your most direct path to a submission that meets your Q2/free/fast criteria. While writing, read at least 5-10 articles from the journal to internalize their style and scope.

* **Months 2-4:** While Paper 1 is in review, begin the heavy lifting on Paper 2 (HyperCapital). This involves significant reading in social science and management journals. Select your target journal (*e.g., Journal of IT & People*) and write the paper according to its specific theoretical conventions. Submit by the end of Month 4.

* **Months 4-5:** Prepare Paper 3 (Arcadia) as a system description or case study. This should be faster to write as it's more descriptive. Target **`Blockchain: Research and Applications`**. By this time, you may have received initial reviews for Paper 1, which you will need to address.

* **Month 6:** Prepare Paper 4 (COS72/HexagonWarrior) for a software engineering journal. By the end of this period, you could have four papers under review and will be managing the revision and resubmission process, which is the reality of academic publishing.

This strategy front-loads your most well-defined technical work, allowing you to build a publication record while tackling the more challenging theoretical papers. This approach transforms your impressive engineering accomplishments into the academic currency required for your doctorate.

### 弱点分析和加强建议
You are a **Practitioner-Innovator**. Your primary strength is building functional, complex systems. Your stated challenge is systematizing the academic theory. Your ambitious timeline suggests you are under pressure to demonstrate research output for your PhD.

This persona is common and powerful. The key is to not see your lack of initial theoretical framing as a weakness, but to frame your work as **practice-led research**. Your systems are the "data" or "evidence" that can be used to build, test, or extend theory. Your papers should reflect this. Avoid writing purely technical descriptions; always **connect them back to a "so what?"—a problem in the academic literature that your system helps to solve or understand**.
