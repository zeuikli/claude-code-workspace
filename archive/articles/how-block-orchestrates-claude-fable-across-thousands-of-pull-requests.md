---
title: "How Block orchestrates Claude Fable across thousands of pull requests"
url: https://claude.com/resources/articles/how-block-orchestrates-claude-fable-across-thousands-of-pull-requests
slug: how-block-orchestrates-claude-fable-across-thousands-of-pull-requests
fetched: 2026-10-12 00:45 UTC
---

# How Block orchestrates Claude Fable across thousands of pull requests

> Source: https://claude.com/resources/articles/how-block-orchestrates-claude-fable-across-thousands-of-pull-requests

> Bradley Axen on how Anthropic&#x27;s Claude Fable 5 orchestrates company-wide code migrations at Block.


# How Block orchestrates Claude Fable across thousands of pull requests

Bradley Axen, Head of AI Capabilities at Block, on how his team evaluates new large language models, how Claude Fable 5 orchestrates company-wide code migrations, and why safeguards are a critical part of deploying frontier intelligence responsibly, at scale.

-

CategoryPerspectives

-

ProductClaude Enterprise

-

DateOctober 8, 2026

-

Reading time11 min

-

ShareCopy link

Block builds tools that help businesses and individuals participate in the economy, including Square for sellers and Cash App for consumers. Bradley Axen leads AI capabilities at Block, where his team builds end-to-end AI products, including Buzz, an open-source workspace for human-agent teams (opens in new tab), and partners with the Square and Cash App teams to build customer-facing AI features. Brad spoke with Anthropic about how frontier models like Claude Opus 5 and Claude Fable 5 have transformed what it means to be an engineer, how Block applies agent orchestration patterns with Fable, and the role of safeguards when every employee has access to frontier models.

## Frontier models have made meaningful progress in 2026. How has this technology impacted how you work?

The biggest impact AI has had on our work at Block is how we build things, and you couldn't overstate how impactful that is. We saw the beginning of it in 2025 with tools like Claude Code, which at the time, required a lot more manual intervention. As models become more intelligent, design and engineering work has shifted toward designing the migrations themselves, reviewing agent behavior, and building more customer-facing features, which was always the goal.

The next phase is to bring these transformative technologies to our customers, through Block’s products. There's just as much value AI can bring to helping a small business handle the back-of-house operations it doesn't want to spend its time on, or to helping a Cash App customer manage their finances. With Claude, we have a whole new lever in technology that can change what people expect software to do for them. Imagine if AI could respond to customer needs and build new interfaces on the fly? Increasingly, I think our products will be built on demand with AI to solve specific problems.

## As frontier intelligence evolves, what can your team do now that it couldn't do a few months ago?

The biggest thing that has changed with Claude’s newer frontier models is the scale at which we can build software. Writing code is still the core component, but now we'll do company-wide migrations with AI. We've all had that dream for a long time, and in 2025 it rarely panned out. Before Claude Fable 5, you had to have a particularly well-shaped problem for frontier models to really shine.

In 2026, AI is a major part of how we run all large-scale code migrations. For us, a migration might mean hundreds or thousands of individual pull requests across multiple repos and millions of lines of code. In the past, humans had to coordinate that work, and models could take on one or a few PRs at a time. With Fable, we're seeing it orchestrate the work across many sessions. A human engineer steers, and Fable focuses on the higher-level design work: data models, API specs, algorithms. It then directs up to dozens of smaller, more cost-effective models like Opus or Sonnet to do the individual tasks, such as making the actual file edits and running tests.

The economics work out well. Early results show the orchestrator using frontier tokens for complex, upfront planning before driving a higher percentage of tokens to smaller worker models, without a drop in quality. We run the whole setup on Buzz, our open source collaboration workspace where humans and AI agents work side by side in shared channels and threads. It gives us great visibility into how the team is progressing.

In any given migration, we might merge a thousand pull requests orchestrated by Fable. That lets engineers focus on the hard design decisions instead of the mechanical work.

## When do you use Claude Fable models over other options?

A lot of models have started to close the gap since, and Opus is very good too, but the moment Fable came out, it was a big step change in how large a problem you could take on at once. Teams at Block gravitated to that and started figuring out what it means to move up another level of abstraction, another level of scale.

Now, a lot of our conversation is about model efficiency. That's where model orchestration comes in: Fable’s frontier intelligence is most valuable when you're tackling a big problem with it, and then we look to smaller models to fill in a lot of the details on code changes. It's literally the first time I can remember since we started using LLMs for code where the answer wasn't just "use the most frontier model 100% of the time."

Model orchestration is a big part of how we build things today, and it means we need new tools. Some tools are very single-conversation focused, and the interface doesn't keep up with you having 45 agents working with you all the time. That's another place Buzz comes in. We have multi-agent workflows in Buzz, and we really think the future is multiple people talking to many agents, with the organization picking the efficient models for routine tasks and frontier models for bigger problems.

## What's the hardest problem you've thrown at Fable?

