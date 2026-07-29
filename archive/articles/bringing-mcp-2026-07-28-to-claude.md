---
title: "MCP 2026-07-28 spec: stateless core, coming to Claude | Claude by Anthropic"
url: https://claude.com/blog/bringing-mcp-2026-07-28-to-claude
slug: bringing-mcp-2026-07-28-to-claude
fetched: 2026-07-29 04:09 UTC
---

# MCP 2026-07-28 spec: stateless core, coming to Claude | Claude by Anthropic

> Source: https://claude.com/blog/bringing-mcp-2026-07-28-to-claude




# Bringing MCP 2026-07-28 to Claude

- Category

Product announcements

- Product

Claude apps

Claude Platform

- Date

July 28, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/bringing-mcp-2026-07-28-to-claude

The fifth spec release of the Model Context Protocol, MCP 2026-07-28, is live today. The latest spec moves MCP to a stateless core, while hardening authorization and graduating official extensions. Support is being rolled out across Claude products.

## What's new in MCP‍

MCP recently surpassed 400M monthly SDK downloads, a 4x increase this year, and has become the industry standard for connecting AI agents to applications. MCP 2026-07-28 is one of the most significant spec releases to date:

Stateless core. MCP moves from a bidirectional stateful protocol to a request/response model. Servers can now deploy on serverless and edge infrastructure. This simplifies the experience of building MCP servers for Claude and scaling their usage as they grow in adoption. 

Standardized extensions. MCP Apps and Tasks now ship under a versioned extensions framework, giving developers a formal path to add capabilities like interactive UIs and long-running work without changing the core protocol.

Auth hardening. Authorization now aligns with production OAuth 2.0 and OIDC deployments, so MCP servers connect to enterprise identity systems like Entra or Okta without workarounds.

Companies across the ecosystem have been building on the new spec alongside the MCP community since beta:

“More builders are using our MCP server to bring generated outputs into Figma's canvas, where they can explore, riff and refine them with their team into products that stand out. As that usage grows, our stateless architecture can scale with it, and with MCP Apps, Tasks, and Enterprise-Managed Auth, we can do even more to keep design and code together in one, connected flow.”

Josh Clemm, VP of Engineering

"MCP is the industry standard for connecting AI agents to tools and data, and Intuit is proud to support the new MCP 2026-07-28 spec. The stateless protocol core and extensions framework, including MCP Apps and Tasks, let our technologists and customers build and connect agentic experiences at enterprise scale, and allow Intuit to continue delivering trusted financial intelligence experiences to its 100 million consumers and businesses, wherever they choose to work."

Chris Kasten, Chief Architect and SVP of Engineering, Platform and Development Xceleration Group

"The stateless core in the 2026-07-28 spec makes MCP a first-class HTTP workload with no session management to work around. Our customers wanted MCPs on Netlify to be as simple as the rest of the platform and this new spec unlocks this at its core. Building MCP Apps into the new extensions framework is a huge step forward for scalability, accessibility, and capability across the whole ecosystem."

Sean Roberts, VP of Applied AI

"Moving MCP to a stateless protocol makes it easier to scale our own service and makes it easier for us to add analytics for our customers' MCP servers. This helps us show people how their MCP tools are being used and what tools are missing that their users would want to use. It's great to see this protocol growing in this direction."

Paul D'Ambra, Product Engineer

"Anthropic pairs frontier models with a developer experience that keeps raising the bar. The stateless core in the open MCP 2026-07-28 spec reduces the complexity we manage, so we can ship more features to our customers, faster and at scale."

Andrew Goodman, VP of AI

"At Zoom, we believe organizational context is what enables AI to deliver meaningful work, which is why we've built MCP servers that securely bring Zoom meeting intelligence into AI platforms like Claude. The new MCP spec makes it far easier to deploy and scale MCP servers on standard HTTP infrastructure — so users get Zoom's meeting intelligence faster and more reliably, right inside the AI workflows they depend on every day."

Ross Mayfield, Head of Product for AI Platform

PrevPrev

0/5

NextNext

eBook

##

See the MCP 2026-07-28 release announcement for full details on the new spec.

## ‍Advancing MCP in Claude‍

Claude now lists over 950 MCP servers in the connectors directory, used by millions of people every day. This year we shipped support for new protocol extensions alongside features that make MCP easier to build on and deploy:

MCP Apps let servers render interactive UI directly in the conversation. Users can see what a connector is doing and work with it inline, without switching tabs.

Enterprise-managed auth lets admins provision MCP connectors for their whole organization through their identity provider. Admins authorize a connector once, users inherit access through their existing IdP groups, and it's connected on first login: zero-touch setup for the end user.

Observability for developers building connectors gives published connectors in our directory a dashboard showing how they perform across Claude product surfaces. Developers can use it to track adoption, diagnose errors and latency, and break down usage by product.

MCP tunnels (research preview) connect Claude to MCP servers inside a private network without exposing them to the public internet. Teams can bring internal tools to Claude with no inbound firewall rules, no public endpoints, and no IP allowlisting on the origin.

The stateless core, standardized extensions, and hardened auth in 2026-07-28 will help developers bring more applications to Claude, with a lower-friction, more consistent end-user experience. We'll continue investing in MCP as an open standard alongside the community, and in the Claude features that make MCP more accessible and effective in production.

## ‍Getting started

‍Explore the spec and SDKs to get started. Support is rolling out across Claude products soon. If you’re planning to submit your MCP server to Claude’s connectors directory, you can learn more here.

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Jul 23, 2026

### Think through hard problems in voice mode

Product announcements

Think through hard problems in voice modeThink through hard problems in voice mode

Think through hard problems in voice modeThink through hard problems in voice mode

May 12, 2026

### Claude for the legal industry

Product announcements

Claude for the legal industryClaude for the legal industry

Claude for the legal industryClaude for the legal industry

Jul 7, 2026

### Claude Cowork is coming to mobile and web

Product announcements

Claude Cowork is coming to mobile and webClaude Cowork is coming to mobile and web

Claude Cowork is coming to mobile and webClaude Cowork is coming to mobile and web

Apr 9, 2026

### Making Claude Cowork ready for enterprise

Product announcements

Making Claude Cowork ready for enterpriseMaking Claude Cowork ready for enterprise

Making Claude Cowork ready for enterpriseMaking Claude Cowork ready for enterprise

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
