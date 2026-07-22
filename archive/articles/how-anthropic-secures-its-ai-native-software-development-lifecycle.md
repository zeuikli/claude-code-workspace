---
title: "How Anthropic secures its AI-native software development lifecycle | Claude by Anthropic"
url: https://claude.com/blog/how-anthropic-secures-its-ai-native-software-development-lifecycle
slug: how-anthropic-secures-its-ai-native-software-development-lifecycle
fetched: 2026-07-22 04:14 UTC
---

# How Anthropic secures its AI-native software development lifecycle | Claude by Anthropic

> Source: https://claude.com/blog/how-anthropic-secures-its-ai-native-software-development-lifecycle




# How Anthropic secures its AI-native software development lifecycle

Anthropic Deputy CISO, Jason Clinton, details how the Security Engineering team secures a SDLC that has AI authoring 80% of merged code.

- Category

Claude Code

Enterprise AI

Agents

- Product

Claude Code

Claude Tag

Claude Enterprise

- Date

July 21, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-anthropic-secures-its-ai-native-software-development-lifecycle

At Anthropic, the amount of code and velocity of deployment have scaled exponentially. Our software engineers on average ship 8x as much code per quarter as they did from 2021 to 2025.

Our reviews, monitoring, and other security processes needed to scale alongside this increased pace. Otherwise it becomes a formula for bottlenecks (Amdahl’s Law).

Our software development processes have changed drastically as well. Claude has evolved from coding assistant to primary creator and reviewer. Claude authors about 80% of the code merged into our codebase today.

More than half of all code is being merged by our internal version of Claude Tag while human engineers focus on directing, setting intent, and owning final approval.

This means our security team must defend a rapidly expanding surface area and harden a lifecycle with non-deterministic, constantly evolving agents at its heart. In this article, I cover strategies to secure the software development lifecycle (SDLC).

(This is intended to be combined with the Zero Trust for Agents framework we recently published; everything in this article uses security design ideas from that framework in the implementation).

The threats we're designing against are specific: a compromised or prompt-injected agent introducing a malicious change; supply-chain and dependency poisoning that an agent ingests as trusted input; and the more familiar classes of application vulnerability now arriving at higher volume. Every control that follows maps to at least one of those.

There are several overarching strategies we’ve deployed to accomplish this without significantly throttling dev velocity including:

- Shifting security left and fully integrating with the code development stage;
- Using hard access and identity boundaries to contain the blast radius;
- Combining automated deterministic and agentic reviews before and after production; and
- Inserting humans in the loop at the highest leveraged points.

In this article, we’ll cover the security processes we have implemented at specific stages of the software development lifecycle as well as the core principles behind them. These principles are more enduring as security teams must reexamine, and often reinvent, their processes as model capabilities evolve. 

## The evolving software development lifecycle

Our development team has covered the changes to their software development lifecycle at length, so this will be a brief primer before we dive into each stage. 

At a high level, our software development lifecycle is compressed. It is driven by prototypes and internal adoption (dogfooding) more than lengthy planning cycles. Ideation comes from all corners of the organization and traditional roles (frontend, backend, design) are blurred. Reviews and approvals still have humans in the loop, but are also driven by agentic loops.

While each stage has been fundamentally transformed and accelerated by Claude Code and Claude Tag, the names and purposes of each stage wouldn’t look alien to a developer coming from a more traditional organization. These are natural gates that we also use as part of our security processes for an AI-native SDLC.

## Plan

One of our first security automations ever was a simple Claude Opus powered PSR (project security review) web application. It ingested a project design document and analyzed it against the MITRE ATT&CK framework to identify potential vulnerabilities and suggested mitigations.

We’ve significantly enhanced the system by connecting it to an internal knowledge index that provides much deeper context across our organization-wide policies, past decisions, and related systems. 

The process internally at Anthropic for an automated PSR.

This gives us a better understanding of potential risk, and it also captures information missing from the PSR. This one implementation saved the majority of the AppSec team’s time. Once we gained confidence that Claude was accurate in assessing risk, we allowed teams to approve their own project, if Claude deemed the launch low enough risk.

