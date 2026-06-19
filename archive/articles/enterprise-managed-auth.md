---
title: "Centrally manage authorization for MCP connectors "
url: https://claude.com/blog/enterprise-managed-auth
slug: enterprise-managed-auth
fetched: 2026-06-19 06:15 UTC
---

# Centrally manage authorization for MCP connectors 

> Source: https://claude.com/blog/enterprise-managed-auth




# Centrally manage authorization for MCP connectors

- Category

Enterprise AI

Product announcements

- Product

Claude Enterprise

Claude apps

- Date

June 18, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/enterprise-managed-auth

Admins can now provision MCP connectors for their whole organization through their identity provider, starting with Okta. Users get connector access automatically on first login, with authorization configured centrally by their organization.

Connectors make Claude more useful at work — they give Claude the context it needs from the tools that your teams already use. Until now, turning them on required action at two steps: admins enabled a connector for the organization, and then every individual user authorized it themselves. 

Enterprise-managed authorization streamlines that second step. Admins authorize a connector once, users inherit access through the IdP groups and roles they already have, and the connector is there the first time someone opens Claude. The result is zero-touch connector setup for the end user.

Enterprise-managed auth is the first implementation of the Enterprise-Managed Authorization extension to the Model Context Protocol. It's built on an open standard so any connector can support it — including the custom connectors your own teams build — and they all work the same way for every Claude customer.

### How it works

Connect your identity provider to Claude and choose which MCP connectors to enable for your organization. When an employee logs in, their connectors are already there. Access stays consistent across Claude chat, Claude Code, and Cowork.

For admins, this folds MCP access management into the same workflow that governs the rest of your stack: provision once, scope by group, manage revocation through the IdP. Because checking access with the IdP is frictionless, admins can shorten access token lifetimes without impacting productivity — so when someone is deprovisioned, their connector access expires fast instead of lingering on an old token. Access runs through the identity provider you already trust, so connectors fall under the same security and access controls as everything else, rather than a separate surface to monitor.

Admins can also require that a connector only ever connects through the IdP, which keeps work and personal use cleanly separated and prevents someone from accidentally linking a personal account to a work tool.

### Built with an ecosystem 

Enterprise-managed authorization works across three groups: the identity providers that govern access, the MCP providers that support the standard, and the Claude customers deploying managed connections across their teams.

Identity providers. Okta is supported at launch, with support for additional identity providers coming soon.

MCP providers. Asana, Atlassian, Canva, Figma, Granola, Linear, and Supabase support Enterprise-managed auth at launch, with Slack coming soon.

Claude customers. Hubspot, Ramp, and Webflow are among the organizations rolling out enterprise-managed auth across their teams.

"Enterprise-managed auth is a foundational milestone in realizing Asana's vision as the operating system for human-agent teams. By providing organizations with a secure, controlled way to connect Claude to their most critical workflows, we are unlocking the ability to scale AI-driven value across the enterprise—backed by the absolute governance, compliance, and trust that large-scale deployment demands."

Arnab Bose, CPO

“Enterprise-managed auth makes Atlassian Rovo MCP easier for Claude Enterprise customers to adopt at scale, giving employees a simple way to connect Claude to the Atlassian work they already rely on across Jira, Confluence, and Teamwork Graph. Just as importantly, it gives admins a centralized place to manage MCP clients' access, so organizations can move faster with AI while maintaining the governance they expect."

Brendan Haire, VP of Engineering, Rovo and AI

"Canva is already trusted by 95% of the Fortune 500, and our MCP server lets even more teams create, edit and publish on-brand designs with Canva's AI and design tools, all in the same workflow. Enterprise-managed auth with Okta makes it clear and simple for enterprises to manage AI access with a system they already trust, enabling teams to create with AI, safely and at scale."

Anwar Haneef, GM & Head of Ecosystem

