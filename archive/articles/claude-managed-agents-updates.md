---
title: "New in Claude Managed Agents: self-hosted sandboxes and MCP tunnels"
url: https://claude.com/blog/claude-managed-agents-updates
slug: claude-managed-agents-updates
fetched: 2026-05-20 05:01 UTC
---

# New in Claude Managed Agents: self-hosted sandboxes and MCP tunnels

> Source: https://claude.com/blog/claude-managed-agents-updates




# New in Claude Managed Agents: self-hosted sandboxes and MCP tunnels

- Category

Product announcements

- Product

Claude Platform

- Date

May 19, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/claude-managed-agents-updates

Starting today, Claude Managed Agents can operate in a sandbox you control and connect to your private Model Context Protocol (MCP) servers. Both the sandbox where an agent executes tools and the services it reaches run within the established boundaries of your enterprise, under your security and runtime controls.

The sandbox runs on your own infrastructure, or with managed providers like Cloudflare, Daytona, Modal, or Vercel to handle the compute and isolation for you.

On the Claude Platform, self-hosted sandboxes is available in public beta and MCP tunnels in research preview (request access).

## Keep agent execution within your perimeter

With self-hosted sandboxes, you keep sensitive files, packages, and services in your own infrastructure or with a managed sandbox provider. The agent loop that handles orchestration, context management, and error recovery stays on Anthropic’s infrastructure, while tool execution moves to your own configured environment.

Inside your perimeter, network policies, audit logging, and security tooling are already in place, and files and repositories don't leave. You also control the compute: resource sizing and the runtime image are set on your side, so agents running compute-heavy work such as long builds or image generation get the CPU, memory, and capacity the task needs.

## Choose your sandbox client

Bring any sandbox client you want, or start with one of our supported providers:

- Cloudflare runs sandboxes at scale using microVMs and lighter weight isolates. Outbound network requests are in your control with zero-trust secrets injection, customizable proxies to audit, reroute, or modify egress, and the ability to connect to internal services over Cloudflare's network. Amplitude is building Design Agent, an internal tool for on-brand production UI and marketing design, on Managed Agents and Cloudflare for tighter observability and control.
- Daytona sandboxes are full composable computers, long-running and stateful. The same primitive runs a quick burst or an agent that works for hours. The sandbox stays accessible while a session runs over SSH or an authenticated preview URL, or can be paused and restored with full state preserved. Clay’s GTM engineering agent, Sculptor, builds, tests, and monitors workflows autonomously on Managed Agents and Daytona.
- Modal is a cloud platform built for AI workloads, where sandboxes share the same foundation as Modal's functions, storage, and networking primitives, giving you everything you need to build production AI systems. Modal's custom container runtime delivers sub-second startup on any image, scales to hundreds of thousands of concurrent sandboxes, and gives you CPU and GPU resources on demand.
- Vercel sandboxes combine VM security, VPC peering, and bring your own cloud with millisecond startup time. Managed Agents handles the model, tools, and session state, while the Vercel Sandbox firewall injects credentials at the network boundary so they never enter the sandbox. Rogo, an AI platform for institutional finance, is building an analyst agent on Managed Agents and Vercel Sandbox to handle their proprietary data securely.

## Connect to services within your private network

With MCP tunnels, your agents reach MCP servers inside your private network without exposing them to the public internet. Internal databases, private APIs, knowledge bases, and ticketing systems become tools your agents can call. A lightweight gateway you deploy makes a single outbound connection, no inbound firewall rules, no public endpoints, and traffic encrypted end to end.

MCP tunnels is supported in Managed Agents and the Messages API. MCP tunnels is managed from workspace settings within the Claude Console by organization admins.

“When building Sculptor, Clay's GTM engineering agent for building and testing GTM workflows autonomously, we wanted to give it a more flexible and powerful way to take actions than just tools in a loop. Claude Managed Agents let us replicate the power of a local agent with the reliability, versioning, and background execution of a cloud agent. And running it with our sandboxes, like Daytona, gives us control over the filesystem, so we can mount external file stores and install packages on the fly.”

Ryan Chang, AI Engineering

“Claude Managed Agents handles the agent loop, Vercel's sandboxes give us an environment we can configure for our workloads. This gives us the option to leverage best-in-class infrastructure while we focus on what compounds for a financial AI platform: depth and breadth of tools and data, and a product surface built for how investors and bankers actually work.”

Strib Walker, Head of Product

“Our use cases require secure orchestration of internal tools across a complex product surface. Modal's sandbox gives us the security boundary our enterprise customers need, and combining it with Claude Managed Agents gives us a powerful harness without hand-rolling extra complexity. We had a working version up in under a week, raising reliability for our customers.”

Sai Yandapalli, CTO

“Claude Managed Agents and Cloudflare let us get the first useful version of our design agent running in two days on infrastructure we already know and trust.”

Will Newton, Design

“As we scale agentic commerce for local businesses, we need a highly efficient path to production with full harness control, scale, and reliability. We're excited to evaluate Claude Managed Agents for this next step, building on our Al infrastructure with Modal!”

Andy Fang, Co-founder

PrevPrev

0/5

NextNext

eBook

##

## Getting started

Both self-hosted sandboxes and MCP tunnels work within the same core primitives supported by Managed Agents. Self-hosted sandboxes is available in public beta and MCP tunnels in research preview. To get started with MCP tunnels, request access.

Explore our docs to learn more, follow our cookbooks to set up your sandbox provider, or deploy your first agent in the Claude Console.

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

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

May 11, 2026

### Introducing the Claude Platform on AWS

Product announcements

Introducing the Claude Platform on AWSIntroducing the Claude Platform on AWS

Introducing the Claude Platform on AWSIntroducing the Claude Platform on AWS

May 11, 2026

### Agent view in Claude Code

Product announcements

Agent view in Claude CodeAgent view in Claude Code

Agent view in Claude CodeAgent view in Claude Code

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