Here we can see one of the first key adaptations to an AI-native SDLC. A PSR was originally designed to catch security issues before the lengthy and expensive coding process. Catching an issue at this stage saved months of re-development. 

Today, multiple prototypes of major features can be created in hours, making detailed architectural review a less critical gate. Connecting our PSR application to our knowledge index captures context that could otherwise be missed without creating an unnecessary speed bump. Creating a Claude Code skill allowed Claude to further fan out and capture additional context wherever it lived. 

Enduring Principle: Connect security agents to organizational context. As the planning cycle compresses, it is much more effective to bring these agents to where the context already lives – chat threads, prior reviews, the codebase – rather than forcing detailed documentation at stages that may no longer require them. Either way, agents need context outside of the code itself.

No items found.

PrevPrev

0/5

NextNext

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

eBook

##

## Code

Security professionals within an AI-native engineering organization have a new lever: they can directly shape how code is created, helping to prevent vulnerabilities at the source. 

Previously, teams observed recurring vulnerabilities and created secure coding guidelines to address them, but those guidelines were difficult to enforce and rarely standardized. 

At Anthropic, those guidelines are encoded in CLAUDE.md files and references to org-wide skills so the code follows these best practices the minute it's generated. This is done as part of a closed loop. Once an agent discovers a bug class, the relevant file is updated to prevent it recurring in future code.

Of course, that doesn’t mean all code comes out perfect. Our team started with a CLAUDE.md file that instructs the agent to run /security-review as a final step before opening a PR. This generally available command, the productized version of our team's internal review workflow, looks for places where potential attacker-controllable input enters, scans for suspicious links, and then verifies its findings. 

Today, these reviews take place while Claude generates the code. Once a security guidance plugin is installed, Claude reviews the conversation and code as it goes. It suggests security improvements and addresses common vulnerabilities in the same session as it generates the code.

Other nudges at PR-time push internal, non-technical teams towards hosting their app on our low-code app-hosting platform, avoiding shadow IT that had traditionally plagued security teams.

Some of our customers choose to integrate /security-review with a PreToolUse hook, which makes this step a harder gate. That is also effective, but our team has chosen to incorporate our hard code review gate at the test/CI stage of the cycle.

In addition to shaping and reviewing code, containing the blast radius is one of our primary concerns at this stage. We do this by setting hard boundaries around identity (more on that in the monitor section) and setting our devs up to code on virtual machines. 

Moving our coding to remote VMs was a relatively painless shift and gave us increased control and visibility compared to laptops alone. Agent traffic on these VMs is egress-allowlisted.  

These tight egress controls matter especially when the agent is reading untrusted input which can carry a prompt-injection payload. An injected instruction can’t reach arbitrary destinations on the internet: exfiltration paths are limited to a small set of monitored services. 

Here again you can see a clear adaptation for an AI-native SDLC. Remote coding was previously used mainly to contain IP, and today we’re seeing more mature AI coding teams adopt these environments as a means to contain agents. 

Enduring Principle: Shifting left in an AI-native engineering organization means closing the loop between vulnerability discovery and updating instructions to customize how Claude generates code. Limit the blast radius (Principle of Least Agency) and what an agent can access with hard boundaries as appropriate.

## Test (CI)

In my experience, the test or CI stage quickly becomes the most painful bottleneck for engineering teams in the midst of an AI-native transformation. At Anthropic, once most developers were using agentic coding tools and running multiple agents at one time, it quickly became obvious the team could only move as quickly as humans could review code.

Let’s be clear: human accountability is still central to our process. What we did was accelerate the review process by combining automated agentic and deterministic reviews, while reserving human review for regulated or truly critical code. 

Historically, human code review has been held as the standard, yet the empirical evidence has shown it is not perfect. Security bugs regularly ship in software across the world. Our review process is able to review more code and catch particularly complex issues, helping to reduce these risks.

