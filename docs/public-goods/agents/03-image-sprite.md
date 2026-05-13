# AG-03 图片精灵 Agent

> **一句话**：告诉它你是做什么的、什么风格、要用在哪里，它帮你持续生成与品牌调性一致的图片——不需要设计师，不需要 Photoshop。

---

## 目标用户

- 电商卖家：产品主图、详情页配图、促销海报
- 内容创作者：公众号封面、小红书配图、视频封面
- 本地商家：菜单图、活动海报、门店宣传图
- 初创公司：官网配图、PPT 插图、品牌素材

## 核心痛点

| 痛点 | 现状 | Agent 解决后 |
|------|------|-------------|
| 找设计师贵且慢 | 一张图 ¥50-500，2-3 天 | 秒出，成本接近 ¥0 |
| AI 生图风格乱 | 每次出图风格不统一 | 品牌档案 → 风格锁定 |
| 不会写提示词 | "生成一张好看的图"效果差 | 描述业务场景 → Agent 翻译成专业 prompt |
| 版权风险 | 网上找图侵权 | 本地模型生成，完全自有 |

---

## 核心概念：品牌档案（Brand Profile）

一次性配置，长期复用：

```yaml
# brand_profile.yaml
business_name: "小明奶茶"
industry: "茶饮餐饮"
style:
  mood: "清新、年轻、治愈"
  colors: ["#A8D5BA", "#FFF8E7", "#E8C4A0"]  # 主色调
  avoid: ["黑暗", "赛博朋克", "工业风"]
  reference_desc: "类似喜茶、霸王茶姬的视觉风格"
logo_path: ./assets/logo.png  # 可选，用于合成
typical_scenes:
  - 奶茶杯特写
  - 门店氛围
  - 原料展示（茶叶/水果）
  - 节日海报（情人节/圣诞/新年）
output:
  sizes: ["1:1", "4:3", "9:16"]  # 正方形/横版/竖版
  format: png
```

---

## 核心指令（用户怎么用）

用户说人话，Agent 翻译并生成：

| 用户说 | Agent 做 |
|--------|---------|
| "帮我生成一张夏日新品海报，产品是芒果奶茶" | 结合品牌档案 → 构建完整 prompt → 出图 |
| "帮我做一套小红书配图，3 张，介绍我们的下午茶套餐" | 出 3 张风格统一的竖版图 |
| "把这张产品图背景换成森林" | 图片编辑：inpainting 替换背景 |
| "生成 10 张不同角度的产品图" | 批量生成 |
| "这张图太暗了，再亮一点、更干净" | 迭代优化，保持风格 |

---

## 技术方案

```
用户指令（自然语言）
    │
    ▼
Prompt 工程层（Agent）
  读取 brand_profile.yaml
  → 构建结构化 prompt：
    主体描述 + 风格关键词 + 颜色约束 + 反向提示词 + 场景参数
    │
    ▼
图像生成层（可选其一）
  ├─ 本地：Stable Diffusion（SDXL / Flux）via ComfyUI API
  ├─ 本地小模型：Kolors（国产，中文理解更好）
  └─ 云 API：Replicate / Stability AI（成本略高但无需 GPU）
    │
    ▼
后处理层（可选）
  ├─ Logo 水印合成
  ├─ 文字排版（标题 / 价格 / 活动文案叠加）
  └─ 尺寸裁切（1:1 / 9:16 / 4:3 等多规格输出）
    │
    ▼
输出：PNG / JPG，可批量下载
```

---

## 本地部署方案

**最低配置**（推荐入门）：
- 显存 ≥ 8GB NVIDIA GPU（RTX 3060 / 4060 以上）
- VRAM 8GB → 跑 SDXL，出图约 15-30 秒
- VRAM 16GB → 跑 Flux.1-dev，出图约 20-40 秒，质量更高

**无 GPU 方案**：
- CPU 模式（较慢，约 3-10 分钟/张，适合低频使用）
- 云 GPU 按需租用（AutoDL / Replicate，¥0.2-1/张）

---

## Prompt 工程示例

用户输入：`"帮我生成一张七夕活动海报，奶茶搭配玫瑰"`

Agent 生成的实际 prompt：
```
Positive:
a beautiful milk tea cup with roses, romantic valentines day poster,
fresh and youthful style, soft green and warm beige color palette,
clean background, professional product photography, high detail,
8k, commercial photography, gentle lighting, cozy atmosphere

Negative:
dark, cyberpunk, industrial, low quality, blurry, ugly, deformed,
watermark, text, logo
```

---

## 图像编辑功能（v1.5）

| 功能 | 技术 | 说明 |
|------|------|------|
| 背景替换 | Inpainting | 抠出产品，换背景 |
| 风格迁移 | IP-Adapter | 把参考图的风格套到新图 |
| 超分辨率 | Real-ESRGAN | 低分辨率图 → 4K |
| 去背景 | RMBG / BiRefNet | 快速抠图，输出透明背景 PNG |

---

## 成本估算

| 方案 | 单张成本 | 适合用量 |
|------|---------|---------|
| 本地 GPU（已有）| ¥0 | 无限 |
| 云 GPU 租用 | ¥0.3-0.8/张 | 每月 < 200 张 |
| Replicate API | ¥0.5-1.5/张 | 偶尔用 |

---

## v2 路线图

- [ ] 视频短片生成（15 秒产品展示视频）
- [ ] 文字排版自动化（海报文案一键排版）
- [ ] 与 AG-07 内容工坊联动（文案 + 图片同步出）
- [ ] 多平台规格一键导出（微信、小红书、抖音各尺寸）
- [ ] 风格一致性强化（LoRA 微调用户品牌风格，10 张参考图即可训练）
