---
title: "Workload Identity Federation (WIF) is now generally available on the Claude Platform."
url: https://claude.com/blog/workload-identity-federation
slug: workload-identity-federation
fetched: 2026-06-18 05:53 UTC
---

# Workload Identity Federation (WIF) is now generally available on the Claude Platform.

> Source: https://claude.com/blog/workload-identity-federation




# Secure access to the Claude Platform with Workload Identity Federation

- Category

Product announcements

- Product

Claude Platform

- Date

June 17, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/workload-identity-federation

Workload Identity Federation (WIF) is now generally available on the Claude Platform. WIF is compatible with any OIDC-compliant identity provider and covers all Claude API endpoints, including when accessing the endpoints through our first-party SDKs and Claude Code.

With WIF for workloads and ant auth login for interactive sessions, developers never have to handle a static API key when building with the Claude Platform.

## How Workload Identity Federation works

WIF replaces static API keys with short-lived, scoped credentials issued at request time. Whether you're a two-person startup running GitHub Actions or an enterprise with detailed credential policies, you can now authenticate with the Claude Platform the same way you authenticate with the rest of your stack.

With WIF, there are no static Anthropic credentials to create, rotate, or leak. Workloads authenticate with the identity they already have: an AWS IAM role, a GCP or Kubernetes service account, an Azure managed identity, a GitHub Actions token, Okta, or other OIDC-compliant providers.

We're also introducing service accounts to the Claude Platform, so each workload can have its own identity, roles, and audit trail instead of a shared API key. First, a federation rule binds an external identity to a service account. Then, when a workload requests access, the Claude Platform verifies the workload's signed OIDC token, matches its claims against your federation rules, and issues a short-lived access token bounded by the service account's roles. Every exchange and request is recorded against that service account in your audit logs.

## Set up your first workload in minutes

The Claude Console has a guided setup flow for configuring workload identities. The setup validates each step and finishes with a test command that confirms your workload can authenticate.

## Run your whole organization without static keys

WIF is compatible with the Admin API for organization management. Federation rules can be configured for least-privilege access through fine-grained scopes. 

Federation configuration is also fully programmatic for organizations operating at scale. New Admin API endpoints let you create and update issuers, service accounts, and federation rules.

No items found.

PrevPrev

0/5

NextNext

eBook

##

## Getting started

API keys work alongside WIF, so you can migrate one workload at a time. Read the setup guides for each identity provider, or open the Claude Console to connect your first workload.

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Jun 17, 2026

### Claude Design now stays on brand for daily work

Product announcements

Claude Design now stays on brand for daily workClaude Design now stays on brand for daily work

Claude Design now stays on brand for daily workClaude Design now stays on brand for daily work

Apr 14, 2026

### Introducing routines in Claude Code

Product announcements

Introducing routines in Claude CodeIntroducing routines in Claude Code

Introducing routines in Claude CodeIntroducing routines in Claude Code

May 28, 2026

### Introducing dynamic workflows in Claude Code

Product announcements

Introducing dynamic workflows in Claude CodeIntroducing dynamic workflows in Claude Code

Introducing dynamic workflows in Claude CodeIntroducing dynamic workflows in Claude Code

Jun 9, 2026

### New in Claude Managed Agents: run agents on a schedule and store environment variables in vaults

Product announcements

New in Claude Managed Agents: run agents on a schedule and store environment variables in vaultsNew in Claude Managed Agents: run agents on a schedule and store environment variables in vaults

New in Claude Managed Agents: run agents on a schedule and store environment variables in vaultsNew in Claude Managed Agents: run agents on a schedule and store environment variables in vaults

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
