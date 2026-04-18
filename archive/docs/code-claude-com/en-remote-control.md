

Skip to main content

Claude Code Docs home page

English

Search...

⌘KAsk AI

Search...

Navigation

Platforms and integrations

Continue local sessions from any device with Remote Control

Getting started

Build with Claude Code

Deployment

Administration

Configuration

Reference

Agent SDK

What's New

Resources

Getting started

-

Overview

-

Quickstart

-

Changelog

Core concepts

-

How Claude Code works

-

Extend Claude Code

-

Explore the .claude directory

-

Explore the context window

Use Claude Code

-

Store instructions and memories

-

Permission modes

-

Common workflows

-

Best practices

Platforms and integrations

-

Overview

-

Remote Control

-
Claude Code on the web

-
Claude Code on desktop

-

Chrome extension (beta)

-

Computer use (preview)

-

Visual Studio Code

-

JetBrains IDEs

-
Code review & CI/CD

-

Claude Code in Slack

On this page

- Requirements
- Start a Remote Control session
- Connect from another device
- Enable Remote Control for all sessions
- Connection and security
- Remote Control vs Claude Code on the web
- Mobile push notifications
- Limitations
- Troubleshooting
- ”Remote Control requires a claude.ai subscription”
- ”Remote Control requires a full-scope login token”
- ”Unable to determine your organization for Remote Control eligibility”
- ”Remote Control is not yet enabled for your account”
- ”Remote Control is disabled by your organization’s policy”
- ”Remote credentials fetch failed”
- Choose the right approach
- Related resources

Platforms and integrations

# Continue local sessions from any device with Remote Control

Copy page

Continue a local Claude Code session from your phone, tablet, or any browser using Remote Control. Works with claude.ai/code and the Claude mobile app.

Copy page

Remote Control is available on all plans. On Team and Enterprise, it is off by default until an admin enables the Remote Control toggle in Claude Code admin settings.

Remote Control connects claude.ai/code or the Claude app for iOS and Android to a Claude Code session running on your machine. Start a task at your desk, then pick it up from your phone on the couch or a browser on another computer.
When you start a Remote Control session on your machine, Claude keeps running locally the entire time, so nothing moves to the cloud. With Remote Control you can:

- Use your full local environment remotely: your filesystem, MCP servers, tools, and project configuration all stay available

- Work from both surfaces at once: the conversation stays in sync across all connected devices, so you can send messages from your terminal, browser, and phone interchangeably

- Survive interruptions: if your laptop sleeps or your network drops, the session reconnects automatically when your machine comes back online

Unlike Claude Code on the web, which runs on cloud infrastructure, Remote Control sessions run directly on your machine and interact with your local filesystem. The web and mobile interfaces are just a window into that local session.

Remote Control requires Claude Code v2.1.51 or later. Check your version with `claude --version`.

This page covers setup, how to start and connect to sessions, and how Remote Control compares to Claude Code on the web.

##
​

Requirements

Before using Remote Control, confirm that your environment meets these conditions:

- Subscription: available on Pro, Max, Team, and Enterprise plans. API keys are not supported. On Team and Enterprise, an admin must first enable the Remote Control toggle in Claude Code admin settings.

- Authentication: run `claude` and use `/login` to sign in through claude.ai if you haven’t already.

- Workspace trust: run `claude` in your project directory at least once to accept the workspace trust dialog.

##
​

Start a Remote Control session

You can start a Remote Control session from the CLI or the VS Code extension. The CLI offers three invocation modes; VS Code uses the `/remote-control` command.

- Server mode

- Interactive session

- From an existing session

- VS Code

Navigate to your project directory and run:

```
`claude remote-control
`
```

The process stays running in your terminal in server mode, waiting for remote connections. It displays a session URL you can use to connect from another device, and you can press spacebar to show a QR code for quick access from your phone. While a remote session is active, the terminal shows connection status and tool activity.Available flags:

FlagDescription

`--name "My Project"`Set a custom session title visible in the session list at claude.ai/code.

`--remote-control-session-name-prefix <prefix>`Prefix for auto-generated session names when no explicit name is set. Defaults to your machine’s hostname, producing names like `myhost-graceful-unicorn`. Set `CLAUDE_REMOTE_CONTROL_SESSION_NAME_PREFIX` for the same effect.

`--spawn <mode>`How the server creates sessions.
• `same-dir` (default): all sessions share the current working directory, so they can conflict if editing the same files.
• `worktree`: each on-demand session gets its own git worktree. Requires a git repository.
• `session`: single-session mode. Serves exactly one session and rejects additional connections. Set at startup only.
Press `w` at runtime to toggle between `same-dir` and `worktree`.

`--capacity <N>`Maximum number of concurrent sessions. Default is 32. Cannot be used with `--spawn=session`.

`--verbose`Show detailed connection and session logs.

`--sandbox` / `--no-sandbox`Enable or disable sandboxing for filesystem and network isolation. Off by default.

To start a normal interactive Claude Code session with Remote Control enabled, use the `--remote-control` flag (or `--rc`):

