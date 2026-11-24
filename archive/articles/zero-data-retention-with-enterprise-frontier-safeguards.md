---
title: "Zero data retention with Enterprise Frontier Safeguards is now in beta"
url: https://claude.com/resources/articles/zero-data-retention-with-enterprise-frontier-safeguards
slug: zero-data-retention-with-enterprise-frontier-safeguards
fetched: 2026-11-24 10:39 UTC
---

# Zero data retention with Enterprise Frontier Safeguards is now in beta

> Source: https://claude.com/resources/articles/zero-data-retention-with-enterprise-frontier-safeguards

> Enterprise Frontier Safeguards is now in public beta, providing detection of sophisticated misuse while remaining compatible with zero data retention.


# Zero data retention with Enterprise Frontier Safeguards is now in beta

-

CategoryProduct updates

-

ProductClaude Platform

-

DateNovember 23, 2026

-

Reading time2 min

-

ShareCopy link

Over the past few months, we've been developing Enterprise Frontier Safeguards (EFS) for our business customers. EFS provides state-of-the-art detection of sophisticated misuse, while remaining compatible with zero data retention (ZDR): neither Anthropic nor any cloud providers retain enterprises' data.

Since we announced EFS in September, we've been developing it further with over 100 of our customers—including a quarter of the Fortune 100 and many companies in industries with strict rules on data visibility (like healthcare, financial services, and law). Leading enterprises like Bridgewater, Salesforce, and Stripe have been evaluating EFS in private beta.

“As a company that runs critical infrastructure, safety matters as much to us as model capability. We need a solution that gives us strong safeguards while allowing us to keep our data in our own account. Enterprise Frontier Safeguards delivers just that.”

Noopur Davis, EVP, Chief Information Security and Product Privacy Officer

“At Stripe, protecting customer data is foundational to how we operate. Anthropic’s Enterprise Frontier Safeguards will enable us to use frontier models with added protection against misuse. It will also let us retain conversation logs in Stripe’s AWS environment, with access and review governed by Stripe’s security controls.”

Matthew Kemelhar, Head of Security

“With EFS, customers can keep sensitive data in their own environments, protected with their own encryption keys, while still preserving the specialized safety mechanisms frontier capabilities require. That balance, keeping enterprises in control of their data without abandoning frontier-model safety, is critical to broader adoption of advanced AI in security-sensitive organizations like Cisco.”

Omar Santos, Distinguished Engineer

“Enterprise Frontier Safeguards gives us exactly what we asked for: our logs stay in a Wells-managed environment under Wells-managed keys. We keep custody of our data while Anthropic operates the detection. That split is what lets our teams put frontier models to work safely and meet our obligations to customers, employees, and regulators. We helped shape these safeguards because our industry needs them.”

Munish Kumar Sharma, Chief Information Security Officer

“Where we have regulated or highly sensitive data, having Enterprise Frontier Safeguards with zero data retention will allow us to confidently accelerate our AI deployment across those highly regulated and sensitive client engagements.”

Todd Lohr, US Vice Chair and Head of Client Technology & Innovation

“As a company that runs critical infrastructure, safety matters as much to us as model capability. We need a solution that gives us strong safeguards while allowing us to keep our data in our own account. Enterprise Frontier Safeguards delivers just that.”

Noopur Davis, EVP, Chief Information Security and Product Privacy Officer

“At Stripe, protecting customer data is foundational to how we operate. Anthropic’s Enterprise Frontier Safeguards will enable us to use frontier models with added protection against misuse. It will also let us retain conversation logs in Stripe’s AWS environment, with access and review governed by Stripe’s security controls.”

Matthew Kemelhar, Head of Security

“With EFS, customers can keep sensitive data in their own environments, protected with their own encryption keys, while still preserving the specialized safety mechanisms frontier capabilities require. That balance, keeping enterprises in control of their data without abandoning frontier-model safety, is critical to broader adoption of advanced AI in security-sensitive organizations like Cisco.”

Omar Santos, Distinguished Engineer

