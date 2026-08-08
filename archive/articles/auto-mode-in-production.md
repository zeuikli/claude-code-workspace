---
title: "Running auto mode in production | Claude by Anthropic"
url: https://claude.com/blog/auto-mode-in-production
slug: auto-mode-in-production
fetched: 2026-08-08 02:52 UTC
---

# Running auto mode in production | Claude by Anthropic

> Source: https://claude.com/blog/auto-mode-in-production




# Running auto mode in production

How the teams at Nuro, Gusto, and Garner Health use auto mode to balance speed and safety at production scale.

- Category

Claude Code

- Product

Claude Code

- Date

August 7, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/auto-mode-in-production

- Author(s)

Molly Vorwerck

Auto mode is now the default setting in Claude Code. Instead of asking you to approve every command an agent wants to run, a classifier evaluates each action and blocks ones that look potentially harmful. 

Auto mode’s design resolves a common agentic coding tradeoff: speed vs. safety. Reviewing every command keeps a human in the loop, but once sessions stretch to hours or multiply in parallel, that oversight becomes the bottleneck. Skipping permission checks entirely is faster—and it’s also how prompt injection, scope drift, and the occasional deleted production resource get through. 

Auto mode closes most of that gap. In internal evaluations, the classifier caught more dangerous actions than developers did when clicking through permission prompts by hand, and its performance held up under third-party red-teaming.  And because sessions pause less often, Claude works 9x longer between interruptions than under the previous default—across all Claude Code usage. 

To see how auto mode holds up in production, we spoke with teams at Nuro, Gusto, and Garner Health about how and why they use auto mode as their daily driver to balance speed with safety in their production environments. 

### Powering longer running autonomous agents at Nuro

Nuro, the physical AI company developing universal Level 4 autonomous driving technology, adopted Claude Code in late 2025, and by March it was the most popular agentic coding tool at the company. 

Before auto mode shipped, staff software engineer Kai Zhou had already started prototyping an internal stand-in: a hook that sent each pending action to a small model, auto-approved the routine 90 percent of the time, and routed anything sensitive to Slack for a human to review. The prototype answered a real tension: engineers hated babysitting approval prompts, but from a company security and legal standpoint, skipping permissions outright was too dangerous to sanction. When auto mode shipped, Kai shelved the side project. 

Today, Kai runs auto mode for everything he writes. 

"I don't want to sit there and click approve all the time," said Kai. "I use auto mode for 100 percent of my coding work. Most of the time, I open three or four sessions running auto mode in parallel and just check in when I need to.”

The exception is work that touches other teams. For instance, when Claude Code reviews a Pull Request on his behalf, Kai switches back to interactive mode and reviews each one before it goes out.

Auto mode doesn’t run unconstrained, either. Nuro leans heavily on skills, and engineers deny the most dangerous commands, like recursive deletes, outright in their settings. The classifier makes its judgment calls inside those guardrails.

The bigger auto mode unlock, however, has been the ability to kick off work that keeps running after engineers are done for the day. Specifically, Kai’s team uses auto mode to power long-running research agents that hill-climb the evaluation metrics behind its autonomous-driving stack: tasks with a clear, measurable signal an agent can iterate against on its own. 

Overnight, an agent can study false negatives flagged by the evaluation suite, draft a proposal, run experiments, and keep iterating on the results. The approach extends to any task with a clear evaluation method—another team at Nuro uses it to shrink the memory footprint of a specific binary—because the metric itself tells the agent whether it’s improving or regressing.

"The other day, I kicked off an agent at 10 p.m. and it kept running until 5 a.m.—and it gave me three PRs in the morning," Kai said. "I think it's pretty impressive. Only auto mode enables this kind of workload."

### Shipping PRs faster and safer at Gusto

At Gusto, a leading SMB technology company, the move to auto mode started as a proactive security upgrade.

Martin Emde, who works on the company's AI Dev Tools team, had watched permission fatigue slow the team down. Auto mode gave them the same velocity without sacrificing control or security, and since adoption took hold across engineering, the overall permissions burden has noticeably declined.

Martin has kicked off 2,425 Claude Code sessions since December, with auto mode as his daily driver. Cross-repo work that used to stall on folder-access approvals now runs uninterrupted, and unattended jobs, like compiling daily notes from GitHub, Slack, and Jira, run on their own. In his team’s own analysis, roughly 10% of session transcripts since mid-May 2026 included an auto mode denial, evidence the classifier is doing real work without dragging on legitimate tasks. 

“Auto mode gave us a safer balance between speed and control," Martin said. "We were able to remove the repeated prompts and increase productivity without compromising safety. We can see that auto mode blocks at the right time, which gives us the confidence to move quickly."

