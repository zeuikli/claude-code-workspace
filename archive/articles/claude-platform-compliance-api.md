---
title: "Audit Claude Platform activity with the Compliance API"
url: https://claude.com/blog/claude-platform-compliance-api
slug: claude-platform-compliance-api
fetched: 2026-04-17 15:43 UTC
---

# Audit Claude Platform activity with the Compliance API

> Source: https://claude.com/blog/claude-platform-compliance-api




# Audit Claude Platform activity with the Compliance API

The Compliance API gives admins programmatic access to audit logs across their Claude Platform organization.

- Category

Product announcements

- Product

Claude Platform

- Date

March 30, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/claude-platform-compliance-api

## Audit Claude Platform activity with the Compliance API

The Compliance API is now available on the Claude Platform, giving admins programmatic access to audit logs across their organization. Security and compliance teams can track user activity, monitor configuration changes, and integrate Claude usage data into their existing compliance infrastructure.

## Audit logging for your organization 

Organizations in regulated industries—like financial services, healthcare, legal—need detailed records of who accessed what, when, and what changed. Without programmatic access to this data, compliance teams need to rely on manual exports and periodic reviews, which don't scale.

The Compliance API provides an activity feed that logs security-relevant events across your organization. Admins can fetch activity logs filtered by time range, specific users, or API keys.

The API currently tracks two categories of activity:

- Admin and system activities: Actions that modify access or configuration of resources, like adding a member to a workspace, creating an API key, updating account settings, or modifying entity access.
- Resource activities: User-driven actions that create or modify resource data, such as creating a file, downloading a file, or deleting a skill. These cover actions that may affect data or allow resources to access sensitive information, excluding direct interactions with the model.

Together, these cover user login and logout events, account setting updates, workspace changes, and other organizational audit events. The API does not log inference activities, such as user interactions with the model or model activities.

## Getting started 

Contact your account team to enable the Compliance API for your organization. Once enabled, create an admin API key and use it to query the activity feed endpoint. Note that logging begins once the API is enabled—historical activities prior to that point aren't available.

Organizations that already use the Compliance API for Claude Enterprise can add their Claude API organization to the same parent organization and filter activity across both from a single feed.

Read the documentation on the Anthropic Trust Center to learn more.

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

Apr 14, 2026

### Redesigning Claude Code on desktop for parallel agents

Claude Code

Redesigning Claude Code on desktop for parallel agentsRedesigning Claude Code on desktop for parallel agents

Redesigning Claude Code on desktop for parallel agentsRedesigning Claude Code on desktop for parallel agents

Apr 14, 2026

### Introducing routines in Claude Code

Product announcements

Introducing routines in Claude CodeIntroducing routines in Claude Code

Introducing routines in Claude CodeIntroducing routines in Claude Code

Apr 9, 2026

### The advisor strategy: Give agents an intelligence boost

Product announcements

The advisor strategy: Give agents an intelligence boostThe advisor strategy: Give agents an intelligence boost

The advisor strategy: Give agents an intelligence boostThe advisor strategy: Give agents an intelligence boost

Jun 25, 2025

### Turn ideas into interactive AI-powered apps

Product announcements

Turn ideas into interactive AI-powered appsTurn ideas into interactive AI-powered apps

Turn ideas into interactive AI-powered appsTurn ideas into interactive AI-powered apps

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
