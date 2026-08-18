---
title: "How ABC Legal turned every employee into a builder with Claude Managed Agents | Claude by Anthropic"
url: https://claude.com/blog/how-abc-legal-turned-every-employee-into-a-builder-with-claude-managed-agents
slug: how-abc-legal-turned-every-employee-into-a-builder-with-claude-managed-agents
fetched: 2026-08-18 02:13 UTC
---

# How ABC Legal turned every employee into a builder with Claude Managed Agents | Claude by Anthropic

> Source: https://claude.com/blog/how-abc-legal-turned-every-employee-into-a-builder-with-claude-managed-agents




# How ABC Legal turned every employee into a builder with Claude Managed Agents

ABC Legal transformed their organization’s AI adoption from scattered experiments to a governed fleet of specialized agents with Claude.

- Category

Enterprise AI

- Product

Claude Enterprise

- Date

August 17, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-abc-legal-turned-every-employee-into-a-builder-with-claude-managed-agents

When Brandon Fuller, CTO of ABC Legal, a U.S.-based legal document delivery company, rolled out Claude Enterprise to the company's 1,100 employees earlier this year, something clicked immediately. Teams across the company (service of process, eFiling, and appearance counsel operations, plus marketing, compliance, finance, and more) started building automations on their own, without being asked.

"Our users really flocked to it," Fuller recalls. "They saw the ease of use of connectors and tools, and suddenly we had people all over the organization automating the tasks that had always eaten up their day."

It was exactly the kind of adoption any CTO hopes for. But Fuller saw an opportunity to go further: what if ABC Legal could also run a fleet of AI agents that were versioned, observable, and always on?

That ambition came down to infrastructure. Early agents lived wherever their builder happened to put them, as scheduled tasks on individual desktops. Moving them off personal machines would let them run unattended and give Fuller a single view of what had been built, what it cost, and whether it ran last night.

So he deployed Claude Managed Agents: one common deployment structure, shared workspaces, a single audit and billing surface, and always-on agents in the cloud instead of on a person’s laptop. 

As of July 2026, Fuller and his team at ABC Legal have tracked: 

- 50+ agents built with Managed Agents in production
- Up to ~50% reduction in the cost of the human tasks some agents cover, before heavy optimization
- ~310 employees across every department using Claude for daily work

Here’s how they got there and what they learned in the process.

# From enthusiasm to engineering: treating every agent like software

When they first deployed Claude Managed Agents, Fuller had the team define every agent as code. He believes this is the natural form for an agent to take. As he explains, “an agent is really just structured text, a prompt plus configuration, and anything that is text can live in a repository where the whole company can see it, review it, and improve it.” An agent's prompt, tool list, schedule, credentials, and memory all go into configuration files kept in a git repository alongside the company's software. Nothing about an agent changes except through a pull request someone approves, which gives every agent version history, code review, rollback, and an audit trail.

He spent a week building a starter kit with two templates, stored in dedicated git repositories. One is for event-driven agents, which start the moment something happens, like a new job arriving or a document coming back from a court. The other is for scheduled agents, which run on a timer: hourly, daily, or weekly. Each agent lives in its own folder with a standard structure: a JSON config file, a system prompt in Markdown, deployment scripts, and operational documentation. Merging a change into the main branch deploys the agent automatically. A builder never has to write software. They clone the repo, copy a starter template, tell Claude Code what the agent should do, and get back everything the agent needs: config, prompt, credential store, and memory.

# Bridging the technical divide

Fuller gathered the company’s 15-person steering committee, drawn from finance, marketing, operations, and development (none of them software developers), and had them clone the repository and build Managed Agents using Claude Code.

The goal was to prove that non-developers could build production agents themselves. If every agent had to route through the dev team, that bottleneck would cap how fast the whole company could move. What made it safe is that they were not writing software. Instead, they were filling in configuration and a prompt, and Managed Agents supplied the runtime.

"I had to explain what a PR was to them. A lot of [the non-software engineers] thought it meant running, like a PR, the fastest you can,” he said. “Now they're doing pull requests and sending them to each other."

Within a week, all 15 employees had working agents. Those builders went back to their teams and trained others. Within a month, roughly 50+ agents were running across ABC Legal. Each agent has a name, an owner, and a single job.

## An agent for most stages of the legal document process

ABC Legal now has an agent at most stages of the legal filing process and the operations around it.

The AI Code Reviewer reviews every pull request across four codebases, running multi-model analysis to catch security bugs, performance regressions, and committed credentials. Engineers now wait for its review before merging.

The EvidenceChain™ Delivery Agent took over a weekly chore an account manager used to do by hand. ABC Legal runs a proprietary site, EvidenceChain.com, where courts, plaintiffs, and defendants look up the record of a service completed in the field, including who the process server was, when they attempted it, and photos of the document delivery. One customer wanted specific records pulled from it on an ongoing basis. The agent now pulls a database report for matching jobs, retrieves each PDF with a browser built into the Managed Agent, and delivers it to the customer's FTP server daily. The account manager who set it up had never automated anything, and built it in about an hour by describing it to Claude Code.

