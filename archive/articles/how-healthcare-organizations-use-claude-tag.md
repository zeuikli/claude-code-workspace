---
title: "How healthcare organizations use Claude Tag | Claude by Anthropic"
url: https://claude.com/blog/how-healthcare-organizations-use-claude-tag
slug: how-healthcare-organizations-use-claude-tag
fetched: 2026-09-15 05:46 UTC
---

# How healthcare organizations use Claude Tag | Claude by Anthropic

> Source: https://claude.com/blog/how-healthcare-organizations-use-claude-tag




# How healthcare organizations use Claude Tag

How Insight Health, Tennr, and Medallion are building human-agent teams with Claude Tag.

- Category

Enterprise AI

- Product

Claude Tag

- Date

September 14, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-healthcare-organizations-use-claude-tag

- Author(s)

Camy Pearson

Maria Howe

Araba Koomson

Healthcare organizations are using Claude Tag (beta), which brings Claude into Slack as a teammate, to help them triage production alerts, maintain internal tools, and answer questions about payer rules. While Claude Tag isn't yet covered by Anthropic's Business Associate Agreement, several healthcare organizations are using it today in channels and with connectors that never touch protected health information (PHI).

Mention @Claude in a channel and it reads the thread, uses the tools you've connected, does the work, and reports back. It remembers what happens in each channel, so long-running work never needs re-explaining, and it can watch a channel and step in on its own when you let it.

Admins decide where Claude Tag works and what it can reach, so healthcare teams can keep Claude Tag out of channels and systems that hold PHI:

- Claude Tag can be off by default and enabled only in approved channels, with DMs disabled and connectors scoped per channel. 
- Claude Tag doesn't read all of Slack – instead, it only sees what a workspace member sees. While it can read the public channels of the workspace and search them by keyword, it doesn’t have access to private channels it hasn’t been invited to. 
- Access bundles let a team connect data sources like its codebase and issue tracker in one channel while the EHR, clinical systems, and patient communications are inaccessible. Learn more about Claude Tag’s agent identity access model and its full architecture in the security and data handling docs, and you can read more about best practices for healthcare organizations, here.

Enterprise organizations that activate Claude Tag and link it to GitHub receive $25,000 in Claude Tag credit ($2,500 for Team organizations with 10+ seats); note that these credits expire October 1, 2026. See the credit details, here.

Here’s how Insight Health, Tennr, and Medallion are using Claude Tag to build human-agent teams today.

#### Running incident response at Insight Health

Insight Health builds MagicDocs, an AI referral coordinator for specialty medical practices. MagicDocs reads inbound patient documents (faxes, referrals, prior-authorization requests, labs, and medical records), extracts the clinical details, matches each document to the right patient, and writes structured data into the EHR. The company serves 1,100+ practices across 56 specialties.

As Insight Health's customer base has grown, production alert triage has eaten into time its lean engineering team would rather spend on higher-value work. So for the past three months, the company has run Claude Tag in its PHI-free engineering and support channels, where it investigates production alerts, files and de-duplicates tickets, reviews PRs, and carries context from one thread to the next.

In their high-volume production alerts channel, they’ve paired Claude Tag with a second agent, Zeus (built by Insight Health on the Claude Agent SDK), to take an incident from first notification to a tested fix. The two agents have deliberately different access: Claude Tag sees the codebase and Linear, so it knows the code patterns and ticket history; Zeus runs on the company's BAA-covered Claude API organization, so it can query production data, masking PHI before the data reaches Slack. When an alert arrives, the agents investigate it–querying production data, checking it against the code and recent deploys, and comparing it to past tickets–all while reporting on their progress in the Slack thread. Once they identify the root cause, they open a draft PR and monitor the tests, and finally an engineer reviews and merges. Claude Tag's channel memory is valuable here: it recognizes a new complaint as a known issue with a fix pending, recalls investigations from weeks earlier, and follows standing instructions unprompted.

"Everyone in the Slack channel sees both agents' reasoning and how they divide the work," said Saran Siva, Insight Health's co-founder and CTO. "That transparency builds trust and teaches the team how to get the most value out of the agents." Since Claude Tag went live, 97% of alerts in Insight Health's critical alert channel have closed without an engineer having to step in, freeing the team to focus on core product work.

Beyond incidents, the Insight Health team uses Claude Tag for hiring, vendor negotiation prep, contract reviews (checking terms against call transcripts), and general business operations.

#### Maintaining internal tooling at Tennr

Tennr is a patient orchestration platform that helps providers get patients into the right care setting faster by automating the intake, documentation, authorization, and scheduling work that otherwise stalls care. Claude Tag lives in its internal tooling, and helps non-technical teams set up and maintain custom internal applications.

