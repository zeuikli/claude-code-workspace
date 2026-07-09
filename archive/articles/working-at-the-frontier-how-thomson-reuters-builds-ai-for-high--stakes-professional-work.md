---
title: "Working at the frontier: How Thomson Reuters builds AI for high- stakes professional work | Claude by Anthropic"
url: https://claude.com/blog/working-at-the-frontier-how-thomson-reuters-builds-ai-for-high--stakes-professional-work
slug: working-at-the-frontier-how-thomson-reuters-builds-ai-for-high--stakes-professional-work
fetched: 2026-07-09 04:50 UTC
---

# Working at the frontier: How Thomson Reuters builds AI for high- stakes professional work | Claude by Anthropic

> Source: https://claude.com/blog/working-at-the-frontier-how-thomson-reuters-builds-ai-for-high--stakes-professional-work




# Working at the frontier: How Thomson Reuters builds AI for high-stakes professional work

Joel Hron, CTO at Thomson Reuters, has spent years putting AI inside products trusted by lawyers and accountants. Here is why he considers Claude Fable 5 a critical evolution in what’s possible with AI for knowledge work.

‍

- Category

Enterprise AI

- Product

Claude Platform

Claude Enterprise

Claude Code

- Date

July 8, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/working-at-the-frontier-how-thomson-reuters-builds-ai-for-high--stakes-professional-work

Thomson Reuters, a global content and technology company, has spent more than 175 years building trusted content and technology for professionals and institutions making consequential decisions. Today, that same mission is shaping how the company builds AI for legal, tax, accounting, compliance, and other high-stakes professional workflows.

"We're a technology company focused on professions that demand accuracy and precision," says Joel Hron, CTO of Thomson Reuters.

Its products are the reference tools those professions run on: Westlaw and Practical Law for legal research and practical guidance, CoCounsel Legal, Thomson Reuters professional-grade legal AI platform, is designed to make legal professionals better at their jobs, with answers they can defend and outcomes that provide real value. Hron joined Thomson Reuters four years ago when his startup was acquired by the company, working at the intersection of product, technology, and strategy. In that time period, he says, AI has reshaped what it means to build software. Choosing the right technology partners has never been more important.

The bar for selecting which LLMs to use to power these products is unusually concrete. Hron and his team evaluate a new model by asking whether its work can withstand the level of professional review lawyers apply before relying on it in their work.

### Evaluating models for legal work

Plenty of companies can build a legal AI tool, but far fewer can build one a lawyer would put their name on. Thomson Reuters brings three advantages to professional AI that general-purpose systems cannot easily replicate: authoritative content, deep domain expertise, and workflow integration.

The reason a lawyer can rely on a Westlaw answer is not the model on its own, says Hron. It is decades of curated case law, the work of 2,700+ domain experts across the globe who annotate and enhance that content every day, and the evaluations Thomson Reuters builds on top of models like Claude. "That human professional is still the one who is accountable for the end work product."

Claude is a valuable model partner, but the professional-grade system comes from the combination of Anthropic's frontier models with Thomson Reuters' authoritative content, deep domain expertise, workflow integration, and evaluation infrastructure.

Thomson Reuters describes this approach as Fiduciary-Grade AI™: AI grounded in authoritative content, shaped by deep domain expertise, and embedded directly into professional workflows, so outputs are transparent, verifiable, and defensible when the stakes are high.

That accountability is why verification matters more here than fluency. Thomson Reuters rebuilt legal research around agents tuned for "not just search and not just retrieval, but citation validation and verification." The requirement is a system that helps validate citations and surface sources clearly, so professionals can review, verify, and apply their judgment with confidence.

The change shows up in what customers report. Research that "would take dozens of hours," Hron says, now arrives "in a matter of minutes," giving professionals a high-quality starting point they can evaluate, refine, and act on. "Deep research has been a profound shift in how to think about legal research."

### Building an agent-first product

For Thomson Reuters, building agents isn't about creating a smarter chatbot. It reflects a new way to deliver existing products. Hron and his team set out to teach an agent to use all the tools the company used to offer as standalone software. A single agent now has access to hundreds of company tools — simultaneously.

That shift changed how Thomson Reuters evaluated models. "Our big test for Claude is to really assess how good it is at making plans and using these tools effectively and correctly," he says.

CoCounsel Legal shows what that looks like. It used to run separate skills one after another. Rebuilt on the Claude Agent SDK, it now plans, delegates, and orchestrates across tools and content sources in real time, so a professional can define the outcome instead of dictating every step. Customer data remains protected and is not used to train third-party models.

