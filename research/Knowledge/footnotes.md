### 在 Markdown 中创建类似脚注

Markdown 支持通过内置语法或 HTML 标签创建上标脚注引用。以下是实现类似示例（上标数字引用 + 底部列表）的常见方法：

1. **使用标准 Markdown 脚注语法**（推荐，用于大多数 Markdown 处理器，如 GitHub Flavored Markdown）：
   - 在正文中插入脚注引用：使用 `[^1]`、`[^2]` 等（自动渲染为上标数字）。
   - 在文档底部定义脚注内容：使用 `[^1]:` 后跟描述。
   - 示例代码：
     ```
     正文内容[^1]，另一个内容[^2]。

     **Footnotes:**

     [^1]: Cryptocurrency market data: CoinMarketCap (https://coinmarketcap.com/charts/)
     [^2]: Layer 2 gas fee data: L2Fees.info (https://l2fees.info/)
     ```
   - 渲染效果：正文中显示上标¹、² 等，点击可跳转到底部脚注列表。

2. **使用 HTML 上标标签**（适用于不支持内置脚注的 Markdown 变体）：
   - 在正文中使用 `<sup>1</sup>` 创建上标数字。
   - 手动在底部创建列表，使用 Unicode 上标字符（如 ¹、²）或普通数字。
   - 示例代码：
     ```
     正文内容<sup>1</sup>，另一个内容<sup>2</sup>。

     **Footnotes:**

     ¹ Cryptocurrency market data: CoinMarketCap (https://coinmarketcap.com/charts/)
     ² Layer 2 gas fee data: L2Fees.info (https://l2fees.info/)
     ```
   - 注意：Unicode 上标字符（如 ¹）可直接复制使用，但兼容性因渲染器而异。

3. **注意事项**：
   - 如果需要自定义样式（如脚注字体大小），可结合 CSS（在支持 HTML 的环境中）。
   - 避免过多脚注以保持可读性。

### 在 LaTeX 中创建类似脚注

LaTeX 内置脚注支持，使用 `\footnote` 命令自动生成上标数字和页面底部注释。对于示例中的底部集中列表（更像尾注或参考文献），可使用标准脚注或 `endnotes` 包。以下是方法：

1. **使用内置 `\footnote` 命令**（页面底部脚注）：
   - 在正文中插入 `\footnote{文本}`，LaTeX 会自动添加上标数字并在页面底部显示脚注。
   - 示例代码：
     ```latex
     \documentclass{article}
     \begin{document}

     正文内容\footnote{Cryptocurrency market data: CoinMarketCap (https://coinmarketcap.com/charts/)}，另一个内容\footnote{Layer 2 gas fee data: L2Fees.info (https://l2fees.info/)}。

     \end{document}
     ```
   - 渲染效果：正文中显示上标¹、² 等，脚注出现在页面底部。

2. **使用 `endnotes` 包创建尾注列表**（文档末尾集中显示，类似示例）：
   - 加载包：`\usepackage{endnotes}`。
   - 在正文中使用 `\endnote{文本}`。
   - 在文档末尾添加 `\theendnotes` 以输出列表。
   - 示例代码：
     ```latex
     \documentclass{article}
     \usepackage{endnotes}
     \begin{document}

     正文内容\endnote{Cryptocurrency market data: CoinMarketCap (https://coinmarketcap.com/charts/)}，另一个内容\endnote{Layer 2 gas fee data: L2Fees.info (https://l2fees.info/)}。

     \section*{Footnotes}
     \theendnotes

     \end{document}
     ```
   - 渲染效果：上标数字引用，尾注在单独部分列出。

3. **自定义脚注数字**（如果需要特定编号）：
   - 使用 `\footnotemark[数字]` 和 `\footnotetext[数字]{文本}` 分离标记和内容。
   - 示例：`\footnotemark[1]` 在正文，`\footnotetext[1]{文本}` 在底部。
   - 这适用于表格或特殊布局。

4. **注意事项**：
   - 脚注编号通常为阿拉伯数字，可通过 `\usepackage[选项]{footmisc}` 自定义格式。
   - 对于 URL，确保使用 `\usepackage{hyperref}` 以使链接可点击。
   - 在复杂文档中，避免脚注过多；考虑使用 BibTeX 处理参考文献。