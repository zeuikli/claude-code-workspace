---
title: "Working at the frontier: How Balyasny Asset Management evaluates and governs Claude Fable 5 | Claude by Anthropic"
url: https://claude.com/blog/working-at-the-frontier-how-balyasny-asset-management-evaluates-and-governs-claude-fable-5
slug: working-at-the-frontier-how-balyasny-asset-management-evaluates-and-governs-claude-fable-5
fetched: 2026-09-18 05:31 UTC
---

# Working at the frontier: How Balyasny Asset Management evaluates and governs Claude Fable 5 | Claude by Anthropic

> Source: https://claude.com/blog/working-at-the-frontier-how-balyasny-asset-management-evaluates-and-governs-claude-fable-5




# Working at the frontier: How Balyasny Asset Management evaluates and governs Claude Fable 5

Balyasny Asset Management (BAM) Chief AI Officer Charlie Flanagan on why the firm uses Claude Fable 5 and the role of safeguards in deploying frontier intelligence safely and reliably across the organization.

‍

- Category

Enterprise AI

- Product

Claude Platform

Claude Code

- Date

September 17, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/working-at-the-frontier-how-balyasny-asset-management-evaluates-and-governs-claude-fable-5

Balyasny Asset Management (BAM) is a global, multi-strategy investment firm that manages roughly $38 billion in assets and supports a team of roughly 2,000 investment professionals and staff. Charlie Flanagan, Chief AI Officer, spoke with Anthropic about how the firm evaluates new models on thousands of real financial tasks, why it built its own platform for running agents, and what changed with the launch of Claude Fable 5.

## How has frontier AI changed for BAM in 2026?

2026 is the year we moved from AI systems that do search to AI systems that do work.

The key change has been not just the models, but the harnesses around them, such as Claude Code. They allow the AI solutions we build to take on vastly more complex and longer-running tasks. The ability to give an AI an outcome rather than a prompt, and have it keep working until complete, has been a gamechanger.

A practical example is merger-arbitrage analysis. When a deal is announced, agents now build the initial deal-analysis package. They estimate how likely the deal is to close and how long it will take, extract the key economic and legal terms, identify conditions and milestones, and flag the areas that need investor judgment.

A year ago, those steps were fragmented across manual research and separate tools; we did not have an agent that could reliably sustain the full multi-step workflow to a usable conclusion. That work used to take three to five days. Now it takes less than one. The agent runs for approximately 30 minutes, with human review before any material output is relied on.

We use Anthropic's frontier models, but most of the infrastructure is built in-house at BAM, including the execution harness, data access, and review controls.

## How did you evaluate Claude Fable 5 before turning it on?

One thing we did years ago which has served us extremely well was invest in robust evaluation systems. We test new models on thousands of real-world financial tasks with verifiable outcomes, across equities, macro, and commodities, rather than relying on general benchmarks or isolated demonstrations. It has allowed us to make data-driven decisions around model choice and routing, and is something I think all enterprises should invest in.

We test both the model on its own and how it performs inside our agentic environment, with the same tools, files, and requirements our users have. Can it plan the work, choose and use the right tools, find and analyze evidence, recover from errors, check its intermediate results, and produce a grounded deliverable? We also look for specific failure modes, like numerical errors, missed coverage, unsupported conclusions, and retrieval problems.

On the relevant subset, Fable achieved 89.4% versus 86.1% for the prior production model, across thousands of tasks. Where it stood out most was complex planning, analysis, and agentic execution.

The surprising result was a set of economics problems we have tested that we have never had a model complete successfully, until Fable. We initially treated the result as a potential evaluation issue because it represented a material step change versus every model we had tested. We reran the evaluation, independently checked the task and scoring logic, and reviewed the result with Anthropic before concluding that the improvement was real. It was a wow moment.

Today, our investment teams use Fable as their go-to frontier model for systematic and coding work. We give them guidance on when to use Fable versus other models, based on efficiency and cost.

## How are you thinking about safety with today's frontier models?

