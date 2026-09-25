---
title: "Claude Tag now supports personal connectors in channels | Claude by Anthropic"
url: https://claude.com/blog/claude-tag-now-supports-personal-connectors-in-channels
slug: claude-tag-now-supports-personal-connectors-in-channels
fetched: 2026-09-25 05:45 UTC
---

# Claude Tag now supports personal connectors in channels | Claude by Anthropic

> Source: https://claude.com/blog/claude-tag-now-supports-personal-connectors-in-channels




# Claude Tag now supports personal connectors in channels

Claude Tag can now use your connectors for requests you make in a channel. Nobody else can use them, and you're in control of how to present the output. 

- Category

Product announcements

Enterprise AI

- Product

Claude Tag

- Date

September 24, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/claude-tag-now-supports-personal-connectors-in-channels

Claude Tag (beta) lets you add Claude to a Slack channel, where it works alongside your team. Until now, Claude could only use the connectors an admin attached to the channel, and most organizations keep that list short on purpose: they want access to follow the person, not the channel. 

Now Claude can use your own connectors for a request you make in a channel. For example, your calendar, your drive, your assigned accounts on the CRM, or your staging deploys. If you have connected it to your Claude account, you can access it in the channel. 

You decide how information is surfaced from when you ask Claude to access your connectors. You can review each response before it posts. Alternatively, you can use auto mode to post automatically unless Claude determines there is sensitive content that needs your review. On  Enterprise plans, admins will be able to require review for everyone.

Personal connectors provide admins more governance options. They can provide access to a shared set of tools under an agent identity, have channel members only use personal connectors to rely on existing role-based access, or decide tool by tool. 

Personal connectors in Claude Tag are rolling out now on Team plans, with Enterprise to follow. 

## Using personal connectors

Most of what people need in a channel sits behind their own login: a time that works on your calendar, your open deals, a plan only you can open. Now you can ask for those in the channel too.

For example, here's Priya in #checkout-migration, a channel connected to GitHub. She asks: "@Claude check my Google Drive doc 'Checkout migration, Q3' against what we've shipped. What's still open?"

Priya asks Claude in #checkout-migration to check her plan against what shipped. The channel reaches GitHub. Only Priya can open the doc.

Claude reads the merged pull requests through the channel's GitHub connector. The doc is one only Priya can open. Before, Claude would have stopped there. 

Now Claude reads the doc through Priya's Google Drive connector, separately from the channel's work, and posts what shipped and what's left. Priya's plan isn't sensitive, so she uses auto mode and Claude screens the comparison before it posts. For a document she'd rather check first, she can switch to review mode and see the response before the channel does.

The same thread. Claude's reply with the comparison, and the review prompt showing what will post before it does.

Everything Claude does through your connector appears in that tool's own log under your account, the way your direct-message work does today. The channel's own work stays under its service account, the one your security team already follows.

You decide what Claude reaches and what the channel sees, the same as when you use your connectors in a direct message, and you can disconnect a connector at any time.

## Where the channel's own connectors still matter

Personal connectors don't run unattended. Scheduled routines, and anything Claude starts on its own, use the connectors an admin attached to the channel. Tools that are needed for unattended actions, or actions the entire channel relies on, should use shared connectors. 

For example, you may want to add Claude to your #on-call channel to help with CI triage and response. Claude can identify and help remediate issues (even after work hours) if you set up shared connectors to your runbook, monitoring tools, and deployment history.

A channel that solely relies on personal connectors suits closely supervised work. For example, collaboratively drafting an RFP response may require pulling data from pricing or other sensitive sources that are not provisioned to the entire channel. Anything Claude posts is visible to everyone in the channel.

## What's next

There's nothing to install. When a request of yours needs one of your connectors, Claude asks you the first time, then uses it in the thread.

Ask @Claude in a channel for what only you can reach. Learn more about Claude Tag.

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

Sep 24, 2026

### Coding sessions are longer and use more context. Claude Opus 5.5 is built with that in mind.

Claude Code

Coding sessions are longer and use more context. Claude Opus 5.5 is built with that in mind.Coding sessions are longer and use more context. Claude Opus 5.5 is built with that in mind.

Coding sessions are longer and use more context. Claude Opus 5.5 is built with that in mind.Coding sessions are longer and use more context. Claude Opus 5.5 is built with that in mind.

Oct 20, 2025

### Claude Code on the web

Product announcements

Claude Code on the webClaude Code on the web

Claude Code on the webClaude Code on the web

Sep 16, 2026

### Claude Cowork and chat are now one Claude

Product announcements

Claude Cowork and chat are now one ClaudeClaude Cowork and chat are now one Claude

Claude Cowork and chat are now one ClaudeClaude Cowork and chat are now one Claude

Sep 23, 2026

### Claude Marketplace: one place to discover plugins, agents, and services from our partners

Product announcements

Claude Marketplace: one place to discover plugins, agents, and services from our partnersClaude Marketplace: one place to discover plugins, agents, and services from our partners

Claude Marketplace: one place to discover plugins, agents, and services from our partnersClaude Marketplace: one place to discover plugins, agents, and services from our partners

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