```
`claude --remote-control
`
```

Optionally pass a name for the session:

```
`claude --remote-control "My Project"
`
```

This gives you a full interactive session in your terminal that you can also control from claude.ai or the Claude app. Unlike `claude remote-control` (server mode), you can type messages locally while the session is also available remotely.

If you’re already in a Claude Code session and want to continue it remotely, use the `/remote-control` (or `/rc`) command:

```
`/remote-control
`
```

Pass a name as an argument to set a custom session title:

```
`/remote-control My Project
`
```

This starts a Remote Control session that carries over your current conversation history and displays a session URL and QR code you can use to connect from another device. The `--verbose`, `--sandbox`, and `--no-sandbox` flags are not available with this command.

In the Claude Code VS Code extension, type `/remote-control` or `/rc` in the prompt box, or open the command menu with `/` and select it. Requires Claude Code v2.1.79 or later.

```
`/remote-control
`
```

A banner appears above the prompt box showing connection status. Once connected, click Open in browser in the banner to go directly to the session, or find it in the session list at claude.ai/code. The session URL is also posted in the conversation.To disconnect, click the close icon on the banner or run `/remote-control` again.Unlike the CLI, the VS Code command does not accept a name argument or display a QR code. The session title is derived from your conversation history or first prompt.

###
​

Connect from another device

Once a Remote Control session is active, you have a few ways to connect from another device:

- Open the session URL in any browser to go directly to the session on claude.ai/code.

- Scan the QR code shown alongside the session URL to open it directly in the Claude app. With `claude remote-control`, press spacebar to toggle the QR code display.

- Open claude.ai/code or the Claude app and find the session by name in the session list. Remote Control sessions show a computer icon with a green status dot when online.

The remote session title is chosen in this order:

- The name you passed to `--name`, `--remote-control`, or `/remote-control`

- The title you set with `/rename`

- The last meaningful message in existing conversation history

- An auto-generated name like `myhost-graceful-unicorn`, where `myhost` is your machine’s hostname or the prefix you set with `--remote-control-session-name-prefix`

If you didn’t set an explicit name, the title updates to reflect your prompt once you send one.
If the environment already has an active session, you’ll be asked whether to continue it or start a new one.
If you don’t have the Claude app yet, use the `/mobile` command inside Claude Code to display a download QR code for iOS or Android.

###
​

Enable Remote Control for all sessions

By default, Remote Control only activates when you explicitly run `claude remote-control`, `claude --remote-control`, or `/remote-control`. To enable it automatically for every interactive session, run `/config` inside Claude Code and set Enable Remote Control for all sessions to `true`. Set it back to `false` to disable.
With this setting on, each interactive Claude Code process registers one remote session. If you run multiple instances, each one gets its own environment and session. To run multiple concurrent sessions from a single process, use server mode instead.

##
​

Connection and security

Your local Claude Code session makes outbound HTTPS requests only and never opens inbound ports on your machine. When you start Remote Control, it registers with the Anthropic API and polls for work. When you connect from another device, the server routes messages between the web or mobile client and your local session over a streaming connection.
All traffic travels through the Anthropic API over TLS, the same transport security as any Claude Code session. The connection uses multiple short-lived credentials, each scoped to a single purpose and expiring independently.

##
​

Remote Control vs Claude Code on the web

Remote Control and Claude Code on the web both use the claude.ai/code interface. The key difference is where the session runs: Remote Control executes on your machine, so your local MCP servers, tools, and project configuration stay available. Claude Code on the web executes in Anthropic-managed cloud infrastructure.
Use Remote Control when you’re in the middle of local work and want to keep going from another device. Use Claude Code on the web when you want to kick off a task without any local setup, work on a repo you don’t have cloned, or run multiple tasks in parallel.

##
​

Mobile push notifications

When Remote Control is active, Claude can send push notifications to your phone.
Claude decides when to push. It typically sends one when a long-running task finishes or when it needs a decision from you to continue. You can also request a push in your prompt, for example `notify me when the tests finish`. Beyond the on/off toggle below, there is no per-event configuration.

Mobile push notifications require Claude Code v2.1.110 or later.

To set up mobile push notifications:

1

Install the Claude mobile app

Download the Claude app for iOS or Android.

2

Sign in with your Claude Code account

Use the same account and organization you use for Claude Code in the terminal.

3

Allow notifications

Accept the notification permission prompt from the operating system.

4

Enable push in Claude Code

In your terminal, run `/config` and enable Push when Claude decides.

If notifications don’t arrive:

- If `/config` shows No mobile registered, open the Claude app on your phone so it can refresh its push token. The warning clears the next time Remote Control connects.

- On iOS, Focus modes and notification summaries can suppress or delay pushes. Check Settings → Notifications → Claude.

- On Android, aggressive battery optimization can delay delivery. Exempt the Claude app from battery optimization in system settings.

##
​

Limitations

- One remote session per interactive process: outside of server mode, each Claude Code instance supports one remote session at a time. Use server mode to run multiple concurrent sessions from a single process.

