---
title: "Redesigning Claude Code on desktop for parallel agents"
url: https://claude.com/blog/claude-code-desktop-redesign
slug: claude-code-desktop-redesign
fetched: 2026-04-17 15:43 UTC
---

# Redesigning Claude Code on desktop for parallel agents

> Source: https://claude.com/blog/claude-code-desktop-redesign




# Redesigning Claude Code on desktop for parallel agents

Today, we're releasing a redesign of the Claude Code desktop app, built to help you run more Claude Code tasks at once.

Download app

Download appDownload app

Read documentation

Read documentationRead documentation

- Category

Claude Code

Product announcements

- Product

Claude Code

- Date

April 14, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/claude-code-desktop-redesign

It includes a new sidebar for managing multiple sessions, a drag-and-drop layout for arranging your workspace, an integrated terminal and file editor, plus performance and quality-of-life improvements.

## The new desktop experience

For many developers, the shape of agentic work has changed. You're not typing one prompt and waiting. You're kicking off a refactor in one repo, a bug fix in another, and a test-writing pass in a third, checking on each as results come in, steering when something drifts, and reviewing diffs before you ship. 

The new app is built for how agentic coding actually feels now: many things in flight, and you in the orchestrator seat.

## Run sessions in parallel

The new sidebar puts every active and recent session in one place. Kick off work across multiple repos and move between them as results arrive.

You can filter by status, project, or environment, or group the sidebar by project to find and resume sessions faster. When a session's PR merges or closes, it archives itself so the sidebar stays focused on what's live.

When you need to ask a question mid-task, you can open a side chat (⌘ + ; or Ctrl + ;) to branch off a conversation. Side chats pull context from the main thread, but don’t add anything back to the thread, to avoid misdirecting your tasks.

## Review and ship without leaving the app

The redesign brings more commonly-used tools into the app, so you can review, tweak, and ship Claude's work without bouncing to your editor:

- Integrated terminal: Run tests or builds alongside your session.
- In-app file editor: Open files, make spot edits directly, and save changes.
- Faster diff viewer: Rebuilt for performance on large changesets.
- Expanded preview: Open HTML files or PDFs in-app, in addition to running local app servers in the preview pane.

Every pane is drag-and-drop. Arrange the terminal, preview, diff viewer, and chat in whatever grid matches how you work.

## Fits your stack

The desktop app now has parity with CLI plugins. If your org manages Claude Code plugins centrally, or you've installed your own locally, they work in the desktop app exactly the way they do in your terminal.

You can still run sessions locally or in the cloud. SSH support now extends to Mac alongside Linux, so you can point sessions at remote machines from either platform.

## Customize for how you work

Three view modes—Verbose, Normal, and Summary—let you dial the interface from full transparency into Claude's tool calls to just the results. New keyboard shortcuts cover session switching, spawning, and navigation; press `⌘ + /` (or `Ctrl + /`) to see the full list. A new usage button shows both your context window and session usage at a glance.

Under the hood, the app has been rebuilt for reliability and speed, and now streams responses as Claude generates them.

## Getting started

The redesigned desktop app is available now for all Claude Code users on Pro, Max, Team, and Enterprise plans, and via the Claude API.

Download the app, or update and restart if you already have it. Explore the documentation to learn more.

No items found.

PrevPrev

0/5

NextNext

eBook

##

FAQ

No items found.

Get Claude Code

curl -fsSL https://claude.ai/install.sh | bash

Copy command to clipboard

irm https://claude.ai/install.ps1 | iex

Copy command to clipboard

Or read the documentation

Try Claude Code

Try Claude CodeTry Claude Code

Developer docs

Developer docsDeveloper docs

## Related posts

Explore more product news and best practices for teams building with Claude.

Apr 16, 2026

### Best practices for using Claude Opus 4.7 with Claude Code

Claude Code

Best practices for using Claude Opus 4.7 with Claude CodeBest practices for using Claude Opus 4.7 with Claude Code

Best practices for using Claude Opus 4.7 with Claude CodeBest practices for using Claude Opus 4.7 with Claude Code

Apr 15, 2026

### Using Claude Code: session management and 1M context

Claude Code

Using Claude Code: session management and 1M contextUsing Claude Code: session management and 1M context

Using Claude Code: session management and 1M contextUsing Claude Code: session management and 1M context

Apr 14, 2026

### Introducing routines in Claude Code

Product announcements

Introducing routines in Claude CodeIntroducing routines in Claude Code

Introducing routines in Claude CodeIntroducing routines in Claude Code

Apr 10, 2026

### Seeing like an agent: how we design tools in Claude Code

Claude Code

Seeing like an agent: how we design tools in Claude CodeSeeing like an agent: how we design tools in Claude Code

Seeing like an agent: how we design tools in Claude CodeSeeing like an agent: how we design tools in Claude Code

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
