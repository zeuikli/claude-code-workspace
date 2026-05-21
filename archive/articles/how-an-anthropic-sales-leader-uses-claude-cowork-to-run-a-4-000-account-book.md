---
title: "How an Anthropic sales leader uses Claude Cowork to run a 4,000-account book"
url: https://claude.com/blog/how-an-anthropic-sales-leader-uses-claude-cowork-to-run-a-4-000-account-book
slug: how-an-anthropic-sales-leader-uses-claude-cowork-to-run-a-4-000-account-book
fetched: 2026-05-21 05:07 UTC
---

# How an Anthropic sales leader uses Claude Cowork to run a 4,000-account book

> Source: https://claude.com/blog/how-an-anthropic-sales-leader-uses-claude-cowork-to-run-a-4-000-account-book




# How an Anthropic sales leader uses Claude Cowork to run a 4,000-account book

Travis Bryant, Head of US Mid-Market GTM at Anthropic, shares how he uses Claude Cowork to prepare customer briefs and weekly forecasts, and to run an overnight territory scoring that used to take cross-functional teams hundreds of hours.

‍

Travis walks through how he uses Claude Cowork to prepare customer briefs, pull weekly forecasts, and score 4,000 accounts overnight.

Join the webinar

Join the webinarJoin the webinar

- Category

Enterprise AI

- Product

Claude Cowork

- Date

May 20, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-an-anthropic-sales-leader-uses-claude-cowork-to-run-a-4-000-account-book

In sales leadership, the job is to make judgment calls: where to invest the team's hours, and what to tell leadership about how the quarter is shaping up. The work surrounding those decisions, like assembling data from four systems and re-baselining numbers every time numbers refresh, used to eat most of my week. Claude Cowork has shifted that balance: it handles the data assembly and reformatting, so I can dedicate more time to customer conversations and strategic decisions.

I run US mid-market go-to-market at Anthropic, which means I'm responsible for 4,000 accounts split between mid-market tech and industries. Mid-market includes tech companies that aren't startups anymore, but aren't large enterprises yet either. Industries cover everything else, from financial services and healthcare to retail and manufacturing.

My work spans three cadences: daily customer call prep, the weekly forecast rollup to Anthropic's sales leadership, and quarterly territory and prospect-list work across the full 4,000-account book. Each is a lot of work on its own and doing all three well used to be impossible.

I tried Claude Code, but never got comfortable with working with the terminal. Claude Cowork wraps the same engine in an interface I can work in. That was when it clicked: I finally had a way to hand off the work and trust it would get done.

## What I run in Claude Cowork every day, week, and quarter

Most of the time I save with Claude Cowork falls into about 90 minutes of small daily wins, or micro-optimizations, that it runs for me.

Each morning, a scheduled task runs a skill that scans my Google Calendar and books a conference room for any external meeting that's missing one. A second skill runs customer call prep before each meeting, pulling spend from BigQuery and pipeline status from Salesforce into a brief that's waiting for me when I open my laptop. The scheduler was the bigger unlock than the skill itself. Once prep stops being a slash command I have to remember and starts running on its own, I stop forgetting it.

The Friday forecast is the next tier up and it saves me about three hours per week. A scheduled skill pulls opportunity records and submitted commits from Salesforce's Forecast tab, token spend from BigQuery, and notes from a handful of internal documents. It assembles a single-page web report in the exact format Anthropic's sales leadership wants to read: top-line metrics, top deals, movers and decliners, and the forecast snapshot rolled up from each first-line manager. The skill deploys the page to an internally shared link before Monday's forecast call. My Monday job is to add commentary: Claude builds the what; I do the why.

The biggest project I've run through Claude Cowork was account propensity scoring for the whole mid-market segment. Every fiscal year, every account in the book needs a score that helps the assigned AE prioritize the territory. In previous companies and roles, work like this ran for hundreds of hours across RevOps, FP&A, and marketing. I did it in one night.

I started by defining two five-dimension scoring rubrics with Claude: one for tech accounts and one for industries. The dimensions for tech were agent opportunity, internal transformation, AI commitment, white space against existing spend, and industry fit. Industries used a different rubric, with dimensions like knowledge-worker density (which can be very high at law firms, for example, and lower in manufacturing because so many employees are on the shop floor), and public AI commitments measured by mentions on the company's open jobs page.

Once the rubric was set, I pointed Claude Cowork at the 4,000-account list. Claude Cowork ran overnight, scoring each account one by one with deep web research, Salesforce data, and BigQuery data, producing a numerical score and a written rationale for every dimension. Then I asked Claude Cowork to build an interactive dashboard from the results. Each AE clicks into their territory's pie slice and sees their accounts ranked by score, with the rationale generated for each dimension. Hovering over an account surfaces potential use cases and comparable case studies for prospecting. The dashboard turned the scores from a data exercise into a working sales tool.

Territory scoring dashboard, shown here with demo data.

None of the prompts were technical. The pattern was: tell Claude what dimensions to score on, run a test territory, check the output, adjust the weights ("I think D4 is probably weighted a little heavy; bring it down a bit"), run the next territory. 

## Why Claude Cowork works for me

What made Claude Cowork stick for me is the interface. Prompts read like English sentences, outputs land in formats I already work in (docs, web pages, and Salesforce updates), and the human-in-the-loop pattern is built in so Claude proposes and I approve before anything ships. 

Sales is full of people who got into the job for the customer conversations. Claude Cowork can give them back the hours to do just that.

## Where sales teams should start

Two patterns from my own week are worth taking back to a sales team.

The first is to put prep on a schedule. Scheduled tasks run themselves; I don’t have to remember to do any of the small daily tasks that end up taking a fair bit of time collectively. Encoding the team's required format into the skill matters too: my forecast lands in the exact layout my leadership reads, so my Monday time goes to commentary instead of formatting. If you want a starting point for your setup, Anthropic's Sales plugin ships with baseline skills, including the call prep one. Those are meant to be customized to match how your team actually works.

The second is to run big strategic projects as overnight Claude Cowork routines. The 4,000-account scoring run is the showcase example, but the same shape works for TAM sizing, account research, comp benchmarking, anything historically deferred because no team had the hours for it. You can refine the prompt the next morning, if needed.

Before Claude Cowork, data assembly, report formatting, and the rebaseline when a number changes used to fill my week. Now, I have the hours back to dedicate to the strategic and customer-relationship work that pushes the needle.

Learn more about how sales teams use Claude Cowork and get started today.

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

May 15, 2026

### Deploying Claude across the legal industry

Enterprise AI

Deploying Claude across the legal industryDeploying Claude across the legal industry

Deploying Claude across the legal industryDeploying Claude across the legal industry

May 14, 2026

### How Claude Code works in large codebases: Best practices and where to start

Enterprise AI

How Claude Code works in large codebases: Best practices and where to startHow Claude Code works in large codebases: Best practices and where to start

How Claude Code works in large codebases: Best practices and where to startHow Claude Code works in large codebases: Best practices and where to start

Dec 8, 2025

### How Anthropic's legal team cut review times from days to hours with Claude

Enterprise AI

How Anthropic's legal team cut review times from days to hours with ClaudeHow Anthropic's legal team cut review times from days to hours with Claude

How Anthropic's legal team cut review times from days to hours with ClaudeHow Anthropic's legal team cut review times from days to hours with Claude

May 5, 2026

### Deploying Claude across financial services

Enterprise AI

Deploying Claude across financial servicesDeploying Claude across financial services

Deploying Claude across financial servicesDeploying Claude across financial services

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