The eFiling Rejection Diagnoser fires automatically when a court rejects a filing, reads the job details, checks the court's rules, and posts a diagnosis to Slack in about a minute, work that used to consume hours of an employee’s day. A job-verification agent checks every incoming job against the courts. It navigates a court website in a browser, confirms the hearing or case is filed appropriately and actually occurring on the stated date, then adjusts the job based on what it found, flagging jurisdictions, courts, and statute-of-limitations timeframes. 

The Attorney Coverage Agent works the network of attorneys to get hearings covered, checking availability, emailing them, and reading replies about availability and pricing so a coordinator can confirm coverage. 

In finance, an AR-remittance agent parses a remittance email, builds the NetSuite payment-application file, and posts it to Slack for one-click approval, and then imports it, with a daily agent that renders a capitalize-or-expense verdict on each engineering ticket. Marketing runs a Google Ads analyst that posts a weekly recommendation for the channel lead. In operations, a review agent called Charvis checks completed service jobs and now agrees with the compliance team about 98% of the time.

The Service-Overdue-Nudger works the tier-1 layer of ABC Legal's operational backlogs, the repetitive first pass a person would otherwise do, and drafts tiered daily outreach messages for human approval.

# Making the agents smarter: harvest, tune, repeat

ABC Legal's agents work under human supervision, posting what they did or what they recommend to Slack, where people reply in threads and react with emoji.

Hank, an internal code review agent, posts every review to a shared Slack channel. Each entry names the pull request and the counts that came out of it so the trail of what the agent decided is public and searchable.

Fuller saw all that reaction data as a training signal going to waste. Not every agent needs the signal, though. Most of the fleet are single-task runners whose output no one grades, and they work alone. For the agents that do collect graded feedback, ABC Legal uses a three-role architecture: separate agents that share one workspace, environment, and credential vault but run on different schedules. The pattern turns messages in Slack into versioned, human-approved changes to the agent:

- The Initial Agent does the work, usually in real time as a job comes in or a document comes back, and records an audit trail of each action.
- The Harvester runs hourly or daily and gathers human feedback from Slack, where it arrives as thread replies and emoji reactions. Each one becomes a labeled data point.
- The Tuner runs weekly, looks across everything at once, and proposes a change to the prompt or config rather than the model's weights. It drafts only. A human reviews and merges the pull request.

 In ABC Legal’s self-improving agent loop, an initial agent does the work in real time, a harvester sweeps up human feedback from Slack on an hourly cadence, and a weekly tuner proposes prompt and config changes as a pull request. Agents improve through the same workflows developers already use.

One example is "deliveries-as-code," Fuller's agentic system for tuning how work gets routed, which started at Docketly, ABC Legal's 50-person sister company. Docketly organizes its work around deliveries, each with its own ruleset for routing and handling. All 145 or so rulesets are single YAML files in git rather than records in an admin screen, so tuning a delivery means editing a file and opening a pull request. 

Four agents make up the loop: one posts a weekly verdict to Slack, the Harvester turns reactions into labels based on human feedback, the Tuner opens a pull request on the YAML, and a fourth agent pushes the merged config to the production database. That fourth agent only executes what a human has already reviewed and approved. In practice, an emoji reaction flagging a mis-routed delivery can become a merged change to that delivery's routing rules within the week. The review is the only manual step in the loop.

# Why Claude Managed Agents

Fuller evaluated multiple frameworks before settling on Claude Managed Agents as his organization’s agentic harness. His criteria were specific: the platform had to have versioning, observable sessions, workspace billing, model selection, memory primitives, MCP wiring, and, most critically, no infrastructure to babysit.

The platform's division of responsibility maps cleanly to how Fuller wants to run things. Anthropic’s managed infrastructure owns everything that makes an agent run: the execution loop, sessions, memory, the console, and the models themselves. ABC Legal owns the prompt, the tool list, the trigger logic, the audit trail, and the feedback loop on outcomes.

A few capabilities proved especially important at scale:

- Versioning: every push creates a new agent version with optimistic locking. Rollback is trivial.
- Model flexibility: the default is Claude Sonnet for most agents, Claude Haiku for high volume and fast tasks, and Claude Opus when deeper reasoning justifies the cost. Swapping models is a one-line change.
- MCP wiring and credential vaults: agents connect to ABC Legal's own platform (with over 100 tools available), Metabase for reporting, Slack for human-in-the-loop interaction, and Atlassian for project management.
- Scheduled deployments: recurring agents run on cron schedules through Bitbucket Pipelines, which already handles repo access, secrets, and billing.

ABC Legal tracks every dollar of AI spend, broken out by vendor, tool, team, and use case. Spend climbed as the fleet went live through the spring, then started falling in July while usage kept growing, the result of the efficiency work described below, with a ~50% reduction in cost for the tasks many agents cover and ~310 employees across every department using Claude.  

