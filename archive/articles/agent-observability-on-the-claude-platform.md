---
title: "Trace agents with OpenTelemetry on the Claude Platform"
url: https://claude.com/resources/articles/agent-observability-on-the-claude-platform
slug: agent-observability-on-the-claude-platform
fetched: 2026-10-15 05:31 UTC
---

# Trace agents with OpenTelemetry on the Claude Platform

> Source: https://claude.com/resources/articles/agent-observability-on-the-claude-platform

> Announcing OpenTelemetry traces from Claude Managed Agents, the Messages API, and Claude SDKs on the Claude Platform.


# Agent observability on the Claude Platform

Announcing OpenTelemetry traces from Claude Managed Agents, the Messages API, and Claude SDKs on the Claude Platform.

-

DateOctober 14, 2026

-

Reading time3 min

-

ShareCopy link

You can now send OpenTelemetry (OTel) traces from Claude Managed Agents, the Messages API, and Claude SDKs to any OTel tool, and follow each step your agents take. If you already send Claude Code or Cowork traces to your observability tool, the agents you build on the Claude Platform can also show up in the same place.

## Trace agents with OpenTelemetry

Trusting an agent with more access starts with tracing its model calls, tool use, and MCP server calls. Review its traces, then widen its access as it proves reliable.

Add a destination in the Claude Console, and every agent turn, model call, and tool use arrives in your observability tool as a standard OpenTelemetry trace, with latency, tokens, and IDs.

## Works with your observability tools

Claude traces follow the OpenTelemetry GenAI semantic conventions, so data from Claude and other providers works in the same tools and dashboards.

- Debug agents next to the rest of your stack. In Grafana Cloud, Honeycomb, Sentry, and Splunk, agent traces sit beside your logs and metrics, so you can see which service a slow or failed step came from.
- Improve agents with production data. With Arize AI, Braintrust, Datadog, Langfuse, LangSmith by LangChain, New Relic, and PostHog, you can turn real traces into evals, catch quality issues, and measure whether a change helped.
- Track usage across your organization. Send traces to Databricks Unity Gateway so platform and security teams can see token usage by team and flag unusual activity.

Claude traces also work with any other OpenTelemetry tool that accepts a standard OTLP endpoint.

## Get started

OpenTelemetry traces on the Claude Platform is available in public beta. Managed Agents and the Messages API need a destination in the Claude Console, while Claude SDKs export traces automatically.

See the docs to get started.

“At Foxglove, we’re building agents that help robotics teams debug their robots. Native OpenTelemetry export from the Claude Platform lets us analyze agent interactions in PostHog alongside product usage data. That helps us evaluate how our agents perform in practice, identify where they fall short, and prioritize improvements for robotics teams.”

Roman Shtylman, Co-Founder and CTO

“Claude powers some of Ramp’s most capable internal and customer-facing agents. We built Reflect, an agentic system that scores their Langfuse traces, finds recurring failures, and proposes fixes. On some agents, we’ve already cut token usage by 10–20% and made sessions 30% faster. But Reflect can only improve what it observes. Native OpenTelemetry export from the Claude API can feed high-fidelity instrumentation directly into that improvement loop, with no extra steps.”

David Traina, Senior Software Engineer

“At Sterling Labs, we tune our systems like a race team tunes its engine. For agents analyzing live markets 24/7, Langfuse is our pit wall. Native OpenTelemetry export from the Claude Platform streams every trace straight in with no custom instrumentation, so my team can focus on the edge, not the wiring.”

Hyon Lee, CTO

“Agents that touch a company’s books have to show their work, the same way an accountant does. Our agents run on the Claude Platform and our telemetry lives in Grafana Cloud, and native OpenTelemetry export from Claude puts each model call in the same trace as the reconciliation or journal-entry workflow it ran inside. We see the prompt version, tool calls, latency, and token spend alongside the rest of our stack, so when an auditor asks what an agent did and why, we can answer from one timeline.”

Ankush Sharma, Head of Infrastructure

“At Foxglove, we’re building agents that help robotics teams debug their robots. Native OpenTelemetry export from the Claude Platform lets us analyze agent interactions in PostHog alongside product usage data. That helps us evaluate how our agents perform in practice, identify where they fall short, and prioritize improvements for robotics teams.”

Roman Shtylman, Co-Founder and CTO

“Claude powers some of Ramp’s most capable internal and customer-facing agents. We built Reflect, an agentic system that scores their Langfuse traces, finds recurring failures, and proposes fixes. On some agents, we’ve already cut token usage by 10–20% and made sessions 30% faster. But Reflect can only improve what it observes. Native OpenTelemetry export from the Claude API can feed high-fidelity instrumentation directly into that improvement loop, with no extra steps.”

David Traina, Senior Software Engineer

“At Sterling Labs, we tune our systems like a race team tunes its engine. For agents analyzing live markets 24/7, Langfuse is our pit wall. Native OpenTelemetry export from the Claude Platform streams every trace straight in with no custom instrumentation, so my team can focus on the edge, not the wiring.”

Hyon Lee, CTO

“Agents that touch a company’s books have to show their work, the same way an accountant does. Our agents run on the Claude Platform and our telemetry lives in Grafana Cloud, and native OpenTelemetry export from Claude puts each model call in the same trace as the reconciliation or journal-entry workflow it ran inside. We see the prompt version, tool calls, latency, and token spend alongside the rest of our stack, so when an auditor asks what an agent did and why, we can answer from one timeline.”

Ankush Sharma, Head of Infrastructure

“At Foxglove, we’re building agents that help robotics teams debug their robots. Native OpenTelemetry export from the Claude Platform lets us analyze agent interactions in PostHog alongside product usage data. That helps us evaluate how our agents perform in practice, identify where they fall short, and prioritize improvements for robotics teams.”

Roman Shtylman, Co-Founder and CTO

“Claude powers some of Ramp’s most capable internal and customer-facing agents. We built Reflect, an agentic system that scores their Langfuse traces, finds recurring failures, and proposes fixes. On some agents, we’ve already cut token usage by 10–20% and made sessions 30% faster. But Reflect can only improve what it observes. Native OpenTelemetry export from the Claude API can feed high-fidelity instrumentation directly into that improvement loop, with no extra steps.”

David Traina, Senior Software Engineer

1/4

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleOct 13, 2026

### Uber's CISO on building an insider threat program for AI

Uber's CISO, Philip Martin, on the importance of monitoring and observability for AI agents, and how Uber's open-source tooling works alongside Enterprise Frontier Safeguards.

ArticleOct 8, 2026

### Building effective agent automations

A reference implementation walkthrough for a scheduled Claude Managed Agents automation, with the config files and six rules for avoiding common failure modes.

Claude Platform

(opens in new tab)

ArticleOct 8, 2026

### How Block orchestrates Claude Fable across thousands of pull requests

Bradley Axen, Head of AI Capabilities at Block, on how his team evaluates new large language models, how Claude Fable 5 orchestrates company-wide code migrations, and why safeguards are a critical part of deploying frontier intelligence responsibly, at scale.

Claude Enterprise

ArticleOct 8, 2026

### Build live dashboards and animate explainers with Claude 

Claude Dashboards and Claude Motion are now in beta. Docs, Slides, and Design are out of beta and on every Claude plan, including Free.

Claude appsClaude Design

2 more: Claude Cowork and Claude CodeClaude CoworkClaude Code
