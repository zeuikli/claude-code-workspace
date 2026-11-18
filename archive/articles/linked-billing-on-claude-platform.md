---
title: "Linked billing on the Claude Platform"
url: https://claude.com/resources/articles/linked-billing-on-claude-platform
slug: linked-billing-on-claude-platform
fetched: 2026-11-18 08:10 UTC
---

# Linked billing on the Claude Platform

> Source: https://claude.com/resources/articles/linked-billing-on-claude-platform

> Linked billing is now in beta on the Claude Platform. Third-party platforms can let customers pay for Claude API usage without sharing an API key.


# Linked billing on the Claude Platform

-

CategoryProduct updates

-

ProductClaude Platform

-

DateNovember 17, 2026

-

Reading time4 min

-

ShareCopy link

Today we're introducing linked billing on the Claude Platform in beta. Third-party platforms, such as coding agents and workflow automation tools, can let their end customers pay for Claude API usage without sharing an API key. End customers keep their existing Anthropic billing and set their own spend limits, and platforms get a simpler, more secure way to offer Claude.

## A more secure alternative to sharing API keys

Paying for Claude API usage on a third-party platform usually means sharing an API key, which works like a password: anyone who has the key can make requests billed to the customer, so the platform has to keep it safe.

With linked billing, customers link their Claude Platform organization instead, and usage is billed directly to it. No API key changes hands, so platforms have no customer keys to store, encrypt or rotate, and customers’ API keys never leave their organization.

Platforms can see usage for each linked customer. Customers approve each linked platform, set a spend limit, and can unlink at any time.

Linked billing on the Claude Platform

## Platforms can offer Claude to customers without building the billing

Linked billing gives platforms a new way to offer Claude to their customers. Platforms send requests, and Anthropic bills the end customers directly. With linked billing, platforms can:

- Launch faster. Anthropic hosts the approval flow and the billing, so there’s no metering or invoicing to build.
- Understand usage by customer. Get each linked customer’s request count, token usage and models used in Console, or programmatically with the Usage and Cost Analytics API (beta).
- Choose who pays. Decide on each request whether the platform or the end customer pays, so platforms can pass Claude API costs to customers or cover some features themselves by product or instance.

## Customers get more visibility and control

Customers can easily link to platforms using Anthropic’s hosted flow. They can then draw down from their existing Anthropic commitment, or pay as they go. With linked billing, customers can also:

- Link once for the whole organization. A Console user with an Owner, Admin, or Billing role approves the link, so it works the same for individual developers and large teams.
- Set limits for each platform. Customers can set a monthly spend limit for each platform, or a default that applies to each one.
- See where API spend goes. Console shows spend for each linked platform.
- Unlink at any time. Customers can unlink directly from Console.

Requests run in the platform’s organization, so settings in the customer’s organization, such as IP allowlists, encryption keys, and data retention, don’t apply.

Platforms that support linked billing today include Asana, ClickHouse, Factory, Gumloop, Harness, Higgsfield AI, Kilo Code, Linear, Major, Mintlify, Omni, OpenArt, Niteshift, Railway, Ramp, Runlayer, Tessera, Tines, and Warp.

## Getting started

Linked billing is available today in beta on the Claude Platform. Third-party platforms can add support by creating an app in Console and following the steps in the docs. Claude Platform customers can link their organization from any supported platform, and find platforms that offer linked billing on Claude Marketplace.

“Our customers include some of the largest companies in the world. Linked billing lets them use their own Claude organization in Tessera, with no new keys to manage”

Anirudh Sriram, CTO, Tessera

“Claude is expanding what’s possible with AI, and Tines helps teams across the business build, deploy, and operationalize that work securely, with the visibility and control IT and Security need. Linked billing gives customers a simpler way to bring Claude and Tines together through their existing Claude Platform organization, without sharing API keys, making it easier to control spend and expand AI adoption across the business.”

Charlie Ardagh, Vice President, Strategic Partnerships, Tines

“Engineering teams should have the flexibility to build their software factories with the models and infrastructure they choose. Linked billing makes that easier and more secure, making it seamless for customers to link their own Claude Platform organizations to Warp without having to manage API keys or complex billing arrangements. We’re excited to bring this experience to Warp.”

Zach Lloyd, Founder and CEO, Warp

“Manually copying API keys is inherently insecure. With linked billing, admins can now use their committed Claude spend directly with the Linear cloud coding agent in a click.”

Tom Moor, Member of Technical Staff, Linear

“At Ramp, we want to save customers time and money wherever they work. Linked Billing makes it easier for our customers to use their existing Claude Platform account through Ramp Router, without the hassle of sharing an API key.”

Amanda Carroccio, Director of AI Partnerships, Ramp

“Linked billing with Claude Platform lets developers using Railway Agent focus on getting their applications built and deployed, instead of managing API keys manually. Linking their Claude Platform organization with Railway gives developers a more secure way of accessing their models and spend limits.”

Cody De Arkland, GM, Agent Experience, Railway

