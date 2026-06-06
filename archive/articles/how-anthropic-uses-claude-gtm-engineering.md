---
title: "How one Anthropic seller rebuilt his team&#x27;s workflows with Claude Code"
url: https://claude.com/blog/how-anthropic-uses-claude-gtm-engineering
slug: how-anthropic-uses-claude-gtm-engineering
fetched: 2026-06-06 04:51 UTC
---

# How one Anthropic seller rebuilt his team&#x27;s workflows with Claude Code

> Source: https://claude.com/blog/how-anthropic-uses-claude-gtm-engineering




# How one Anthropic seller rebuilt his team's workflows with Claude Code

Before he joined Anthropic, Jared Sires, GTM product manager, had never opened a terminal. Now Anthropic’s Sales team uses his tools.

- Category

Claude Code

Enterprise AI

- Product

Claude Code

Claude Cowork

- Date

June 5, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-anthropic-uses-claude-gtm-engineering

Before joining Anthropic in 2024, Jared Sires had never written a line of code. And why would he? He was a startup account executive. 

As is often the case at fast-growing companies, Jared’s book quickly grew to 600 or 700 accounts. With 10 to 15 customer calls a day and an expanding account list, Jared found himself at his desk, answering customer emails until 9 or 10 p.m. every night. 

"It was almost impossible to manage my inbox," he says. "And doing outbound on top of that, you don’t really know where to focus."

Jared turned to Claude Code for help. With no coding experience, he created CLAFTS, short for Claude Drafts: an application that lives inside Gmail and uses the Claude API to draft replies to customer emails. It took multiple iterations, but eventually Jared estimates CLAFTS was saving him two to three hours a day. He shared it in Slack the next morning, and within 24 hours, others from the sales organization had started using it with similar results. 

That led to a shift in Jared’s role at Anthropic: today, he is product manager of the go-to-market team, a role focused exclusively on identifying problems in how the Anthropic sales organization operates and building Claude-powered solutions to fix them. In this new role, Jared has built tools that automate customer communications, research customer backgrounds before calls, and generate follow-up emails from meeting transcripts. He then packages them as a plugin inside Claude Cowork so the whole sales team can use them. 

He describes the shift in his career as “the most empowering thing I’ve ever experienced.”

Here's how Jared used Claude to handle his inbox at scale, what he's building next, and best practices GTM teams can take from his approach.

## A sales rep buried in administrative tasks

Email volume wasn’t the only challenge Jared faced as an account executive. Anthropic ships product changes every 24 to 48 hours, and customer questions tend to land on the most recent details: batch API SLAs, prompt caching discounts, model pricing, SDK behavior. Answering them well meant searching across Slack, Google Docs, internal knowledge bases, and the developer documentation—and doing it again day after day, with a slightly different set of facts.

"Having to relay technical documentation to customers is pretty hard, especially here at Anthropic when your products evolve so quickly," Jared says.

