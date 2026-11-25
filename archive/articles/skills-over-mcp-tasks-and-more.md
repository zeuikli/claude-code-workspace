---
title: "MCP servers can now ship skills, run tasks, and more with Claude"
url: https://claude.com/resources/articles/skills-over-mcp-tasks-and-more
slug: skills-over-mcp-tasks-and-more
fetched: 2026-11-25 09:29 UTC
---

# MCP servers can now ship skills, run tasks, and more with Claude

> Source: https://claude.com/resources/articles/skills-over-mcp-tasks-and-more

> Skills over MCP is in public beta in Claude, so MCP servers can ship skills alongside their tools. Tasks and Elicitation are now generally available, and File Uploads is rolling out soon.


# MCP servers can now ship skills, run tasks, and more with Claude

-

CategoryProduct updates

-

ProductClaude apps, Claude Platform

-

DateNovember 24, 2026

-

Reading time6 min

-

ShareCopy link

Skills over MCP is now in public beta in Claude, so MCP servers can ship skills alongside their tools. We're also giving servers ways to handle longer, more interactive work with Claude: Tasks and Elicitation are now generally available, and File Uploads is rolling out soon.

Two years ago, Anthropic launched the Model Context Protocol (MCP) as a new standard for connecting AI agents to the systems where data lives. The spec has kept evolving to meet the connectivity needs of agents in production, and is becoming foundational for agentic messaging and orchestration.

With today’s updates, Claude can work with a server more like it works with another agent: learning from it, delegating to it, and exchanging input and files along the way.

## Ship expertise alongside tools with Skills over MCP

Tool names and descriptions tell Claude what a server can do, but don't cover how to handle specific use cases. With Skills over MCP, servers can publish skills alongside their tools to help Claude take on longer, multi-step work. Claude loads a skill only when it's needed, keeping context use low. Skills update with the server, so developers can ship tools and guidance together and users have nothing separate to install.

Skills can cover best practices, step-by-step workflows, or even playbooks tailored to a user's account or organization. Using Skills over MCP:

- Shopify helps Claude design and update a merchant's online store end to end.
- HubSpot onboards customers and gets them set up in Claude.
- Atlassian helps Claude draw on deep organizational context for insights and work analysis.
- Carta will help Claude draft and issue equity from an uploaded document (coming soon).

Skills over MCP is in public beta in Claude and Claude Code, on by default for Pro, Max, and Ultra plans and available to Team plans once an admin enables it. Coming soon to Enterprise.

## MCP servers can now take on long-running, interactive work with Claude

Agents in production are taking on longer, more consequential jobs. Servers can now support that work by running it in the background, checking in with users, and receiving files from Claude.

Hand off long-running work with Tasks. Tool calls used to have to finish before Claude could move on. With Tasks, servers can run operations that take time, or even full agent loops, while Claude keeps working and picks up the result when it's ready. Using Tasks, ZoomInfo runs deeper accounts and contact research that previously took several prompts.

Ask for input mid-call with Elicitation. Some actions need a user’s sign-off, like spending money or deleting data. With Elicitation, a server can pause to ask the user for input through a form or link, then continue where it left off. Using Elicitation:

- Supabase confirms costs before creating a paid project and before running destructive SQL.
- Railway asks before making potentially destructive changes, like removing a service.
- GitHub has users enter a repository's name before an agent deletes it.

Tasks and Elicitation are now generally available in Claude and Claude Code for Pro, Max, and Ultra plans, and rolling out to Team and Enterprise organizations.

Send and receive files with File Uploads. Claude will be able to pass files to MCP servers, not just text. The File Uploads extension sends PDFs, spreadsheets, and images to a server without passing them through the context window.

File Uploads is rolling out soon in Claude and Claude Code to Pro, Max, Ultra, and eligible Team and Enterprise plans.

## Add support to your plugins today

These features are part of the open MCP spec and its extensions, so a server that supports them works in any compatible client, not just Claude. To add support, see the docs for Skills over MCP, Tasks, Elicitation, and File Uploads.

## Built on stronger foundations for connecting agents in production

Thanks to contributions from across the AI ecosystem, MCP now sees over 700 million monthly SDK downloads, and there are over 10,000 MCP connectors for Claude. We've worked with the MCP community to improve how MCP works in Claude. Over the past year, it has become:

- More token efficient: Tool search loads tool definitions only when needed, which can cut the context they use by over 85% in multi-server setups.
- Easier to scale: The latest MCP spec is stateless and supported across Claude products, making it easier to build servers and maintain their reliability as they grow.
- Simpler to authorize: The Enterprise Managed Auth extension lets admins authorize supported servers once, so users connect automatically.
- More interactive: The MCP Apps extension brings full interfaces into Claude, beside the conversation or full screen.

Together, these improvements make MCP easier to build on and adopt, and give the standard a strong base to continue evolving for the needs of agents in production.

## Thank you to the MCP community

MCP is an open standard, hosted by the Agentic AI Foundation and shaped by the people who build on it. Two years of progress came from the maintainers, contributors, and developers who wrote the spec, built the SDKs, shipped servers, and added client support. Thank you for making MCP what it is today.

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleNov 24, 2026

### Turn artifacts into Mac and Windows apps

Open the artifacts you use every day like any other app, and let them do more on your computer

Claude apps

ArticleNov 23, 2026

### Zero data retention with Enterprise Frontier Safeguards is now in beta

Claude Platform

ArticleNov 23, 2026

### Introducing Claude Ship

Open a pull request and get back to building. Claude can now review pull requests, fix them, and approve the ones that a team's policy allows.

Claude Ship

ArticleNov 17, 2026

### Linked billing on the Claude Platform

Claude Platform
