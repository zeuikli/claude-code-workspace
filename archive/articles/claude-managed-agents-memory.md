---
title: "Built-in memory for Claude Managed Agents"
url: https://claude.com/blog/claude-managed-agents-memory
slug: claude-managed-agents-memory
fetched: 2026-04-24 04:16 UTC
---

# Built-in memory for Claude Managed Agents

> Source: https://claude.com/blog/claude-managed-agents-memory




# Built-in memory for Claude Managed Agents

- Category

Product announcements

- Product

Claude Platform

- Date

April 23, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/claude-managed-agents-memory

Memory on Claude Managed Agents is available today in public beta. Your agents can now learn from every session, using an intelligence-optimized memory layer that balances performance with flexibility. Because memories are stored as files, developers can export them, manage them via the API, and keep full control over what agents retain.

## Agents that learn across sessions

Managed Agents pairs production infrastructure with a harness tuned for performance. Memory extends that: it’s optimized against internal benchmarks for long-running agents that improve across sessions and share what they've learned with each other.

We've found that agents are most effective with memory when it builds on the tools they already use. Memory on Managed Agents mounts directly onto a filesystem, so Claude can rely on the same bash and code execution capabilities that make it effective at agentic tasks. With filesystem-based memory, our latest models save more comprehensive, well-organized memories and are more discerning about what to remember for a given task.

## Portable memories for production-grade agents 

Memory is built for enterprise deployments, with scoped permissions, audit logs, and full programmatic control. Stores can be shared across multiple agents with different access scopes. For example, an org-wide store might be read-only, while per-user stores allow reads and writes. Multiple agents can work concurrently against the same store without overwriting each other.

Memories are files that can be exported and independently managed via the API, giving developers full control. All changes are tracked with a detailed audit log, so you can tell which agent and session a memory came from. You can roll back to an earlier version or redact content from history. Updates also surface in the Claude Console as session events, so developers can trace what an agent learned and where it came from.

## What teams are building

Teams have been using memory to close feedback loops, speed up verification, and replace custom retrieval infrastructure:

- Netflix agents carry context across sessions, including insights that took multiple turns to uncover and corrections from a human mid-conversation, instead of manually updating prompts and skills.
- Rakuten's task-based long-running agents use memory to learn from every session and avoid repeating past mistakes, cutting first-pass errors by 97%, all within workspace-scoped, observable boundaries.
- Wisedocs built their document verification pipeline on Managed Agents, using cross-session memory to spot and remember recurring document issues, speeding up verification by 30%.‍
- Ando is building their workplace messaging platform on Managed Agents, capturing how each organization interacts instead of building memory infrastructure themselves.

Memory in Claude Managed Agents lets us put continuous learning into production at scale. Our agents distill lessons from every session, delivering 97% fewer first-pass errors at 27% lower cost and 34% lower latency, so users spend less time nudging agents to fix mistakes the system has already learned to avoid. And because memory is workspace-scoped and observable, continuous learning stays under our control.

Yusuke Kaji, General Manager, AI for Business

A lot of our work at Ando is making sense of fast-moving, messy conversations between teams and their agents. Memory lets us stop building memory infra and focus on the product itself.

Sara Du, Founder

A good memory API gets rid of many infrastructure headaches, especially when building across agents and sessions. In our document verification pipeline on Claude Managed Agents, we used cross-session memory to let our agents identify and remember common issues — including ones we didn't think about. It's sped verification up 30%.

Denys Linkov, Head of Machine Learning

PrevPrev

0/5

NextNext

eBook

##

## Getting started

Memory on Managed Agents is now available in public beta on the Claude Platform. Visit the Claude Console or use our new CLI to deploy your first agent with memory. Explore the documentation to learn more.

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Sep 11, 2025

### Bringing memory to Claude

Product announcements

Bringing memory to ClaudeBringing memory to Claude

Bringing memory to ClaudeBringing memory to Claude

Apr 23, 2026

### New connectors in Claude for everyday life

Product announcements

New connectors in Claude for everyday lifeNew connectors in Claude for everyday life

New connectors in Claude for everyday lifeNew connectors in Claude for everyday life

Mar 12, 2026

### Claude now creates interactive charts, diagrams and visualizations

Product announcements

Claude now creates interactive charts, diagrams and visualizationsClaude now creates interactive charts, diagrams and visualizations

Claude now creates interactive charts, diagrams and visualizationsClaude now creates interactive charts, diagrams and visualizations

Apr 14, 2026

### Redesigning Claude Code on desktop for parallel agents

Claude Code

Redesigning Claude Code on desktop for parallel agentsRedesigning Claude Code on desktop for parallel agents

Redesigning Claude Code on desktop for parallel agentsRedesigning Claude Code on desktop for parallel agents

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
