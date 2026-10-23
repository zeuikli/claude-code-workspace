---
title: "Building agents: When to fold subagents into your main agent loop "
url: https://claude.com/resources/articles/building-agents-when-to-fold-subagents-into-your-main-agent-loop
slug: building-agents-when-to-fold-subagents-into-your-main-agent-loop
fetched: 2026-10-23 05:42 UTC
---

# Building agents: When to fold subagents into your main agent loop 

> Source: https://claude.com/resources/articles/building-agents-when-to-fold-subagents-into-your-main-agent-loop

> When to consider using fewer subagents and how to migrate the into your main loop.


# Building agents: When to fold subagents into your main agent loop

When building agents in Claude Platform, using fewer subagents in favor of progressively disclosed context and tools can improve quality while reducing cost and latency. Here’s when and how to migrate.

-

CategoryBest practices, Perspectives

-

ProductClaude Platform

-

AuthorDiane Sarkis

-

DateOctober 22, 2026

-

Reading time18 min

-

ShareCopy link

If you’ve built an agent in Claude Platform that includes multiple subagents, see which may make sense to fold into the main agent loop using our migration kit. It runs a guided workflow to identify your patterns, evaluate alternatives, and verify the best approach. It includes a demo that you can try on a mock system before running on your agent.

Subagents – agents with their own context window, tools, and instructions, orchestrated by a coordinator – are a core component of agent design. They are effective at verification, parallel work, and modular permissioning. We use them in many of our own agents that we build using Claude Platform, for example our multi-agent research system.

However, recently the Applied AI team has found a pattern of enterprise agent deployments that have benefited from folding routers, planners, and domain subagents into the main agent loop. In our comparisons across several enterprise deployments, a single agent with skills frequently outperformed both the one-prompt-for-everything design and the subagent design on quality, and often at a lower cost and latency per task.

For example, one company found the dozen of specialist subagents within its customer-facing agent made a consistent on-brand experience difficult to maintain and added latency that hurt the user experience.

We also often see proposed agent designs that follow a familiar progression: an intent classifier, a fixed multi-step reasoning pipeline, user-segment buckets, separate recommendation branches, and a multi-agent orchestrator on top.

In these cases feedback is often that most of this structure was doing work the model no longer needed done for it, and that one clear system prompt, 4-5 thin data tools, and firm output guardrails would cover most of the use case.

To be clear, subagents still have their place, including at the research frontier. Use them when:

- A single agent loop hits measurable performance degradation from context bloat, or
- Multiple tasks need to be tackled in parallel with fresh context windows that can be discarded once the task is done, or
- A single agent struggles to select appropriate tools or there are conflicting instructions in the system prompt.

But too often we see enterprises give each team or problem type its own subagent, with the agent architecture becoming a copy of their org chart (Conway’s law at work).

This post explains when to consider folding subagents into your main agent loop with best practices we’ve learned from building agents in large organizations.

## Agent building failure modes for large organizations

Companies often want to build an agent that unites multiple products and capabilities into a single customer interface.

Typically, each capability is owned by a separate team, so companies start by letting each individual team build their own agent, then a central platform team builds an orchestrator on top. This can take on several structures including orchestrator-subagent or a single agent with specific agents exposed as MCP tools.

This looks like the simplest solution but introduces immediate complexity around:

- Context management: You need to decide what context is exchanged between agents and often lose details in the back and forth.
- Subagent sprawl: Every team ships its own subagent, so companies end up with hundreds of overlapping subagents with no enforced standards and no specific owner.
- The Frankenprompt: Every team adds a sentence to the system prompt, resulting in conflicting rules and no consistent voice.
- Unvetted, overly localized evals: Everyone adds their own evals that are overly optimized for their subtask. No one owns or maintains the whole set, and leadership makes decisions based on watered-down, overly localized scores.
- Latency: Multi-agent architectural complexity adds latency. One customer that evaluated their multi-agent harness against a single agent loop saw a roughly 2x faster runtime with the latter.

## Using an agent loop with progressive disclosure

The orchestrator-subagent design described above is a reasonable approach to coordinating specialists built across teams, but often a more effective approach can be progressively disclosing context via skills and progressively disclosing tools via tool search. In other words, the agent sees short descriptions of the skills and tools, which are fully loaded only when needed.

There are three reasons why this approach can make sense:

- Shared context produces better answers: for longer-running agents, we want the context from several different tasks to sit in the main context window. An agent that has seen the result of each earlier step can connect them, which leads to richer outputs and better insights than a set of summaries handed back by subagents. It also means fewer context windows and fewer lossy handoffs.
- Progressive disclosure prevents context bloat: this technique allows teams to build single agents that can accomplish a wide variety of tasks without requiring all of the context to be immediately loaded into one long system prompt. This removes the main reason teams previously split work across subagents. In fact, we reduced Claude Code’s system prompt for more advanced models by over 80% which included cuts related to progressively disclosing skills and tools.
- Models are more capable: starting with Opus 4.5, models became capable of managing far more in a single loop than most teams expected. You cannot turn off thinking on Opus 5.5, and Fable 5.1, and recent models increasingly narrate their progress and check their work as they go, which makes some harness elements redundant. Each new model lets you move more of the decision-making out of the harness and into the model itself. A simpler loop is also easier to move to the next model; in migrations we have helped customers with, rigid multi-agent structures were often what stopped the new model from doing more of the work.

