---
title: "The advisor strategy: Give Sonnet an intelligence boost with Opus"
url: https://claude.com/blog/the-advisor-strategy
slug: the-advisor-strategy
fetched: 2026-04-17 15:43 UTC
---

# The advisor strategy: Give Sonnet an intelligence boost with Opus

> Source: https://claude.com/blog/the-advisor-strategy




# The advisor strategy: Give agents an intelligence boost

Pair Opus as an advisor with Sonnet or Haiku as an executor, and get near Opus-level intelligence in your agents at a fraction of the cost.

- Category

Product announcements

- Product

Claude Platform

- Date

April 9, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/the-advisor-strategy

Developers who want to better balance intelligence and cost have converged on what we call the advisor strategy: pair Opus as an advisor with Sonnet or Haiku as an executor. This brings near Opus-level intelligence to your agents while keeping costs near Sonnet levels.

Today we're introducing the advisor tool on the Claude Platform to make the advisor strategy a one-line change in your API call.

## Build cost-effective agents with the advisor strategy 

With the advisor strategy, Sonnet or Haiku runs the task end-to-end as the executor, calling tools, reading results, and iterating toward a solution. When the executor hits a decision it can't reasonably solve, it consults Opus for guidance as the advisor. Opus accesses the shared context and returns a plan, a correction, or a stop signal, and the executor resumes. The advisor never calls tools or produces user-facing output, and only provides guidance to the executor.

This inverts a common sub-agent pattern, where a larger orchestrator model decomposes work and delegates to smaller worker models. In the advisor strategy, a smaller, more cost-effective model drives and escalates without decomposition, a worker pool, or orchestration logic. Frontier-level reasoning applies only when the executor needs it, and the rest of the run stays at executor-level cost.

In our evaluations, Sonnet with Opus as an advisor showed a 2.7 percentage point increase on SWE-bench Multilingual1 over Sonnet alone, while reducing cost per agentic task by 11.9%.

## The advisor tool 

We’re bringing the advisor strategy to our API with the advisor tool, a server-side tool which Sonnet and Haiku know to invoke when they need guidance or help with a specific task.

In our evaluations, Sonnet with an Opus advisor improved scores across BrowseComp2 and Terminal-Bench 2.03 benchmarks while costing less per task than Sonnet alone.

The advisor strategy also works with Haiku as the executor. On BrowseComp, Haiku with an Opus advisor scored 41.2%, more than double its solo score of 19.7%. Haiku with an Opus advisor trails Sonnet solo by 29% in score but costs 85% less per task. The advisor adds cost relative to Haiku alone, but the combined price is still a fraction of what Sonnet costs, making it a strong option for high-volume tasks that require a balance of intelligence and cost.

Declare advisor_20260301 in your Messages API request, and the model handoff happens inside a single /v1/messages request—no extra round-trips or context management. The executor model decides when to invoke it. When it does, we route the curated context to the advisor model, return the plan, and the executor continues all within the same request.

```
`response = client.messages.create(
    model="claude-sonnet-4-6",  # executor
    tools=[
        {
            "type": "advisor_20260301",
            "name": "advisor",
            "model": "claude-opus-4-6",
            "max_uses": 3,
        },
        # ... your other tools
    ],
    messages=[...]
)

# Advisor tokens reported separately
# in the usage block.`
```

Pricing. Advisor tokens are billed at the advisor model's rates; executor tokens are billed at the executor model's rates. Since the advisor only generates a short plan (typically 400-700 text tokens) while the executor handles the full output at its lower rate, the overall cost stays well below running the advisor model end-to-end.

Built-in cost controls. Set max_uses to cap advisor calls per request. Advisor tokens are reported separately in the usage block so you can track spend per tier.

Works alongside your existing tools. The advisor tool is just another entry in your Messages API request. Your agent can search the web, execute code, and consult Opus in the same loop.

“It makes better architectural decisions on complex tasks while adding no overhead on simple ones. The plans and trajectories are night and day different.”

Eric Simmons, CEO and Founder, Bolt

“We saw clear improvements in agent turns, tool calls, and overall score — better than a planning tool we built ourselves.”

Kay Zhu, Cofounder & CTO, Genspark

“On structured document extraction tasks, the advisor tool enables Haiku 4.5 to dynamically scale intelligence by consulting Opus 4.6 as complexity demands, matching frontier-model quality at 5× lower cost.”

Anuraj Pandey, Machine Learning Engineer, Eve Legal

PrevPrev

0/5

NextNext

eBook

##

## Get started

The advisor tool is available now in beta natively on the Claude Platform. To get started:

- Add the beta feature header: anthropic-beta: advisor-tool-2026-03-01
- Add the advisor_20260301 to your Messages API request
- Modify your system prompt based on your use case

We recommend running your existing eval suite against Sonnet solo, Sonnet executor with Opus advisor, and Opus solo. Explore the docs to learn more.

## Footnotes

- SWE-bench Multilingual: Sonnet 4.6 solo used adaptive thinking. Sonnet 4.6 + Advisor used our suggested system prompt for coding with thinking turned off. Both runs used high effort with bash and file editing tools. Scores are averaged over five trials of 300 problems across nine languages. Opus 4.6 was used as the advisor model in all runs.
- BrowseComp: All runs used thinking turned off with web search and web fetch tools. Sonnet 4.6 runs used medium effort. Sonnet 4.6 + Advisor used our suggested system prompt for coding; Haiku 4.5 + Advisor did not. No programmatic tool calling or context compaction. Scores are based on 1,266 problems with one attempt per problem. Opus 4.6 was used as the advisor model in all runs.‍
- Terminal-Bench 2.0: All runs used thinking turned off with bash and file editing tools. Sonnet 4.6 runs used medium effort. Neither advisor run used our suggested system prompt for coding. Each task ran in an isolated pod with 3x resource allocation and a 1x timeout. Scores are averaged over five attempts per task across 89 tasks. Opus 4.6 was used as the advisor model in all runs.

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Apr 14, 2026

### Redesigning Claude Code on desktop for parallel agents

Claude Code

Redesigning Claude Code on desktop for parallel agentsRedesigning Claude Code on desktop for parallel agents

Redesigning Claude Code on desktop for parallel agentsRedesigning Claude Code on desktop for parallel agents

Apr 14, 2026

### Introducing routines in Claude Code

Product announcements

Introducing routines in Claude CodeIntroducing routines in Claude Code

Introducing routines in Claude CodeIntroducing routines in Claude Code

Jun 25, 2025

### Turn ideas into interactive AI-powered apps

Product announcements

Turn ideas into interactive AI-powered appsTurn ideas into interactive AI-powered apps

Turn ideas into interactive AI-powered appsTurn ideas into interactive AI-powered apps

Apr 9, 2026

### Making Claude Cowork ready for enterprise

Product announcements

Making Claude Cowork ready for enterpriseMaking Claude Cowork ready for enterprise

Making Claude Cowork ready for enterpriseMaking Claude Cowork ready for enterprise

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