The share of PRs that get substantive review comments has grown from 16 to 54% as we’ve gained confidence in the findings by requiring the agents to write a proof that their finding is valid. We’ve also determined that approximately a third of the bugs behind past claude.ai incidents would have been caught by the automated processes we have now implemented.

We’re not the only organization that has found this to be true. Intercom has shared it auto-approves 19% of its PRs. Deployment doubled while downtime from breaking code changes dropped 35%. CircleCI reached a similar conclusion building Chunk, an autonomous agent on Claude that resolves CI/CD maintenance issues and validates its own fixes before a human ever sees them. The approach doubled the rate at which agent tasks convert into completed pull requests.

When a PR is opened at Anthropic, multiple agents automatically review it. Each review agent is designed and scoped to a specific, narrow focus and leverages RAG for additional context and memory surrounding past incidents. 

This is much more effective than one mega-prompt or super security agent for a few reasons:

- They do not share biases and blindspots
- If one is compromised or makes a mistake, it can be caught by other reviewers
- Effort isn’t spread too thinly across multiple focus areas

To be clear, agents aren't merging code to production unchecked. We tier our codebase by risk, and make deliberate decisions on what parts to automate. Entire codebases have strict human approval processes.

Human accountability is still central for code that is reviewed and merged by Claude.  Every approval is logged with the signals and reasoning behind it, and a risk-weighted sample is reviewed by humans. Another round of testing focuses on invariants like “user A can never read user B’s data,” and triggers additional manual reviews.We combine our agentic scans with SAST tools as well, which post directly on PRs. 

Most scanning approaches, whether agentic or deterministic, are consumption based. Costs will increase as code throughput increases, and teams will need to decide what level of coverage is appropriate for them. 

At Anthropic, we accept costs here will grow as our code velocity increases, but anticipate unit cost will fall. Models today are much better at coding than all models from a few years ago, and we anticipate that this pattern will continue.

Enduring Principle: Automated reviews are a different type of risk that is controlled differently (through multiple gates and agents with separate context windows). Humans stay in the loop, but may be in different places in the lifecycle depending on the nature of the codebase. 

## Deploy (CD)

Anthropic maintains a robust staging environment where we execute common security best practices such as external pentesting for major launches and periodic DAST scans to catch logic bugs that static scans have missed or can’t see. 

Like the other SDLC stages, AI presents both new challenges and solutions for security teams. On one hand, fewer vulnerabilities reach this stage. On the other, the vulnerabilities that do survive are among the most subtle and difficult to catch. 

Combine that with larger volumes of code being shipped more frequently, and periodic dynamic testing doesn’t seem so dynamic anymore. 

The good news is that AI models are better on the multi-step, cross-component reasoning that can catch a greater percentage of these complex vulnerabilities. For example, in February, we disclosed that Claude discovered and helped to fix more than 500 high-severity OSS vulnerabilities.

At Anthropic, we are implementing continuous AI-powered DAST scans in our staging environment. These look for vulnerabilities at the system level where the assumptions between two or more services are incorrect. There are a number of vendors that offer these capabilities today.

Enduring Principle: Dynamic testing should match deployment cadence. 

## Monitor

As any good security team knows, the job isn’t done once code is pushed to prod. We can assume any vulnerability will be quickly identified by increasingly sophisticated attackers.

Our security team has implemented programs here that are standard practice such as a public bug bounty program, red team simulated attacks, and regular scans for vulnerabilities across our dependencies, secrets, supply chain, cloud posture, and containers. 

Claude plays a large role in these, but we’ll focus on larger changes to our monitoring efforts as a result of our AI-native SDLC: alert triage and code migrations.

When an alert fires at Anthropic, Claude starts:

- Reviewing the production logs
- Root-causing the bug; 
- Writing the post-mortem; and in some cases
- Writing the code change to fix the bug. 

What this agent can’t do is deploy the fix automatically. It’s a single-purpose system account agent with three permissions: it can write new docs, post in company channels, and access production logs. 

The fix either needs to come from a separate agent-human reviewer system. The reason for this comes back to managing identity, permissions, and hard boundaries: it’s important to contain the blast radius when pushing code into production. Separating agents is critical as one (or multiple) agents act as checks on the other. 

