---
title: "Product development in the agentic era"
url: https://claude.com/blog/product-development-in-the-agentic-era
slug: product-development-in-the-agentic-era
fetched: 2026-04-30 04:30 UTC
---

# Product development in the agentic era

> Source: https://claude.com/blog/product-development-in-the-agentic-era




# Product development in the agentic era

Jess Yan, Claude Managed Agents product manager, shares how she uses the product to unblock herself and free up time to hone her craft.

- Category

Agents

- Product

Claude Platform

- Date

April 29, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/product-development-in-the-agentic-era

One of the ironies of being a product manager in the age of AI is that my work feels more human than ever.

The job of product management has always been a mix of craft and alignment. For most of my career, my week was occupied by the latter: meetings with cross-functional stakeholders and teammates, status reports, and ticket backlogs with my engineering team. I got used to making instinctive, quick decisions followed by uphill battles advocating, convincing, and resourcing; shipping impactful products often felt more transactional than generative. 

With Claude, I can pressure test ideas, automate workflows, and get unstuck. I'm finally spending real time with our users and my team on the part of the job that always mattered most: the craft. While these new workflows changed my day-to-day, the most meaningful shifts happened when we started developing Claude Managed Agents (currently in beta), a suite of composable APIs for building and deploying cloud-hosted agents at scale.

In this post, I'll share how Managed Agents has changed the way I work as a product manager, and a few patterns you can borrow for your own workflows.

## Product development, then and now

API design used to live in documents and comment threads; on the AI exponential, we build with what we ship. A spec that reads elegantly in a doc can fall apart the first time you try to build against it. With Claude Code, I can sketch out an agent against pre-production versions of our API specs, and within an afternoon be running a real prototype end-to-end. 

We reshaped API abstractions and Claude Console UX several times based on what we learned building with our own primitives–changes that even a multi-week doc review would never have surfaced, and otherwise would've come up too late via user feedback. We still litigate shapes and run raw curl requests to make sure we're happy with the bare-metal experience, but Claude Code gets me from the basic "hello world" test to a functional agent in the same sitting. As I build these agents, I'm able to more concretely anticipate ways our harness and API can flex for the next wave of model and task evolution.

Initially, these prototypes were just for shaping the product, but they now are evolving my day-to-day work as well. My workflow as a PM now splits cleanly across our products. I use Claude and Claude Cowork for open-ended research and discovery–the murky, early-stage exploration where I want an ongoing conversation. Once I have greater clarity on the job to be done, I use Claude Code to write and ship a custom agent for it, built atop of Managed Agents. 

The two-pronged payoff has been the biggest unlock. On one side, being able to build against my own product easily raises the ceiling on what I can imagine shipping next. On the other, once the product is live, the same development muscle lets me automate the long tail of operational work that used to stall in my backlog.

## Managed Agents use cases for product managers

Now I spin up bespoke agents for any "job to be done." Building one is simple: I load the Managed Agents skill in Claude Code and outline a quick sketch of what I'm looking for. Developers can also use the latest version of Claude Code and built-in `claude-api skill` to build with Managed Agents–just prompt Claude with “start onboarding for managed agents in Claude API” to get started. After invoking this skill, Claude builds the agent, explaining its integration steps along the way, so I can easily shift direction as needed. 

Examples of these agents include:

- Adoption analytics. An agent with persistent access to our internal databases and skills for understanding our data schemas runs queries to surface interesting outliers and patterns. With memory of prior runs, it can build on prior findings and continuously advance its perspective.
- Developer sentiment monitoring. An agent with the pre-built web search tool and guidance on focus areas scans a specific list of domains for the latest developer feedback, reporting back on common themes. Since there is so much content to analyze, it fans out research to multiple agents in parallel, waits for results, and synthesizes findings. 
- Demo building. An agent with access to demo GitHub repos, branding assets, and an event deck turns prebuilt templates into a polished demo tailored to the relevant audience, such as a conference or customer meeting.

Managed Agents sessions run in the cloud, so I can walk away and come back to find the work done. Processes that could never scale because every launch has its own quirks are now easy to automate using Managed Agents, and every agent run feels energizing instead of tedious.

## Freeing up space to hone my craft

A year ago, all of this kind of work would've crawled along in cross-functional staffing requests, chaotic spreadsheets, or half-baked concepts I just never got to try out. Now, with Claude and Managed Agents, I can scale myself, using my time to partner with my team on developing the most impactful products. My day now spans generating innovative ideas with customers, digging into murky and ambiguous problems with my engineering counterparts, and investing real creative energy in frontier product work.

If you're a product manager and you haven't built an agent yet, that's where I'd start this week. The experiments and tools you've always wished existed are a single prompt and a few API calls away.

Learn more in our docs. 

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

Apr 29, 2026

### Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

Agents

Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and WarpClaude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and WarpClaude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

Oct 31, 2025

### What is Model Context Protocol? Connect AI to your world

Agents

What is Model Context Protocol? Connect AI to your worldWhat is Model Context Protocol? Connect AI to your world

What is Model Context Protocol? Connect AI to your worldWhat is Model Context Protocol? Connect AI to your world

Apr 22, 2026

### Building agents that reach production systems with MCP

Agents

Building agents that reach production systems with MCPBuilding agents that reach production systems with MCP

Building agents that reach production systems with MCPBuilding agents that reach production systems with MCP

Apr 10, 2026

### Multi-agent coordination patterns: Five approaches and when to use them

Agents

Multi-agent coordination patterns: Five approaches and when to use themMulti-agent coordination patterns: Five approaches and when to use them

Multi-agent coordination patterns: Five approaches and when to use themMulti-agent coordination patterns: Five approaches and when to use them

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