Hron traces the choice back to how the two companies started working together. Thomson Reuters was one of Anthropic's earliest enterprise customers, and the deciding factor wasn't a benchmark. "The number one thing that spoke to us was Anthropic's approach to building enterprise AI," he says, citing transparency, safety, and responsible AI development. The first proof point was deep research in legal, built together as both teams noticed how Anthropic's engineers used the tools the way Thomson Reuters was already shipping them.

### What knowledge work demands of a model

Product, operations, and business teams across the company use Claude Cowork for process automation and light prototyping.

Across those projects, Hron's team has settled on four things a model has to do before Thomson Reuters trusts it.

First, the model, as part of the CoCounsel Legal system, has to check its own citations. Rather than retrieve a source and move on, the system has to validate what it cites before presenting its findings to a human for final review and verification.

In this system, the model also has to hold steady across long chains of tool calls. Longer tasks demand better context management and dependable tool use over an extended run. A model has to keep the thread across many steps and many systems, so an agent finishes real work instead of stalling halfway through.

It also has to bring a person into the work, not just the answer. For the hardest jobs, Hron wants a model that will "bring the human into the loop of developing a work product rather than just relying on the agent to one shot an answer."

And finally, it has to free up time for work the Thomson Reuters team didn't have bandwidth to tackle before. Thomson Reuters is developing advanced drafting capabilities for complex legal work, including motion drafting, filings that professionals would otherwise "spend days or weeks perfecting," he says. The task "always required far too much context and precision" for earlier models. With Claude Fable 5, it's now within reach.

### The ROI of AI

Hron takes a contrarian view on AI's return on investment, one other leaders rolling out models might find useful. "If you try to optimize too much for the rate of return calculation, you miss the forest for the trees," he says. He wants teams to feel the cultural and mindset shift before they tune for cost per task. Once that mindset shift happens, the returns follow on their own.

He still tracks traditional engineering measures like DevOps Research and Assessment (DORA) and time from idea to production, and he points to an internal error-remediation tool built on Claude that turned a production issue from three hours of root cause analysis into a four-minute fix. "The ability to get back to health within minutes versus hours is a material difference."

The deeper change, according to Hron, is to the work itself.

"The act of writing lines of code is no longer the job," Hron says of his engineers; the skills that matter most now are systems thinking, judgment, and taste. He sees the same pattern spreading past engineering, with AI making people "more T-shaped," able to reach across product, design, and finance rather than staying in one lane.

### What's next

Employees at Thomson Reuters use Claude Code to get up to speed on code bases and build long-running agents.

Hron and his team are eager to push the boundaries with Claude Fable 5 and future Claude models: longer-horizon work, better context management, and tool calling they can count on across the chain of tasks an agent runs.

He is just as eager to use these models in his own work. Claude Code has let him "be far more technical again," coming up to speed on a codebase he hasn't touched in months within minutes rather than a day, and he turns to Claude Cowork to take on the perspective of a CFO or strategy officer and pressure-test ideas.

Those are the directions models like Claude Fable 5 are being built around, and for work that ultimately has to hold up in court, Hron sees that as the frontier worth pushing on next. After all, professional AI has to work in environments where being almost right is not good enough.

Get started with Claude Fable 5.

No items found.

PrevPrev

0/5

NextNext

eBook

##

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Jul 8, 2026

### How Anthropic's marketing operations team uses Claude Cowork to automate reporting and campaign builds

Enterprise AI

How Anthropic's marketing operations team uses Claude Cowork to automate reporting and campaign buildsHow Anthropic's marketing operations team uses Claude Cowork to automate reporting and campaign builds

How Anthropic's marketing operations team uses Claude Cowork to automate reporting and campaign buildsHow Anthropic's marketing operations team uses Claude Cowork to automate reporting and campaign builds

Jul 7, 2026

### How people are using Claude Cowork

Enterprise AI

How people are using Claude CoworkHow people are using Claude Cowork

How people are using Claude CoworkHow people are using Claude Cowork

Jun 3, 2026

### How Anthropic enables self-service data analytics with Claude

Enterprise AI

How Anthropic enables self-service data analytics with ClaudeHow Anthropic enables self-service data analytics with Claude

How Anthropic enables self-service data analytics with ClaudeHow Anthropic enables self-service data analytics with Claude

May 14, 2026

### How Claude Code works in large codebases: Best practices and where to start

Enterprise AI

How Claude Code works in large codebases: Best practices and where to startHow Claude Code works in large codebases: Best practices and where to start

How Claude Code works in large codebases: Best practices and where to startHow Claude Code works in large codebases: Best practices and where to start

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
