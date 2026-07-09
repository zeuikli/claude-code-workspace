---
title: "Using Claude Cowork in marketing operations to automate reporting and campaign building | Claude by Anthropic"
url: https://claude.com/blog/how-anthropics-marketing-operations-team-uses-claude-cowork-to-automate-reporting-and-campaign-builds
slug: how-anthropics-marketing-operations-team-uses-claude-cowork-to-automate-reporting-and-campaign-builds
fetched: 2026-07-09 04:50 UTC
---

# Using Claude Cowork in marketing operations to automate reporting and campaign building | Claude by Anthropic

> Source: https://claude.com/blog/how-anthropics-marketing-operations-team-uses-claude-cowork-to-automate-reporting-and-campaign-builds




# How Anthropic's marketing operations team uses Claude Cowork to automate reporting and campaign builds

Ian Chan and Annabel Custer, in marketing operations at Anthropic, share how they automate work their team used to do by hand across multiple platforms.

- Category

Enterprise AI

- Product

Claude Cowork

- Date

July 8, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-anthropics-marketing-operations-team-uses-claude-cowork-to-automate-reporting-and-campaign-builds

Marketing operations teams spend a meaningful portion of their time keeping the systems behind marketing programs in step with the business. While automation sits firmly in their purview, a lot of the work is anything but: martech tools don’t integrate cleanly with each other, reports are consolidated manually, landing pages get spun up one at a time. 

Ian Chan, on the marketing operations team at Anthropic, used to spend one to two days a week pulling together the weekly marketing metrics review. Annabel Custer, who focuses on campaign operations, used to set up each new event by clicking through Salesforce, HubSpot, Swoogo, and email tools in sequence. Both have now compressed days of manual work into hours by setting up workflows in Claude Cowork.

The recovered hours have shifted the shape of their work. Ian and Annabel now spend less time clicking through systems and more time on enablement, validation, and the underlying data and processes the marketing team relies on as more people across the company pull their own numbers and drive their own programs.

## Generating the weekly marketing metrics report

In a perfect world, every metric in the weekly report Ian prepares for marketing and leadership would live in a dashboard and his job would be to simply put together the narrative. In practice, some metrics are in the dashboard already, while others haven’t yet made it there from the data warehouse, and others haven’t been piped into the warehouse yet. New ones might exist only in a Slack message or a call transcript.

At Anthropic, the business moves faster than a traditional reporting pipeline can keep up with and Ian used to spend a day to two days every week tracking down data and validating it. Claude Cowork now handles most of that data hunt. 

A scheduled task runs every Sunday evening, prompting Claude to read the previous week's review and the latest meeting transcript, check Slack for what the sales team is focused on, query the warehouse, and leave a folder with the numbers and a few suggested focus areas. 

On Monday morning, Ian opens Claude Cowork and pulls the initial report, which contains the metrics tables and suggested headlines, or areas of focus. 

The weekly business review summary is shown here created with demo data and all information anonymized or modified for publication.

Ian reviews them and once he’s confirmed or decided where to focus the narrative, he tells Claude to expand on them with supporting details and examples. Some weeks the team is responding to a sales priority, and others—to a product launch. At the quarter turn, Ian tells Claude to lead with quarterly plans and feeds in the quarterly review doc.

Claude generates the leadership slide from the same data and narrative: what changed, why, and what the teams are doing about it. Any follow-ups become Asana tasks. 

The weekly metrics report, shown here with demo data and all information anonymized or modified for publication, contains key metrics and suggested areas of focus.

When the numbers don’t line up, Claude flags the mismatch instead of guessing. After a reorg on the sales team, for example, marketing's reporting no longer matched theirs. Claude flagged the gap and asked Ian how to handle it.

The process runs on connectors to the marketing platforms and tools the team uses, and three skills that Ian has built and updates continually:

- A prep skill drives the report assembly, including focus, headlines, and expansion with supporting detail.
- A proofreading skill checks every number in the draft against a verified source.
- An action-items skill turns follow-ups into Asana tasks.

At the end of each weekly session, Ian asks Claude to summarize what came up that should go back into the skills. The new sales reorg structure, for example, the corrections he made, or a new way he wanted the headlines framed. In Ian’s case, the entire process, which used to take up to two days of work, takes up to two hours. 

Now, a meaningful share of Ian’s time has moved to helping marketers frame their questions, refine their prompts, and interpret what they get back when they pull their own numbers from Claude. He also has bandwidth to go deeper into the data layer, making sure Claude interprets the numbers, definitions, and regional structures the same way as the data warehouse. 

Human validation has become an integral part of both workstreams—a shift that’s accelerating as Claude automates the mundane manual tasks that have traditionally taken up much of marketing analysts’ time.

## Automating event builds and data imports

