---
title: "How Outtake built a cyber investigator on Claude | Claude by Anthropic"
url: https://claude.com/blog/how-outtake-built-a-cyber-investigator-on-claude
slug: how-outtake-built-a-cyber-investigator-on-claude
fetched: 2026-07-23 04:12 UTC
---

# How Outtake built a cyber investigator on Claude | Claude by Anthropic

> Source: https://claude.com/blog/how-outtake-built-a-cyber-investigator-on-claude




# How Outtake built a cyber investigator on Claude

How Outtake ensures multi-hour agent sessions stay on track to uncover attack network operations

- Category

Agents

Claude Code

- Product

Claude Code

Claude Platform

- Date

July 22, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-outtake-built-a-cyber-investigator-on-claude

In our series, How startups build with Claude, we highlight how startups are transforming their industries with AI. In this article, we share how Outtake built an autonomous cyber investigator that detects, investigates, and dismantles digital threats, from cloned login pages to entire adversarial networks.

          The quick pitch

          Name
          Outtake

          Founded
          2023

          Founders
          Alex Dhillon (CEO), formerly of Palantir's moonshot team

          Growth
          Grew annual recurring revenue 6x and its customer base more than 10x year-over-year, scanning 20M+ potential cyberattacks in 2025 alone.

Even with strong safeguards and controls, bad actors can mask their use of AI in seemingly benign purposes that hide their malicious intent. Code generation platforms can create convincing login portals, agentic go-to-market tooling can power the distribution of phishing attacks, and image generation capabilities can spoof identity. Traditional cybersecurity defenses struggle to keep up.

“If you put on the bad actor's hat, it's actually a great time to be running attacks,” says Alex Dhillon, founder and CEO of AI cybersecurity platform Outtake. “The average attack is not only executed faster because of AI, but it also captures deeper access due to AI”

Outtake unifies the full digital trust attack chain into a single defense, using fleets of AI agents to autonomously detect, investigate, and dismantle threats aimed at their customers, which include leading AI labs, major hedge funds, and US federal agencies. 

Here’s how the Outtake team recently built the Recon Agent, a long-running autonomous cyber investigator, on Claude using Claude Code and the Agent SDK.

## Agentic offense needs agentic defense

When targeting a company, attackers typically move through the same process: weaponize public data → build impersonations as lures → exploit internal systems. This process has been accelerated by AI.

Before breaking into anything, they harvest publicly available information about an organization, and its executives and employees.

They then turn that intelligence into bait, like a fake website with a fraudulent login page, to trick victims into handing over credentials. The access gained from these lures help the attacker get inside the perimeter to reach an organization’s most valuable and sensitive assets.

 
This three-part sequence is predictable, but legacy security tooling guards only one slice at a time:

- Threat intelligence tools monitor the public-data stage,
- Brand protection tools watch for impersonations, and
- Endpoint tools guard the internal systems. 

Outtake’s Recon Agent investigates the full network behind an impersonation. Instead of just taking down a cloned login page, for example, the agent gathers and classifies evidence from the impersonation event. 

It follows those leads to connected infrastructure, like a fake Telegram account that presents itself as “Customer Support,” and maps this adversarial network in a graph. The agent’s final step produces a report explaining the investigation process, a profile of the threat actor, and a reconstructed timeline of what the attacker did. 

To carry out this sophisticated workflow, the Recon Agent can read, write, and run code. It can even interact with malicious login pages directly to see where stolen credentials actually go. 

These investigations can require agents to run autonomously for long periods of time. Agent sessions run a median of 16 minutes, but routinely stretch to an hour and beyond; the longest run thus far lasted two hours of agentic work before returning results.

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

## How Outtake built a complex long-running agent with Claude

Outtake built the Recon Agent in roughly four stages. Each stage was about understanding what a good investigation looked like, then progressively handing that judgment to the agent.

### Step 1: Become the expert first.

Before building any part of the agent, Outtake's engineers ran real cyber investigations themselves and pulled domain expertise from customers and design partners. 

The goal was to define what "good" looks like. For these types of investigations, that meant identifying what evidence matters, how to organize it, and what separated an actionable conclusion from a guess. That standard became the fixed reference point they returned to at every later stage. 

