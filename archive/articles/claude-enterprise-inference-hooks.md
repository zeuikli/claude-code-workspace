---
title: "Inference hooks: inline data loss prevention for Claude Enterprise | Claude by Anthropic"
url: https://claude.com/blog/claude-enterprise-inference-hooks
slug: claude-enterprise-inference-hooks
fetched: 2026-08-06 04:08 UTC
---

# Inference hooks: inline data loss prevention for Claude Enterprise | Claude by Anthropic

> Source: https://claude.com/blog/claude-enterprise-inference-hooks




# Inference hooks: inline data loss prevention for Claude Enterprise

- Category

Enterprise AI

Product announcements

- Product

Claude Enterprise

Claude apps

Claude Cowork

Claude Code

- Date

August 5, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/claude-enterprise-inference-hooks

Inference hooks lets your compliance team inspect and enforce policy on every prompt and tool call response before they reach Claude — across Claude Enterprise surfaces including chat, Claude Code, Claude Cowork, and more. Your DLP server makes the call to block or allow, and Claude enforces that decision in real time, blocking unapproved content before it reaches Claude.

Security teams require every channel where employees can move sensitive data to pass through an inspection point their team controls. Until today, native inline enforcement was limited to Claude Code's client-side hooks. Inference hooks closes the gap with a single enforcement layer that covers every Claude Enterprise surface without separate integration work or agent per product. 

## How inference hooks works

When an organization turns on inference hooks, every inference request routes through a signed WebSocket connection to a security server. Before the model starts generating, Claude sends the prompt and its surrounding context to your server. Your server returns a verdict — allow or deny — and Claude only proceeds once it has one.  The same check runs on tool calls: when Claude calls a tool — including tools connected through MCP, skills, and plugins — the tool's response is checked before it's sent back to the model.

## Ways to use inference hooks

Extend your existing DLP program to Claude. Inference hooks uses an open, webhook-based protocol with a published schema. That makes deployment easy — just point it at the same server your other tools already report to including Netskope, Palo Alto Networks, Proofpoint, Zscaler or an AI security server you built in-house.

Cover chat, Claude Code, Cowork, and additional Claude Enterprise products with one configuration. Turn on inference hooks once at the organization level and it applies to Claude Enterprise surfaces, including tool calls made through MCP connectors, skills, and plugins.

Simplify rollout with shadow mode (always allow), role-based exclusions, and percentage-based rollouts. Customize failure-policy tolerance, timeouts, and other settings to match your organization's risk tolerance.

## Getting started

Inference hooks is available today in beta for Claude Enterprise customers. Read the documentation to configure your organization's DLP server and start enforcing policy across Claude Enterprise surfaces.

For security vendors, inference hooks is built on a webhook-based protocol with a documented schema, so you can build an integration, and Claude Enterprise customers can point their organization at your platform.

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

Aug 4, 2026

### A guide to cost visibility and control in Claude

Enterprise AI

A guide to cost visibility and control in ClaudeA guide to cost visibility and control in Claude

A guide to cost visibility and control in ClaudeA guide to cost visibility and control in Claude

Jul 28, 2026

### Bringing MCP 2026-07-28 to Claude

Product announcements

Bringing MCP 2026-07-28 to ClaudeBringing MCP 2026-07-28 to Claude

Bringing MCP 2026-07-28 to ClaudeBringing MCP 2026-07-28 to Claude

Jul 24, 2026

### How the product designer who built Claude Design uses it to explore ideas before building them

Enterprise AI

How the product designer who built Claude Design uses it to explore ideas before building themHow the product designer who built Claude Design uses it to explore ideas before building them

How the product designer who built Claude Design uses it to explore ideas before building themHow the product designer who built Claude Design uses it to explore ideas before building them

Jul 24, 2026

### Claude models explained: choosing the best model for your use case

Enterprise AI

Claude models explained: choosing the best model for your use caseClaude models explained: choosing the best model for your use case

Claude models explained: choosing the best model for your use caseClaude models explained: choosing the best model for your use case

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