The company's approach to cost is deliberate: push spend toward vertical, operational tools and agents where return is measurable, whilef keeping horizontal chat and ideation usage broad and costs in check. Most agents start with a human in the loop, where the agent looks at the job or ticket and makes a recommendation for a person to review before anything is acted on. The recommendation is either stored in the job and surfaced in a banner so the person can accept or reject it in the flow of their work, or posted to a Slack channel where people can reply in the thread. Those responses build a labeled dataset of good and bad calls, which feeds the harvester and tuner loop and lets the team write evals and benchmark agents across frontier models. Once an agent proves it is as good as or better than the humans on that specific task, it shifts into automation mode and acts on its own, and it stays inside the same measurement framework afterward to watch for any changes in performance.

The metric ABC Legal tracks is an efficiency ratio; the value an agent delivers measured against what it costs to run. Every Managed Agent reports its own value back to a data warehouse on each run, in hours and dollars. Agents follow a J-curve, often starting underwater while they are new and running larger models, then flipping positive as the team writes evals, moves to cheaper and faster models, and trims tokens.

# Best practices for deploying a fleet of agents

Fuller’s experience with deploying AI–specifically Claude Managed Agents led him to a few working principles about using the technology: 

‍

- Think of everything as code. "Code is just structured text. LLMs are text engines,” he said. “The more of your business you can turn into text in a repo, the more leverage agents give you." This applies to traditional software and equally to prompts, schemas, dispatch rules, notification templates, and business configurations.
- Start with humans in the loop. Every agent begins by posting recommendations for human review. Only after demonstrating consistent agreement with human decisions does it earn the right to act independently. "Every agent earns trust before it acts alone. It doesn't start there."

- Use the PR as your control surface. "If you want an agent involved in a decision, make the decision look like a pull request." Line-by-line comments, approval workflows, and immutable audit trails come free with version control, and compose naturally with both AI and human review.
- Invest in the feedback loop. The harvester-tuner pattern means agents improve without retraining. Slack replies and emoji reactions become structured signals that feed back into prompt and config changes, all through the same pull request workflow humans already use.
- Skip the scheduled-tasks detour. ABC Legal spent real time building scheduled tasks and local routines before moving to Managed Agents, largely because the product had only just launched in beta. Fuller's advice today is to go straight to Managed Agents.
- Expect the git hurdle, not the AI hurdle. The hard part was getting business users comfortable with cloning a repo and working in Git and pull requests, more than anything about the AI itself. It worked, and fast, but it was a real hurdle, and Fuller would like to see it made easier in the tooling itself.
- Not every task deserves an agent. The cost is real, so every team has to think in terms of value over cost. The work is picking tractable problems that genuinely save time or create automation, and being willing to say a given task is not worth an agent.

# What's next

ABC Legal's agent fleet continues to grow. In-flight projects include a service photo reviewer, a PagerDuty triage agent, a daily KPI digest, and expanded Tuner loops on existing agents.

The team is also identifying more "X-as-code" candidates: notification templates, event routing rules, and dispatch logic that can be moved into repositories where agents can read, reason about, and propose improvements.

As Fuller puts it: "We want AI to support a business that can run itself, with employees free to steer it."

Learn more about Claude Managed Agents.

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

Aug 14, 2026

### Maximizing the value of your Claude Code sessions

Claude Code

Maximizing the value of your Claude Code sessionsMaximizing the value of your Claude Code sessions

Maximizing the value of your Claude Code sessionsMaximizing the value of your Claude Code sessions

Aug 13, 2026

### Securing the frontier: How JetBrains evaluates and deploys Claude Fable 5

Enterprise AI

Securing the frontier: How JetBrains evaluates and deploys Claude Fable 5Securing the frontier: How JetBrains evaluates and deploys Claude Fable 5

Securing the frontier: How JetBrains evaluates and deploys Claude Fable 5Securing the frontier: How JetBrains evaluates and deploys Claude Fable 5

Oct 30, 2025

### How Brex improves code quality and productivity with Claude Code

Enterprise AI

How Brex improves code quality and productivity with Claude CodeHow Brex improves code quality and productivity with Claude Code

How Brex improves code quality and productivity with Claude CodeHow Brex improves code quality and productivity with Claude Code

Jan 26, 2026

### How Anthropic's Growth Marketing team cut ad creation time from 30 minutes to 30 seconds with Claude Code

Enterprise AI

How Anthropic's Growth Marketing team cut ad creation time from 30 minutes to 30 seconds with Claude CodeHow Anthropic's Growth Marketing team cut ad creation time from 30 minutes to 30 seconds with Claude Code

How Anthropic's Growth Marketing team cut ad creation time from 30 minutes to 30 seconds with Claude CodeHow Anthropic's Growth Marketing team cut ad creation time from 30 minutes to 30 seconds with Claude Code

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