Chad Kunsman, a member of Gusto’s AIT Cloud Engineering team, came to the same conclusion from the other direction. His work—endpoint investigations, log audits, connector management, doc ingestion across a stack of MCP servers—runs in short, twenty-minute bursts rather than overnight marathons. He wasn't looking for longer runs; he wanted the hands-off pace of bypass permissions without the exposure of a bad prompt, or a prompt injection, slipping through.

"Given the protection against prompt injection, and the way it checks that what you're doing actually lines up with what you asked for, it's the better choice than bypass permissions and far faster than permission prompts," said Chad.

On the rare occasions the classifier does step in, Chad says it's on the mark. "When it stopped me, it made sense and explained why. It was drifting from what I'd originally asked, and it checked in. It wasn't off base at all."

Chad still steps out of auto mode for his most sensitive work. When a session has its teeth into production infrastructure—Terraform, AWS, direct POST calls against live APIs—he switches to accept edits and verifies each tool call by hand. “You have to weigh the amount of time you’re saving against what it could reasonably make a mistake on, and how catastrophic that would be,” he said. “Ultimately, you’re still responsible for what happens.”

That judgment operates inside a broader defense-in-depth setup: Gusto routes its MCP traffic through a governed proxy layer with tool guards and prompt inspection, so agents work with tightly scoped permissions before auto mode ever weighs in. 

### Accelerating the software development lifecycle (SDLC) at Garner Health

Garner Health, the healthcare technology company, rolled out Claude Code in February to all 550 employees across every function. The tool is wired into all the core systems including Salesforce, Zendesk, and Snowflake, and employees are encouraged to spend about two hours a week automating the most repeatable  parts of their job.

Before auto mode, that scale came with overhead. Evan Magnussen, Garner's platform engineering manager, describes permission management as a tedious cycle of hand-curating approved command lists and watching piped commands get rejected.

Today, Evan and most of his colleagues use auto mode in every session, from researching the codebase to managing external integrations through MCP.

“We've built out a standardized software development lifecycle for the entire engineering organization that is really only possible because of auto mode,” Evan said. “Employees view it as a weight off their shoulders. They don’t have to monitor their agents for hours on end anymore."

That lifecycle runs as a plugin of standardized skills. An agent picks up a task, explores the context it has access to, commits context files to the repository, runs what Evan calls “antagonistic research” to pressure-test its own assumptions, and then moves on to implementation—pausing for a human only when it needs context it can’t find on its own. The research-heavy stages, Evan notes, weren’t possible before auto mode.

Out of the box, the classifier has needed little tuning. Evan’s one adjustment mirrors Kai’s at Nuro: he configured auto mode not to approve actions that communicate with other people, like sending Slack messages or emails. 

“I personally don’t like Claude to just act on my behalf when I’m communicating with another person,” he said. Teams working on core intellectual property—the most skeptical of skipping permissions before auto mode—learned to tune the classifier’s injected prompts to be more or less permissive for their work.

His advice for other enterprises rolling it out? Lean in and build the right controls so that you can empower engineers while ensuring safe deployment. “If we were to say, everyone go build your own workflows, and we have no telemetry, that would be very dangerous,” Evan said. “Because we have the telemetry, because we’ve built out workflows that are relatively standard, we have much more confidence.”

Get started with auto mode in Claude Code.

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

Aug 7, 2026

### Auto mode is now the default in Claude Code for Pro, Max, and Team plans

Claude Code

Auto mode is now the default in Claude Code for Pro, Max, and Team plansAuto mode is now the default in Claude Code for Pro, Max, and Team plans

Auto mode is now the default in Claude Code for Pro, Max, and Team plansAuto mode is now the default in Claude Code for Pro, Max, and Team plans

Aug 6, 2026

### Millennium and Anthropic are building a digital risk analyst with Claude

Enterprise AI

Millennium and Anthropic are building a digital risk analyst with Claude Millennium and Anthropic are building a digital risk analyst with Claude

Millennium and Anthropic are building a digital risk analyst with Claude Millennium and Anthropic are building a digital risk analyst with Claude

Jul 24, 2026

### Claude models explained: choosing the best model for your use case

Enterprise AI

Claude models explained: choosing the best model for your use caseClaude models explained: choosing the best model for your use case

Claude models explained: choosing the best model for your use caseClaude models explained: choosing the best model for your use case

Jul 22, 2026

### Building verification loops in Claude Code with skills

Claude Code

Building verification loops in Claude Code with skillsBuilding verification loops in Claude Code with skills

Building verification loops in Claude Code with skillsBuilding verification loops in Claude Code with skills

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