At fast-growing companies like Tennr, internal tools die as fast as they are built because nobody has the bandwidth to maintain them. In July 2026, Tennr took a different approach as it built internal tools. It launched recruiting.tennr.com, an internal offer presentation portal built in Claude Code, and made Claude Tag its primary maintainer through a dedicated Slack channel. Now the people who actually use the tool (recruiters, People team members, hiring managers, and RevOps) @-mention Claude with requests in plain language English, and Claude ships the code change, deploys it, and reports back. They can iterate on the tool directly, without pulling engineers off product work.

In roughly a month, the team shipped 15+ tickets this way: a benefits deep-dive section built from an uploaded PDF one-pager, a "Sign your offer here" banner linking to Dropbox Sign, target bonus fields, and self-service admin controls. When a publicly exposed copy API was flagged, Claude locked it down the same day. When an Ashby import bug kept resetting equity on live offers, Claude fixed the bug and propagated the corrected values. When a separate bug briefly showed candidates variable comp incorrectly, Claude posted a channel-wide notice with the affected window and remediation without being asked. It also wrote the onboarding documentation and handles permission management for the tool.

The team taught Claude its own ops conventions in-channel, including an emoji status legend, and a ticket format with numbered tickets, requester, commit link, screenshots, and a live test link. Claude adopted them going forward. Recruiters were filing what amounted to engineering tickets in natural language, sometimes just a screenshot, and getting production changes back within the hour. "Claude Tag is what makes internal tooling viable at all," said Abe Griffiths, Tennr's VP of Business Operations and Strategy. "With Claude as the steward of the tool via a Slack channel, the people who actually use the tool can iterate on it directly, without pulling engineers off product work."

Rollout was quick because the groundwork existed. Tennr only allows PHI in a limited set of private channels, so adding Claude Tag broadly didn't introduce a new data problem. What made Claude Tag easy to say yes to was per-channel scoping.

"In the offer tool channel, we want Claude to be proactive: fix problems, modify code, skip PR reviews, and ship," Griffiths said. "That posture would obviously be wrong for, say, a Product or Eng channel where Claude's role is closer to info gathering or keeping us organized. Being able to draw those lines channel by channel meant we could give Claude real autonomy where it's low risk without granting it everywhere."

#### Accumulating payer expertise at Medallion

Medallion automates provider credentialing, licensing, and payer enrollment for healthcare organizations. Much of that work depends on arcane, undocumented rules: which payers require a minimum number of credentialed providers before a group can enroll, state-specific regulations, and dozens of similar questions engineers need answered before they can codify a process into the product. Historically, those answers lived with a small group of in-house healthcare domain experts, creating an ongoing human bottleneck for core product development decisions.

Claude Tag now sits in that loop and breaks the knowledge silo. When an engineer asks a payer-rules question in Slack, Claude Tag answers from past expert responses, historical data, and unstructured internal resources. The expertise accumulates in the channel instead of in one person's head.

"When it isn't confident, it tags in the right expert, and their response becomes the basis for future answers on related topics," said CTO Armaan Sarkar.

What made them comfortable rolling out Claude Tag? Sarkar points to picking the right PHI-free workstreams, expert review, and automated validation. Claude Tag operates at the policy level: the questions are about payer rules and process, not individual patients or providers. It doesn't answer alone: experts provide oversight and corrections, and every exchange happens in a Slack channel anyone at the company can audit. And the outputs get checked downstream, since Medallion's systems use these policies to take actions that are audited and validated on their own.

#### Getting started

The teams above all started in the same place: engineering, product, ops, or recruiting channels, with one or two connectors, working in open threads rather than DMs so the whole team could review and pick up context.

Review the Claude Tag best practices for healthcare organizations, here, then start with one channel. Turn Claude Tag on for an alert or support-engineering channel, connect GitHub, and let the team work with it for two weeks before widening the allowlist. 

Get started with Claude Tag.

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

Sep 14, 2026

### Deploying AI from pilot to production

Enterprise AI

Deploying AI from pilot to productionDeploying AI from pilot to production

Deploying AI from pilot to productionDeploying AI from pilot to production

Sep 10, 2026

### What 1,000 small business owners taught us about AI

Enterprise AI

What 1,000 small business owners taught us about AIWhat 1,000 small business owners taught us about AI

What 1,000 small business owners taught us about AIWhat 1,000 small business owners taught us about AI

Sep 14, 2026

### Agentic coding is straining CI. Here’s how we scaled test impact analysis at Anthropic

Claude Code

Agentic coding is straining CI. Here’s how we scaled test impact analysis at AnthropicAgentic coding is straining CI. Here’s how we scaled test impact analysis at Anthropic

Agentic coding is straining CI. Here’s how we scaled test impact analysis at AnthropicAgentic coding is straining CI. Here’s how we scaled test impact analysis at Anthropic

Jun 24, 2026

### Building effective human-agent teams

Enterprise AI

Building effective human-agent teamsBuilding effective human-agent teams

Building effective human-agent teamsBuilding effective human-agent teams

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
