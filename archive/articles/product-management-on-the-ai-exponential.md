---
title: "Product management on the AI exponential "
url: https://claude.com/blog/product-management-on-the-ai-exponential
slug: product-management-on-the-ai-exponential
fetched: 2026-04-17 15:44 UTC
---

# Product management on the AI exponential 

> Source: https://claude.com/blog/product-management-on-the-ai-exponential





# Product management on the AI exponential

Claude Code’s Head of Product Cat Wu shares how product management teams are adapting their workflows and roadmaps in the face of rapidly evolving model intelligence.

- Category

Claude Code

- Product

Claude Code

- Date

March 19, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/product-management-on-the-ai-exponential

Since Claude Sonnet 3.5 (new) in October 2024, I made a habit of testing every new model by asking Claude Code (an internal tool at the time) to add a table tool to Excalidraw. With each new model, Claude got a little further but still failed. 

Then, with the release of Opus 4 in June 2025, Claude started occasionally succeeding, enough that we turned the exercise into a pre-recorded demo for the Claude 4 model launch to show what had become possible with our latest model.

Less than a year later, Opus 4.6 can one-shot Excalidraw feature requests reliably enough that we feel comfortable doing it live, in front of thousands of professional developers.

The speed of model progress keeps expanding what's possible. The traditional product management playbook is built on the assumption that what's technologically possible at the start of a project is roughly what's possible at the end. PMs would gather enough information upfront to make confident bets about the future, then execute against a plan over the course of months. 

Exponentially improving models break that assumption. The constraints you designed around might disappear mid-project. You're building on ground that's rising underneath you, and teams need to reorganize around that reality. The new product management rhythm is rapid experimentation, consistent shipping, and doubling down on what works.

Not surprisingly, one of the most common questions I get as a product manager at Anthropic is how our role is changing. Here's what I've learned.

## My journey to product management with Claude Code

I started my career as a product engineer at startups like Scale AI and Dagster, and then became a venture capitalist, a role in which I still wrote code to automate the tedious parts of my job, like scanning X for the announcement of new companies or detecting when open source projects were gaining momentum.

I joined Anthropic in August 2024 as a product manager on the Research PM team, which bridges our research team and real-world customers to deliver better models. When Claude Code became available internally that fall, I used it to accelerate the more manual parts of my job, including building Streamlit apps to analyze large-scale user feedback and running evals to help the company find new benchmarks to trust. The low barrier to building also meant I could explore well beyond my usual role, like creating RL environments to better understand training.

These projects took hundreds of hours of prompting Claude Code powered by Sonnet 3.5 (new), but not a single line of code written by hand.

## Designing a new product management workflow

Tools like Claude Code and Cowork are blurring the lines between distinct roles in the product development life cycle.

Claude Code isn’t the only tool powering my workflow. Over time, I've settled into a natural division of labor across three products: a chat collaborator (Claude.ai), agentic coding tool (Claude Code), and a knowledge work tool (Cowork). 

Claude.ai is where I talk to Claude as a thought partner without needing it to take action. I bounce ideas for strategy docs, how to handle tricky situations, and get quick answers.

Claude Code is where I build prototypes, evals, and scripts, many of which call Claude API. I use this when the output is code.

Cowork is where I do everything else, from getting to inbox zero, tracking and acting on a todo list, creating slide decks, understanding the history of a decision by searching Slack, and booking my work travel.

I’ve talked with product managers across the industry who've found their own versions of this workflow:

“Claude has raised the ceiling on what good product teams can build, and dramatically shortened the distance between idea and prototype. Getting something tangible in front of customers used to take weeks of building. Now I'll start in Claude Cowork, pulling in context from Slack, our codebase, and docs, then move into Claude Code to have something demo-able in a couple of hours. Good product teams have always tested their ideas with real customers, and that instinct hasn't changed. What has is how many more high-quality ideas we can actually put through the loop.” - Bihan Jiang, Director of Product, Decagon

“To me, being a PM in an AI-native world is both creative and academic. Each new model release changes what’s possible, and in building Datadog’s Bits AI SRE agent we study its strengths and failure modes through offline evaluation on real-world production incidents. We also design tight feedback loops, refining the UX to surface where the agent struggles and turning those insights into product improvements. In that sense, a PM’s craft has shifted from defining certainty upfront to accelerating discovery.” - Kai Xin Tai, Senior Product Manager, Datadog

One of the most exciting parts of being a product manager today is that these workflows are constantly evolving and giving us more leverage.

## Leaning into the AI exponential

METR. (2026, March). Task-Completion Time Horizons of Frontier AI Models. https://metr.org/time-horizons/

METR finds that, about half the time, Opus 4.6 can complete software tasks which take humans almost 12 hours. When we first started building Claude Code, Sonnet 3.5 (new) was the frontier model and METR measured that it could do tasks that would take a human around 21 minutes. That's a roughly 41x jump in 16 months.