- Local process must keep running: Remote Control runs as a local process. If you close the terminal, quit VS Code, or otherwise stop the `claude` process, the session ends.

- Extended network outage: if your machine is awake but unable to reach the network for more than roughly 10 minutes, the session times out and the process exits. Run `claude remote-control` again to start a new session.

- Ultraplan disconnects Remote Control: starting an ultraplan session disconnects any active Remote Control session because both features occupy the claude.ai/code interface and only one can be connected at a time.

- Some commands are local-only: commands that open an interactive picker in the terminal, such as `/mcp`, `/plugin`, or `/resume`, work only from the local CLI. Commands that produce text output, including `/compact`, `/clear`, `/context`, `/cost`, `/exit`, `/recap`, and `/reload-plugins`, work from mobile and web.

##
​

Troubleshooting

###
​

”Remote Control requires a claude.ai subscription”

You’re not authenticated with a claude.ai account. Run `claude auth login` and choose the claude.ai option. If `ANTHROPIC_API_KEY` is set in your environment, unset it first.

###
​

”Remote Control requires a full-scope login token”

You’re authenticated with a long-lived token from `claude setup-token` or the `CLAUDE_CODE_OAUTH_TOKEN` environment variable. These tokens are limited to inference-only and cannot establish Remote Control sessions. Run `claude auth login` to authenticate with a full-scope session token instead.

###
​

”Unable to determine your organization for Remote Control eligibility”

Your cached account information is stale or incomplete. Run `claude auth login` to refresh it.

###
​

”Remote Control is not yet enabled for your account”

The eligibility check can fail with certain environment variables present:

- `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` or `DISABLE_TELEMETRY`: unset them and try again.

- `CLAUDE_CODE_USE_BEDROCK`, `CLAUDE_CODE_USE_VERTEX`, or `CLAUDE_CODE_USE_FOUNDRY`: Remote Control requires claude.ai authentication and does not work with third-party providers.

If none of these are set, run `/logout` then `/login` to refresh.

###
​

”Remote Control is disabled by your organization’s policy”

This error has three distinct causes. Run `/status` first to see which login method and subscription you’re using.

- You’re authenticated with an API key or Console account: Remote Control requires claude.ai OAuth. Run `/login` and choose the claude.ai option. If `ANTHROPIC_API_KEY` is set in your environment, unset it.

- Your Team or Enterprise admin hasn’t enabled it: Remote Control is off by default on these plans. An admin can enable it at claude.ai/admin-settings/claude-code by turning on the Remote Control toggle. This is a server-side organization setting, not a managed settings key.

- The admin toggle is grayed out: your organization has a data retention or compliance configuration that is incompatible with Remote Control. This cannot be changed from the admin panel. Contact Anthropic support to discuss options.

###
​

”Remote credentials fetch failed”

Claude Code could not obtain a short-lived credential from the Anthropic API to establish the connection. Re-run with `--verbose` to see the full error:

```
`claude remote-control --verbose
`
```

Common causes:

- Not signed in: run `claude` and use `/login` to authenticate with your claude.ai account. API key authentication is not supported for Remote Control.

- Network or proxy issue: a firewall or proxy may be blocking the outbound HTTPS request. Remote Control requires access to the Anthropic API on port 443.

- Session creation failed: if you also see `Session creation failed — see debug log`, the failure happened earlier in setup. Check that your subscription is active.

##
​

Choose the right approach

Claude Code offers several ways to work when you’re not at your terminal. They differ in what triggers the work, where Claude runs, and how much you need to set up.

TriggerClaude runs onSetupBest for

DispatchMessage a task from the Claude mobile appYour machine (Desktop)Pair the mobile app with DesktopDelegating work while you’re away, minimal setup

Remote ControlDrive a running session from claude.ai/code or the Claude mobile appYour machine (CLI or VS Code)Run `claude remote-control`Steering in-progress work from another device

ChannelsPush events from a chat app like Telegram or Discord, or your own serverYour machine (CLI)Install a channel plugin or build your ownReacting to external events like CI failures or chat messages

SlackMention `@Claude` in a team channelAnthropic cloudInstall the Slack app with Claude Code on the web enabledPRs and reviews from team chat

Scheduled tasksSet a scheduleCLI, Desktop, or cloudPick a frequencyRecurring automation like daily reviews

##
​

Related resources

- Claude Code on the web: run sessions in Anthropic-managed cloud environments instead of on your machine

- Ultraplan: launch a cloud planning session from your terminal and review the plan in your browser

- Channels: forward Telegram, Discord, or iMessage into a session so Claude reacts to messages while you’re away

- Dispatch: message a task from your phone and it can spawn a Desktop session to handle it

- Authentication: set up `/login` and manage credentials for claude.ai

- CLI reference: full list of flags and commands including `claude remote-control`

- Security: how Remote Control sessions fit into the Claude Code security model

- Data usage: what data flows through the Anthropic API during local and remote sessions

Was this page helpful?

YesNo

OverviewGet started

⌘I

Assistant

Responses are generated using AI and may contain mistakes.