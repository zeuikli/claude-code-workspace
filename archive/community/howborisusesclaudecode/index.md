

claude-cli â How Boris Uses Claude Code

            About
            Claudeonomics

                Part 1 13

                Part 2 10

                Part 3 12

                Part 4 5

                Part 5 2

                Part 6 3

                Part 7 8

                Part 8 4

                Part 9 15

                Part 10
                7

                Part 11

                    8
                    New

                Install Skill

                How To Use Skills

                ~
                intro

                1
                parallel

                2
                web+mobile

                3
                opus

                4
                CLAUDE.md

                5
                @.claude

                6
                plan

                7
                slash

                8
                subagents

                9
                hooks

                10
                perms

                11
                tools

                12
                long-run

                13
                verify

                ~
                intro

                1
                worktrees

                2
                plan

                3
                CLAUDE.md

                4
                skills

                5
                bugs

                6
                prompting

                7
                terminal

                8
                subagents

                9
                data

                10
                learning

                ~
                intro

                1
                terminal

                2
                effort

                3
                plugins

                4
                agents

                5
                permissions

                6
                sandbox

                7
                statusline

                8
                keybindings

                9
                hooks

                10
                spinners

                11
                output

                12
                customize

                ~
                intro

                1
                cli

                2
                desktop

                3
                subagents

                4
                agents

                5
                non-git

                ~
                intro

                1
                /simplify

                2
                /batch

                ~
                intro

                1
                /loop

                2
                code-review

                3
                /btw

                ~
                intro

                1
                /effort

                2
                remote

                3
                voice

                4
                setup

                5
                --name

                6
                auto-name

                7
                /color

                8
                postcompact

                ~
                intro

                1
                auto mode

                2
                /schedule

                3
                iMessage

                4
                memory

                ~
                intro

                1
                mobile

                2
                teleport

                3
                loops

                4
                hooks

                5
                dispatch

                6
                chrome

                7
                desktop

                8
                fork

                9
                /btw

                10
                worktrees

                11
                /batch

                12
                --bare

                13
                --add-dir

                14
                --agent

                15
                /voice

                ~
                intro

                1
                routines

                2
                /rewind

                3
                /compact vs /clear

                4
                auto-compact

                5
                delegate

                6
                full context

                7
                xhigh

                ~
                intro

                1
                auto mode

                2
                /fewer-perms

                3
                recaps

                4
                /focus

                5
                effort

                6
                /go

                7
                4.6â4.7

                8
                notifications

                ~
                guide

                ~
                install

# How Boris Cherny Uses Claude Code

                        Boris created Claude Code at Anthropic. When asked how he uses it, he shared 13 practical tips from his daily workflow. His setup is "surprisingly vanilla" â proof that CC works great out of the box.

                        @bcherny's January 2, 2026 thread

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

Run 5 Claudes in Parallel

Boris runs 5 instances of Claude Code simultaneously in his terminal using 5 separate git checkouts of the same repo. He numbers his tabs 1-5 for easy reference and uses system notifications to know when any Claude needs input.

Key detail

                        Each tab runs in its own git checkout, so Claude can make changes in parallel without conflicts. Configure iTerm2 notifications to know when any Claude needs attention.

~/repo-1 $ # Tab 1: Working on feature
~/repo-2 $ # Tab 2: Running tests
~/repo-3 $ # Tab 3: Code review
~/repo-4 $ # Tab 4: Debugging
~/repo-5 $ # Tab 5: Documentation

                        View original post

                    â intro
                    web+mobile â

2

Parallel Web and Mobile Sessions

Beyond the terminal, Boris runs 5-10 additional sessions on claude.ai/code. He fluidly hands off between local and web using the `&` command or `--teleport` flag.

He also kicks off sessions from his phone via the Claude iOS app in the morning, then picks them up on his computer later.

Key commands

                        `&` â Background a session

                        `--teleport` â Switch contexts between local and web

                        View original post

                    â parallel
                    opus â

3

Opus 4.5 with Thinking for Everything

Boris uses Opus 4.5 with thinking mode for every task. His reasoning:

Why Opus over Sonnet

                        "It's the best coding model I've ever used, and even though it's bigger & slower than Sonnet, since you have to steer it less and it's better at tool use, it is almost always faster than using a smaller model in the end."

The takeaway: less steering + better tool use = faster overall results, even with a larger model.

                        View original post

                    â web+mobile
                    CLAUDE.md â

4

Shared CLAUDE.md Documentation

The team shares a single CLAUDE.md file for the Claude Code repo, checked into git. The whole team contributes multiple times a week.

Key practice

                        "Anytime we see Claude do something incorrectly we add it to the CLAUDE.md, so Claude knows not to do it next time."

claude-cli $ cat CLAUDE.md
# Development Workflow

**Always use `bun`, not `npm`.**

# 1. Make changes
# 2. Typecheck (fast)
bun run typecheck

# 3. Run tests
bun run test -- -t "test name"    # Single suite
bun run test:file -- "glob"       # Specific files

# 4. Lint before committing
bun run lint:file -- "file1.ts"   # Specific files
bun run lint                      # All files

# 5. Before creating PR
bun run lint:claude && bun run test

                        View original post

                    â opus
                    @.claude â

5

@.claude in Code Reviews

During code review, Boris tags @.claude on PRs to add learnings to the CLAUDE.md as part of the PR itself.

They use the Claude Code GitHub Action (`/install-github-action`) for this. Boris calls it their version of "Compounding Engineering" â inspired by Dan Shipper's concept.

// Example PR comment:
nit: use a string literal, not ts enum

@claude add to CLAUDE.md to never use enums,
always prefer literal unions

Result

                        Claude automatically updates the CLAUDE.md and commits: "Prefer `type` over `interface`; **never use `enum`** (use string literal unions instead)"

                        View original post

                    â CLAUDE.md
                    plan â

6

Start in Plan Mode

Most sessions start in Plan mode (shift+tab twice). Boris iterates on the plan with Claude until it's solid, then switches to auto-accept mode.

The workflow

                        Plan mode â Refine plan â Auto-accept edits â Claude 1-shots it

> i want to improve progress notification
  rendering for skills. can you make it look
  and feel a bit more like subagent progress?

â®â® plan mode on (shift+tab to cycle)

"A good plan is really important to avoid issues down the line."

                        View original post

                    â @.claude
                    slash â

7

Slash Commands for Inner Loops

Boris uses slash commands for workflows he does many times a day. This saves repeated prompting, and Claude can use them too.

Commands are checked into git under `.claude/commands/` and shared with the team.

> /commit-push-pr

  /commit-push-pr     Commit, push, and open a PR

Power feature

                        Slash commands can include inline Bash to pre-compute info (like git status) for quick execution without extra model calls.

                        View original post

                    â plan
                    subagents â

8

Subagents for Common Workflows

Boris thinks of subagents as automations for the most common PR workflows:

â¼ .claude
  â¼ agents
    â build-validator.md
    â code-architect.md
    â code-simplifier.md
    â oncall-guide.md
    â verify-app.md

Examples

                        code-simplifier â Cleans up code after Claude finishes

                        verify-app â Detailed instructions for end-to-end testing

                        View original post

                    â slash
                    hooks â

9

PostToolUse Hooks for Formatting

The team uses a PostToolUse hook to auto-format Claude's code. While Claude generates well-formatted code 90% of the time, the hook catches edge cases to prevent CI failures.

"PostToolUse": [
  {
    "matcher": "Write|Edit",
    "hooks": [
      {
        "type": "command",
        "command": "bun run format || true"
      }
    ]
  }
]

                        View original post

                    â subagents
                    perms â

10

Pre-Allow Safe Permissions

Instead of `--dangerously-skip-permissions`, Boris uses /permissions to pre-allow common safe commands. Most are shared in `.claude/settings.json`.

> /permissions

Permissions: Allow  Ask  Deny  Workspace

Claude Code won't ask before using allowed tools.

