---
title: "Self-service data analytics in Slack: how Anthropic deploys Claude Tag for ad-hoc questions | Claude by Anthropic"
url: https://claude.com/blog/self-service-data-analytics-in-slack-how-anthropic-deploys-claude-tag-for-ad-hoc-questions
slug: self-service-data-analytics-in-slack-how-anthropic-deploys-claude-tag-for-ad-hoc-questions
fetched: 2026-08-14 03:22 UTC
---

# Self-service data analytics in Slack: how Anthropic deploys Claude Tag for ad-hoc questions | Claude by Anthropic

> Source: https://claude.com/blog/self-service-data-analytics-in-slack-how-anthropic-deploys-claude-tag-for-ad-hoc-questions




# Self-service data analytics in Slack: how Anthropic deploys Claude Tag for ad-hoc questions

- Category

No items found.

- Product

No items found.

- Date

August 13, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/self-service-data-analytics-in-slack-how-anthropic-deploys-claude-tag-for-ad-hoc-questions

- Author(s)

Clement Peng

Lily Zhao

In our previous post, we described how we enabled Claude to answer data analytics questions with ~95% accuracy through three primary artifacts: 

- A governed semantic layer; 
- A set of skill files that encode our analytical conventions; and 
- An evaluation suite to measure performance. 

That post focused on Claude Code (the primary development surface for our data scientists and data engineers), and best practices for improving agentic accuracy.

This post discusses how the data team at Anthropic applies that foundation to where the rest of the company works using Claude Tag (public beta), which is the foundation for our data analytics agent in Slack. Anyone can ask it data-related questions and receive answers backed by the same governed definitions analysts use. 

Fictional recreation of a Claude Tag conversation for illustrative purposes. Details, names, and tools are not real.

## Best practices for deploying a data analytics agent in Slack

Getting an agent to be accurate and getting it deployed where non-analysts can use it turned out to be quite different motions. We won’t rehash our recommendations on accuracy from our prior post as they’re still applicable here. 

Rather, we’ll cover our five most important learnings over the past year for how to deploy a data analytics agent in Slack and how you should think about distribution, permissions, freshness, and observability.

No items found.

PrevPrev

0/5

NextNext

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

eBook

##

### Refresh skills as often as you refresh your data models

You can teach Claude how to do a task aligned with your style and requirements using a skill, which is a markdown file with natural language instructions and files Claude can reference when needed.

The single most important architectural decision we made was to treat skill files as served content, refreshed continuously, rather than something shipped once and forgotten. 

Data models can change several times a day. For example, a column gets renamed, a metric definition is corrected, or a table is deprecated. Every one of those changes needs to land in a skill file in relatively short order. If Claude is reading last Tuesday's copy of the skill, it gives last Tuesday's wrong answer with full confidence.

This tendency can be especially damaging since the data consumer is now completely separated from the context they need to judge the accuracy of the response. They aren’t looking at a dashboard with trend lines or associated metrics that can guide their “sniff test.” They may receive just a single data point or two in Slack, and if it's not data they look at regularly, they are likely to accept that confidently wrong answer.

To control this ever-changing environment, Claude Tag's runtime mounts our data repo's skills/ directory and re-reads it on every conversation. The skill files are just markdown on disk; the agent reads them the same way it would read any project file. 

### Give the agent skills beyond knowing what to query 

Our initial instinct for deploying our data analytics agent using Claude Tag was to create a “knowledge skill,” which teaches Claude which tables to use and how our semantic layer is organized, and call it a day. We quickly determined that approach would provide correct numbers, but stop short of useful insights.

Most data consumers tend to ask open-ended and ambiguous questions like "what's driving this dip?" or "can you forecast where this lands at month-end?" or "show me this data as a funnel." Answering those requires the agent to know not just where the data is but how an analyst would work with it.

So alongside this knowledge skill, we mounted Claude Tag with additional analytics or runbook skills, including:

- Forecasting: when and how to fit a simple trend, seasonality assumptions, and when to refuse because a series is too short or too noisy.
- Cohort and retention analysis: standard cohort definitions, the retention curve template reported to leadership, and any gotchas (left-censoring, survivorship) that trip up naive implementations.
- Funnel analysis: the canonical stage definitions for key product funnels, so "where are users dropping off in onboarding?" is consistent across responses.
- Charting: visualization conventions like which chart type to use for which question, color palettes, and when a table is clearer than a plot.
- Analytical writing: how to structure a finding (TL;DR first, number, mechanism, caveat), and the level of hedging that’s appropriate given the degree of confidence.