“Enterprise Frontier Safeguards gives us exactly what we asked for: our logs stay in a Wells-managed environment under Wells-managed keys. We keep custody of our data while Anthropic operates the detection. That split is what lets our teams put frontier models to work safely and meet our obligations to customers, employees, and regulators. We helped shape these safeguards because our industry needs them.”

Munish Kumar Sharma, Chief Information Security Officer

“Where we have regulated or highly sensitive data, having Enterprise Frontier Safeguards with zero data retention will allow us to confidently accelerate our AI deployment across those highly regulated and sensitive client engagements.”

Todd Lohr, US Vice Chair and Head of Client Technology & Innovation

“As a company that runs critical infrastructure, safety matters as much to us as model capability. We need a solution that gives us strong safeguards while allowing us to keep our data in our own account. Enterprise Frontier Safeguards delivers just that.”

Noopur Davis, EVP, Chief Information Security and Product Privacy Officer

1/5

Now, we're opening up EFS in public beta. In this post, we explain how EFS works in more detail, how it stays compatible with ZDR, and how businesses can join the beta program.

## How EFS provides automated safety monitoring with ZDR

Customers who rely on legacy ZDR are protected by Claude's classifiers: our real-time safeguards that screen individual requests to assess whether they might cause harm. But sophisticated attacks generally occur across multiple queries—and any single request might, in isolation, look harmless.

For example, our September threat intelligence report describes an operation against roughly fifty organizations in which an AI agent divided the work of an attack among many other agents running in parallel. It saved the credentials it had harvested between sessions, so that the attackers could easily resume their campaign. Viewed one request at a time, this attack would have appeared as separate, more benign tasks.

To catch attacks like these, we use a second defensive layer, known as automated safety monitoring. This layer looks for patterns of misuse across many requests. Through EFS, Anthropic can provide automated safety monitoring without storing any customer data. Instead, our automated safety monitoring system analyzes data stored entirely on infrastructure controlled by our customers.

When automated safety monitoring finds a risk, it creates a Safety Case for you to review. These cases can be read from your cloud storage or through an API, and can be integrated with security information and event management systems. They do not include inputs and outputs.

Once it's set up, automated safety monitoring can help your team detect intentional misuse that could lead to serious harm (like offensive cyber operations). It can also help detect agents that take actions beyond a user's intentions, such as—in extreme cases—using a software exploit to access an internal database or external system.

## Zero data retention and EFS

With EFS, you bring your own storage for storing inputs and outputs. Neither Anthropic nor your cloud provider keeps a copy of your data once it is delivered to storage you control. This provides you the following guarantees:

- Zero data retention. Neither Anthropic nor your cloud provider retains your data. You bring your own storage and store your own data. Inputs and outputs are deleted promptly after they're written to your own storage. You configure your own access policies and audit logging, and encrypt safety data with your own keys.
- No operator human review. Neither Anthropic nor your cloud provider personnel access your inputs and outputs. Only automated safety monitoring can access this data.
- We never train on your data. Inputs and outputs are used only for automated safety monitoring, never for model or classifier training.

You can use EFS through the Claude Platform, Claude Platform on AWS, Amazon Bedrock, or Claude on Google Cloud. When you use EFS through Amazon Bedrock or Claude on Google Cloud (Google Managed), it's operated by your cloud provider, and the end-to-end data flow stays within that cloud's boundary.

You can use Amazon S3 or Google Cloud Storage in your own account for your storage, depending on where you use Claude. Your cloud provider bills you for that storage as usual, including reads, writes, and key operations (plus any applicable network transfer).

## Get started

EFS is available on the Claude Platform, Claude Platform on AWS, Amazon Bedrock, and Claude on Google Cloud. Support for EFS in Microsoft Foundry is coming soon.

Eligible customers will be notified with instructions on how to get started. Read our developer docs to learn how to set it up, and our security whitepaper (opens in new tab) for how the architecture works, or deploy it through consulting partners like Accenture, Deloitte, KPMG, and PwC.

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleNov 17, 2026

### Linked billing on the Claude Platform

Claude Platform

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
