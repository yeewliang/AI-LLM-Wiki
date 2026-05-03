## 前言

週末你用 Cursor 從零做出一個 side project。前端寫完後端串完，部署上線，看著它跑起來 — — 真的超爽。

但在週一回到公司。同樣的工具，同樣的 AI，隨著時間演進 codebase 卻越來越難維護 — — agent 在不該動的地方亂改，每次 session 都得重新交代一遍背景，Plan 完後你卻開始擔心是否有哪邊沒注意到。

是因為複雜度上升導致的 AI 變笨嗎？難道 AI 只能用在 MVC 上面，PROD 就不行嗎？或許可能是我們需要改變我們與 AI 協作的工作方式。

2026 年 2 月，OpenAI 工程師 Ryan Lopopolo 寫了一篇文章：3 人團隊，5 個月，AI 產出近百萬行代碼、超過 1,500 個 PR。他們沒有特別的模型，沒有秘密 prompt — — 他們換了一套工作方式。

這套工作方式叫做 **Harness Engineering** 。

## 工程師工作方式

AI 輔助開發已有幾個可辨識的階段，由淺入深大致是這樣：

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ORiSWK8BfznGXeuxiMJizA.png)

### Prompt Engineering

「每次都從頭」。你學會了怎麼問，但關掉對話，知識停在腦子裡，沒有進入系統。

### Vibe Coding

更往前一步，能快速做出東西，協作感也很真實。但天花板很低 — — 大型 codebase 或多人協作時，沒有結構的協作只會製造混亂。

### Harness Engineering

是更成熟的一步。 **工程師的產出不再是代碼，而是建立讓 agent 可靠工作的環境。**

## Harness 是什麼：工程師視角

「Harness」這個詞由 Martin Fowler 的團隊精確定義：

[https://martinfowler.com/articles/harness-engineering.html](https://martinfowler.com/articles/harness-engineering.html)

> ***harness = system prompt + Context Management + Tool Use + Evaulation Loop***

這個定義把 harness 從「一段說明文字」升格為一個工程物件 — — 有四個元件，可以被設計、版本化、評估。

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*SC8ars7Rm8Rfrv65yrSuRQ.png)

四個元件缺一不可。少了任何一個，agent 就在那個維度沒有邊界，遲早出問題。

## 核心轉變：你的產出是什麼？

> *工程師的產出從「程式碼」變成了「約束系統」 — — AGENTS.md、架構規則、自定義 linter、回饋路徑。*

這個轉變對應 Harness Engineering 的六大核心概念

1. Repo as System of Record — 不在倉庫裡的東西，對 agent 不存在
2. Map, Not Manual — 放入口，而非完整的手冊
3. Mechanical Enforcement — 文件會腐爛，lint 規則不會 (下面會提到)
4. Agent Readability — 文件是為 agent 推理速度優化，不為人類閱讀邏輯
5. Entropy & Garbage Collection — Agent 會複現倉庫裡的壞模式，需週期性清理
6. Throughput Changes Merge — PR 短命，偶發失敗用重跑解決

***先搞懂最重要的三個。***

### 1\. Repo as System of Record（倉庫即記錄系統）

不在倉庫裡的東西，對 agent 不存在。

Slack 討論、口頭共識、你腦子裡的架構決定 — — 對 agent 都是透明的。 **一切決策、規範、計劃都必須提交進倉庫** ，agent 才能可靠遵守。

> 不單單只「寫文件」，而是思維上的變化：你說的規則如果不在 repo 裡，就等於沒說。每次都要重複的敘述，也是不好

### 2\. Mechanical Enforcement（機械化執行）

文件會腐爛，lint 規則不會。

AGENTS.md 裡寫「不在 core 層 import infra」，但沒人執行這條規則。某次 agent 圖方便直接 import，你沒發現，這個模式就被後來的 agent 複製了。

> **把「約定」升格成 lint 規則** 。違反時不只報錯，還嵌入修復指令 — — agent 讀完就能自己改，不需要你再介入。

### 3\. Entropy & Garbage Collection（熵管理）

Agent 會複現 codebase 裡的模式 — — 包括壞模式。