This is also an important lesson for CISOs, and one that I had to learn the hard way. When considering an agent’s hard boundaries you need to include its access to other agents.

Following a model upgrade, the incident response agent reached out over Slack to another Claude instance on its own initiative. It asked the agent, which could write code, to push the fix. This was caught at a human review gate as designed, but this experience taught us to draw the boundary around access and actions, not around a model’s instructions or what we believe a model can do. Today at Anthropic, agent-to-agent communication on Slack is the norm and we give considerable thought to agent identity models.

The second major change is how our team approaches migrations. Every security engineering team has experienced the moment where they realize a code migration will be necessary to fix some systemic flaw in the way the company operates. In the past, the CISO would need to start campaigning and request a small percentage of each department’s engineering resources for multiple quarters to get it fixed. 

The economic cost of migration has fallen and so too has the cost of cross company coordination. Claude automates the migration process, tens of thousands of lines of code, in days. 

Enduring Principle: Give every agent a single-purpose identity with the minimum permissions for its job. If you do let agents coordinate, have them do so over the same channels as humans. 

## Governance

We have automated many of our security processes, but humans are still very much an integral part of ensuring a secure software development lifecycle. But instead of focusing on reviewing code and bug reports, our attention is now focused on Claude Tag, loops, and dashboards.

This underscores the importance of strong governance. If a skill goes stale, a discovered bug class never makes it back into CLAUDE.md, or an agent's decisions go unsampled, the whole structure degrades. We avoid this by:

- Tiering our codebase by risk and then automating reviews based on that level.
- Shadow mode for all new AI reviewers. New agents post comments for human approval until trust is earned. Our team also “red teams” them and tries to insert malicious changes.
- Sampling a percentage of all automated approvals.
- Watching our vitals. We maintain and closely monitor a dashboard that rolls up key metrics across every security process and workstream.
- Routing every agent action to the SIEM. Every automated approval, tool call, and agent-to-agent message is logged with the signals it used and lands in our SIEM, so any decision is attributable and auditable after the fact. We use this data and treat these agents as a new type of insider threat, and raise alerts when they act out of alignment.

Enduring Principle: The security engineer’s job evolves from monitoring bugs to monitoring loops.

## The only constant is change

It’s hard to overstate just how fast the software development lifecycle, and the means of hardening it are evolving. Model capabilities advance every month, bringing both new challenges and solutions. 

What doesn’t quite work today or isn’t quite economically feasible likely will be soon. The right question for your team isn't "can we afford to scan everything?" but "what would we run if scanning were nearly free?" Plan for that.

This article was written by Jason Clinton, Deputy CISO, Anthropic. He’d like to thank Michael Segner for his contributions to this article. 

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Jul 16, 2026

### How Anthropic runs large-scale code migrations with Claude Code

Claude Code

How Anthropic runs large-scale code migrations with Claude CodeHow Anthropic runs large-scale code migrations with Claude Code

How Anthropic runs large-scale code migrations with Claude CodeHow Anthropic runs large-scale code migrations with Claude Code

Jul 21, 2026

### How Datadog built a “universal machine tool” for Claude Code

Claude Code

How Datadog built a “universal machine tool” for Claude CodeHow Datadog built a “universal machine tool” for Claude Code

How Datadog built a “universal machine tool” for Claude CodeHow Datadog built a “universal machine tool” for Claude Code

Jul 20, 2026

### Working at the frontier: How Rakuten builds agents overnight with Claude Fable 5

Enterprise AI

Working at the frontier: How Rakuten builds agents overnight with Claude Fable 5Working at the frontier: How Rakuten builds agents overnight with Claude Fable 5

Working at the frontier: How Rakuten builds agents overnight with Claude Fable 5Working at the frontier: How Rakuten builds agents overnight with Claude Fable 5

Jul 17, 2026

### Working at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problems

Enterprise AI

Working at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problemsWorking at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problems

Working at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problemsWorking at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problems

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