â 12.  Bash(bq query:*)
  13.  Bash(bun run build:*)
  14.  Bash(bun run lint:file:*)
  15.  Bash(bun run test:*)
  16.  Bash(bun run test:file:*)
  17.  Bash(bun run typecheck:*)
  18.  Bash(bun test:*)
  19.  Bash(cc:*)
  20.  Bash(comm:*)
> 21.  Bash(find:*)

                        View original post

                    â hooks
                    tools â

11

Tool Integrations

Claude Code uses all of Boris's tools autonomously:

- Searches and posts to Slack (via MCP server)

- Runs BigQuery queries with bq CLI

- Grabs error logs from Sentry

claude-cli-2 $ cat .mcp.json
{
  "mcpServers": {
    "slack": {
      "type": "http",
      "url": "https://slack.mcp.anthropic.com/mcp"
    }
  }
}

                        View original post

                    â perms
                    long-run â

12

Handle Long-Running Tasks

For very long-running tasks, Boris ensures Claude can work uninterrupted:

Options

                        (a) Prompt Claude to verify with a background agent when done

                        (b) Use an agent Stop hook for deterministic checks

                        (c) Use the "ralph-wiggum" plugin (community idea by @GeoffreyHuntley)

For sandboxed environments, he'll use `--permission-mode=dontAsk` or `--dangerously-skip-permissions` to avoid blocks.

* Reticulating... (1d 2h 47m Â· â 2.4m tokens Â· thinking)

>

                        View original post

                    â tools
                    verify â

13

The Most Important Tip: Verification

This is Boris's #1 tip:

Key insight

                        "Probably the most important thing to get great results out of Claude Code â give Claude a way to verify its work. If Claude has that feedback loop, it will 2-3x the quality of the final result."

For his own changes to claude.ai/code, Claude uses the Claude Chrome extension to open a browser, test UI changes, and iterate until it works perfectly.

Verification varies by domain: Bash commands, test suites, simulators, browser testing, etc. The key is giving Claude a way to close the feedback loop.

Takeaway

                        Invest in domain-specific verification for optimal performance. Claude tests every single change Boris lands to claude.ai/code.

                        View original post

                    â long-run
                    back to intro â

# More Tips from Boris Cherny

                        Boris shared 10 more tips on January 31, 2026. These are sourced directly from the Claude Code team â remember, everyone's setup is different. Experiment to see what works for you!

                        @bcherny's January 31, 2026 thread

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

Do More in Parallel

Spin up 3-5 git worktrees at once, each running its own Claude session in parallel. It's the single biggest productivity unlock, and the top tip from the team.

Why worktrees over checkouts

                        Most of the Claude Code team prefers worktrees â it's the reason @amorriscode built native support for them into the Claude Desktop app!

Some people also name their worktrees and set up shell aliases (za, zb, zc) so they can hop between them in one keystroke. Others have a dedicated "analysis" worktree that's only for reading logs and running BigQuery.

$ git worktree add .claude/worktrees/my-worktree origin/main

$ cd .claude/worktrees/my-worktree && claude

# Claude Code v2.1.29
# Opus 4.5 Â· Claude Enterprise
# .claude/worktrees/my-worktree

                        View original post

                    â intro
                    plan â

2

Start Every Complex Task in Plan Mode

Pour your energy into the plan so Claude can 1-shot the implementation. Don't keep pushing when things go sideways â switch back to plan mode and re-plan.

Team patterns

                        One person has one Claude write the plan, then they spin up a second Claude to review it as a staff engineer. Another says the moment something goes sideways, they switch back to plan mode and re-plan.

They also explicitly tell Claude to enter plan mode for verification steps, not just for the build.

> Try "refactor cli.tsx"

â®â® plan mode on (shift+Tab to cycle)

                        View original post

                    â worktrees
                    CLAUDE.md â

3

Invest in Your CLAUDE.md

After every correction, end with: "Update your CLAUDE.md so you don't make that mistake again." Claude is eerily good at writing rules for itself.

Key practice

                        Ruthlessly edit your CLAUDE.md over time. Keep iterating until Claude's mistake rate measurably drops.

One engineer tells Claude to maintain a notes directory for every task/project, updated after every PR. They then point CLAUDE.md at it.

Memory files  Â·  /memory
â ~/.claude/CLAUDE.md: 76 tokens
â CLAUDE.md: 4k tokens

                        View original post

                    â plan
                    skills â

4

Create Your Own Skills

Create your own skills and commit them to git. Reuse across every project.

Tips from the team

- If you do something more than once a day, turn it into a skill or command

- Build a /techdebt slash command and run it at the end of every session to find and kill duplicated code

- Set up a slash command that syncs 7 days of Slack, GDrive, Asana, and GitHub into one context dump

- Build analytics-engineer-style agents that write dbt models, review code, and test changes in dev

                        View original post

                    â CLAUDE.md
                    bugs â

5

Claude Fixes Most Bugs by Itself

Enable the Slack MCP, then paste a Slack bug thread into Claude and just say "fix." Zero context switching required.

Or, just say "Go fix the failing CI tests." Don't micromanage how.

Pro tip

                        Point Claude at docker logs to troubleshoot distributed systems â it's surprisingly capable at this.

> fix this https://ant.slack.com/archives/...

â slack - search_public (MCP)(query: "in:C07VBS...")
  Searches for messages in public Slack ch...

'slack_search_public' does NOT generally
for user consent to use 'slack_search_p...

                        View original post

                    â skills
                    prompting â

6

Level Up Your Prompting

a. Challenge Claude. Say "Grill me on these changes and don't make a PR until I pass your test." Make Claude be your reviewer. Or, say "Prove to me this works" and have Claude diff behavior between main and your feature branch.

b. After a mediocre fix, say: "Knowing everything you know now, scrap this and implement the elegant solution."

c. Write detailed specs and reduce ambiguity before handing work off. The more specific you are, the better the output.

Key insight

                        Don't accept the first solution. Push Claude to do better â it usually can.

                        View original post

                    â bugs
                    terminal â

7

Terminal & Environment Setup

The team loves Ghostty! Multiple people like its synchronized rendering, 24-bit color, and proper unicode support.

For easier Claude-juggling, use /statusline to customize your status bar to always show context usage and current git branch. Many of us also color-code and name our terminal tabs, sometimes using tmux â one tab per task/worktree.

Voice dictation

                        Use voice dictation. You speak 3x faster than you type, and your prompts get way more detailed as a result. (Hit fn x2 on macOS)

ââââââââââââââââââââââââââââââââââââââââââââ
â â â â  â  1 â1  â  2 â â2  â  3 â3  â  4 â
ââââââââââââââââââââââââââââââââââââââââââââ¤
â Ã * Claude Code (node)                   â
â                                          â
â Claude Code v2.1.29                      â
â Opus 4.5 Â· Claude Enterprise             â
â /code/claude                             â
ââââââââââââââââââââââââââââââââââââââââââââ

                        View original post

                    â prompting
                    subagents â

8

Use Subagents

a. Append "use subagents" to any request where you want Claude to throw more compute at the problem.

b. Offload individual tasks to subagents to keep your main agent's context window clean and focused.

c. Route permission requests to Opus 4.5 via a hook â let it scan for attacks and auto-approve the safe ones.

> use 5 subagents to explore the codebase

â I'll launch 5 explore agents in parallel to...

â Running 5 Explore agents... (ctrl+o to expand)
  ââ Explore entry points and startup Â· 10 t...
  â  â Bash: Find CLI or main entry files
  ââ Explore React components structure Â· 14...
  â  â Bash: ls -la /Users/boris/code/clau...
  ââ Explore tools implementation Â· 14 tool...
  â  â Bash: Find tool implementation files
  ââ Explore state management Â· 13 tool uses
  â  â Search: **/screens/REPL.tsx
  ââ Explore testing infrastructure Â· 13 to...
     â Search: test/mocks/**/*.ts

                        View original post

                    â terminal
                    data â

