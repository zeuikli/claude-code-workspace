---
title: "Compliance API coverage extends to Claude Cowork and Claude Code | Claude by Anthropic"
url: https://claude.com/blog/compliance-api-cowork-and-claude-code
slug: compliance-api-cowork-and-claude-code
fetched: 2026-08-12 03:20 UTC
---

# Compliance API coverage extends to Claude Cowork and Claude Code | Claude by Anthropic

> Source: https://claude.com/blog/compliance-api-cowork-and-claude-code




# Compliance API coverage extends to Claude Cowork and Claude Code

- Category

Enterprise AI

Product announcements

- Product

Claude Enterprise

Claude apps

Claude Code

Claude Cowork

- Date

August 11, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/compliance-api-cowork-and-claude-code

Claude's Compliance API now covers Cowork across the desktop app, web, and mobile, as well as Claude Code in the CLI and desktop app. Coverage is in beta for Claude Enterprise customers. Compliance and security teams can pull session content and metadata from both products through the same Compliance API interface they already use for Claude chats.

The new endpoints are additive: nothing changes about the data you already pull from the Compliance API today.

Security and compliance teams rely on the Compliance API to see how Claude is used across their organization — for audits and eDiscovery — without deploying separate logging infrastructure for each surface. Extending coverage to Cowork and Claude Code closes a gap: those sessions now show up alongside Claude chats. 

## How it works

The new session endpoints return a consolidated, server-hosted transcript for each Cowork and Claude Code session, so prompts, responses, and tool activity come back together in a single session record.

Each session record carries two kinds of data:

- Session content: prompts and responses, tool calls content (web and MCP), and skills and artifacts content captured as transcript text.
- Session metadata: verified user ID and email address, organization ID, session and per-message IDs, and timestamps.

This beta doesn't include Claude Code on the web, Claude Code accessed through the Claude Platform, or sessions run on Amazon Bedrock, Google Cloud's Vertex AI, or Microsoft Foundry.

Organizations already exporting OpenTelemetry data can keep it running: the Compliance API can work alongside it with no infrastructure required on your side.

## Getting started

Coverage for Cowork and Claude Code is available today and included with the Compliance API using your existing Compliance Access Key – there’s no separate integration to build. If it's already enabled for your organization, query the new session endpoints directly. If not, review the Compliance API documentation to enable it.

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

Jun 5, 2026

### The Claude Cowork product guide

Enterprise AI

The Claude Cowork product guideThe Claude Cowork product guide

The Claude Cowork product guideThe Claude Cowork product guide

May 22, 2026

### How Anthropic's finance team uses Claude to shape the narrative behind the numbers

Enterprise AI

How Anthropic's finance team uses Claude to shape the narrative behind the numbersHow Anthropic's finance team uses Claude to shape the narrative behind the numbers

How Anthropic's finance team uses Claude to shape the narrative behind the numbersHow Anthropic's finance team uses Claude to shape the narrative behind the numbers

Aug 7, 2026

### How Anthropic's business development team uses Claude to run inbound and outbound at scale

Enterprise AI

How Anthropic's business development team uses Claude to run inbound and outbound at scaleHow Anthropic's business development team uses Claude to run inbound and outbound at scale

How Anthropic's business development team uses Claude to run inbound and outbound at scaleHow Anthropic's business development team uses Claude to run inbound and outbound at scale

Aug 5, 2026

### Inference hooks: inline data loss prevention for Claude Enterprise

Enterprise AI

Inference hooks: inline data loss prevention for Claude EnterpriseInference hooks: inline data loss prevention for Claude Enterprise

Inference hooks: inline data loss prevention for Claude EnterpriseInference hooks: inline data loss prevention for Claude Enterprise

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