“The most important thing about building long running agents is that you really have to understand what does good look like? What is the agent supposed to be doing?” said Jack Hayford, engineering lead for Outtake's agent platform. “Because ultimately you're ensuring that the agent can do that every single time.”

### Step 2: Prototype in Claude Code

Initially, the Outtake team used traditional agent frameworks to progressively automate the investigations they were standardizing. 

They quickly realized, however, that the Recon Agent couldn't just be a simple investigator. It needed to write, run code, build tools on the fly, and actually interact with malicious domains. 

“Every investigation is different, and deeply technical,” Hayford said. “The agent needed coding muscle and capability, and Claude Code was a strong initial harness for us to actually validate those assumptions and start experimenting more and more.”

It was by prototyping in Claude Code that they forged their core design principle: constrain the agent tightly at the orchestration level (‘always do X, Y, Z when investigating a domain’), but leave  it free to improvise whenever judgement was required.

### Step 3: Graduate to a production-grade harness

“We really liked the patterns that Claude Code had introduced, but we needed additional access to the lower level primitives, which we weren't trying to build ourselves,” Hayford said.

Using the Claude Agent SDK was a natural next step for taking the Recon Agent into production. Carrying over skills and patterns from Claude Code ensured that the team didn't drop any velocity while they gained tighter control over the Recon Agent’s memory, context, and file system without reinventing the wheel in terms of the agent loop and handling sessions.

### Step 4: Build a tight iteration loop driven by evals. 

The ability to iterate inexpensively and responsively is particularly crucial in cybersecurity, where attackers adapt the moment they learn a defensive tool exists. The team integrated agent evals from the very beginning, and arrived at a strong eval suite that runs many scenarios at once. This let them make sweeping changes, like model upgrades and full memory-system refactors, safely and with confidence. 

It also let the team pull themselves out of the agentic loop. When, for example, the Recon Agent finishes an investigation and reports back that it could have done better with some tool it didn't have, a separate coding agent then reads those suggestions, writes the new tool, and builds a test scenario to try it out. 

Only at the very end does a human step in to look at the result: did the agent do the investigation better with that tool, or not? “We are the bottleneck, and when you build these long, complex agents, it's very important that the feedback loop be automated. It's a lot faster and it's also a lot more satisfying as a developer,” said Hayford.

## Learnings from building a long-running agent

In the early days of agents, builders scripted agent behavior in advance with hardcoded, deterministic, step-by-step paths to keep it from going off the rails. Now, elaborate workflows are being replaced by a harness: a supportive environment of memory, tools, skills, and guardrails.

Here are some takeaways from the Outtake team’s experience in implementing the Recon Agents build.

### Tools: a filesystem and bash is all you need

Filesystem enables memory that survives compaction. Agents are typically given very specific and nuanced tools, but giving an agent a filesystem along with the ability to write, read, and run code helps the agent respond to obstacles. 

“Handing those extremely powerful open-ended tools and capabilities to an agent is a huge step change. We’ve observed plenty of cases where an agent had a tool that was failing due to a network hiccup or whatever, and it would just find the right workaround and continue,” said Hayford. “Because the rest of the harness that we had built was strong enough, and because it left the agent with opportunity for improvisation with these powerful, open-ended tools, it was still able to get to a successful outcome.”

### Prompts are suggestions

Prompts provide flexibility when needed, but hardcoding where possible ensures stability. “When you're building these long-running agents that get complicated over time, prompts are suggestions,” Hayford said. “When an agent didn't do what you wanted, the natural response is to add to the most plastic part of the agent. Slipping ‘when X happens, make sure you do Y’ into the system prompt may work initially, but as this agent runs longer, every single word in that prompt will probably be ignored eventually.”

The correct approach is to build around that likelihood by identifying what the agent should always do every time and making it part of the agent guardrails. “Pull these things out of the prompt and put them into the harness,” he said. “Now the agent doesn't have to think about it anymore and it has more context space and attention to put towards areas where it can really thrive.” 

Read more on best practices for directing Claude, and the context cost and authority of each method. 

### Evals are for speed, not just reliability

