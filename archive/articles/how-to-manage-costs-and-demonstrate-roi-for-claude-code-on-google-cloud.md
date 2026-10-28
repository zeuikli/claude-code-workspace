---
title: "Manage costs and demonstrate ROI for Claude Code on Google Cloud"
url: https://claude.com/resources/articles/how-to-manage-costs-and-demonstrate-roi-for-claude-code-on-google-cloud
slug: how-to-manage-costs-and-demonstrate-roi-for-claude-code-on-google-cloud
fetched: 2026-10-28 06:36 UTC
---

# Manage costs and demonstrate ROI for Claude Code on Google Cloud

> Source: https://claude.com/resources/articles/how-to-manage-costs-and-demonstrate-roi-for-claude-code-on-google-cloud

> Best practices for managing costs and measuring return on investment for Anthropic&#x27;s Claude Code on Google Cloud. 


# Manage costs and demonstrate ROI for Claude Code on Google Cloud

Best practices for managing costs and measuring return on investment for Claude Code on Google Cloud.

-

CategoryBest practices

-

ProductClaude Code

-

DateOctober 27, 2026

-

Reading time17 min

-

ShareCopy link

As organizations delegate more work to Claude Code, spend grows with it, and platform teams need a way to both control costs and understand impact. Inspired by a recent webinar (opens in new tab) with Google Cloud, we share how organizations using Claude Code can better track and optimize these considerations on Google Cloud, including three core levers: control, track, and prove.

## Controls for managing Claude Code spend

Claude on Google Cloud has consumption-based pricing, so your bill is a readout of how much your developers are using Claude in your Google Cloud environment. Adoption drives usage; usage is what you pay for, and it’s also where the value shows up.

Your Claude Code bill is a product of how many tokens tasks consume and the models that handle them. Token consumption scales with task complexity and conversation length. Chat is a Q&A conversation. An agentic tool like Claude Code spends more tokens per task relative to chat because it's doing multistep work: reading files, running tools, and reasoning across a whole task. Meanwhile each model has its own price per token, so matching the model to the task is the other major cost control.

Visibility into the tokens and model choices impacting your organization’s bill each month is available through the Claude apps gateway and Google Cloud services. You can govern the spend and manage costs via three independent levers:

- Control. Creating guardrails that guide usage without over-restricting access and unintentionally blocking people.
- Track. Granular oversight of where the spend is happening, and where it will continue to go, before the bill arrives.
- Prove. Identifying the value your org is getting from spending these tokens and attributing exactly where it’s coming from.

Here’s how to apply this control -> track -> prove framework to your own Claude Code on Google Cloud deployment.

### The governance toolbox

Claude on Google Cloud comes with tools and capabilities for controlling, tracking, and proving the value of your spend.

Google Cloud already gives you many native capabilities you can apply to tracking and controlling your Claude spend:

- Per-project billing. Allows you to host a dedicated project for Claude Code as a clean way to track costs.
- Billing budgets and alerts. Allows you to set budget alerts and get notified as actual spend crosses thresholds you define.
- Spend caps (Preview). Allows you to enforce a service-level Google Cloud spend budget with ability to manually lift the cap.
- BigQuery exports. Lets you analyze Claude spend alongside the rest of your cloud costs.
- Quotas. Claude models on Google Cloud have per-minute limits on requests, input tokens, and output tokens for each model family and endpoint location.
- Provisioned throughput. Pay a fixed fee for reserved capacity instead of pay-as-you-go.

Claude Code and Claude apps gateway add their own tracking and control capabilities. The gateway is a self-hosted service, shipped in the same `claude` binary your developers already use, that runs in your Google Cloud project between Claude Code and Claude on Google Cloud. Developers sign in through your identity provider, such as Google Workspace, so every request carries a verified identity. That lets you set model allowlists per IdP group, and spend caps per user, IdP group, or organization, by day, week, or month.

Here's how to choose and combine capabilities to manage the three levers measuring the cost and ROI behind your organization’s AI investments with Claude on Google Cloud:

#### Lever 1: Control

The control lever is all about providing guardrails that guide developers in their Claude Code use, instead of restricting them with arbitrary caps.

Guiding rather than restricting is important because high cost sessions are not necessarily bad — in fact, they're often high value, especially in Claude Code. Those sessions are generally your power users that are at the forefront, using new workflows and getting a lot of value from Claude and getting a lot of work done.

Waste tends to sit in the long middle of heavy spenders. For example, they're using Fable for a daily routine that Sonnet can easily handle. Or maybe they have forgotten some scheduled task they no longer care about, but it keeps on running automatically anyway.

There are four features that give you the guardrails to guide your users instead of restricting them:

- Spend limits (opens in new tab). The Claude apps gateway allows you to set spend caps per user, per IdP group, or organization-wide, by day, week, or month. Group and organization caps are per-developer defaults that each member inherits, not a shared pool.
- Threshold alerts. When used with Claude apps gateway, Claude Code on Google Cloud warns developers as they approach their cap, first past 75% and again past 95%. These are in-CLI warnings for developers, whereas Google Cloud Billing alerts are meant for admins. At the cap, the gateway returns 429 until the period resets or an admin raises the cap, and you can script cap increases through the gateway's admin API.
- Model defaults and allowlists. Specify which models are available, per IdP group, via the Claude apps gateway which enforces the allowlist server-side on every request. We have found that setting a model default works really well, because most people will stick to the model default; if they want to switch models, they usually are switching for a reason. You can use model defaults in addition to or instead of model allowlists.
- Gateway Admin API. The gateway serves an admin API for spend limits (opens in new tab), so you can set and change caps programmatically, for example using a ticketing workflow.

Combine these capabilities to control your overall bill, but remember that control is only the first lever. Price per token doesn't give you the full picture. The most important metric is the cost per task, which can be monitored and analyzed by tracking this usage.

#### Lever 2: Track

This lever is all about seeing where spend is going and how it’s being used. The good news is that you can track Claude Code usage, costs, and tool activity across your organization. Primary tracking strategies include:

- Usage and cost observability. Claude Code's OpenTelemetry metrics and events (opens in new tab) report usage and estimated cost, broken down by skill, plugin, agent, and MCP server. Send them over OpenTelemetry Protocol (OTLP) to tools you already run, such as Google Cloud Monitoring, through an OpenTelemetry collector or relayed by the Claude apps gateway (for centralized OpenTelemetry config).
- End-user usage view. Developers see their own spend and get usage warnings right in Claude Code before they hit a limit.
- Data export to your existing systems. Google Cloud Billing exports to BigQuery let you filter to Claude SKUs by model and token type, putting Claude spend alongside the rest of your cloud and AI spend. OTel flows to your O11y stack, and the gateway Admin API can feed spend-limit status straight into your ticketing system.

Claude Code, whether running on developer machines or on cloud workstations, can export OpenTelemetry once you enable it, including sessions, active time, lines of code, commits, pull requests, tokens and cost, broken down by user, team, and model. The most recent releases of Claude Code also break usage down by skill, plugin, agent, and MCP server so you can see not just overall Claude Code usage but also which of your org’s internal skills and plugins get adopted. With the Claude apps gateway, you don't need to configure each machine. Set a telemetry destination on the gateway, and it turns telemetry on for signed-in developers. It also tags every export with the developer's verified email and IdP groups from their sign-in, rather than values configured on the client-side.

To attribute usage to your own cost centers and departments, set the OTEL_RESOURCE_ATTRIBUTES environment variable (for example, department=engineering,cost_center=eng-123). Claude Code adds these tags to every metric and event, so you can filter and aggregate by them. The metrics land in Google Cloud Monitoring (or other monitoring solutions like Grafana or Splunk) with those custom attributes.

A Claude Code usage dashboard in Cloud Monitoring, built from Claude Code's OpenTelemetry metrics. Illustrative recreation with sample data.

A typical adoption view shows active developers, number of sessions over the last 24 hours, and total tokens consumed. The orange box shows blocked requests when developers hit their gateway-enforced spend caps. That metric pairs well with your existing ticketing system as a workflow that allows developers to request an increase.

For ready-made Cloud Monitoring dashboard, refer to the Claude Code Monitoring template (opens in new tab), which turns Claude Code’s OpenTelemetry metrics into a single view of adoption, coding activity, and token usage and estimated spend, so you can track usage and costs by user and model as you roll out Claude Code on Google Cloud. You can copy this template directly from within the Cloud Monitoring console.

To set up custom Claude Code telemetry on Google Cloud, start with the Claude Code OTel quickstart (opens in new tab). Use it to configure s Claude Code to export OpenTelemetry straight to Google Cloud Observability suite including Cloud Logging and Cloud Monitoring. The quickstart also routes logs into partitioned BigQuery tables, one per event type (API requests, tool decisions, tool results, assistant responses, and completed hook executions), and ships SQL queries for spend per developer/model, tool success and latency, hook wait time, per-turn and per-session analytics.

#### Lever 3: Prove

The control lever governs and apportions usage and costs; the track lever allows you to visualize that spend. The prove lever is how you map usage to ROI for Claude Code on Google Cloud.

The metrics that platform engineers care most about measuring in Claude Code are contained within three dimensions: usage, developer satisfaction, and impact.

Adoption and usage metrics measure how people are using Claude in your organization, including your activated users and their weekly and daily usage. These reveal information like depth of use, user retention over time, and who your Claude Code power users are. These metrics are all derived via Claude Code OTel data.

Satisfaction metrics monitor the user experience for your engineers, including their happiness with Claude Code, perceived time savings, confidence in output, and any friction they might experience. Satisfaction metrics come from a short survey run before and after rollout, followed by ongoing user check-ins.

Impact metrics assess how Claude is delivering measurable engineering outcomes, comparing throughput, cycle time, and review speed against a baseline, plus qualitative measurements on specific bodies of work.

### A starting set of impact metrics

Here's a starting set of impact metrics, grouped into three areas: time, effort, and volume.

Time measures how quickly work ships: PR cycle time from open -> merge, and code review turnaround.