Every data team likely already has these conventions; they just usually live in someone's head and are only occasionally documented. Writing them down as skills ensures Claude applies them as consistently as your data scientist would.

### Connect to business context, not just the warehouse

Even this combination of knowledge skills and runbook skills is not always enough to answer a question. When someone asks "why did sign-ups drop on Tuesday?", the answer often isn’t in the data model, but rather is frequently spread across Slack threads, incident trackers, release notes, and docs.

To account for these gaps, we wire Claude Tag into our internal knowledge index, which catalogs documents, discussions, and events across the company. When the agent sees a metric move, it can search that index for contemporaneous context: an incident opened that morning, a feature flag flipped, a competitor announcement someone shared in a channel. 

The answer now would look like "sign-ups dropped 12% Tuesday: there was a payment-service incident open 9-11am that morning, and the dip is concentrated in the affected region."

If your organization has a knowledge graph, internal search, or even just well-organized incident and changelog feeds, connecting Claude Tag to them is the highest-leverage information you can add after the warehouse itself. You can also connect Claude Tag so it can read and get context from key channels across Slack. 

### Permission the service account deliberately

Claude Tag queries your warehouse as a service account, not as the human who asked the question. While that's the right design (since you don't want every Slack user requiring direct warehouse credentials), everyone who can mention the bot has the bot's data access. There is no per-user row-level security: what the service account can read, anyone in the channel can ask about.

We approach this in five ways (and we recommend taking this seriously as it’s easy to get wrong and hard to undo):

1. Scope the service account to governed data only. At Anthropic, Claude Tag's service account can read the semantic layer's output tables and the curated marts that feed them. It cannot read raw event streams, staging schemas, or anything in a personal sandbox. If a question requires data outside that boundary, the agent says so rather than guessing. That is also the right user experience because data outside the governed layer hasn't been validated.

2. Classify PII at the column level and deny the service account clearance. Governed data isn’t automatically PII safe data (e.g., a curated table can still carry an email address). We maintain a data catalog with column-level lineage, so every column’s origin and downstream flow is known. When new columns land, Claude scans them and flags likely PII candidates for human review. A human then applies the classification in the column’s metadata, and lineage propagates that label to derived tables. Given Claude Tag’s service account holds no PII clearance, the warehouse’s column-level access controls make any PII columns invisible to the agent. It can query the table, but the sensitive columns simply aren’t readable.

