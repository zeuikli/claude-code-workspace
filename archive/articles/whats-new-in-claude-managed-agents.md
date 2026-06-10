---
title: "New in Claude Managed Agents: run agents on a schedule and store environment variables in vaults"
url: https://claude.com/blog/whats-new-in-claude-managed-agents
slug: whats-new-in-claude-managed-agents
fetched: 2026-06-10 05:15 UTC
---

# New in Claude Managed Agents: run agents on a schedule and store environment variables in vaults

> Source: https://claude.com/blog/whats-new-in-claude-managed-agents




# New in Claude Managed Agents: run agents on a schedule and store environment variables in vaults

- Category

Product announcements

- Product

Claude Platform

- Date

June 9, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/whats-new-in-claude-managed-agents

Starting today, Claude Managed Agents can run on a schedule and securely access CLI tools and other authenticated services. Both features are now available in public beta on the Claude Platform.

## Run agents on a schedule

Agents can now run on a schedule, completing routine work automatically. A scheduled deployment gives an agent a cron schedule. Each time the schedule fires, the agent starts a new session and completes its task, with no scheduler for you to build or host. 

Use it for recurring work like a nightly data sync, a weekly compliance scan, or a daily digest. Once a deployment is live, you can pause, resume, or archive it at any time, or trigger additional runs on demand.

Teams are already using scheduled deployments to automate recurring work:

- Rakuten uses scheduled deployments to analyze spreadsheet data and produce reports and decks on a weekly or monthly schedule. Teams also monitor production logs and metrics, allowing product managers to see application health without creating a dashboard.
- Actively AI uses Managed Agents to power cross-account agentic search for sales teams. Scheduled deployments refresh answers regularly, simplifying their stack by replacing scheduling infrastructure the team initially built themselves.‍
- Ando uses scheduled deployments to keep hiring and sales teams moving. Agents autonomously watch channels for proposed next steps, follow up when they're due, and send meeting reminders.

## Store environment variables in vaults to authenticate CLIs and other tools

Agents connect to external systems through direct API calls, CLIs, and MCP. Now we're extending vaults to support environment variables, so CLIs and other tools can make authenticated requests. CLIs let agents drive existing command-line tools directly through a shell, making them a fast, lightweight integration path. Register an API key with an environment variable name and the domains it can reach, and the CLIs installed in an agent's sandbox can use it to make authenticated API calls.

The agent never sees your key because the sandbox only holds a placeholder. The real key is attached at the network boundary, and only on requests to domains you allow, so it only goes where you’ve approved. To change a key, update it in the vault, and running sessions will pick up the new value on their next call. Most CLIs that send their key in an HTTP request work this way, including the Browserbase, KERNEL, Notion, Ramp, and Sentry CLIs. Browserbase and KERNEL give Managed Agents browser capabilities for the first time, so agents can navigate and interact with the web alongside their other tools.

Teams are using environment variables in vaults to give agents secure access to authenticated tools:

- Notion uses environment variables in vaults to roll out its CLI alongside MCP tools, adding file-upload capabilities to its agents without API tokens ever being handed to the model.
- Browserbase built its public catalog of browser skills using the browse CLI, authenticated through vaults. A scheduled deployment periodically validates the catalog to keep it accurate.
- KERNEL uses environment variables in vaults to securely connect agents to the databases where it tracks usage and customer conversations. The agent flags usage surges as they happen, so the team can confirm with customers if the activity is intended.‍
- Milana uses environment variables in vaults to securely connect its AI product engineer to a customer's codebase. The agent finds and fixes bugs automatically, with large-scale data analysis running faster than before.

“Environment variables in vaults let us securely roll out the Notion CLI, meeting our security team’s strict guidelines by ensuring sensitive API tokens are never handed to agents. The CLI is complementary to MCP tools, enabling file-upload capabilities in Claude Managed Agents.”

Quan Nguyen, Public API Lead

“Teams across Rakuten use scheduled deployments to analyze data in a spreadsheet and produce a report or deck on a weekly or monthly schedule. Our power users put it on production logs and metrics, so a product manager can see the health of their application without creating an analytics dashboard.”

Yusuke Kaji, General Manager of AI for Business

“Most of our users prefer to work with fewer agents rather than many. With scheduled deployments, they can bundle more capabilities into one autonomous agent. For example, an agent can watch multiple sales and hiring processes, check in with the right people for updates, and push next steps along.”

Sara Du, Founder

“We built a cross-account agentic search system on Claude Managed Agents that lets sales teams ask things like which accounts to reach out to today. Since customers want those answers refreshed regularly, we replaced the scheduling infrastructure we'd built ourselves with scheduled deployments, which greatly simplified our stack and improved our product cycles.”

Mihir Garimella, Co-founder

“With Claude Managed Agents, we grounded our agent on a customer's actual codebase. We found it easy to work with and got high-quality results almost instantly. The key unlock was environment variables in vaults, which let our agent invoke private APIs through a CLI without exposing credentials. Large-scale data analysis is now dramatically faster, and with outcomes we can ensure the quality of every output.”

Raghav Sethi, Co-founder & CTO

“Environment variables in vaults enabled our engineering team to combine two major compute primitives: the agent and the browser. At Browserbase, we used Claude Managed Agents with the browse CLI to generate our public catalog of browser skills that help agents navigate the web, and scheduled deployments run periodic validation on our public catalog.”

Ziray Hao, Product Lead

Usage on Kernel's browser infrastructure can surge quickly, often right after a customer deploys. With environment variables in vaults, our agent now connects directly to the databases where we track usage and customer conversations. It pulls 30 days of daily usage in seconds, flags surges as they happen, and helps our team confirm with customers that the activity is intended.

Catherine Jue, Co-founder & CEO

PrevPrev

0/5

NextNext

eBook

##

## Getting started

Explore our documentation to learn more or visit the Claude Console to deploy your first agent.

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Jun 8, 2026

### Building intelligent apps for Apple platforms with Claude in the Foundation Models framework

Product announcements

Building intelligent apps for Apple platforms with Claude in the Foundation Models frameworkBuilding intelligent apps for Apple platforms with Claude in the Foundation Models framework

Building intelligent apps for Apple platforms with Claude in the Foundation Models frameworkBuilding intelligent apps for Apple platforms with Claude in the Foundation Models framework

Jun 8, 2026

### Observability for developers building connectors

Product announcements

Observability for developers building connectorsObservability for developers building connectors

Observability for developers building connectorsObservability for developers building connectors

May 28, 2026

### Introducing dynamic workflows in Claude Code

Product announcements

Introducing dynamic workflows in Claude CodeIntroducing dynamic workflows in Claude Code

Introducing dynamic workflows in Claude CodeIntroducing dynamic workflows in Claude Code

May 26, 2026

### Code w/ Claude London 2026: Rethinking how we build

Product announcements

Code w/ Claude London 2026: Rethinking how we buildCode w/ Claude London 2026: Rethinking how we build

Code w/ Claude London 2026: Rethinking how we buildCode w/ Claude London 2026: Rethinking how we build

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
