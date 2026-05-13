---
title: "How Anthropic&#x27;s cybersecurity team built a threat detection platform with Claude Code"
url: https://claude.com/blog/how-anthropic-uses-claude-cybersecurity
slug: how-anthropic-uses-claude-cybersecurity
fetched: 2026-05-13 04:41 UTC
---

# How Anthropic&#x27;s cybersecurity team built a threat detection platform with Claude Code

> Source: https://claude.com/blog/how-anthropic-uses-claude-cybersecurity




# How Anthropic's cybersecurity team built a threat detection platform with Claude Code

Jackie Bow, technical lead for Anthropic's Detection Platform Engineering team, shares how her team uses Claude Code to build tools that automate alert triage, accelerate investigations, and transform how security analysts work.

- Category

Claude Code

- Product

Claude Code

- Date

May 12, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-anthropic-uses-claude-cybersecurity

For her entire career, Jackie Bow imagined tools that could tap into the context that actually matters—not just logs and alerts, but the Slack conversations, internal docs, and institutional knowledge that tell you whether something is a real threat or just noise—without needing humans to take the load of combing through the data manually.

When she joined Anthropic, she finally got the chance to build them—with Claude as her collaborator. Jackie leads Anthropic's Detection Platform Engineering team, which focuses on defensive cybersecurity: detecting threats and responding to potential breaches rather than probing for vulnerabilities. The work involves monitoring systems for suspicious activity, triaging security alerts, and investigating anomalies before they become incidents.

For a company building increasingly capable AI models, this work is foundational. Anthropic's Responsible Scaling Policy ties product releases directly to security commitments, meaning Bow's team helps determine what the company can safely ship.

"I feel like it's the golden age of the security engineer," says Bow, who serves as Technical Lead for Anthropic's Detection Platform Engineering team. "I can finally build the tools I always wished I had."

## The problem: Drowning in data and alerts

Security leaders know the pattern all too well.

An alert fires. An analyst opens their terminal and begins the familiar ritual of jumping between five or six different tools, each requiring its own query language and mental model. They must maintain expertise across multiple platforms while constantly context-switching between different interfaces and query syntaxes.

Each investigation becomes an exercise in data archaeology, piecing together fragments scattered across disconnected systems. For most teams, simple investigations consume hours, and complex ones can stretch across days. 

"There's only so many alerts a human can look at in a day before they start to drop off in how detailed they're going into it," Jackie explains.

Her team decided to do something about it. They asked themselves: what's draining our energy? What feels repetitive? What prevents us from doing impactful work?

The answers were clear. Alert triage could eat up hours before analysts could determine if threats were real. Manual correlation across disconnected systems slowed everything down. And the constant context-switching between query languages and interfaces created cognitive overhead that compounded throughout the day.

As the company grows, so does the attack surface, and so do the demands on the security team.

"We can't scale to meet the needs of Anthropic without augmenting with something like Claude," Jackie says.

## The solution: Claude Looks Up Evidence (CLUE)

Over several months, Bow's team built CLUE, a detection and response platform that reimagines how security teams investigate threats. Rather than adding another dashboard to the stack, CLUE provides a natural language interface powered by Claude that connects directly to Anthropic's internal systems via tool use.

Building CLUE with Claude Code collapsed the traditional software development timeline exponentially, freeing them up to build this system in addition to tackling their day-to-day work. Bow's team had a proof of concept running in a day. Design documentation, development steps, and implementation finished within a week.

"So much of what we built was us talking to Claude Code," Jackie recalls. "It was both a design partner and collaborator."

The moment that shifted her perception came when she asked Claude Code to add a button to the CLUE interface. She expected the familiar slog of JavaScript frameworks and CSS debugging. Claude Code implemented the feature immediately, and did it better than she would have.

"That was when I realized I'm not bound by my own technical limitations anymore. I can build whatever I can think of," she says.

### CLUE Triage

When alerts flow in, CLUE Triage performs the first-pass triage before a human analyst ever sees them. Claude uses tools to enrich each alert with additional context from across Anthropic's systems, including Slack messages, internal documentation, code repositories, and data warehouses. It assigns dispositions: false positive, true positive, malicious, or expected behavior. Each alert receives a confidence score so analysts know where to focus their attention.

This enrichment step solves a problem any security analyst recognizes: alerts arrive as isolated signals. A failed login attempt. An unusual API call. A configuration change. Without context, these events are just noise. With context (who the user is, what they were working on, whether this matches patterns from their team) clear signals emerge.

"That internal context is the missing piece that really helps alerts be contextualized for your environment," Jackie explains.

### CLUE Investigate

With CLUE, security analysts can now query all security-critical logs using natural language. Want to know "What are all the failed logins for this system over the past day?" Just ask CLUE, and Claude executes the necessary SQL queries.

"Claude is much better at writing precise queries than humans are," Jackie says. The tool runs an agentic loop: an orchestrator issues commands to sub-agents that execute queries in parallel, gather findings, and synthesize results into coherent investigation summaries. What would take hours of manual correlation work now runs in three to four minutes.

The numbers bear this out. Across investigations, CLUE averages 25 tool calls and nearly 11 queries per session—far more than an analyst could reasonably execute manually, and with higher precision. Each of those tool calls would otherwise require opening a separate console or switching to a different interface.