Effort measures how much work each change takes: review iterations per PR, review comments and rework per PR.

Volume measures what the freed-up capacity delivers: PRs per engineer, deployment frequency, and named bodies of work: the specific backlog items your teams shipped with the freed capacity. These add a qualitative view alongside the counts..

These are directional reference points, not rules, but a good starting point for measuring Claude Code's impact in your organization. The baseline you need already exists: your delivery history in source control and tickets.

### Define your unit of work

Most of these metrics count PRs, but a typo fix and a feature release are both one PR. Therefore, count merged PRs of a defined class instead: Claude opens the PR, and a person decides whether it ships. Labels such as hotfix or feature release, the ticket ID, and whether Claude was involved make those PRs easy to find in the systems you already run. Not every unit of work is a PR; a service cutover or an incident closed at its root cause are examples. The same rule applies: count one finished thing, where it lands.

## Claude Code native telemetry

After putting cost governance and usage tracking in place, the next step is to map those to ROI. Claude Code’s native telemetry helps you capture contribution and productivity metrics that document the value your organization is deriving.

Claude Code’s OTel metrics let you track or derive code suggestion accept rate, lines of code modified, commits created, PRs created, cost per unit of output, and PRs per user.

All of these native metrics offer useful and actionable information. This info becomes even more valuable when paired with logged events like user prompts and tool decisions, captured via Claude Code telemetry on Google Cloud (opens in new tab). Logging user prompts, for example, is a good way to understand everything your user base is trying to build, because not every unit of work is necessarily a PR. Note that user prompts are not logged automatically due to potentially sensitive content; you have to specifically opt in.

One example would be using Claude Code to troubleshoot an incident if you’re an SRE or generate sample data for a live demo if you’re a sales engineer. Those sessions do not result in a PR, but they do accelerate those teams’ workflows. Keep in mind that Claude Code's PR metric counts the PRs Claude Code creates, not what eventually merges. Your source control and ticketing systems remain the record of what shipped, so correlate Claude Code telemetry with GitHub or GitLab and your ticket tracker for the full picture

Here’s the measurable impact that some Claude on Google Cloud customers have achieved with Claude Code.

- Delivery Hero (opens in new tab) had a team overhaul a design system across 100 UI components. Claude Code did in minutes what would normally take a week of an engineer's time.
- Shopify  (opens in new tab)engineers build faster with Claude Code, but non-engineers are also building internal tools in minutes instead of days. Claude Code is expanding who can build at Shopify, not just speeding up the people already building.
- Fifth Dimension (opens in new tab) engineers universally use Claude Code on Google Cloud. Combined, they're writing over 300,000 lines of code a month with a 98% acceptance rate.

## Getting started

The goal of this post is to help you feel comfortable with the tools and capabilities that exist to help you manage Claude Code on Google Cloud costs and demonstrate ROI. As platform engineers, the system serves not only to notice and observe behavior in your user base. It also gives you the knowledge necessary to dynamically adjust governance and settings.

It’s a continuous loop: start with reasonable defaults, such as an org-wide spend cap, a default model, and a model allowlist, then refine by role and team as usage data comes in. By tracking actual use and correlating metrics to the value you’re getting from Claude Code, you can then deliver these to your stakeholders who need to analyze the ROI and business impact of using Claude Code.

How organizations use Claude Code on Google Cloud and the value derived from that usage will both evolve as the amount of work and the type of work we're delegating to Claude keep getting deeper and more diverse. The control → track → prove framework outlined here is a stable starting point for measuring every aspect and outcome of your Claude Code deployment.

Here are resources to get you started:

- Manage costs effectively (opens in new tab)
- Monitoring usage and costs (opens in new tab)
- Claude apps gateway spend limits (opens in new tab)
- Deploy Claude apps gateway on Google Cloud (opens in new tab)
- Create, edit, or delete budgets and budget alerts (opens in new tab)
- Manage spend cap budgets | Cloud Billing (opens in new tab)

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleOct 22, 2026

### Building agents: When to fold subagents into your main agent loop

When building agents in Claude Platform, using fewer subagents in favor of progressively disclosed context and tools can improve quality while reducing cost and latency. Here’s when and how to migrate.

Claude Platform

ArticleOct 19, 2026

### Redesigning source control at Anthropic

As merges to Anthropic's monorepo grew from about 2,500 to more than 30,000 a day, source control became the biggest development bottleneck. Here is how the team built Scion, an in-house version control system designed for always-online agents, and migrated off git in five months.

Claude Code

(opens in new tab)

ArticleOct 16, 2026

### How an Anthropic BDR in Japan runs his day with Claude Managed Agents

How one business development representative clears his inbound queue and drafts bilingual customer emails with Claude Managed Agents and Claude Tag.

Claude Managed Agents

ArticleOct 16, 2026

### How the Claude Code team does code review

How do you review code at the volume agents produce it? The Claude Code team shares its review process, from Claude verifying its own work to risk-tiered human approval, plus a checklist for adopting it.

Claude Code

(opens in new tab)
