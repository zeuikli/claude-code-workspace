---
title: "Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp"
url: https://claude.com/blog/claude-api-skill
slug: claude-api-skill
fetched: 2026-04-30 04:30 UTC
---

# Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

> Source: https://claude.com/blog/claude-api-skill




# Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

- Category

Agents

Claude Code

- Product

Claude Enterprise

Claude Code

- Date

April 29, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/claude-api-skill

Today, CodeRabbit, JetBrains, Resolve AI, and Warp are bundling the claude-api skill, giving developers production-ready Claude API code wherever they build. First introduced in Claude Code in March, the skill is now in more of the tools developers already use.

## Building with the Claude API skill

The `claude-api `skill captures the details that make Claude API code work well, like which agent pattern fits a given job, what parameters change between model generations, and when to apply prompt caching. The result is fewer errors, better caching, cleaner agent patterns, and smoother model migrations. 

It stays current as our SDKs change. When a new model is released or the API gains a feature, Claude already knows.

Anywhere the skill is available, ask Claude to:

- "Improve my cache hit rate." The skill applies prompt caching rules many developers miss.
- "Add context compaction to my agent." It walks you through the compaction primitives and agent patterns in our docs.
- "Upgrade me to the latest Claude model." Claude reviews your code and walks you through updating model names, prompts, and effort settings for a new model like Opus 4.7. In Claude Code, you can also run this directly with `/claude-api migrate.`‍
- "Build a deep research agent for my industry." Claude walks you through configuring Claude Managed Agents, so long-running research is a few prompts, not a custom project. In Claude Code, you can also run this directly with `/claude-api managed-agents-onboard`.

"At CodeRabbit, we review millions of PRs a week and see how often stale API knowledge causes production issues. The Claude API skill keeps Claude current as our SDKs change, so developers building agents run into fewer review-time surprises."

Erik Thorelli, Developer Experience Lead

"With the Claude API skill, developers on JetBrains IDEs and Junie can turn a Claude API upgrade into a guided IDE workflow. A good example is migrating to Claude Opus 4.7, where the skill can update model references, move manual thinking settings to adaptive thinking, clean up outdated parameters and beta headers, and suggest the right effort level inline. That gives teams a stronger first pass and helps avoid version-specific mistakes that normally show up in cleanup rounds."

Denis Shiryaev, Head of AI Dev Tools Ecosystem

“The Claude API skill helps Resolve AI engineers adopt new model capabilities faster. Instead of manually parsing migration guides and chasing every small API change, our team can move from model release to implementation in a single guided pass."

Mayank Agarwal, Founder & CTO

"Developers shouldn't have to leave Warp to look up Claude API parameters or caching rules. With the Claude API skill built in, that knowledge is already there, so engineers stay in flow and ship faster."

Zach Lloyd, Founder and CEO

PrevPrev

0/5

NextNext

eBook

##

## For Claude-powered coding agents

Any coding agent can bundle the `claude-api `skill to give their users expertise around the Claude API. If you are building a tool where developers write Claude API code, the skill is open source at anthropics/skills. Our bundling guide walks through the setup in about 20 lines of CI, and the skill stays current automatically.

## Getting started

The skill is already in Claude Code, CodeRabbit, JetBrains, Junie, Resolve AI, and Warp. To learn more, see the claude-api skill docs.

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Oct 31, 2025

### What is Model Context Protocol? Connect AI to your world

Agents

What is Model Context Protocol? Connect AI to your worldWhat is Model Context Protocol? Connect AI to your world

What is Model Context Protocol? Connect AI to your worldWhat is Model Context Protocol? Connect AI to your world

Apr 29, 2026

### Product development in the agentic era

Agents

Product development in the agentic eraProduct development in the agentic era

Product development in the agentic eraProduct development in the agentic era

Apr 28, 2026

### Onboarding Claude Code like a new developer: Lessons from 17 years of development

Claude Code

Onboarding Claude Code like a new developer: Lessons from 17 years of developmentOnboarding Claude Code like a new developer: Lessons from 17 years of development

Onboarding Claude Code like a new developer: Lessons from 17 years of developmentOnboarding Claude Code like a new developer: Lessons from 17 years of development

Apr 22, 2026

### Building agents that reach production systems with MCP

Agents

Building agents that reach production systems with MCPBuilding agents that reach production systems with MCP

Building agents that reach production systems with MCPBuilding agents that reach production systems with MCP

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