The single agent loop design requires discipline: a carefully managed system prompt, skill and tool descriptions that trigger at the right times, and deliberate handling of context windows, memory, and note-taking. This article goes deeper into migration and design considerations in subsequent sections.

One central team should own end-to-end quality and the system prompt, vetting every new tool and eval before it ships. Keeping that central team small helps iteration move quickly and lowers coordination cost across a large org.

If you go the multi-agent route, start with the simplest pattern (generator-verifier, orchestrator-subagent, or other) that could work. Decompose boundaries effectively by dividing by context: give each subagent a piece of work that needs little from the rest of the system and have it hand back a compact result (good candidates are independent research paths, separate components with clean interfaces, or black-box verification). When agents are split by problem type, they engage in a "telephone game," passing information back and forth with each handoff degrading fidelity.

## How to fold subagents into the main agent loop

Many teams already have an orchestrator and a set of specialist agents in production. The following is the single loop design we'd suggest working toward:

- One model and one context window running an open-ended tool loop, with limits (turn and cost budgets, write gates) set in the harness.
- Each turn, the model emits a batch of tool calls. The harness runs them in parallel and returns raw results to the same model, which decides the next step: another batch, a question to the user, or an answer.
- The loop stops when the model answers or hits a budget. A goal or verifier check can optionally run after the answer.
- The model writes its plan in context on the first turn and revises it as results arrive. This is the main change from the orchestrator and specialist agents setup: the model that writes the plan is also the one carrying it out, so it can change the plan mid-turn.
- Context still gets loaded, and is managed by the agent itself:

- A code step that rewrites the plan from a catalog of rules is no longer needed, since the model decides each step.
- Ordering and domain procedure move into skills.
- Hard limits (validation, approval gates) and anything else that comes up mid-conversation (e.g. memory lookup) move into the tools.
- Code can still be used to load anything cheap and almost always relevant (e.g. an entity resolution step), and to handle any mechanical parts (payload construction, stream parsing, resuming a clarification) inside tools the loop calls.