One of his first experiments with Claude was narrow and practical. Using Apps Script (Google's lightweight development platform) and Claude, Jared pulled product usage data from internal systems and had Claude rank his accounts each morning by how fast they were growing. 

"Each day Claude would give me a brief on who I needed to focus on based on how much they were using," he says. With 700 accounts in his book, the daily brief helped him determine where to spend his outbound time.

## Developing CLAFTS

The harder challenge was Jared’s inbox and the late hours he had to spend responding to emails. 

With Claude Code, he started to develop a system that drafts replies to customer emails in his voice. "Claude Code, having the terminology 'code' at the end of it, made me feel a little bit intimidated just to even start," he says. "But after a certain time frame, I understood the power of it being able to hook up to my computer and answer things about files on it."

CLAFTS is built on roughly 4,300 lines of code, almost all of it written by Claude Code. It pulls context from a shared Google Drive folder and other third-party tools, references Anthropic's public documentation through web search, and matches Jared's writing style. By the time he opens his drafts folder at the end of the day, the responses are waiting for review.

Whenever Anthropic ships a product change, the documentation reflects it and Claude picks up the change on the next draft. "Claude is able to use web search to understand our latest documentation from our website and reference that material when generating emails," Jared says. "I don't need to keep all of that in my head."

Out of the box, Claude’s writing tended to be longer and heavier on hedging phrases, so Jared reworked the system prompt until the drafts matched his own writing style. "I've probably gone through hundreds of iterations with CLAFTS in the system prompt to generate different pieces of writing for me," he says.

Next, he developed the CLAFTS Tones feature, which uses pattern matching to mimic his voice across different relationships. Customers, peers, and family threads all read differently, and the drafts adjust to each.

Jared tested the feature by writing himself a sequence of increasingly angry emails on his personal account. Claude picked up the tone, then refused to keep going.

"Claude started to mimic that, and at some point I started to have refusals because Claude didn't want to generate angry emails to customers," he says. "That was when I knew CLAFTS Tones was working."

### Measuring the impact of CLAFTS

While CLAFTS saves Jared 10-15 hours per week, the shift he cares about most is the accuracy of the work. With Claude pulling current product details from documentation on every draft, the answers customers receive are tied to whatever shipped most recently rather than to whatever Jared happened to remember.

"Before CLAFTS, I felt like I was doing more administrative work than actually spending time with customers," Jared says. "After CLAFTS, I was actually able to do more of what I wanted to do, which is sales."

## Scaling Anthropic’s GTM toolkit 

Beyond Jared, a BDR regularly working past midnight emailing customers, John Albert, helped co-build Clafts. The rest of the business development team came on board once they saw their teammate was getting hours back each day. From there, they did most of the evangelism themselves.

The next set of tools Jared built was a set of skills bookending his calendar: daily brief and daily recap.

Each morning, the daily brief skill reads his calendar, runs a web search on whoever he's meeting with, and produces talking points before the first call. The skill connects to Google Calendar and CRM data through MCP servers, pulling relevant information about each customer.

And at the end of the day, the daily recap skill pulls from Google Docs and meeting notes to draft follow-up emails, similar to CLAFTS.

"You couple those together and you get Claude managing your daily tasks, which essentially becomes an agent," he says. 

Jared’s work now pushes further into agent territory as he’s experimenting with the Agent SDK and chaining workflows where the output of one Claude run feeds the input of the next.

To make sure the tools he builds with Claude Code scale across the wider team he supports, he ships them with Claude Cowork, packaging skills and MCP connectors into a plugin anyone can install in minutes.

Within months of launching the Sales plugin, roughly 80 percent of Anthropic’s sales org was using it. The remaining 20 percent are largely new hires, which Jared considers the next challenge to tackle, since the skills were built specifically to help people ramp faster.

Before the plugin, every new hire used to spend weeks figuring out their own workflow. Now a new hire can install it on day one and have 20-plus skills already wired into the tools they use: Salesforce, Intercom, Gong, Google Calendar, Gmail, Google Drive, and BigQuery.

Two skills anchor the sales team plugin:

-  `/customer-context `pulls a 360-degree account view across all those sources in about 90 seconds. 
- `/pipeline-management` surfaces at-risk deals, forecasting guidance, and progression recommendations.

The package also integrates with Cowork's scheduling feature, which lets reps queue skills to run automatically.

"Our sales people can get back to having meaningful conversations instead of going to update all these different applications,” he says.

## Architecting what’s next 

Jared’s role has changed alongside the tooling. As a GTM Architect, he now sits in design conversations with product engineers and helps shape new tools for Anthropic’s sales team. 

"I feel like with the technical barrier dissolving, I'm almost able to design more products and have senior engineers help me implement to the final stretch," Jared says. "I'm able to augment and do more things."

For sellers wondering whether they could build something similar, his advice is to open Claude Code, find one task that's slowing them down, and ask Claude how to build a solution for it.

"If you told me I was going to be a go-to-market product manager at Anthropic a year ago, I would be pretty surprised," he says. "I never had the technical chops to be in these conversations. With Claude, I'm able to design and build things that don’t just improve my own day-to-day workflows, but also those of my broader team. I have space to work more creatively and strategically, and there’s no turning back."

Get started with Claude today. Stay tuned for more stories in the "How Anthropic uses Claude" series.

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

Jun 3, 2026

### How Anthropic enables self-service data analytics with Claude

Enterprise AI

How Anthropic enables self-service data analytics with ClaudeHow Anthropic enables self-service data analytics with Claude

How Anthropic enables self-service data analytics with ClaudeHow Anthropic enables self-service data analytics with Claude

Jun 3, 2026

### Lessons from building Claude Code: How we use skills

Claude Code

Lessons from building Claude Code: How we use skillsLessons from building Claude Code: How we use skills

Lessons from building Claude Code: How we use skillsLessons from building Claude Code: How we use skills

Jun 2, 2026

### A harness for every task: dynamic workflows in Claude Code

Claude Code

A harness for every task: dynamic workflows in Claude Code A harness for every task: dynamic workflows in Claude Code

A harness for every task: dynamic workflows in Claude Code A harness for every task: dynamic workflows in Claude Code

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