The real differentiator, however, is internal context. CLUE connects directly to Anthropic's systems via tools, giving Claude access to institutional knowledge that external security platforms would never be able to access. When an alert fires, Claude can check Slack to see if the team discussed planned maintenance. It can query the data warehouse to understand baseline behavior. It can examine code repositories to understand what a service actually does.

### Data governance review

The team demonstrated CLUE's capabilities with a common data governance scenario: checking whether three contractors had accessed any documents they shouldn't have over the past two months.

According to Bow, this type of investigation would typically take at least half a day of manual work, including querying access logs, cross-referencing permissions, and reviewing document classifications. With CLUE, Claude reads the request, formulates a plan, and generates verbose queries that abstract the technical complexity. The investigation is over in minutes, producing a summary and recommendations with full transparency into every query run.

## Measuring the impact

When the team set out to build CLUE, they wanted to understand not just whether it felt faster, but whether they could quantify the results.

Fewer false positives: Before CLUE Triage, roughly one in three alerts turned out to be false positives. That rate has dropped to 7%, meaning analysts spend their time on signals that matter.*

Broader coverage: Perhaps more important than speed is what the team can now examine. Before CLUE, lower-confidence signals went unexamined because there simply wasn't time. Now, CLUE Triage processes every incoming alert with enrichment, and batch processing handles thousands of signals that would have previously been noise in a dashboard.

Time savings at scale: Based on 30 days of usage, CLUE automated roughly 12,000 queries and 27,000 tool calls—work that would have taken an estimated 1,870 hours (234 person-days) to complete manually. That translates to 5-10x time savings compared to manual triage.*

What they're still learning to measure: Accuracy is harder to quantify than speed. The team reviews CLUE's dispositions and tracks disagreements, but they're still building the feedback loops to understand how often Claude catches something analysts would have missed—and vice versa. The transcripts help: every investigation can be audited for exactly what Claude examined and how it reached its conclusions.

## Where we're headed: letting Claude investigate like Claude

There's a concept in AI research called "the bitter lesson"—the observation that encoding human-specific reasoning into models consistently underperforms compared to giving models general capabilities and letting them find their own approaches. Bow and her team have been thinking about what this means for detection and response.

"Early in CLUE's development, the team debated how much to constrain Claude's investigation paths," says Bow. "The SOAR-era instinct said: build playbooks, define every step, make the process deterministic. But we kept noticing something. When we gave Claude latitude to explore—access to tools and a goal, rather than a rigid sequence—it often took investigation paths we wouldn't have prescribed. Sometimes those paths surfaced context we'd have missed."

The key is giving Claude boundaries (what tools it can use, what data it can access) while leaving the strategy open. This insight shapes where they're taking CLUE next.

From reactive to proactive: Today, CLUE responds to alerts. An event fires, Claude investigates. But the architecture supports something more ambitious: continuous exploration. Instead of waiting for detection rules to trigger, Claude agents could actively hunt for suspicious patterns—anomalies that don't match any rule the team has written, behaviors that look normal individually but unusual in aggregate.

Learning from itself: The team stores every investigation transcript. That corpus is becoming a knowledge base Claude can query for patterns in how past investigations unfolded. Over time, CLUE develops organizational memory that no human analyst could maintain.

Embracing non-determinism: Traditional security tooling treats inconsistency as a bug. CLUE treats it as a feature. The same alert might get investigated differently on different days, and that's fine—sometimes the second path finds something the first missed. The team is experimenting with running multiple investigation strategies in parallel and comparing results.

"The bitter lesson for security operations? We spent years building systems that encoded how humans investigate. The next generation of tools should give models the capability to investigate and let them find better approaches than we would have prescribed," Bow adds.

Check out our best practices for preparing your security program for AI-accelerated offense.

Get started with Claude Code today. Stay tuned for more stories in the "How Anthropic uses Claude" series.

*These results were generated using Claude Sonnet and Opus models.

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

May 1, 2026

### How a non-technical project manager built and shipped a stress management app with Claude Code in six weeks

Claude Code

How a non-technical project manager built and shipped a stress management app with Claude Code in six weeksHow a non-technical project manager built and shipped a stress management app with Claude Code in six weeks

How a non-technical project manager built and shipped a stress management app with Claude Code in six weeksHow a non-technical project manager built and shipped a stress management app with Claude Code in six weeks

Apr 30, 2026

### Lessons from building Claude Code: Prompt caching is everything

Claude Code

Lessons from building Claude Code: Prompt caching is everythingLessons from building Claude Code: Prompt caching is everything

Lessons from building Claude Code: Prompt caching is everythingLessons from building Claude Code: Prompt caching is everything

Apr 29, 2026

### Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

Agents

Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and WarpClaude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and WarpClaude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

Apr 28, 2026

### Onboarding Claude Code like a new developer: Lessons from 17 years of development

Claude Code

Onboarding Claude Code like a new developer: Lessons from 17 years of developmentOnboarding Claude Code like a new developer: Lessons from 17 years of development

Onboarding Claude Code like a new developer: Lessons from 17 years of developmentOnboarding Claude Code like a new developer: Lessons from 17 years of development

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