The first is large-scale migrations: multiple-thousand-PR migrations where Fable orchestrated the whole system that did the work.

The second is taking a large codebase, something in the neighborhood of a million lines of code, and making sure it's not growing tech debt every day. We are shipping more PRs than ever before. People are shipping a lot more features and a lot more changes, so our systems accumulate tech debt faster than ever, and we've been missing the corresponding thing that speeds up our ability to maintain them. That's finally happening. We have agents that do daily or weekly passes across a whole codebase asking, "How's it going in here? What do we need to clean up and consolidate?"

## With broad access, how do you drive efficient use of frontier models?

We give anyone in a technical role full access to the most frontier models, because a big part of our strategy is to always be working at the edge of what's possible.

Using Fable to fix a typo in a README is a very bad use of resources. So we needed better systems for suggesting which model to use for given tasks. To accomplish this, we’ve been building an auto-selector that helps employees choose which model to use, when. Our multi-agent systems powered by a mix of larger and smaller frontier models help too.

A big part of our goal as a company is to operate efficiently by default, and that's the skill we're building now. We've got a lot of great models to choose from. If everyone gets good at picking the right model for the right task, our cost effectiveness goes a lot further without slowing us down.

## Do you advise specific optimization strategies, like effort levels?

Even as someone who works with LLMs all day, I almost feel like a model at xhigh effort is a different model than the same model at medium. I don't think of effort levels as a spectrum you walk along. Fable on low might just be better than another model on xhigh. So I think of it as a bigger grid we need to optimize against. Every single use case we benchmark, we check not just every model but every effort level of every model.

As someone working centrally on how we do AI, I want recommendations that are really clear, such as: "Use this model on high as the default for this kind of task." We have to make the tools do that automatically as much as possible, and then let experts explore when they want to.

## How are you thinking about incorporating safeguards with today's frontier models?

Some things are so critical that you need guarantees, and we're not ready to let LLMs loose on our codebase. We always leave merges to main and deploys to production up to people, along with related changes like feature flags. Agents can make code changes, but those changes have to pass our security checks, and then two humans have to approve the deploy. That dual-approval layer makes it impossible for an LLM to push those kinds of changes on its own.

At a lower level, it's surprising how many things an employee can do on their laptop if they're not paying attention, things you assume humans won't do because they know not to. That pushes us in interesting directions. I think a lot of the future of work is remote workstations, because they're easier to secure (and they help with other problems LLMs have, like filling up disk space). A big part of our security story is building systems that are secure by default: a network allow list instead of a deny list, and things like that, which stop the worst kinds of problems.

We also try to get as much as possible out of the model loop. A lot of our security guardrails are really cheap, efficient checks that run without the model needing to be involved. We build those into the interfaces people use to do work. Sometimes it's even a regex. Increasingly, smaller classifiers are part of the picture too.

Then in the day to day, there's a whole class of things you want to enable to make people productive, where blocking isn't worth it. We intentionally let the model open PRs, review code, and query our logging systems and analytical databases, all to help people move faster.

That's where the model's built-in safeguards are really critical. By that, I mean the way Fable and other frontier models are tuned to not take part in dangerous activities, plus Anthropic's own safety classifiers (opens in new tab). In our testing, even if someone asks Claude to "hack around" our dual-approval system, it refuses to try to bypass it. It's something we benchmark, too.

## Any advice for other engineering teams working with frontier models?

We have thousands of people working with AI who are pushing the frontier of what it can do. They're learning what works as individuals, and they're improving the systems around them. I've got a bunch of local skills on my laptop that make it possible for me to work in our Square web front end, for example, even though I’m not a front-end developer by trade. Organizational maturity comes when all of this context and organizational knowledge is remembered at a system level, not an individual level.

Our goal is to document everything we're learning from people doing the work and put it into a system where everyone benefits, so every time you run an agent, you know it has the best context available to contribute to your work.

Get started with Claude Fable 5.1 (opens in new tab) today.

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleOct 6, 2026

### How Comcast and Booz Allen use Claude Mythos to find exploit chains and secure their codebases

Security teams at Comcast and Booz Allen used Claude Mythos-class models through Project Glasswing to find, validate, and fix vulnerabilities their existing scanners missed.

ArticleSep 29, 2026

### Agents you can coach: how Asana builds human-agent teams with Claude

Arnab Bose, Chief Product Officer at Asana, on how Asana runs AI agents as teammates with scoped roles, shared memory, and work that everyone can see.

‍

Claude Platform

ArticleSep 28, 2026

### Automating eval design and hillclimbing with Claude

Principles for designing evals and hillclimbing against them without fooling yourself, and how the claude-api skill's build-eval and hillclimb commands put them to work.

Claude Platform

(opens in new tab)

ArticleSep 25, 2026

### Using Claude Code: Spending your effort

What effort really is and when to use which level in Claude Code, from my own tests of three builds and a deep dive into Terminal-Bench 3.0 on Opus 5.5 and Fable 5.1.

Claude Code

(opens in new tab)