Use manual “reflections” as a roadmap to automated evals that tighten dev cycles. The conventional view is that evals are a quality gate for reliability. For long-running agents, though, the bigger payoff is speed. 

Early on, every time the Recon Agent ran, the team did a manual review of its performance. But reading an agent’s 30-minute transcript of everything it did is brutal and doesn't scale. 

“In modern agent development, evaluating the output is the most expensive step in the loop,” Jack said. 

An eval is just a structured, graded, automatable version of that reflection. Once you've codified what good looks like into a repeatable check, you can put an agent in the judge's seat to read the 30-minute transcript and score the run.

“I think that some engineers feel apprehensive about building evals because it's like this idea of building a perfect case,” Jack said. “Building some version of evals from the very beginning will make you build that agent faster regardless of how official or ‘perfect' they are.”

### Protecting your agents

Prompt injection is a real threat, so putting your agent in a sandbox or giving it armor is essential. The Outtake team chose Claude in part because of its strength against prompt injection. 

“Security is a big note for us for building the Recon Agent,” Hayford said. “We gave it a file system and bash and we're sending it to adversarial environments, so the most important problem we had to solve was building a sort of blastbox where you could try to hide your agent from sensitive internals without actually hindering it.” 

Their approach assumes the agent might get hijacked, so the surrounding system is engineered to contain the damage. Security looks different from agent to agent, however, depending on their purpose, and not all agents are blastbox candidates. 

Outtake is now scoring the level of trust at the exact point where the agent reaches out to the internet, implementing a checkpoint that evaluates whatever the agent is about to touch: ‘Is this page an impersonation? Is it malware? Is it trying to prompt-inject the agent right now?’ This may be exactly the armor that agents need as they traverse an increasingly adversarial internet.

          Best practices from the Outtake team

          Do you know what "good" looks like?
          Be the agent first. Run the real task yourself and pull domain expertise from customers and design partners so you have a fixed standard to hold every later iteration against.

          Is each piece of complexity earned?
          Find the simplest working version and automate piece by piece. Add complexity only when results justify it &mdash; same discipline as traditional software.

          Is your harness matched to the workload?
          Validate assumptions fast in Claude Code, then graduate to the Agent SDK when you need lower-level control over memory, context, and sessions. Don't rebuild the agent loop yourself.

          Where should the agent be constrained?
          Hardcode guardrails at the orchestration layer, but don't let those constraints reach into low-level judgment calls. The improvisation space is where the best results come from.

## What's next

Recon Agent is live and running investigations today. If you want to go deeper on how Outtake uses Claude to map adversarial infrastructure at scale:

- View the full webinar for a live demo and deeper discussion of how Outtake uses Claude to autonomously investigate and map threat infrastructure at scale.
- See Recon Agent in action. Explore how the agent moves from a single impersonation to a full threat actor profile.
- Get a free Recon Agent assessment to see what an investigation surfaces on your own exposure.

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Jul 22, 2026

### Building verification loops in Claude Code with skills

Claude Code

Building verification loops in Claude Code with skillsBuilding verification loops in Claude Code with skills

Building verification loops in Claude Code with skillsBuilding verification loops in Claude Code with skills

Jul 21, 2026

### How Anthropic secures its AI-native software development lifecycle

Claude Code

How Anthropic secures its AI-native software development lifecycleHow Anthropic secures its AI-native software development lifecycle

How Anthropic secures its AI-native software development lifecycleHow Anthropic secures its AI-native software development lifecycle

Jul 21, 2026

### How Datadog built a “universal machine tool” for Claude Code

Claude Code

How Datadog built a “universal machine tool” for Claude CodeHow Datadog built a “universal machine tool” for Claude Code

How Datadog built a “universal machine tool” for Claude CodeHow Datadog built a “universal machine tool” for Claude Code

Jul 16, 2026

### How Anthropic runs large-scale code migrations with Claude Code

Claude Code

How Anthropic runs large-scale code migrations with Claude CodeHow Anthropic runs large-scale code migrations with Claude Code

How Anthropic runs large-scale code migrations with Claude CodeHow Anthropic runs large-scale code migrations with Claude Code

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