The Claude Code team has evolved to keep pace with how quickly models improve. Our roles are blending together: designers ship code, engineers make product decisions, product managers build prototypes and evals. This works because clear strategy and goals let everyone prioritize autonomously. The product manager’s job is to create clarity in the ambiguity that rapid model progress creates, push the team to think bigger about what’s possible, and clear the path to shipping faster.

Here are four shifts we’ve embraced:

Plan in short sprints

Traditional product manager thinking treats exploration as something that happens before the roadmap gets locked. You do your research, you write the PRD, and you hand it off for the engineering team to build. 

Instead of a long-term roadmap, we encourage everyone on the team (engineers, product managers, designers) to take on side quests. A side quest is a short self-directed experiment you run outside your official roadmap—an afternoon spent prototyping an idea, testing a capability you assumed was out of reach, or just seeing what happens when you push the model harder than you expect to.

Some of Anthropic’s most popular features—Claude Code on Desktop, the AskUserQuestion tool, and todo lists—emerged this way.

Encourage demos and evals over docs

Our team has largely replaced documentation-first thinking with prototype-first thinking. Instead of hosting traditional stand-ups, we share demos of new ideas. Internal users try them, and the ones with real engagement get polished and shared more broadly. Because you can prototype in an afternoon, wrong bets are cheap.

For example, when Noah shared his plugins spec with Claude Code, the prototype that came back was close to production ready. That prototype anchored what the team ultimately shipped since it enabled the team to quickly validate the UX.

Pro-tip: after you write a spec, send it to Claude Code and see if it can build it. Even a rough prototype changes the conversation.

In addition to demos, evals can also help make an abstract product feel more concrete. For example, for agent teams which lets users coordinate multiple Claude Code instances working together, Conner hand-crafted a set of evals to understand when agent teams work well, when they don’t, and what to fix. Measuring whether the feature is working makes it easier to improve it.

Revisit features with new models

Now, you ship a feature, then a better model comes out and your feature could be dramatically better. Every model release is an implicit prompt to revisit what you've already built.

The best way to catch these moments is to be a daily active user and deliberately ask it to do things you think might be too hard. Sometimes it works, and that’s a signal that the product needs to catch up.

That’s how Claude Code with Chrome happened. We noticed users were building web apps with Claude Code and then manually switching to Claude in Chrome to test it. Users were manually prompting and copying and pasting instructions between these two tools. It worked well enough that we realized this should be a built-in feature. If users are hacking something together, that’s scaffolding you can build into the product.

When prototyping these ideas, always optimize for capability first. Use more tokens than you think you need. It's a common mistake to cut token costs too early and ship something much less capable as a result. You can always bring costs down later as cheaper models catch up, but first you need to know whether the feature is even possible.

Do the simple thing

At Anthropic, we have a guiding principle across every team: do the simple thing that works.

If your product cleverly works around a model limitation, that workaround becomes unnecessary complexity when the next model drops. That's why "do the simple thing" matters: the simpler your implementation, the easier it is to swap in new capabilities when they arrive.

When we first launched todo lists in Claude Code, the model wouldn't reliably check off items as it completed them. So we added system reminders every few messages that would periodically nudge the agent to update its own todo list. It worked, but it was a hack. With the next model, the behavior came for free and we removed the reminders entirely. We've seen this pattern repeatedly: our system prompt and tool descriptions used to be heavily engineered to compensate for model limitations, and we've been able to cut the prompting with each model, including a 20% reduction for Opus 4.6.

## Looking forward

Many product managers are used to having tight control over the full product experience, but AI pushes you to let go in order to move quickly. When it comes to building AI products in particular, it feels like surfing a wave where the most important thing is to stay on it. As a perfectionist, this was the hardest shift for me to get comfortable with, but the product manager’s role is now to identify the handful of true non-negotiables and let the rest go.

The net effect of these shifts is that product teams can move significantly faster. When a product manager can go from idea to working prototype in an afternoon, the gap between “what if we tried…” and “here, try this” nearly disappears. 

At Anthropic, product managers aren’t the only ones transforming their workflows with Claude. Our data science, finance, marketing, legal, and design teams picked up these tools on their own. The whole organization moves at the same speed instead of waiting on handoffs.

The PM role now is to track both things at once: how AI is changing the way you work, and how it's changing what's possible in your product. Do that well, and you stop being surprised when the table tool finally works. You're the one who saw it coming. 

Start building better products with Claude Code.

‍

Acknowledgments: This article was written by Cat Wu, the Head of Product for Claude Code at Anthropic. You can find her on X and LinkedIn. She'd like to thank Bihan Jiang and Kai Xin Tai for their contributions to this piece.

‍

‍

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

### Redesigning Claude Code on desktop for parallel agents

Claude Code

Redesigning Claude Code on desktop for parallel agentsRedesigning Claude Code on desktop for parallel agents

Redesigning Claude Code on desktop for parallel agentsRedesigning Claude Code on desktop for parallel agents

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