“Our customers want to bring AI into more of their work without adding overhead for IT and finance. Linked billing lets them use their existing Claude commitment to power Agentic Work Management in Asana, including AI Studio and AI Teammates, with less setup and spending limits they control as adoption grows.”

Arnab Bose, Chief Product Officer, Asana

“Linked billing makes Claude billing in ClickHouse Cloud turnkey: link your Claude Platform organization, no keys to manage, and Claude API usage is billed to your organization on the terms you already have.”

Ryadh Dahimene, Director of Product Management, AI/ML, ClickHouse

“Linked billing simplifies the onboarding process for our enterprise customers. Instead of creating an Anthropic API key and sharing it with us, an admin links their Claude Platform organization once. We don’t need to hold their key, furthering the security of the integration.”

Leo Tchourakov, Member of Technical Staff, Factory

“Gumloop takes security very seriously, and with linked billing our customers no longer hand their API key to a third party. They link their Claude Platform organization to Gumloop once, and their Claude API usage is billed directly to that organization.”

Rahul Behal, Chief Technology Officer, Gumloop

“Software factories are the next chapter of engineering, and many of our customers are building them with Claude. Using linked billing, they can link their Claude Platform organization to Cosmos by Harness, and Claude API usage in Cosmos is billed to that organization. We’re excited to be supporting linked billing for the Claude Platform.”

Sanjay Nagaraj, SVP of Engineering, Harness

“Our customers look to Claude for agentic capabilities in the tools they use to create. Linked billing lets them link their Claude Platform organization to Higgsfield, with Claude API usage billed directly to their organization. Operational simplicity lets their creative teams focus on what they do best.”

Alex Mashrabov, CEO, Higgsfield AI

“Linked billing means our customers link their Claude Platform organization and everything just works. We get to spend our time building instead of managing credentials.”

Kyle Finken, Engineer Manager, Mintlify

“Niteshift orchestrates cloud coding agents with full-stack dev environments. As agent usage grows in volume and scope, our customers are increasingly focused on both cost control and security. Linked billing allows them to set a monthly spend limit and keep their billing relationship with Anthropic, without sharing long-lived API keys.”

Sajid Mehmood, CEO & Co-Founder, Niteshift

“Linked billing with Claude Platform lets customers link their Claude organization to Omni without sharing an API key. Alongside Omni’s own usage tracking, they can trace Claude token usage back to Omni for better auditability.”

Marc Dupuis, Director of Product, Omni

“Runlayer works with enterprises at the frontier of AI, and we’re excited to be supporting linked billing on the Claude Platform. No API key to share means one less attack vector.”

Andy Berman, CEO, Runlayer

“Our customers include some of the largest companies in the world. Linked billing lets them use their own Claude organization in Tessera, with no new keys to manage”

Anirudh Sriram, CTO, Tessera

“Claude is expanding what’s possible with AI, and Tines helps teams across the business build, deploy, and operationalize that work securely, with the visibility and control IT and Security need. Linked billing gives customers a simpler way to bring Claude and Tines together through their existing Claude Platform organization, without sharing API keys, making it easier to control spend and expand AI adoption across the business.”

Charlie Ardagh, Vice President, Strategic Partnerships, Tines

“Engineering teams should have the flexibility to build their software factories with the models and infrastructure they choose. Linked billing makes that easier and more secure, making it seamless for customers to link their own Claude Platform organizations to Warp without having to manage API keys or complex billing arrangements. We’re excited to bring this experience to Warp.”

Zach Lloyd, Founder and CEO, Warp

“Manually copying API keys is inherently insecure. With linked billing, admins can now use their committed Claude spend directly with the Linear cloud coding agent in a click.”

Tom Moor, Member of Technical Staff, Linear

“At Ramp, we want to save customers time and money wherever they work. Linked Billing makes it easier for our customers to use their existing Claude Platform account through Ramp Router, without the hassle of sharing an API key.”

Amanda Carroccio, Director of AI Partnerships, Ramp

“Linked billing with Claude Platform lets developers using Railway Agent focus on getting their applications built and deployed, instead of managing API keys manually. Linking their Claude Platform organization with Railway gives developers a more secure way of accessing their models and spend limits.”

Cody De Arkland, GM, Agent Experience, Railway

1/16

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleNov 12, 2026

### Operate Claude Managed Agents inside your security perimeter

Introducing self-hosted Claude Managed Agents. Now you can run agents in your own environment, whether that’s in your own cloud or on-premise. You host the agents, credentials, and session history, and choose where requests to Claude are sent.

Claude PlatformClaude Managed Agents

ArticleNov 12, 2026

### Introducing Claude for Manufacturing

A new plugin with 17 skills and four connectors helps manufacturers draft quotes, quality reports, and supplier requests from the systems they already run.

ArticleNov 12, 2026

### Introducing Claude Meetings

Add Claude to your video call and get the work started while you talk

ArticleNov 10, 2026

### Your apps can now open in Claude, and Claude can work in them

Our partners can now embed their apps directly in Claude, so you and Claude can work in the same tool, on the same screen, without switching tabs.

Claude appsMCP