9

Use Claude for Data & Analytics

Ask Claude Code to use the "bq" CLI to pull and analyze metrics on the fly. We have a BigQuery skill checked into the codebase, and everyone on the team uses it for analytics queries directly in Claude Code.

Boris's take

                        "Personally, I haven't written a line of SQL in 6+ months."

This works for any database that has a CLI, MCP, or API.

                        View original post

                    â subagents
                    learning â

10

Learning with Claude

A few tips from the team to use Claude Code for learning:

a. Enable the "Explanatory" or "Learning" output style in /config to have Claude explain the why behind its changes.

b. Have Claude generate a visual HTML presentation explaining unfamiliar code. It makes surprisingly good slides!

c. Ask Claude to draw ASCII diagrams of new protocols and codebases to help you understand them.

d. Build a spaced-repetition learning skill: you explain your understanding, Claude asks follow-ups to fill gaps, stores the result.

Key takeaway

                        Claude Code isn't just for writing code â it's a powerful learning tool when you configure it to explain and teach.

                        View original post

                    â data
                    back to intro â

# Customize Your Claude

                        Boris shared 12 more tips on February 11, 2026. This time the theme is customization â hooks, plugins, agents, permissions, and all the ways to make Claude Code your own.

                        @bcherny's February 11, 2026 thread

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

Configure Your Terminal

A few quick settings to make Claude Code feel right in your terminal:

Key settings

- Theme: Run `/config` to set light/dark mode

- Notifications: Enable notifications for iTerm2, or use a custom notifs hook