"The Figma MCP brings the power of code and canvas together so teams can move faster, explore more and ship products that stand out. As MCP adoption grows, enterprise-managed auth makes it easier for enterprises to scale their MCP deployments securely without slowing teams down."

Devdatta Akhawe, VP of Engineering

"It's great to see Anthropic and Okta make it easier for enterprises to connect to MCP servers securely, centrally and at scale. Granola helps teams capture some of the most important context at work: decisions, details and follow ups as they happen. MCP makes this useful across team tools, and enterprise-managed auth makes it available frictionlessly across teams."

Chris Pedregal, CEO & co-founder

“Enterprise-managed auth is the security and user experience that we've been looking for with MCP connections. Folks just perform a standard login to Okta and they're connected with their personal context to all MCP hosts in our software ecosystem. Personal identity passes through, but no one gets tripped up on a multitude of OAuth grants. It's a huge win for enterprise management, especially paired with selective control of individual tools exposed by those MCP hosts.”

Andrew Meinert Director, System Operations & AI

"Logging in once and automatically having all your MCP connectors automatically set up is pretty magical."

Tom Moor, Head of Engineering

"The momentum around MCP is incredible, but as we move toward an interconnected AI workforce, security can't be an afterthought. By embedding the Cross App Access protocol into MCP as the Enterprise-Managed Authorization extension, as well as implementing it in the Claude ecosystem, we turn identity into a centralized governance plane and give security teams strict compliance control and users a seamless, secure experience."

Aaron Parecki, Director of Identity Standards

“Before enterprise-managed auth, onboarding a new hire to their full toolkit meant a queue of per-connector OAuth approvals. Now they log in to Claude on day one already connected — 2,000 employees, provisioned through Okta, zero extra steps.”

Cameron Leavenworth, Staff IT Engineer, AI

“Slack is the place where humans and agents are working side by side, in the same conversation, with the same context, toward the same goals. Through the Slack MCP server, all of this becomes accessible to Claude, not just to read but to act on. Enterprise-managed auth means organizations can roll out access to all users without friction. Security teams configure it once through their existing identity provider and users get seamless access.”

Rod García, VP of Engineering

“The only way to use Supabase through Claude was to be an org owner or hand out Personal Access Tokens to everyone on your team. Enterprise-managed auth fixes that: your IdP controls access and roles, so builders can use Claude to explore and query their data without IT compromising on security to get there.”

Bil Harmer, CISO

“Our team opens Claude and every tool they’re cleared for is right there, scoped by the identity groups IT already runs. Enterprise-managed auth turned AI into something people use instead of request, and we’re taking it across Webflow.”

Reed Shackelford, Senior Manager, Enterprise AI Operations

PrevPrev

0/5

NextNext

eBook

##

### Getting started

Enterprise-managed auth is available today in beta for customers on the Claude Team and Enterprise plans. Learn more on our Help Center and apply for access to get started. 

Any identity or MCP provider can add support for enterprise-managed auth by implementing the open extension to the MCP authorization spec. Submit interest to join the beta here.

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Jun 18, 2026

### Claude Code now supports artifacts

Product announcements

Claude Code now supports artifactsClaude Code now supports artifacts

Claude Code now supports artifactsClaude Code now supports artifacts

May 21, 2026

### Claude now works with more security and compliance tools

Enterprise AI

Claude now works with more security and compliance toolsClaude now works with more security and compliance tools

Claude now works with more security and compliance toolsClaude now works with more security and compliance tools

Jun 17, 2026

### Secure access to the Claude Platform with Workload Identity Federation

Product announcements

Secure access to the Claude Platform with Workload Identity FederationSecure access to the Claude Platform with Workload Identity Federation

Secure access to the Claude Platform with Workload Identity FederationSecure access to the Claude Platform with Workload Identity Federation

Jun 17, 2026

### Claude Design now stays on brand for daily work

Product announcements

Claude Design now stays on brand for daily workClaude Design now stays on brand for daily work

Claude Design now stays on brand for daily workClaude Design now stays on brand for daily work

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
