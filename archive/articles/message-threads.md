---
title: "Make long-running agents faster with message threads"
url: https://claude.com/resources/articles/message-threads
slug: message-threads
fetched: 2026-11-03 07:31 UTC
---

# Make long-running agents faster with message threads

> Source: https://claude.com/resources/articles/message-threads

> New in the Messages API, send your conversation once, and the API receives only what’s new with every turn.


# Make long-running agents faster with message threads

New in the Messages API, send your conversation once, and the API receives only what’s new with every turn.

-

CategoryAnnouncements

-

ProductClaude Platform

-

DateNovember 2, 2026

-

Reading time3 min

-

ShareCopy link

Message threads is now available in public beta on the Claude Platform. With message threads, agents no longer need to resend the full conversation history on every turn, reducing latency for long-running sessions.

### How message threads works

A coding agent might make hundreds of requests in one session, and each request resends every earlier message and tool result. Once a conversation reaches hundreds of thousands of tokens, resending all of it adds time before Claude starts responding. With message threads, agents send only what’s new since the last turn, which reduces time to first token (TTFT).

With message threads on by default for most Claude Code users, requests with 500k to 1M tokens see median TTFT drop by about 35%.

To use message threads, add the `thread` parameter to Messages API requests. The first request includes the full conversation and starts a thread. Each request after that includes only the new messages and the ID of the previous response. Between turns, we hold each thread in memory, where it’s encrypted and not written to disk. A thread expires 5 minutes after its last request and your client then resends the full conversation to start a new one. While each request is smaller with message threads, Claude still reads the full conversation on every turn, so token usage stays the same.

Message threads is best for active sessions where latency matters, including:

- Long-running coding agents, where each tool result or file edit adds to the conversation.
- Computer use agents, where screenshots stay with the thread instead of being re-uploaded on every turn.
- Document and image-heavy workflows, where requests are made smaller.

The more context an agent carries, the more message threads can reduce time to first token.

### Getting started

Message threads is available now in public beta on the native Claude Platform, and on Claude Platform on AWS, Claude in Microsoft Foundry, and on Claude Models on Google Cloud (Anthropic managed). Standard Claude token rates and existing rate limits apply. See the documentation to get started.

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleOct 28, 2026

### Smart reports, surveys, and pooled group budgets for Claude Enterprise

In many organizations, members have identified the unique work that Claude can unlock. The next step is expanding that work to every team.

Claude Enterprise

ArticleOct 28, 2026

### IDC brings Quanta into Claude and adopts Claude across the company

IDC integrated Claude as part of its Quanta platform, and it has rolled Claude out across its own business

Claude CoworkClaude Code

1 more: Claude EnterpriseClaude Enterprise

ArticleOct 28, 2026

### Introducing artifacts for legal work

Claude for Legal now includes ready-to-use artifacts for legal work that teams can adapt with their own data and connectors, and share across the business.

Claude Enterprise

ArticleOct 27, 2026

### Claude for Financial Advisors

Financial advisors can now connect Claude to the custodians, portfolio platforms, CRMs, and planning tools they depend on, along with new skills tailored to the daily work of a financial advisor.