- Newlines: If you use Claude Code in an IDE terminal, Apple Terminal, Warp, or Alacritty, run `/terminal-setup` to enable shift+enter for newlines (so you don't need to type `\`)

- Vim mode: Run `/vim`

                        View original post

                    â intro
                    effort â

2

Adjust Effort Level

Run `/model` to pick your preferred effort level:

Effort levels

- Low â less tokens & faster responses

- Medium â balanced behavior

- High â more tokens & more intelligence

Personally, I use High for everything.

||| High effort (default)  â â to adjust

Fast mode is ON and available with Opus 4.6

                        View original post

                    â terminal
                    plugins â

3

Install Plugins, MCPs, and Skills

Plugins let you install LSPs (now available for every major language), MCPs, skills, agents, and custom hooks.

Install a plugin from the official Anthropic plugin marketplace, or create your own marketplace for your company. Then, check the `settings.json` into your codebase to auto-add the marketplaces for your team.

Getting started

                        Run `/plugin` to browse and install plugins.

                        View original post

                    â effort
                    agents â

4

Create Custom Agents

To create custom agents, drop `.md` files in `.claude/agents`. Each agent can have a custom name, color, tool set, pre-allowed and pre-disallowed tools, permission mode, and model.

Pro tip

                        There's a little-known feature that lets you set the default agent used for the main conversation. Just set the `"agent"` field in your `settings.json` or use the `--agent` flag.

> use the sentry errors agent

sentry-errors(Fetch Sentry error logs)

  Search(pattern: "sentry", path: "src")
  +10 more tool uses (ctrl+o to expand)

Run `/agents` to get started.

                        View original post

                    â plugins
                    permissions â

5

Pre-Approve Common Permissions

Claude Code uses a sophisticated permission system with a combo of prompt injection detection, static analysis, sandboxing, and human oversight.

Out of the box, we pre-approve a small set of safe commands. To pre-approve more, run `/permissions` and add to the allow and block lists. Check these into your team's `settings.json`.

Wildcard syntax

                        We support full wildcard syntax. Try `"Bash(bun run *)"` or `"Edit(/docs/**)"`

> /permissions

Permissions: [Allow]  Ask  Deny

52. Bash(gh issue view:*)
53. Bash(gh pr checks:*)
54. Bash(gh pr comment:*)
55. Bash(gh pr diff:*)
56. Bash(gh pr list:*)

                        View original post

                    â agents
                    sandbox â

6

Enable Sandboxing

Opt into Claude Code's open source sandbox runtime to improve safety while reducing permission prompts.

Run `/sandbox` to enable it. Sandboxing runs on your machine, and supports both file and network isolation. Windows support coming soon.

Sandbox modes

- Sandbox BashTool, with auto-allow â commands run in sandbox, auto-approved

- Sandbox BashTool, with regular permissions â sandbox + normal permission prompts

- No Sandbox â default behavior

                        View original post

                    â permissions
                    statusline â

7

Add a Status Line

Custom status lines show up right below the composer, and let you show model, directory, remaining context, cost, and pretty much anything else you want to see while you work.

Everyone on the Claude Code team has a different statusline. Use `/statusline` to get started, to have Claude generate a statusline for you based on your `.bashrc`/`.zshrc`.

> _

[Opus] ð my-app | ð¿ feature/auth
ââââââââââââââââââ 42% | $0.08 | ð 7m 3s

                        View original post

                    â sandbox
                    keybindings â

8

Customize Your Keybindings

Did you know every key binding in Claude Code is customizable?

Run `/keybindings` to re-map any key. Settings live reload so you can see how it feels immediately.

How it works

                        Keybindings are stored in `~/.claude/keybindings.json`. Claude can generate the config for you â just describe what you want.

                        View original post

                    â statusline
                    hooks â

9

Set Up Hooks

Hooks are a way to deterministically hook into Claude's lifecycle. Use them to:

Use cases

- Automatically route permission requests to Slack or Opus

- Nudge Claude to keep going when it reaches the end of a turn (you can even kick off an agent or use a prompt to decide whether Claude should keep going)

- Pre-process or post-process tool calls, e.g. to add your own logging

Ask Claude to add a hook to get started.

                        View original post

                    â keybindings
                    spinners â

10

Customize Your Spinner Verbs

It's the little things that make CC feel personal. Ask Claude to customize your spinner verbs to add or replace the default list with your own verbs.

Check the `settings.json` into source control to share verbs with your team.

> in my settings, make my spinner verbs star trek themed.

â Update(~/.claude/settings.json)

â± Beaming upâ¦ (esc to interrupt)

                        View original post

                    â hooks
                    output â

11

Use Output Styles

Run `/config` and set an output style to have Claude respond using a different tone or format.

Recommended styles

- Explanatory â great when getting familiar with a new codebase, to have Claude explain frameworks and code patterns as it works

- Learning â have Claude coach you through making code changes

- Custom â create your own output styles to adjust Claude's voice the way you like

                        View original post

                    â spinners
                    customize â

12

Customize All the Things!

Claude Code is built to work great out of the box. When you do customize, check your `settings.json` into git so your team can benefit, too.

We support configuring for your codebase, for a sub-folder, for just yourself, or via enterprise-wide policies.

By the numbers

                        Pick a behavior, and it is likely that you can configure it. We support 37 settings and 84 env vars (use the `"env"` field in your `settings.json` to avoid wrapper scripts).

                        View original post

                    â output
                    back to intro â

# Built-in Worktree Support

                        Boris announced built-in git worktree support for Claude Code on February 20, 2026. Agents can now run in parallel without interfering with each other â in CLI, Desktop app, IDE extensions, web, and mobile.

                        @bcherny's February 20, 2026 thread

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

Use `claude --worktree` for Isolation

To run Claude Code in its own git worktree, just start it with the `--worktree` option. You can name your worktree, or have Claude name it for you.

Use this to run multiple parallel Claude Code sessions in the same git repo, without the code edits clobbering each other.

$ claude --worktree my_worktree

# You can also pass --tmux to launch in its own Tmux session
$ claude --worktree my_worktree --tmux

What changed

                        The Claude Code Desktop app has had built-in support for worktrees for a while â now it's in the CLI too.

                        View original post

                    â intro
                    desktop â

2

Use Worktree Mode in the Desktop App

If you prefer not to use the terminal, head to the Code tab in the Claude Desktop app and check the worktree checkbox.

How to enable

                        Open the Claude Desktop app â Code tab â check the "worktree" checkbox. That's it.

                        View original post

                    â cli
                    subagents â

3

Subagents Now Support Worktrees

Subagents can also use worktree isolation to do more work in parallel. This is especially powerful for large batched changes and code migrations.

To use it, ask Claude to use worktrees for its agents. Available in CLI, Desktop app, IDE extensions, web, and Claude Code mobile app.

> Migrate all sync io to async. Batch up the changes,
  and launch 10 parallel agents with worktree isolation.
  Make sure each agent tests its changes end to end,
  then have it put up a PR.

                        View original post

                    â desktop
                    agents â

4

Custom Agents Support Git Worktrees

You can also make subagents always run in their own worktree. To do that, just add `isolation: worktree` to your agent frontmatter.

# .claude/agents/worktree-worker.md
---
name: worktree-worker
model: haiku
isolation: worktree
---

                        View original post

                    â subagents
                    non-git â

5

Also Available for Non-Git Source Control

If you're a Mercurial, Perforce, or SVN user, define worktree hooks to benefit from isolation without having to use Git.

$ cat .claude/settings.json
{
  ...
  "hooks": {
    "WorktreeCreate": [
      { "command": "jj workspace add \"$(cat /dev/stdin | jq -r '.name')\"" }
    ],
    "WorktreeRemove": [
      { "command": "jj workspace forget \"$(cat /dev/stdin | jq -r '.worktree_path')\"" }
    ]
  },
  ...
}

                        View original post

                    â agents
                    back to intro â

# Ship to Production

                        Boris announced two new built-in skills for Claude Code on February 27, 2026: /simplify to improve code quality and /batch to automate code migrations in parallel. Combined, these automate much of the work it used to take to shepherd a PR to production and perform parallelizable code migrations.

                        @bcherny's February 27, 2026 thread

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

/simplify â Improve Code Quality

Use parallel agents to improve code quality, tune code efficiency, and ensure CLAUDE.md compliance. Just append `/simplify` to any prompt.

> hey claude make this code change then run /simplify

What it does

                        Runs parallel agents that review your changed code for reuse opportunities, quality issues, and efficiency improvements â all in one pass.

                        View original post

                    â intro
                    /batch â

2

/batch â Parallel Code Migrations

Interactively plan out code migrations, then execute in parallel using dozens of agents. Each agent runs with full isolation using git worktrees, testing its work before putting up a PR.

> /batch migrate src/ from Solid to React

How it works

                        You plan the migration interactively, then /batch fans out the work to parallel agents â each in its own worktree, each testing and creating a PR independently.

                        View original post

                    â /simplify
                    back to intro â

# Three Features. Four Days.

                        /loop lets Claude run recurring tasks for up to 3 days unattended. Code Review dispatches a team of agents on every PR. /btw lets you ask questions mid-task without breaking Claude's flow.

                        @bcherny's March 7, 2026 thread

                        @bcherny's March 9, 2026 thread

                        @trq212's March 10, 2026 thread

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

/loop â Schedule Recurring Tasks

Use /loop to schedule recurring tasks for up to 3 days at a time. Claude runs your prompt on an interval, handling long-running workflows autonomously.

> /loop babysit all my PRs. Auto-fix build issues and when comments come in, use a worktree agent to fix them

> /loop every morning use the Slack MCP to give me a summary of top posts I was tagged in

What it does

                        Schedules a prompt to run on a recurring interval. Use it for PR babysitting, Slack summaries, deploy monitoring, or any repeating workflow â running for up to 3 days unattended.

                        Learn more: Run prompts on a schedule

                    â intro
                    code-review â

2

Code Review â Agents Hunt for Bugs

When a PR opens, Claude dispatches a team of agents to hunt for bugs. Anthropic built it for themselves first â code output per engineer is up 200% this year, and reviews were the bottleneck.

Boris personally used it for weeks before launch. It catches real bugs he wouldn't have noticed otherwise.

# A PR opens on your repo
# Claude Code automatically:
#   1. Reads the diff
#   2. Dispatches specialized review agents
#   3. Posts inline comments on real bugs

What it does

                        Automatically reviews every PR with a team of agents. Each agent focuses on a different concern â logic errors, security issues, performance regressions â then posts inline comments directly on the PR.

                        View original post

                    â /loop
                    /btw â

3

/btw â Ask Questions While Claude Works

A slash command for side-chain conversations while Claude is actively working. Single-turn, no tool calls, but has full context of the conversation. Built by @ErikSchluntz as a side project â 1.5M views on the launch tweet.

# Claude is mid-task, refactoring auth middleware...
> /btw what does the retry logic do?

# Claude responds inline without stopping its work:
The retry logic in auth.ts uses exponential backoff
with a max of 3 attempts. It catches 401/403 errors
and refreshes the token before retrying.

What it does

                        Lets you ask a quick question mid-task without interrupting Claude's flow. The response is single-turn with no tool calls, but Claude has full context of what it's working on â so answers are grounded in the current conversation.

                        View original post

                    â code-review
                    back to intro â

# End of Week Ships

                        The Claude Code team dropped 8 features in one thread: /effort max for deeper reasoning, voice mode for everyone, remote control sessions, setup scripts, session naming, /color, and a new PostCompact hook.

                        @trq212's March 13, 2026 thread

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

/effort â Max Reasoning Mode

Set effort to 'max' and Claude reasons for longer, using as many tokens as needed. Burns through your usage limits faster, so you activate it per session.

> /effort max

# Four levels available:
#   low    - quick answers, minimal reasoning
#   medium - balanced (default)
#   high   - deeper reasoning
#   max    - reasons as long as needed

What it does

                        Sets the reasoning effort level for the current session. At 'max', Claude thinks longer and uses more tokens per response â useful for hard debugging, architecture decisions, or tricky code where you want Claude to really think it through.

                        View original post

                    â intro
                    remote â

2

Remote Control â Spawn New Sessions

Run `claude remote-control` and then spawn a new local session directly from the mobile app. Available on Max, Team, and Enterprise (v2.1.74+).

$ claude remote-control

# Then open the Claude mobile app
# Tap "Code" â start a new session
# Claude connects to your local machine

What it does

                        Lets you start fresh Claude Code sessions from your phone while connected to your local dev environment. Walk away from your desk, think of something, and kick off a task from mobile â Claude runs on your machine.

                        View original post

                    â /effort
                    voice â

3

Voice Mode â Talk to Claude Code

Voice mode is now rolled out to 100% of users, including in Claude Code Desktop and Cowork. Sometimes you need somebody to talk to.

# In Claude Code Desktop or Cowork:
# Click the microphone icon
# Talk naturally â Claude hears you and responds

ð "Hey Claude, fix all the bugs in this repo."

What it does

                        Lets you speak to Claude Code instead of typing. Available in Desktop and Cowork â useful for hands-free coding, dictating complex requirements, or when you think faster than you type.

                        View original post

                    â remote
                    setup â

4

Setup Scripts â Automate Cloud Environments

Add a setup script in Claude Code on the web and desktop. It runs before Claude Code launches on a cloud environment â install dependencies, configure settings, set env vars.

# In "Update cloud environment" settings:

# Name:
apps

# Setup script (runs on new session start):
#!/bin/bash
yarn install

What it does

                        Runs a bash script automatically when a new Claude Code session starts on a cloud environment. Skipped when resuming an existing session. Use it to install dependencies, set up configs, or prepare the environment before Claude starts working.

                        View original post

                    â voice
                    --name â

5

claude --name â Name Your Sessions

Name your session at launch with the `--name` flag. Makes it easy to identify sessions when running multiple in parallel.

$ claude --name "auth-refactor"

# Now your session shows up as "auth-refactor"
# instead of a generic session ID

What it does

                        Gives your Claude Code session a human-readable name on start. Especially useful when juggling multiple worktrees or sessions â you can tell at a glance which session is doing what.

                        View original post

                    â setup
                    auto-name â

6

Auto Session Naming After Plan Mode

After plan mode, Claude will automatically name your session based on what you're working on. No manual naming needed.

# Enter plan mode, describe your task:
> shift+tab
[plan]> Refactor the auth middleware to use JWT

# After exiting plan mode, session is auto-named:
# Session: "refactor-auth-jwt"

What it does

                        Claude infers a descriptive session name from your plan mode conversation. Pairs well with `claude --name` â use `--name` when you know what you're doing upfront, and let auto-naming handle it when you start by planning.

                        View original post

                    â --name
                    /color â

7

/color â Customize Prompt Color

Change the color of the prompt input with `/color`. Useful for visually distinguishing sessions when running multiple in parallel.

> /color

# Pick a color for this session's prompt
# Helps tell sessions apart at a glance

What it does

                        Sets the color of your prompt input for the current session. When you have 3-5 sessions open in different terminals, color-coding them makes it instantly clear which is which.

                        View original post

                    â auto-name
                    postcompact â

8

PostCompact Hook â React to Context Compression

A new hook event: PostCompact. Fires after Claude compresses its conversation context, letting you inject instructions or run commands when compaction happens.

# In your hooks config:
"hooks": {
  "PostCompact": [{
    "matcher": "",
    "hooks": [{
      "type": "command",
      "command": "echo 'Context was compacted'"
    }]
  }]
}

What it does

                        Fires after Claude compresses its context window. Use it to re-inject critical instructions that might get lost during compaction, log when compaction happens, or trigger any automation you need when the context resets.

                        View original post

                    â /color
                    back to intro â

# New Superpowers

                        Auto mode kills permission prompts with built-in safety classifiers, /schedule creates cloud-based recurring jobs that run beyond your laptop, iMessage becomes a channel, and auto-dream keeps your memory clean.

                        @noahzweben's March 23, 2026 post

                        @bcherny's March 24, 2026 post

                        @trq212's March 25, 2026 post

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

Auto Mode â A Safer Way to Skip Permissions

Instead of approving every file write and bash command, or skipping permissions entirely with `--dangerously-skip-permissions`, auto mode lets Claude make permission decisions on your behalf.

# Enable auto mode
$ claude --enable-auto-mode

# Or cycle with shift+tab during a session:
# plan mode â auto mode â normal mode

How it works

                        Anthropic built and tested classifiers that evaluate each action before it runs. Safe operations (reading files, running tests) get auto-approved. Risky ones (deleting files, force-pushing, running unknown scripts) still get flagged. It's the middle ground between clicking "approve" 50 times per session and yolo-ing with no safety net.

Boris's take: "no ð more ð permission prompts ð"

                        View original post

                    â intro
                    /schedule â

2

/schedule â Cloud Jobs from Your Terminal

Use `/schedule` to create recurring cloud-based jobs for Claude, directly from the terminal. Unlike `/loop` (which runs locally for up to 3 days), scheduled jobs run in the cloud â they work even when your laptop is closed.

# Schedule a daily docs update
$ /schedule a daily job that looks at all PRs shipped
  since yesterday and update our docs based on the
  changes. Use the Slack MCP to message #docs-update
  with the changes

Use cases

                        The Anthropic team uses these internally to automatically resolve CI failures, push doc updates, and power automations that need to exist beyond a closed laptop. Think of it as cron jobs, but Claude does the work.

                        View original post

                    â auto mode
                    iMessage â

3

iMessage Plugin â Text Claude from Your Phone

iMessage is now available as a Claude Code channel. Install the plugin and text Claude like you'd text a friend â from any Apple device.

# Install the iMessage plugin
$ /plugin install imessage@claude-plugins-official

What it does

                        Claude Code becomes a contact in your Messages app. Send it tasks, get responses as iMessages. Works from your iPhone, iPad, or Mac â no terminal needed. Pairs well with remote control sessions for kicking off work from anywhere.

                        View original post

                    â /schedule
                    memory â

4

Auto-Memory & Auto-Dream â Persistent, Self-Cleaning Memory

Claude Code now has a built-in memory system. Run `/memory` to configure it.

# View and configure memory settings
$ /memory

# Memory types:
#   User memory    â saved in ~/.claude/CLAUDE.md
#   Project memory â saved in ./CLAUDE.md

# Trigger a dream (memory consolidation)
$ /dream

Auto-memory

                        When enabled, Claude automatically saves preferences, corrections, and patterns between sessions. No manual CLAUDE.md editing needed â Claude writes the memories for you.

Auto-dream

                        As memory accumulates, it can get messy â outdated assumptions, overlapping notes, low-signal entries. Auto-dream runs a subagent that periodically reviews past sessions, keeps what matters, removes what doesn't, and merges insights into cleaner structured memory. The naming maps to how REM sleep consolidates short-term memory into long-term storage.

                    â iMessage
                    back to intro â

# Hidden & Underutilized Features

                        Boris's favorite hidden and under-utilized features in Claude Code. Mobile app, session teleporting, /loop and /schedule, hooks, Cowork Dispatch, Chrome extension, Desktop app, /branch, /btw, worktrees, /batch, --bare, --add-dir, --agent, and /voice.

                        @bcherny's March 29, 2026 thread

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

Claude Code Has a Mobile App

Did you know Claude Code has a mobile app? Boris writes a lot of his code from the iOS app. It's a convenient way to make changes without opening a laptop.

How to use it

                        Download the Claude app for iOS/Android, then tap the Code tab on the left. You get a full Claude Code session right from your phone.

                        View original post

                    â intro
                    teleport â

2

Move Sessions Between Devices

Move sessions back and forth between mobile/web/desktop and terminal.

# Continue a cloud session on your machine
$ claude --teleport
# or
$ /teleport

# Control a local session from phone/web
$ /remote-control

Boris's setup

                        "I have 'Enable Remote Control for all sessions' set in my /config."

                        View original post

                    â mobile
                    loops â

3

/loop and /schedule â Automated Workflows

Two of the most powerful features in Claude Code. Use these to schedule Claude to run automatically at a set interval, for up to a week at a time.

# Boris's running loops:
$ /loop 5m /babysit
# auto-address code review, auto-rebase, shepherd PRs

$ /loop 30m /slack-feedback
# auto put up PRs for Slack feedback every 30 mins

$ /loop /post-merge-sweeper
# put up PRs to address missed code review comments

$ /loop 1h /pr-pruner
# close out stale and unnecessary PRs

Pro tip

                        Experiment with turning workflows into skills + loops. It's powerful.

                        View original post

                    â teleport
                    hooks â

4

Hooks â Deterministic Agent Lifecycle Logic

Use hooks to deterministically run logic as part of the agent lifecycle.

Examples

- Dynamically load in context each time you start Claude (SessionStart)

- Log every bash command the model runs (PreToolUse)

- Route permission prompts to WhatsApp for you to approve/deny (PermissionRequest)

- Poke Claude to keep going whenever it stops (Stop)

See code.claude.com/docs/en/hooks

                        View original post

                    â loops
                    dispatch â

5

Cowork Dispatch

Boris uses Dispatch every day to catch up on Slack and emails, manage files, and do things on his laptop when he's not at a computer.

"When I'm not coding, I'm dispatching."

What it is

                        Dispatch is a secure remote control for the Claude Desktop app. It can use your MCPs, browser, and computer, with your permission.

                        View original post

                    â hooks
                    chrome â

6

Use the Chrome Extension for Frontend Work

The most important tip for using Claude Code is: give Claude a way to verify its output. Once you do that, Claude will iterate until the result is great.

Think of it like any other engineer: if you ask someone to build a website but they aren't allowed to use a browser, will the result look good? Probably not. But if you give them a browser, they will write code and iterate until it looks good.

Boris's workflow

                        "I use the Chrome extension every time I work on web code. It tends to work more reliably than other similar MCPs."

Download the extension for Chrome/Edge.

                        View original post

                    â dispatch
                    desktop â

7

Desktop App â Auto Start and Test Web Servers

Use the Claude Desktop app to have Claude automatically start and test web servers.

What it does

                        The Desktop app bundles in the ability for Claude to automatically run your web server and even test it in a built-in browser. You can set up something similar in CLI or VSCode using the Chrome extension, or just use the Desktop app.

                        View original post

                    â chrome
                    fork â

8

Fork Your Session

People often ask how to fork an existing session. Two ways:

# Option 1: From inside your session
$ /branch

# Option 2: From the CLI
$ claude --resume <session-id> --fork-session

What happens

                        Claude creates a branched conversation. You're now in the branch. To resume the original, use the session ID it gives you.

                        View original post

                    â desktop
                    /btw â

9

/btw â Side Queries While Claude Works

Boris uses this all the time to answer quick questions while the agent works.

> /btw how do i spell daushund?

  dachshund â German for "badger dog"
  (dachs = badger, hund = dog).

How it works

                        Single-turn, no tool calls, but has full context of the conversation. Claude responds inline without stopping its work.

                        View original post

                    â fork
                    worktrees â

10

Use Git Worktrees

Claude Code ships with deep support for git worktrees. Worktrees are essential for doing lots of parallel work in the same repository. Boris has dozens of Claudes running at all times.

# Start a new session in a worktree
$ claude -w

# Or check the "worktree" checkbox in Desktop app

Non-git VCS

                        For non-git VCS users, use the WorktreeCreate hook to add your own logic for worktree creation.

                        View original post

                    â /btw
                    /batch â

11

/batch â Fan Out Massive Changesets

`/batch` interviews you, then has Claude fan out the work to as many worktree agents as it takes (dozens, hundreds, even thousands) to get it done.

Use cases

                        Use it for large code migrations and other kinds of parallelizable work. Each agent runs in its own worktree with full isolation.

                        View original post

                    â worktrees
                    --bare â

12

--bare â Speed Up SDK Startup by 10x

By default, when you run `claude -p` (or the TypeScript or Python SDKs) it searches for local CLAUDE.md's, settings, and MCPs. But for non-interactive usage, most of the time you want to explicitly specify what to load.

$ claude -p "summarize this codebase" \
    --output-format=stream-json \
    --verbose \
    --bare

Why it matters

                        This was a design oversight when the SDK was first built. In a future version, the default will flip to --bare. For now, opt in with the flag to get up to 10x faster startup.

                        View original post

                    â /batch
                    --add-dir â

13

--add-dir â Give Claude Access to More Folders

When working across multiple repositories, Boris usually starts Claude in one repo and uses `--add-dir` (or `/add-dir`) to let Claude see the other repo. This tells Claude about the repo and gives it permissions to work in it.

# At launch
$ claude --add-dir /path/to/other-repo

# During a session
> /add-dir /path/to/other-repo

Team setup

                        Add `"additionalDirectories"` to your team's settings.json to always load in additional folders when starting Claude Code.

                        View original post

                    â --bare
                    --agent â

14

--agent â Custom System Prompt & Tools

Custom agents are a powerful primitive that often gets overlooked.

# Define an agent
$ cat .claude/agents/ReadOnly.md
---
name: ReadOnly
description: Read-only agent restricted to the Read tool only
color: blue
tools: Read
---

You are a read-only agent that cannot edit files or run bash.

# Launch it
$ claude --agent=ReadOnly

How it works

                        Define a new agent in `.claude/agents`, then run `claude --agent=<your agent's name>`. Each agent can have a custom name, color, tool set, and system prompt.

                        View original post

                    â --add-dir
                    /voice â

15

/voice â Voice Input

Fun fact: Boris does most of his coding by speaking to Claude, rather than typing.

How to use it

- CLI: Run `/voice` then hold the space bar

- Desktop: Press the voice button

- iOS: Enable dictation in your iOS settings

                        View original post

                    â --agent
                    back to intro â

# New Feature Launches

                        Fresh out of Anthropic this week. Routines â schedule Claude Code runs or trigger them from GitHub events. Three session management tips from Thariq on the 1M context window: /rewind over correcting, /compact vs /clear, and a one-line env var to dodge context rot. Plus three from Cat on using Opus 4.7: delegate, full-context briefs, and the new xhigh effort level.

                        @claudeai's April 14, 2026 post

                        @trq212's April 15, 2026 article

                        @_catwu's April 16, 2026 post

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

Routines â Scheduled & Event-Driven Claude Code

Claude announced Routines in Claude Code â research preview, Apr 14 2026. Configure a routine once (prompt, repo, connectors), and it runs on a schedule, from an API call, or in response to a GitHub event. Runs on Anthropic infra â no laptop needed.

Triggers

- Schedule â cron expression

- GitHub event â PR opened/merged, release published, issue opened

- API â POST to a webhook URL with token

Connectors

                        GitHub, Linear â extend with your own. Each routine has its own API endpoint, so you can point alerts, deploy hooks, or internal tools at Claude directly.

Example use case: POST an alert payload to the routine's webhook. Claude finds the owning service and posts a triage summary to #oncall.

                        View original post

                    â intro
                    /rewind â

2

Rewind Over Correcting

From Thariq (Apr 15, 2026): the single habit that signals good context management is rewind, not correction.

When Claude goes down a wrong path, don't type "that didn't work, try X instead." That keeps the failed attempt in your context and pollutes the window. Instead, rewind and re-prompt with what you learned.

# jump back to a previous message, drop everything after it
$ /rewind
# or in the terminal: double-tap Esc

The math

                        Correcting: context = file reads + failed attempt + correction + fix.

                        Rewinding: context = file reads + one informed prompt + fix.

You can also use `"summarize from here"` to have Claude summarize its learnings into a handoff message before rewinding â a message from the next iteration of Claude to its past self.

                        View original post

                    â routines
                    /compact vs /clear â

3

/compact vs /clear â Know the Difference

Two ways to shed weight from a long session. They feel similar but behave very differently.

/compact â lossy LLM summary

                        Claude summarizes the conversation and replaces the history with that summary. Cheap, keeps momentum, details can be fuzzy. You're trusting Claude to decide what mattered.

# steer the compaction with a hint
$ /compact focus on the auth refactor, drop the test debugging

/clear â hand-written brief

                        You write down what matters ("we're refactoring the auth middleware, constraint is X, files are A and B, we've ruled out approach Y") and start clean. More work, but the context is exactly what you decided.

Rule of thumb: starting a genuinely new task â new session with `/clear`. Related task where you still need some context â `/compact` with a hint.

                        View original post

                    â /rewind
                    auto-compact â

4

Lower Your Auto-Compact Threshold

Context rot â model performance degrading as context grows â kicks in around 300-400k tokens on the 1M context model. You can set your autocompact threshold to force earlier compaction and effectively lower your context window.

# 400k is Thariq's recommended compromise
$ CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000 claude

Why this works

                        Stays below the rot zone while still getting most of the 1M benefit. Context windows are a hard cutoff â when you near the end, you're forced to compact. Forcing it earlier means your compaction happens while the model is still sharp.

Pair with proactive `/compact <hint>` when you feel bad-compact risk (autocompact fires mid-task and summarizes the wrong things).

Docs: Claude Code settings

                        View original post

                    â /compact vs /clear
                    delegate â

5

Delegation over Guidance

From Cat Wu (Apr 16, 2026) on Opus 4.7 in Claude Code: "The model performs best if you treat it like an engineer you're delegating to, not a pair programmer you're guiding line by line."

This is a mental model shift. The old workflow: describe a step, watch the output, correct, describe the next step. High interrupt frequency, you're always in the loop.

The new workflow

                        Write a crisp brief. Launch Claude. Come back when it's done â or when it asks a real question. Fewer interruptions, more autonomous runs, higher quality output.

When Claude asks too many clarifying questions or goes off-track, that's usually a signal that your brief was incomplete â not that the model needs more hand-holding. Invest in the upfront brief (see next tip) and let Opus 4.7 do its thing.

                        View original post

                    â auto-compact
                    full context â

6

Full Task Context Upfront

The delegation model from Tip 5 only works if Claude has what it needs. Cat's second tip: "Give Claude Code your full task context upfront: goal, constraints, acceptance criteria in the first turn."

The three things to include

- Goal â what success looks like in plain language

- Constraints â non-goals, things not to touch, perf/API contracts

- Acceptance criteria â how you'll verify the work is done right

# Good: full context upfront
Goal: add rate limiting to the /api/login endpoint

Constraints:
- don't modify the DB schema
- keep the existing auth flow unchanged
- use Redis (already configured)

Acceptance criteria:
- 5 req/min per IP, returns 429 on limit
- existing tests still pass
- new test case for the rate-limit behavior

If Claude starts with all three, it plans around the full problem space. If it starts with just "add rate limiting," it'll make assumptions you'll have to correct later â and every correction costs context.

                        View original post

                    â delegate
                    xhigh â

7

xhigh â New Default Effort for Opus 4.7

Opus 4.7 in Claude Code defaults to `xhigh` â a new effort level beyond the low/medium/high/max scale Tip 34 described. The model reasons longer before acting, which pairs with the delegation shift: think harder once, rather than iterate fast and bounce back to you.

# check or change the effort level
$ /effort

Why xhigh is the new default

                        xhigh effort + a full-context brief = one-shot completion of bigger tasks than previous Opus models could handle. The default change signals that Opus 4.7 is expected to run more autonomously, which benefits from more reasoning tokens upfront.

Drop it down if you want speed over depth, or leave it alone for most work. Available through `/effort` just like the other levels.

                        View original post

                    â full context
                    back to intro â

# Mastering Opus 4.7

                        Boris dogfooded Opus 4.7 for weeks before launch. His verdict: "It feels more intelligent, agentic, and precise than 4.6. It took a few days for me to learn how to work with it effectively." Here's what he learned â plus key behavioral shifts from the Anthropic blog. Auto mode, /fewer-permission-prompts, recaps, /focus, effort mastery, the /go composite skill, and what changed under the hood.

                        @bcherny's April 16, 2026 thread

                        Anthropic blog post

                        Click the tabs above to explore each tip â

or use â â arrow keys

1

Auto Mode + Parallel Claudes

Opus 4.7 loves complex, long-running tasks â deep research, refactoring code, building complex features, iterating until it hits a performance benchmark. In the past, you either had to babysit the model or use `--dangerously-skip-permissions`.

Auto mode changes the game

                        Permission prompts are routed to a model-based classifier. If it's safe, it's auto-approved. No more babysitting while the model runs. More than that â it means you can run more Claudes in parallel. Once a Claude is cooking, switch focus to the next one.

Shift-tab to enter auto mode in the CLI, or choose it in the dropdown in Desktop or VSCode. Available for Max, Teams, and Enterprise.

                        View original post

                    â intro
                    /fewer-perms â

2

/fewer-permission-prompts â Tune Your Allowlist

A new skill that scans through your session history to find common bash and MCP commands that are safe but caused repeated permission prompts.

# scan your history and get recommendations
$ /fewer-permission-prompts

What it does

                        Recommends a list of commands to add to your permissions allowlist. Use it to tune up your permissions and avoid unnecessary prompts â especially useful if you don't use auto mode.

                        View original post

                    â auto mode
                    recaps â

3

Recaps â Know What Happened While You Were Away

Shipped alongside Opus 4.7. Recaps are short summaries of what an agent did and what's next. Useful when returning to a long-running session after a few minutes or a few hours.

â» Cogitated for 6m 27s

â» recap: Fixing the post-submit transcript
  shift bug. The styling-flash part is shipped
  as PR #29869 (auto-merge on, posted to stamps).
  Next: I need a screen recording of the remaining
  horizontal rewrap on `cc -c` to target that
  separate cause. (disable recaps in /config)

Pairs naturally with auto mode â you launch Claude, switch focus, come back, and immediately see what happened and what's next without scrolling through tool output. Disable in `/config` if you prefer the old behavior.

                        View original post

                    â /fewer-perms
                    /focus â

4

Focus Mode â See Only the Final Result

Boris: "I've been loving the new focus mode in the CLI, which hides all the intermediate work to just focus on the final result. The model has reached a point where I generally trust it to run the right commands and make the right edits. I just look at the final result."

# toggle focus mode on/off
$ /focus

When to use it

                        When you trust the model enough that watching every file read and bash command is noise. Focus mode shows you what changed, not how it got there. A natural complement to auto mode â one removes permission prompts, the other removes visual clutter.

                        View original post

                    â recaps
                    effort â

5

Effort Mastery â xhigh, max, and Adaptive Thinking

Opus 4.7 uses adaptive thinking instead of fixed thinking budgets. The model decides when thinking is beneficial rather than using a fixed allocation â less overthinking, smarter resource use.

Boris's setup

                        "I use xhigh effort for most tasks, and max effort for the hardest tasks."

# set effort level
$ /effort

# the scale: low â medium â high â xhigh â max
# Speed ââââââââââââââââââââââ Intelligence

Key detail most people miss

                        Max applies to just your current session. All other effort levels (including xhigh) are sticky and persist for your next session too. This means you can safely crank to max for one hard debugging session without permanently changing your default.

To steer thinking without changing effort: say "Think carefully and step-by-step before responding" for harder problems, or "Prioritize responding quickly rather than thinking deeply" to save tokens on simple tasks.

                        View original post

                    â /focus
                    /go â

6

/go â Verify, Simplify, Ship

"Give Claude a way to verify its work. This has always been a way to 2-3x what you get out of Claude, and with 4.7 it's more important than ever."

Boris's workflow these days: "Many of my prompts look like 'Claude do blah blah /go'."

/go is a skill that has Claude:

- Test itself end to end using bash, browser, or computer use

- Run the `/simplify` skill

- Put up a PR

Verification by domain: backend â make sure Claude knows how to start your server/service to test end to end. Frontend â use the Claude Chromium extension. Desktop apps â use computer use.

"For long running work, verification is important because that way when you come back to a task, you know the code works."

                        View original post

                    â effort
                    4.6â4.7 â

7

What Changed from 4.6 â Three Shifts to Know

If you're upgrading from 4.6, three behavioral changes matter. Don't assume your old habits carry over â Opus 4.7 thinks differently.

1. Calibrated response length

                        Shorter answers for simple queries, longer for open-ended analysis. If you want a specific length or style, say so explicitly in your prompt.

2. Less automatic tool usage

                        4.7 reasons more instead of immediately calling tools. If Claude isn't reaching for the right tools, provide explicit guidance describing when and why to use them.

3. More judicious subagent spawning

                        4.7 is more selective about delegation. For tasks like "refactor across 40 files," explicitly request parallel subagents. Anti-pattern: don't ask it to spawn subagents for refactoring a single visible function.

Source: Anthropic blog post

                    â /go
                    notifications â

8

Task Completion Notifications

With auto mode + focus mode, you're spending less time watching Claude work. But you need to know when it finishes. Set up notifications so you don't have to keep checking back.

Options

- Sound alert â ask Claude to play a sound when it finishes a task

- Stop hook â use a `Stop` hook to trigger a notification (Slack, system notification, etc.)

- iTerm2 notifications â enable native terminal notifications

- Recaps â when you do check back, recaps tell you what happened (tip 3)

The workflow that pulls this all together: start Claude in auto mode with focus on. It runs autonomously, verifies its own work via `/go`, and notifies you when done. You review the recap and the PR. The future Boris described in Part 1 is here.

Source: Anthropic blog post

                    â 4.6â4.7
                    back to intro â

# How To Use Skills

                        Anthropic runs hundreds of skills internally. Thariq cataloged what works, what doesn't, and how to think about building them. 9 skill types, 9 authoring tips, and distribution strategies from production use. We turned his post into a skill. Obviously.

                        @trq212's March 17, 2026 post

skill installs

cumulative over time

0

total installs

0 installs

--

                                -
                                now

1

Install as a Skill

Get the full guide available directly in Claude Code. Type `/thariq-skills` anytime to surface it.

                                $ mkdir -p ~/.claude/skills/thariq-skills && curl -L -o ~/.claude/skills/thariq-skills/SKILL.md https://howborisusesclaudecode.com/api/install-thariq
                                copy

Covers all 9 skill types, authoring best practices, progressive disclosure patterns, distribution strategies, and the gotchas Anthropic discovered running hundreds of skills in production.

2

9 Types of Skills

After cataloging all their skills, Anthropic noticed they cluster into recurring categories. The best skills fit cleanly into one.

Library & API Reference

Internal libs, CLIs, SDKs, gotchas

billing-lib &middot; platform-cli

Product Verification

Drive the running product to verify

signup-driver &middot; checkout

Data & Analysis

IDs, field names, query patterns

funnel-query &middot; grafana

Business Automation

Multi-tool workflows &rarr; one command

standup &middot; weekly-recap

Scaffolding & Templates

Framework-correct boilerplate

new-app &middot; migration

Code Quality & Review

Adversarial review, style, testing

adversarial &middot; hypothesis

CI/CD & Deployment

Commit, push, deploy safely

babysit-pr &middot; deploy

Incident Runbooks

Symptom &rarr; investigation &rarr; report

oncall &middot; log-correlator

Infrastructure Ops

Safety-gated cleanup & maintenance

orphans &middot; cost-investigation

3

9 Tips for Making Skills

The best practices from running hundreds of skills in production.

Skip the obvious

Claude already has defaults. Focus on what pushes it off its beaten path.

Build a Gotchas section

Highest-signal content. Add a line every time Claude trips on something.

Progressive disclosure

A skill is a folder, not a file. SKILL.md is the hub, spoke files do the work.

Don't railroad

Give info, not step-by-step scripts. Let Claude adapt to the situation.

Description = trigger

Write it for the model, not humans. Include the phrases that should invoke it.

Think through setup

Store config in config.json. Ask the user on first run if it's missing.

Store data

Use ${CLAUDE_PLUGIN_DATA} for logs, JSON, or SQLite that persists across upgrades.

Give it code

Include helper scripts so Claude composes instead of reconstructing from scratch.

On-demand hooks

Session-scoped guardrails. /careful blocks rm -rf, /freeze locks edits.

# Install as a Claude Code Skill

                        Get all 87 tips available directly in Claude Code. Type `/boris` anytime to surface these workflow patterns.

                        A skill is a knowledge file that lives on your machine. Once installed, Claude references it automatically when you ask about workflows â or on demand with `/boris`.

skill installs

cumulative over time

0

total installs

0 installs

--

                                -
                                now

                            download social card

                            Requires Claude Code. Install it first if you haven't: `npm install -g @anthropic-ai/claude-code`

1

One-Line Install

Run this command in your terminal to install globally:

                                $ mkdir -p ~/.claude/skills/boris && curl -L -o ~/.claude/skills/boris/SKILL.md https://howborisusesclaudecode.com/api/install
                                copy

This installs globally to `~/.claude/skills/`. For project-specific install, use `.claude/skills/` instead.

2

Use the Skill

Start a new Claude Code session and type:

> /boris

# Or just ask about workflows - Claude will use it automatically:
> How should I set up parallel Claude sessions?

You'll see the full tips document appear in your conversation. If you get "skill not found", verify the file exists: `ls ~/.claude/skills/boris/SKILL.md`

3

What's Included

87 Tips Organized by Topic

- Parallel Execution - Worktrees, multiple sessions, web/mobile

- Model Selection - Why Opus 4.5 with thinking

- Plan Mode - Start complex tasks right

- CLAUDE.md - Best practices, @.claude in PRs

- Skills & Commands - /simplify, /batch, /btw, custom workflows

- Subagents - Common PR automations

- Hooks - PostToolUse, SessionStart, PermissionRequest, Stop

- Permissions - Pre-allow safe commands, wildcard syntax

- MCP Integrations - Slack, BigQuery, Sentry

- Prompting - Challenge Claude, write specs

- Terminal Setup - Ghostty, /voice, /color, keybindings

- Bug Fixing - Slack MCP, CI tests, docker logs

- Long-Running Tasks - Stop hooks, background agents

- Verification - Chrome extension, browser testing

- Learning - Use Claude to understand code

- Customization - Themes, spinners, output styles

- Plugins & Agents - LSPs, MCPs, --agent, custom agents

- Safety - Sandboxing, auto mode, permissions

- Worktrees - claude -w, Desktop, subagent isolation, non-git VCS

- Scheduled Tasks - /loop, /schedule, automated workflows

- Code Review - Agent-powered PR reviews that catch real bugs

- /effort - Max reasoning mode for deeper thinking

- Remote Control - Teleport, mobile app, /remote-control

- Session Management - --name, /branch, --fork-session

- Setup Scripts - Automate cloud environment setup

- PostCompact Hook - React to context compression

- iMessage Plugin - Text Claude from any Apple device

- Auto-Memory & Dream - Persistent, self-cleaning memory

- Mobile App - Write code from the Claude iOS/Android app

- Cowork Dispatch - Remote control for Claude Desktop

- Desktop App - Auto start and test web servers

- --bare - 10x faster SDK startup

- --add-dir - Give Claude access to more folders

- Routines - Scheduled and event-driven Claude Code runs

- Rewind - Double-Esc to drop failed attempts from context

- /compact vs /clear - Know when to summarize vs start fresh

- Auto-compact window - Env var to dodge context rot at 400k

- Delegation over Guidance - Treat Opus 4.7 like an engineer you hand off to

- Full Task Context Upfront - Goal, constraints, acceptance criteria in first turn

- xhigh effort - New default reasoning level for Opus 4.7

- Auto Mode + Parallel Claudes - Run multiple sessions, zero babysitting

- /fewer-permission-prompts - Scan history, tune your allowlist

- Recaps - Know what happened while you were away

- Focus Mode - /focus to see only the final result

- /go - Verify + simplify + PR in one composite skill

- 4.6â4.7 Shifts - Calibrated length, less auto-tool-use, judicious subagents

- Notifications - Hooks and alerts for autonomous runs

Try After Installing

> How do I run parallel Claude sessions with worktrees?

> What should I put in my CLAUDE.md?

> Set up a PostToolUse hook to auto-format my code

> What's the best way to verify Claude's work?

?

Manual Download

Prefer to download manually? Download SKILL.md and place it in:

~/.claude/skills/boris/SKILL.md

Create the `~/.claude/skills/boris/` directory if it doesn't exist.

?

Keeping It Updated

The skill automatically checks for updates when you type `/boris`. If a newer version is available, Claude will download it for you â no manual steps needed.

To uninstall: `rm -rf ~/.claude/skills/boris/`

How Skills Work

Skills are markdown files with YAML frontmatter that Claude Code loads automatically. When you type `/boris` or ask about related topics, Claude surfaces this knowledge to help you. Skills can be user-invocable (slash commands) or auto-surfaced based on semantic matching.

                claude-cli connected

                opus-4.7 Â· thinking

            Based on @bcherny's thread

                Ctrl+C, Ctrl+V, Ctrl+Ship. Built by @CarolinaCherry. You're welcome.

        HowBorisUsesClaudeCode.com
        ☕ Buy me a coffee

            &times;

Built by @CarolinaCherry. Not affiliated with Anthropic.

Boris Cherny created Claude Code at Anthropic. He regularly shares how he uses it on X, but those tips end up scattered across dozens of threads that are hard to find and follow. I built this site to collect all of them in one place â organized, easy to browse, and always up to date.

Everything here is sourced directly from Boris's posts. Nothing is invented or extrapolated.

This is a fan-made resource. Not official. Not sponsored. Built with Claude Code, obviously.