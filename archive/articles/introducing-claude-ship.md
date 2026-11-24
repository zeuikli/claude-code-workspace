---
title: "Introducing Claude Ship"
url: https://claude.com/resources/articles/introducing-claude-ship
slug: introducing-claude-ship
fetched: 2026-11-24 10:39 UTC
---

# Introducing Claude Ship

> Source: https://claude.com/resources/articles/introducing-claude-ship

> Open a pull request and get back to building. Claude can now review pull requests, fix them, and approve the ones that a team&#x27;s policy allows.


# Introducing Claude Ship

Open a pull request and get back to building. Claude can now review pull requests, fix them, and approve the ones that a team's policy allows.

-

DateNovember 23, 2026

-

Reading time6 min

-

ShareCopy link

Anyone who has opened a pull request knows how this goes. They start on the next thing, and then the review comes back. So they stop, dig back into the old code, push a fix, and wait for the review to run again. Then they go find someone to approve it.

There's a good reason it works this way. Most teams want a person to approve every change, and that's easy to keep up with when people write every line. But a lot of developers build with agents now. On the Claude Code team, Claude writes most of our code, and we wanted everything after the PR to move that fast too.

That's why we built Claude Ship, available today in beta. It can review PRs, fix them, and decide what's ready to merge based on policies each team sets. Teams stay in control of where it runs and which changes need a person. The goal: ship code as fast as teams write it.

Eligible Claude Enterprise organizations can claim at least $10,000 in Claude Ship credits to use within 30 days of claiming. Claim by January 15, 2027. Terms apply.

### How Claude Ship works: review, fix, and approve

Claude Ship is made up of Code Review, which is already generally available, and two new agents in beta: PR Steward and Claude Approvals. Together, they take a pull request through review, fixes, and an approval decision so teams don't have to manage each step manually.

Code Review performs an in-depth review of pull requests against the codebase through multiple lenses. It collects findings, adversarially verifies them, categorizes them, and posts them to a PR. On the Claude Code team, where Claude's review is one layer of a broader process, merged PRs more than doubled from June to September while the share reverted fell by more than 40%. Code Review gives teams fast reviews, clear findings, and a choice of Quick, Standard, or Deep review levels for each repository.

PR Steward works to keep a PR green, but is designed not to approve or merge pull requests. It jumps in on failing CI checks, merge conflicts, and review feedback from Code Review, other review tools, or team members. After every push, it comments with what it changed and how to undo it. Developers can comment `@claude` with an instruction to steer the work, or `@claude stop` to have it step back.

From there, Claude Approvals applies an approval policy that the team writes as a file in the repository. Claude can approve routine changes on its own if the policy allows it, or can require deeper human sign-off for certain scenarios. It works like a smarter CODEOWNERS file. Teams can have Claude Approvals consider a variety of signals in its decision-making process, including Code Review findings or their own classifiers using natural language. For most customers, we recommend enabling this first in observe-only mode to build confidence before configuring branch protection to require Claude Approvals' green light.

## Two ways to get started

### For developers: `/ship` it from Claude Code

Developers can try Claude Ship on their own pull requests with the new `/ship` command in Claude Code. When a change is ready, they run `/ship`. Claude pushes it, opens the PR, reviews the change, and works on feedback and failing checks to help get it ready to merge. What can merge depends on the developer's permissions and the repository's branch rules.

### For admins and engineering leaders: set the rules, one repository at a time

Turning Claude Ship on for an entire repository puts it to work across a team's pull requests automatically, under settings and an approval policy the team controls. Developers don't need to manually invoke the `/ship` command.

- Admins choose where it runs. An admin turns on Code Review and PR Steward for each repository. Claude Approvals starts when a connected repository has a policy file on its default branch, and an admin can turn it off.
- Each repository gets the settings it needs. Admins choose the review level (Quick, Standard, or Deep), choose when reviews run, and configure spend limits.
- Teams keep the tools they have. Claude Ship works with existing branch protection and required checks.

Teams set the pace. They can start with one repository, choose a review level and when reviews run, set a monthly spend limit, and run their approval policy in observe mode until they trust it.

### How the Claude Code team ships

We run Claude Ship on many of our own pull requests. One of the biggest changes is who can act on customer feedback. For example, a product manager on the Claude Code team can now read a piece of feedback, talk through ideas and tradeoffs with Claude Tag, have it open a PR, and move on to the next thing while Claude Ship takes it through review, fixes, and an approval decision.

Recently, a customer was confused because our Analytics API documentation implied an Admin key could pull Pro and Team usage. The PM asked Claude Tag whether a fix was in flight, and it opened one. Code Review found nothing blocking, a docs reviewer signed off, Claude Approvals passed, and the fix merged that same evening.

### What customers are saying

“We have had numerous cases where Claude Code Review caught real issues before a human reviewer got to the pull request, and PR Steward helped the contributor fix them. Our reviewers were already using Claude Code to keep up with the volume, so having Code Review, PR Steward and Claude Approvals start automatically when a pull request opens makes that simpler. We keep a human in the loop, and the human’s time now goes to the changes that need it.”

Vatsal Bhatt, Director of Engineering

“PR Steward is helping teams in our pilot spend less time working through code review feedback and more time building. We can tailor it to our teams’ processes, including how it suggests changes and organizes feedback. That flexibility has made it a useful part of the development workflow.”

Alex Devkar, Senior Vice President, Engineering and Analytics

### Availability

Claude Ship is available on Claude Team and Enterprise plans for repositories on GitHub. Code Review is generally available, and PR Steward and Claude Approvals are in beta.

Claude Ship usage is billed on tokens, so turning it on can add to an organization’s costs. The amount depends on the number and size of pull requests covered, the review level, how often reviews run, and how much work PR Steward does. Admins can set spend limits for Code Review and PR Steward. Claude Approvals has no base charge, but classifiers in a policy are billed on the tokens they use, and a policy that uses Claude's review triggers a billed Code Review, even in observe mode. Running `/ship` counts as regular Claude Code usage.

Claude Ship is not available to organizations with Zero Data Retention, the HIPAA configuration, or customer-managed encryption keys.

### Get started

Developers can update Claude Code and run `/ship` on their next change. `/ship` is rolling out in Claude Code and the desktop app starting today.

Teams already using Code Review can add PR Steward on a repository, and an approval policy in observe mode.

Teams new to Code Review can read the setup guide to connect GitHub and turn on their first repository.

Learn more in documentation.

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleNov 23, 2026

### KPMG's Todd Lohr on AI when your data is also your clients' data

Todd Lohr, KPMG US Vice Chair and Head of Client Technology & Innovation, on adopting frontier AI and building safeguards at the same time, and what that means for a firm that holds its clients' most sensitive data.

Claude Enterprise

ArticleNov 23, 2026

### Zero data retention with Enterprise Frontier Safeguards is now in beta

Claude Platform

ArticleNov 23, 2026

### The enterprise guide to securing coding agents

How security and technical leaders can understand and bound risk as they scale Claude Code

Claude Code

ArticleNov 17, 2026

### Linked billing on the Claude Platform

Claude Platform