3. Document the connection path in the skill itself. Our warehouse skill has a dedicated section on how the agent connects (whether via CLI, direct API, or an MCP server) and exactly how authentication works for each path. This prosaic feature allows us to differentiate between the agent failing cleanly ("I can't reach the warehouse from this surface; here's why") versus failing confusingly (a query that silently runs against the wrong project, or an auth prompt relayed somewhere it shouldn't be). When the connection mechanics are in the skill, the agent can explain its own constraints.

4. Treat Claude’s channel membership as an access grant. Adding Claude Tag to a Slack channel is, in effect, granting that channel's members read access to whatever the agent can query. We made this explicit: Claude is added to a channel by a data-team member, and the data team owns the list of channels.

5. Label every query. For every warehouse query, Claude Tag carries labels identifying the surface, the conversation, and the requesting user (where Slack provides it). This doesn't enforce anything at query time, but it provides cost attribution and audit trails (you can determine who asked the question that scanned 4 TB after the fact).

Our general posture is that a data analytics agent in Slack is a shared read replica of your governed warehouse, and we try to scope it as such.

### Instrument every answer

Determining whether the agent gave a sufficient answer is not something you can eyeball.

We log a structured event for every question Claude Tag handles. This includes:

- Which skill files were loaded and at what version; 
- Whether the user reacted with 👍/ 👎 or replied with a correction; and 
- Any open data quality warnings on the tables it touched. We also surface any data quality warnings in the answer's footer, so a stale-data alert appears next to the number rather than being invisible.

This telemetry feeds two views. One tracks adoption or what fraction of agent queries route through the governed layer rather than ad hoc SQL by surface and domain. The other tracks correctness measured by the rate of 👎 reactions and corrections by domain. This is the online proxy for accuracy between eval runs.

The adoption metric turned out to be the single most actionable number we tracked. When it dips for a domain, it almost always means either a skill file has drifted or a new class of questions has appeared that the semantic layer doesn't cover. 

## How this accelerates self-service analytics adoption

### Claude Tag threads become the new meeting 

Our favorite, most effective Claude Tag threads usually have multiple people in them. In these cases we see people contributing ideas and context while Claude handles the legwork. 

For example, a data team member asked Claude why a revenue dashboard was taking a few minutes longer than usual to load. Claude discovered query results weren't being cached and a bug was slowing down how results reached the page. 

Claude notified the dashboard owner who decided to fix the cache immediately while handling the bug in a separate motion. 

The owner then asked what other dashboards had slowed, and it turned out dozens were impacted by the same caching error. Claude wrote the caching fix, the data team member reviewed it, and all impacted dashboards were functioning at full capacity in less than an hour.

Fictional recreation of a Claude Tag conversation for illustrative purposes. Incident details, names, and tools are not real.

These threads are open which is helpful for multiple reasons. People reading along pick up context (what broke, why, how it got fixed) without anyone writing a summary for them. More importantly, they don't have to remain passive readers. Anyone who knows something useful can jump in and contribute, the way the team members did in the example above.

So keep the agent in shared channels and keep the work in threads instead of DMs, as the thread can function as a reviewable historical record.

### Claude Tag handles repetitive tasks

A lot of data work is recurring: pipeline health checks, KPI monitoring, etc. You can ask Claude to create loops that can handle cyclical tasks on schedule or in response to unusual changes. Some data specific examples we’ve implemented include:

- Proactive Readouts: Claude provides a summary before a weekly standup: what moved last week, how it compares to the week prior, and what’s worth noting. 
- Test Monitoring: When we’re monitoring a launch or an experiment, Claude provides readouts multiple times a day. During one recent experiment, it noticed the settings had changed partway through and helped us catch and fix it early.
- Observability: Other loops monitor our pipelines and dashboards. If a pipeline fails, Claude starts investigating, drafts a fix, and pings the person on call. If a KPI moves unexpectedly, Claude provides likely explanations: a holiday effect? an upstream data change? and checks them before anyone opens a dashboard.
- Triage: Another loop tracks our data questions channel. For each new question, it makes a call: answer it directly, start a deeper investigation, or bring in a human. By the time someone from the data team checks, most of the work is already done.

Claude can also help design the loop. Ask @Claude what repetitive jobs it’s seen in your channels and how it can help.

### Stepping in when needed

You can allow Claude to be more proactive in any channel you choose, reading along and stepping in to help when needed. In one of our data channels over the last month, Claude Tag answered more than 75% of questions people posted, typically within a minute or two, even without being called. 

For example, an Anthropic team member asked in a public channel whether a dashboard included a new usage category. Within 90 seconds Claude answered how the data was defined, confirmed the new segment was missing, proposed a fix, and drafted a PR. A data scientist reviewed and approved. Claude then merged the PR and refreshed the dashboard. 

Fictional recreation of a Claude Tag conversation for illustrative purposes. Incident details, names, and tools are not real.

## Getting started

If you've already done the work from our first post, the Slack deployment is mostly plumbing, though the order is important:

- Permissions first. Decide what the service account can read before you write a line of agent code. It's much easier to widen access later than to claw it back.
- Distribution second. Pick mounted-repo or skills-over-MCP and verify freshness end-to-end: change a skill file, and confirm Claude Tag picks it up within your SLA.
- Telemetry from day one. You will not retroactively instrument month-old conversations. Log the structured event on the very first question.
- Knowledge index when you can. The warehouse answers what; your internal docs and incident feeds answer why. Wire them in as soon as the data path is stable.
- Analytics skills last. Create the data-access skill first and then let real questions inform which analyst skills (forecasting, cohorts, funnels) your co-workers actually need.

This article was written by Clement Peng and Lily Zhao, members of Anthropic's Data Science and Data Engineering team, with contributions from Josh Cherry and Michael Segner.

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

No items found.

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