repo 裡有一段糟糕的舊代碼，agent 下次可能就照著寫。技術債不只讓人類痛苦，也在污染 agent 的 in-context 學習。

> 定期清理偏差、掃描違規代碼，是讓 harness 保持健康的必要維護。

> 補充 — Ralph Loop 讓 Agent 自主跑到完成

理解了 harness 之後，下一個自然問題是：agent 跑完一個任務後，能不能自己繼續跑下一個？

這就是 **Ralph 模式** — — 名字來自辛普森家庭的 Ralph Wiggum，一個很專注但不看全局的小孩。

## [GitHub - snarktank/ralph: Ralph is an autonomous AI agent loop that runs repeatedly until all PRD…](https://github.com/snarktank/ralph?source=post_page-----ba4d859e4606---------------------------------------)

### Ralph is an autonomous AI agent loop that runs repeatedly until all PRD items are complete. - GitHub - snarktank/ralph…

github.com

Ralph 的邏輯極簡： **一個 bash 迴圈，每次迭代清空 context、讀 PRD、做一件事、提交，直到所有任務完成。**

```c
while ! task_complete; do
  claude "讀 PRD，完成下一個未完成的任務，提交。"
done
```

每次迭代從乾淨的 context 開始，不帶上次的包袱 — — 這正是 harness 設計的核心。

而 Ralph 六個信條對應到 Harness Engineering 原則：

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*A5H5YBlcclS-0HBwkijUtw.png)

到這邊，小總結在 harness engineering 中，我覺得可以先做的

- 建立文件 OR Memory Layer (之後 Hermes Agent 會講到)
- 透過文件制定約束
- 約束往前推進，維護專案品質
- 定期檢視程式或文件的髒東西，清除他們

> **Context engineering**: Continuously enhanced knowledge base in the codebase, plus agent access to dynamic context like observability data and browser navigation
> 
> **Architectural constraints**: Monitored not only by the LLM-based agents, but also deterministic custom linters and structural tests
> 
> **“Garbage collection”**: Agents that run periodically to find inconsistencies in documentation or violations of architectural constraints, fighting entropy and decay

## 判斷約束好壞的三個特徵

> 有了文件後，想要制定約束避免程式亂走，就要來做個約束，但怎樣才會是好的約束呢？

### ① 機器可驗證

好的約束應該能被 lint 或 CI 自動驗證，而不靠人工 review。  
如果你想不出「這條規則怎麼用程式檢查」，它可能只能作為建議，不是規則。

### ② 嵌入修復指令

好的 lint 錯誤訊息是寫給 agent 看的，不是寫給人看的：

- ❌「Error: import violation」
- ✅「LINT ERROR: core/user.py 直接 import infra/db。應改用 core/ports.py 的 UserRepo interface。」

第二種可以讓 agent 讀完就能修，不需要你再介入。

### ③ 漸進披露

AGENTS.md 應該是目錄頁，不是百科全書。

維繫約 100 行的入口，指向更深層的細則文件。入口越精簡，agent 越不容易因 context 太重而跑偏。

巨型指令文件有三個死因：塞爆 context window、快速忘記、無法機械驗證。

## 其實，你不一定要追求更好的 Prompt

Vibe Coding 有它的價值 — — 快速驗證想法、做 side project，它是很好的工具。

但當你開始問「為什麼 agent 一直亂搞」「維護為什麼越來越難」「為什麼每次 session 都得重新交代」 — — 不是你的 prompt 有問題，而是 **環境設計開始炸裂** 。

Harness Engineering 將 prompt 給予一個完整演進的角色：

- 把規則放進 repo，不放在腦子裡
- 把約定升格成 lint，不靠口頭遵守
- 把 agent 放在回饋迴路裡，讓它自己修正

你不需要更好的 prompt。你需要一個更好的環境 — — 一個你設計的 harness。

*延伸閱讀：*

- [*Harness Engineering — OpenAI*](https://openai.com/zh-Hans-CN/index/harness-engineering/)
- [*deusyu/harness-engineering*](https://github.com/deusyu/harness-engineering) *— 中文學習檔案，整合 19 篇相關文章*
- [*snarktank/ralph*](https://github.com/snarktank/ralph) *— Ralph 原版實作*