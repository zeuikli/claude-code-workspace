---
title: "Introducing dynamic workflows"
url: https://claude.com/blog/introducing-dynamic-workflows-in-claude-code
slug: introducing-dynamic-workflows-in-claude-code
fetched: 2026-05-29 05:11 UTC
---

# Introducing dynamic workflows

> Source: https://claude.com/blog/introducing-dynamic-workflows-in-claude-code




# Introducing dynamic workflows in Claude Code

- Category

Product announcements

- Product

Claude Code

- Date

May 28, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/introducing-dynamic-workflows-in-claude-code

Today we're introducing dynamic workflows in Claude Code, helping Claude take on the most challenging tasks end-to-end. Work you'd normally plan in quarters now finishes in days. Claude dynamically writes orchestration scripts that run tens to hundreds of parallel subagents in a single session, checking its work before anything reaches you.

Some problems are too big for one pass by a single agent, especially in complex, legacy codebases: a bug hunt across an entire service, a migration that touches hundreds of files, a plan you want stress-tested from every angle before you commit to it. Dynamic workflows can handle all of these end-to-end.

Dynamic workflows are available today in research preview in the Claude Code CLI, Desktop, and the VS code extension for Max, Team, and Enterprise (if admin enabled) plans, as well as on the Claude API, on Amazon Bedrock, Vertex AI, and Microsoft Foundry.

Note: Dynamic workflows can consume substantially more tokens than a typical Claude Code session, so we recommend starting on a scoped task to get a feel for usage in your work. 

For the best experience, turn on auto mode when using dynamic workflows. From there, you have two ways to start a workflow:

- Ask Claude to create a dynamic workflow directly (e.g.,  “Create a workflow”), or
- Switch on a new Claude Code-specific setting called `ultracode`. This is accessible through the effort menu and it sets the effort level to xhigh, while letting Claude decide automatically when to use a workflow to handle your task.

## Dynamic workflows in action

Early access users and teams inside Anthropic have been using dynamic workflows for a wide range of use cases, including:

- Codebase-wide bug hunts, profiler-guided optimization audits, and security audits: Claude searches a service or repo in parallel, then runs independent verification on every finding so the report surfaces real issues. The same shape works for hardening passes:  auth checks, input validation, and unsafe patterns across an entire codebase.
- Large migrations and modernization efforts: Claude can handle framework swaps, API deprecations, language ports that span thousands of files end-to-end.‍
- Critical work you need checked twice: When the cost of a wrong answer is high, a workflow gives Claude independent attempts at the problem and adversarial agents working to break the result before you see it.

“Dynamic workflows have been especially valuable for discovery and review tasks across large codebases. We’ve seen strong results using it to identify dead code and surface cleanup opportunities that traditional static analysis missed, helping our engineers move faster on maintenance and refactoring work.”

Alessio Vallero, Senior Engineering Manager

“Dynamic workflows fill the gap between firing off a single subagent and building out a full agent team. Plan to implementation just flows, so we can trust longer runs without losing visibility.”

Ken Takao, Lead Systems Engineer

PrevPrev

0/5

NextNext

eBook

##

### Rewriting Bun with dynamic workflows

An example of what dynamic workflows can unlock at scale is the recent rewrite of Bun. Jarred Sumner used dynamic workflows to port Bun from Zig to Rust with 99.8% of the existing test suite passing, roughly 750,000 lines of Rust, and eleven days from first commit to merge. One workflow mapped the right Rust lifetime for every struct field in the Zig codebase. The next wrote every .rs file as a behavior-identical port of its .zig counterpart, hundreds of agents working in parallel with two reviewers on each file. A fix loop then drove the build and test suite until both ran clean. After the port landed, an overnight workflow addressed unnecessary data copies and opened a PR for each for final review. While not yet in production, all of this was handled by dynamic workflows. Jarred will be writing about this more in the future.

## How it works

When a workflow kicks off, Claude plans dynamically based on your prompt, breaks it into subtasks, and fans the work out across subagents running in parallel. Results are checked before they're folded in, and you come back to a single, coordinated answer. Agents address the problem from independent angles, other agents try to refute what they found, and the run keeps iterating until the answers converge—which is how a workflow reaches results a single pass can't.

Dynamic workflows are built for parallel and long-running work that can extend into hours and days, doing the most complex engineering work that previously would have taken weeks. Progress is saved as the run goes, so a job that's interrupted picks up where it left off instead of starting over. Because the coordination happens outside the conversation, the plan stays on track no matter how big the task gets.

It’s important to note that dynamic workflows consume meaningfully more usage than a typical Claude Code session. The first time a workflow triggers, Claude Code shows what's about to run and asks you to confirm. Organization admins can also optionally disable workflows through managed settings.

## Getting started

If you're on a Max or Team plan, or using Claude Code via the API, dynamic workflows are on by default. Ask Claude to create a workflow or turn on the Claude Code-specific setting `ultracode` to get started. If you’re on an Enterprise plan, dynamic workflows are off by default at launch. Your admin can easily change this in the Claude Code settings.

Read the documentation to learn more.

FAQ

No items found.

Get Claude Code

curl -fsSL https://claude.ai/install.sh | bash

Copy command to clipboard

irm https://claude.ai/install.ps1 | iex

Copy command to clipboard

Or read the documentation

Try Claude Code

Try Claude CodeTry Claude Code

Developer docs

Developer docsDeveloper docs

## Related posts

Explore more product news and best practices for teams building with Claude.

May 26, 2026

### Code w/ Claude London 2026: Rethinking how we build

Product announcements

Code w/ Claude London 2026: Rethinking how we buildCode w/ Claude London 2026: Rethinking how we build

Code w/ Claude London 2026: Rethinking how we buildCode w/ Claude London 2026: Rethinking how we build

May 19, 2026

### New in Claude Managed Agents: self-hosted sandboxes and MCP tunnels

Product announcements

New in Claude Managed Agents: self-hosted sandboxes and MCP tunnelsNew in Claude Managed Agents: self-hosted sandboxes and MCP tunnels

New in Claude Managed Agents: self-hosted sandboxes and MCP tunnelsNew in Claude Managed Agents: self-hosted sandboxes and MCP tunnels

May 12, 2026

### Code w/ Claude SF 2026 recap: Building on the AI exponential

Product announcements

Code w/ Claude SF 2026 recap: Building on the AI exponential Code w/ Claude SF 2026 recap: Building on the AI exponential

Code w/ Claude SF 2026 recap: Building on the AI exponential Code w/ Claude SF 2026 recap: Building on the AI exponential

May 12, 2026

### Claude for the legal industry

Product announcements

Claude for the legal industryClaude for the legal industry

Claude for the legal industryClaude for the legal industry

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