We treat safety as a product and operating-model question, not as a one-time model-selection exercise. The relevant questions are not only what the model can do, but what data it can access, what tools it can use, what actions it can take, what must remain human-approved, and how we will know when something has gone wrong.

That means putting controls around the model rather than assuming the model itself is the control. We use approved data boundaries, least-privilege access, tool-level permissions, logging and traceability, human review for material outputs, and clear escalation paths for edge cases. We also test adversarial and failure scenarios before broadening access.

Those controls were a day-one priority, and security did not fundamentally change with Fable. A more capable model does not receive broader authority simply because it can reason or plan more effectively. Models can use only the tools and data sources approved for that user and task, and they cannot grant themselves more access. Investment judgment and accountability remain with people.

## Where does BAMAgent fit in?

Looking ahead, the direction of travel is toward more capable agents that can take longer-running, multi-step actions. That makes governance more important, not less. For us, that has meant building BAMAgent, our internal platform for securely deploying agents into approved enterprise workflows. It gives agents the tools and systems they need, but only those tools and systems. We have been building it for six months now and it supports thousands of autonomous agents working 24/7.

BAMAgent is the next step beyond our chat platform. Chat helps people take in and synthesize information. BAMAgent does the work: multi-step research and analysis that can run for hours or days, with agents working in parallel, and it ends in something a person can review. It can build and maintain a company research package, prepare for an earnings or macro event, or turn new evidence into financial scenarios. The agent plans the work, uses approved internal systems, runs the analysis, checks its intermediate outputs, and returns a research artifact, model, or decision-support package.

Fable is our preferred model for the planning and analysis stages. A mistake there flows through every deliverable that follows, so we want the strongest available model deciding how to break down a problem, which evidence matters, and how to reconcile conflicting signals. That is what lets the agent work like a capable coworker.

Every enterprise should be developing a strategy to move toward a hosted-agent model that allows enterprise management and enforcement while maximizing the utility of agents for users.

## What has Claude Fable 5 made possible for BAM?

The reaction has been incredibly positive. Ultimately, people care about what this technology can unlock in their day-to-day work.

In one example, a BAMAgent ran a tax-loss harvesting analysis. It explored 90,000 database tables, found the relevant mutual fund holdings data, and built its own weighting system. After a review by our team, the result was more comprehensive than what a traditional approach would have produced.

Separately, our Chief Economist has configured an agent workflow that reduces a recurring central-bank analysis from roughly two days to approximately 30 minutes, with the economist retaining review and judgment.

Fable contributes the reasoning, synthesis, and multi-step problem-solving. BAM's harness provides the workflow design, approved data and tool access, retrieval context, permissions, monitoring, and human-review controls. Both are necessary for a production-quality result.

## As models become increasingly powerful, what's next on your AI roadmap?

This is the year we go from people having tools to having teammates. Much like a teammate, agents will become more useful over time as you work with them, complete more complex tasks, and start to do work proactively to help.

We already have some teams running over 300 agents doing analysis over new data and information constantly. It helps the teams both be faster to insights and not miss anything.

It also changes the question we ask. We used to build expert systems and teach people to automate the processes they already had. Now we ask whether there is a better way to reach the outcome.

The limits are really just our own imagination. The tools, data, and models are now at a point where they can do real work for hours on end; it's up to us to continue to reimagine what is possible. It is going to be an incredibly exciting next 12 months.

Get started with Claude Fable.

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

Jul 24, 2026

### How the product designer who built Claude Design uses it to explore ideas before building them

Enterprise AI

How the product designer who built Claude Design uses it to explore ideas before building themHow the product designer who built Claude Design uses it to explore ideas before building them

How the product designer who built Claude Design uses it to explore ideas before building themHow the product designer who built Claude Design uses it to explore ideas before building them

Aug 7, 2026

### How Anthropic's business development team uses Claude to run inbound and outbound at scale

Enterprise AI

How Anthropic's business development team uses Claude to run inbound and outbound at scaleHow Anthropic's business development team uses Claude to run inbound and outbound at scale

How Anthropic's business development team uses Claude to run inbound and outbound at scaleHow Anthropic's business development team uses Claude to run inbound and outbound at scale

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

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