This single loop design also helps with the end state many teams are working toward (an agent that understands a user's high-level goals and acts on their behalf), since it keeps everything the agent has learned in one context.

The suggestions below are how a team could get from a multi-agent system to a single agent loop in stages, and how several teams can keep contributing to that agent along the way.

### Task-completion evals

The first step is to create an eval set that can help you determine whether you should fold a subagent into the main agent loop. The eval structure we’ve seen work is one shared end-to-end set owned by a central team with smaller eval sets shipped with each skill by the team that owns it. Even a set of 10 golden examples is enough to start.

Grading the agent's final message against a rubric is a good starting point for tracking answer quality. While you still have an orchestrator, you should also track routing accuracy (did it pick the right subagent?). Once a subagent is folded in, check instead whether the agent loaded the right skill or called the right tool. Working toward task-completion evals over time is helpful as this matters most when comparing architectures.

This can be complex in environments where internal systems are difficult to replay and user engagement is difficult to simulate. One approach that has worked for us internally is to record timestamps on important events, so they can be replayed later to run as targeted evals.

### Reducing subagents over time

Evolving toward a single agent loop involves folding the subagents into tools and skills. This can be done by merging domain subagents, calling them as tools, or replacing them with skills and tools.

### Combining domain agents

Build a small end-to-end eval before the first merge. Then fold in by shared context starting with subagents that have the most use.

Merge specialists that chain on each other's output, touch the same data, or are often called together. For example, if a significant share of production traffic is one specialist followed by a second, that is a tightly coupled pair, which makes it a candidate to merge into one domain agent.

### Subagents called as tools

When one of the three conditions above applies and you keep a subagent, it can be effective to have the main agent call subagents as tools so it can continue holding the conversation with the user.

We’d only recommend a full handoff, where the subagent takes over the conversation, when it needs to talk to the user directly. Everything else can be a skill plus tools in the main loop.

This will allow you to define a shared response schema for subagents, verify the conclusion against real data with the main agent, and trim the input to any final synthesis step. This is a good first step, as you don’t need to rewrite the subagents. It also gives you a baseline on the task-completion eval before deciding to fold any subagents into the main agent.

However, some failure modes will remain:

- Each specialist has its own prompt, context, owner team, and evals
- Each call still hands back a lossy summary
- Every call is a nested model loop that adds latency

### Folding subagents into the main agent via skills and tools

Fold subagents into the main agent one at a time by turning each one’s prompts into skills and API calls into MCP tools. Compare eval performance with and without the subagent. Then decide which to keep.

When you compare, don’t just examine the final score, take a look at which tasks flipped. When we tested this on a sample support agent, folding one subagent into another lowered latency, but also broke a process that had been passing. The main agent was holding the order lookup tool and answering on its own, without asking the shipping specialist for the delivery date.

Before each change, make sure your eval has a task for every chain of agents that runs together in production and for every rule the agent must not break, and run each task more than once, since a break like this one only showed up in one run out of two.

## How several teams can contribute to a single agent

Domain reasoning can be retrieved from knowledge bases, skills, and MCP tools. Individual teams can shift their ownership from agents to skills and tools, with one small central team keeping ownership of the system prompt and end-to-end quality. This involves vetting new skills, tools, and evals before they ship.

### MCP tools

Tools are the right fit when the agent needs to take an action, read live data from a system, or return a result in a fixed shape. You can also use tools as a way to keep calling subagents while you migrate. We recommend tools grouped by user intent (not one tool per API) because once you exceed 30-50 tool definitions in the system prompt, tool choice tends to degrade.

Use tool search with deferred loading, limit hard preconditions, and move any needed ones into the tools. For example, if Y needs X's output, Y's tool checks for it and returns an instruction the model can act on. Per-user permissions work the same way. Each tool checks what the calling user may see or do and returns a plain refusal the model can read, so one loop can serve users with different access without a separate agent per permission level.

### Skills

Skills are the right fit when the agent needs to know how a team does work, like the steps, rules, and judgment calls a specialist subagent's prompt used to hold.

Our approach to growing skill libraries is to give the maintenance work back to the people writing the skills. Claude can do the heavy lifting with skills that can build, test, and prune other skills.

To prevent skill sprawl, you can have DRIs per team own their skills and make sure they are well crafted, distinct, and shipped with appropriate evals.

- /skill-creator allows you to author new skills that start well-formed, and audit existing ones to trim, deduplicate, and restructure them.
- /skill-doctor allows you to see what each skill in your library costs and how often it’s actually used, and delete dead weight.

### Knowledge bases

Knowledge bases are the right fit for reference material the agent only needs some of the time. Facts and reference material (policies, metric definitions, product specs) can sit behind a search or lookup tool the model calls, or ship as reference files inside a skill. Avoid having code retrieve and paste this context into prompts.

## Tools to accelerate this work

We recently released a set of Claude API skills that can help with most of the work mentioned above. Our migration kit chains these skills together in one guided workflow for assessing and moving multi-agent systems to a single agent loop. It includes a demo you can try before running it on the real thing:

- /claude-api build-eval: can help create a first end-to-end set owned by the central team or small evals each team ships with its skill
- /claude-api prompt-audit: can flag instructions written for older models in your prompts, skills, and tool descriptions and propose fixes as a diff. This can be run on your system prompts to find any rules that were added for an earlier model and are now making the agent slower or more rigid. Each team's DRI can also run it on their own skills and tool descriptions.
- /claude-api hillclimb: can iteratively improve an app against an existing eval. This can be used for the "folded in vs kept" comparison (after folding one subagent into a skill plus tools, let it iterate on the skill and tool descriptions and see if the folded version matches or beats the subagent), as well as your system prompt.
- /claude-api cost-optimize: profiles where your calls go and proposes savings from options such as prompt caching, trimming unneeded input and output tokens, effort, and model choice, one change at a time. This can help bring cost and latency down on a given design.

As models evolve, our understanding of how to best use them and guidance around best practice evolve as well. That makes any one architecture less important than the principle behind it: measure, change one thing at a time, and keep what holds up.

This is one of those cases. As models get more capable and agents get longer running, more of your subagents can be skills and tools. You don’t have to make that move in one step, though. Build a small end-to-end eval, fold in one subagent, and keep it as a subagent only if the folded version scores worse, then rinse and repeat.

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleOct 19, 2026

### Redesigning source control at Anthropic

As merges to Anthropic's monorepo grew from about 2,500 to more than 30,000 a day, source control became the biggest development bottleneck. Here is how the team built Scion, an in-house version control system designed for always-online agents, and migrated off git in five months.

Claude Code

(opens in new tab)

ArticleOct 16, 2026

### How an Anthropic BDR in Japan runs his day with Claude Managed Agents

How one business development representative clears his inbound queue and drafts bilingual customer emails with Claude Managed Agents and Claude Tag.

Claude Managed Agents

ArticleOct 16, 2026

### How the Claude Code team does code review

How do you review code at the volume agents produce it? The Claude Code team shares its review process, from Claude verifying its own work to risk-tiered human approval, plus a checklist for adopting it.

Claude Code

(opens in new tab)

ArticleOct 13, 2026

### Uber's CISO on building an insider threat program for AI

Uber's CISO, Philip Martin, on the importance of monitoring and observability for AI agents, and how Uber's open-source tooling works alongside Enterprise Frontier Safeguards.
