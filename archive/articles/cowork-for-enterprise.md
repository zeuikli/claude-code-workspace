---
title: "Making Claude Cowork ready for enterprise"
url: https://claude.com/blog/cowork-for-enterprise
slug: cowork-for-enterprise
fetched: 2026-04-17 15:43 UTC
---

# Making Claude Cowork ready for enterprise

> Source: https://claude.com/blog/cowork-for-enterprise




# Making Claude Cowork ready for enterprise

- Category

Product announcements

- Product

Claude Enterprise

- Date

April 9, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/cowork-for-enterprise

Claude Cowork is now generally available on all paid plans. Within companies, Claude Cowork has become a key part of how teams operate: handling tasks, drafting project deliverables, and keeping teams up to date. 

Today, we’re introducing organization controls to help teams deploy Claude Cowork company-wide:  role-based access controls for Enterprise, group spend limits, expanded OpenTelemetry observability, and usage analytics for admins to see Claude Cowork adoption. 

## Early signals

Claude Code helped developers transition from handing Claude questions to whole tasks, and we’re seeing the same pattern across the entire organization with Claude Cowork: the vast majority of Claude Cowork usage comes from outside engineering teams. Importantly, functions like operations, marketing, finance, and legal are not handing Claude their core work, but rather the work that surrounds their most critical tasks—project updates, collaboration decks, research sprints, etc. 

As early enterprise adopters of Claude Cowork have seen this pattern emerge in one team, they’ve often wanted to roll it out more broadly, opening questions like who gets access, spend management, and how to see what’s happening across teams.

## Controls for organization-wide deployment

Deploying agents with Claude Cowork’s capabilities across an organization requires governance and visibility for admin teams. Today, we’re adding more of the controls organizations need:

Role-based access controls. Admins on Claude Enterprise can now organize users into groups — manually or via SCIM from your identity provider — and assign each a custom role defining which Claude capabilities its members can use. Turn Claude Cowork on for specific teams and adjust as adoption grows.

Group spend limits. Set per-team budgets from the admin console. Predictable costs, adjustable as you learn what each team needs.

Usage analytics. Claude Cowork activity now appears in the admin dashboard and the Analytics API. From the dashboard, admins can track Claude Cowork sessions and active users across various date ranges. The Analytics API goes deeper: per-user Claude Cowork activity, skill and connector invocations, and DAU/WAU/MAU alongside existing Chat and Claude Code figures. See which teams are adopting, which workflows are landing, and where to invest next.

Expanded OpenTelemetry support. Claude Cowork now emits events for tool and connector calls, files read or modified, skills used, and whether each AI-initiated action was approved manually or automatically. Events are compatible with standard SIEM pipelines like Splunk and Cribl, and a shared user account identifier lets you correlate OTEL events with Compliance API records. OpenTelemetry is available on Team and Enterprise plans.

Zoom MCP connector. Claude Cowork integrates with the tools your teams already use. Today, Zoom is launching a connector that brings meeting intelligence directly into the Cowork experience. The Zoom connector delivers AI Companion meeting summaries and action items alongside transcripts and smart recordings — helping teams use their conversations on Zoom to create agentic workflows in Cowork. Add Zoom from the connector directory in Claude's settings.

Per tool connector controls. Admins can now restrict which actions are available within each MCP connector across the organization — allowing read access but disabling write operations, for example. Permissions apply org-wide and are configured from the admin console.

## How organizations use Claude Cowork

Zapier connected Cowork to their org database, Slack, and Jira to surface engineering bottlenecks—getting back a dashboard, team-by-team analyses, and a prioritized roadmap that Product and Design Ops then copied for themselves. Jamf turned a seven-facet performance review into a 45-minute guided self-evaluation, then built similar workflows for vendor reviews and incident response. Airtree, a venture firm, built a board prep workflow that pulls from a portfolio company's Drive, Slack updates, and competitor news, cross-referenced against the previous prep.

“The barrier between "having an idea" and "shipping something" has collapsed. The skill that matters now isn't knowing how to do every step. It's knowing clearly what you're trying to accomplish and being able to direct toward that outcome. Execution is still real work, but the ceiling on what one person can ship has moved dramatically. I genuinely cannot remember doing my job without it.”

Larisa Cavallaro, AI Automation Engineer

“People across the org are using Cowork for data blending, analysis, and dashboard building. Bespoke dashboarding has been huge. Tasks that previously required a BI tool or an engineer's help, people are now doing themselves in minutes.”

Nick Benyo, Software Engineer

“Using Claude Cowork across teams multiplied its value. Skills built by one person could be used by everyone. Claude Cowork became shared firm infrastructure rather than just an individual productivity tool.”

Jackie Vullinghs, Partner

“Claude Cowork helps teams do work at a scale that was hard to justify before. The human role becomes validation, refinement, and decision-making. Not repetitive rework.”

Joel Hron, CTO

PrevPrev

0/5

NextNext

eBook

##

## Getting started

Claude Cowork and Claude Code on Desktop are generally available today on all paid plans on macOS and Windows. Download the Claude desktop app at claude.com/download.

For admins deploying Claude across your organization: configure role-based access controls, group spend limits and OpenTelemetry from the admin console. Claude Cowork usage data is available in the admin dashboard, and the Analytics API is documented here. 

For a deployment walkthrough, join our April 16th webinar with PayPal.

FAQ

No items found.

More about Cowork

More about CoworkMore about Cowork

## Related posts

Explore more product news and best practices for teams building with Claude.

Apr 14, 2026

### Redesigning Claude Code on desktop for parallel agents

Claude Code

Redesigning Claude Code on desktop for parallel agentsRedesigning Claude Code on desktop for parallel agents

Redesigning Claude Code on desktop for parallel agentsRedesigning Claude Code on desktop for parallel agents

Apr 14, 2026

### Introducing routines in Claude Code

Product announcements

Introducing routines in Claude CodeIntroducing routines in Claude Code

Introducing routines in Claude CodeIntroducing routines in Claude Code

Apr 9, 2026

### The advisor strategy: Give agents an intelligence boost

Product announcements

The advisor strategy: Give agents an intelligence boostThe advisor strategy: Give agents an intelligence boost

The advisor strategy: Give agents an intelligence boostThe advisor strategy: Give agents an intelligence boost

Jun 25, 2025

### Turn ideas into interactive AI-powered apps

Product announcements

Turn ideas into interactive AI-powered appsTurn ideas into interactive AI-powered apps

Turn ideas into interactive AI-powered appsTurn ideas into interactive AI-powered apps

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