Setting up the infrastructure behind marketing campaigns has traditionally been one of the most manual processes in marketing. Every event, webinar, or integrated campaign needs to be set up in the CRM, in the marketing automation platform that runs the email sequences and the automation behind them, and in the event management platform that hosts the registration page and the event landing page. Each of these is typically a different vendor, and the integrations between them are rarely complete.

Before Claude Cowork, Annabel picked up every request from a dedicated Slack channel and worked through the sequence manually. Her new setup is almost entirely handled by Claude. It starts with an intake form where requesters specify the type of help they need: event build, data import, apply-to-attend, or approval support. 

Once an hour, a dispatcher skill reads the channel, picks the most urgent request, stamps the ticket so the work doesn't get duplicated, and hands it off to one of five specialist skills that Annabel has set up to do the required work. It doesn’t do any event setup itself; its job is to decide what runs next, and keeping it separate lets Annabel refine each specialist skill on its own without touching the routing.

The dispatcher skill, edited for publication to show demo data and information, reads the channel and hand off requests to one of five specialist skills that do the required work.

For an event build, which is the most complex request type, an event-build skill handles the full sequence end to end: CRM campaign creation, marketing automation campaign with workflows and lists, event platform setup, email drafting, landing page generation, and all of the integrations between them. 

The event-build skill (excerpted and edited for publication) scripts two Slack updates: when Claude picks up the request, and when the landing page is ready for the requester's review and the audit takes over.

When the build is done, it hands off to a new agent for audit. The audit agent starts with no prior context, submits a test registration on the live landing page, opens the confirmation email in Gmail, and marks the Asana task complete if everything looks right. Annabel reviews each result before it ships. 

This workflow runs on connectors to the marketing platforms and tools Annabel works with, plus a number of skills she's built and updates as she finds new edge cases:

- A dispatcher skill reads the intake channel and routes each request to the right specialist skill below. 
- An event-build skill drives the end-to-end setup across platforms.
- A webinar-landing-page creation skill spins up landing pages for webinars.
- An audit skill, run by a separate fresh Claude instance, verifies the event-build skill's output before the task is marked complete.
- An apply-to-attend skill handles in-flight changes to the registration flow:
- An approval-support skill handles event approvals and sends the appropriate emails at a scheduled cadence.
- A data-import skill scrubs lists and processes attendee data. 

She also keeps a separate "manager" agent open. When a run misfires, she opens the manager and asks it to look at what happened and propose what to adjust. Anything worth keeping goes back into the relevant skill. 

While these automated workflows will become significant time savers in Annabel’s day, her primary motivation to build them was quality of work. As the marketing team scales, marketers cloning event pages from whatever template happens to be nearby can produce bugs, such as confirmation emails surfacing the wrong city name or broken landing pages. With Claude Cowork, she gets consistency across builds, at scale.

As Claude takes on the repetitive parts of campaign operations, Annabel can focus on more strategic projects, like enablement, and automating or optimizing processes and campaign architecture for better insights. 

## Advice for Marketing Ops teams on getting started with Claude Cowork

- Turn repeated corrections into skills. When you find yourself correcting Claude on the same thing more than once, that feedback belongs in a skill. You don’t need to build skills, either: Claude can do that for you.
- Build a proofreading skill first. The proofreading skill checks that every number Claude puts in a report traces back to a verified source.

- Ask Claude to reflect. Claude reads instructions differently than a human writes them, so after the first runs of a new workflow, ask what was difficult about the instructions. Annabel feeds what surfaces back into the skill as part of her broader practice of constantly updating skills.

- Lean on scheduled tasks. Work that runs on its own every Sunday night or every hour is work no one has to remember to do.

‍

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

Jul 8, 2026

### Working at the frontier: How Thomson Reuters builds AI for high-stakes professional work

Enterprise AI

Working at the frontier: How Thomson Reuters builds AI for high-stakes professional workWorking at the frontier: How Thomson Reuters builds AI for high-stakes professional work

Working at the frontier: How Thomson Reuters builds AI for high-stakes professional workWorking at the frontier: How Thomson Reuters builds AI for high-stakes professional work

Jul 7, 2026

### How people are using Claude Cowork

Enterprise AI

How people are using Claude CoworkHow people are using Claude Cowork

How people are using Claude CoworkHow people are using Claude Cowork

Jun 3, 2026

### How Anthropic enables self-service data analytics with Claude

Enterprise AI

How Anthropic enables self-service data analytics with ClaudeHow Anthropic enables self-service data analytics with Claude

How Anthropic enables self-service data analytics with ClaudeHow Anthropic enables self-service data analytics with Claude

May 14, 2026

### How Claude Code works in large codebases: Best practices and where to start

Enterprise AI

How Claude Code works in large codebases: Best practices and where to startHow Claude Code works in large codebases: Best practices and where to start

How Claude Code works in large codebases: Best practices and where to startHow Claude Code works in large codebases: Best practices and where to start

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
