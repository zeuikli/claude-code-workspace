---
title: "How Cursor knew Claude Fable 5 was ready for the hardest 1% of problems | Claude by Anthropic"
url: https://claude.com/blog/working-at-the-frontier-cursor
slug: working-at-the-frontier-cursor
fetched: 2026-07-18 03:52 UTC
---

# How Cursor knew Claude Fable 5 was ready for the hardest 1% of problems | Claude by Anthropic

> Source: https://claude.com/blog/working-at-the-frontier-cursor




# Working at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problems

Nate Schmidt's job at Cursor is to evaluate frontier models against their ability to tackle long-running, real-world engineering problems. Here’s why–and how–Claude Fable 5 changed the calculus on what coding agents are capable of.

- Category

Enterprise AI

- Product

Claude Platform

- Date

July 17, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/working-at-the-frontier-cursor

Cursor is an AI coding agent for building professional software. It supports every major frontier model alongside Cursor's own, which makes the company an unusually neutral judge of how each one actually performs.

Nate Schmidt is the engineer who maintains that scorecard. He works on evals and model behavior at Cursor: studying how models succeed, how they fail, and what makes a developer quietly switch away from one mid-task. When colleagues and customers want a read on a new release, they come to him.

Over time, Schmidt's team noticed that public benchmark scores and real developer reception to these models had stopped lining up, so they built their own: CursorBench. 

CursorBench was built to capture the messy, underspecified ways engineers actually prompt their models. One eval task is just a stack trace pasted in with the single word "fix," and the model has to infer the intent, find the root cause, and validate the change on its own. Another tells the model the wrong module is broken, to see whether it challenges the user's assumption or follows it into a dead end. 

When Claude Fable 5 ran the eval, the model achieved 72.9% at Max effort, setting a new high, and capturing what agentic coding tools were capable of when paired with the right models. 

Claude Fable 5 achieved achieved 72.9% at Max effort, setting a new high.

But when Schmidt was using the model on his own engineering workflows and personal tests, he'd stopped having to repeat his goals. The constant babysitting—reminding the model of context, spelling out the solution, auditing the results—wasn't necessary anymore. He could hand over a problem, from the gnarly refactor he was putting off to reasoning about nuanced edge cases, and Claude Fable 5 could solve it.

"I don't feel like I have to bootstrap Claude Fable 5 to understand the world I exist in and the problem I'm trying to solve," Schmidt says. "The model just has a sense of it out-of-the-box." 

### Reasoning about the entire mission

When Schmidt's team runs a new model through CursorBench, the right answer is table stakes. What they're scoring is whether the model understood what it was being asked.

"Many evals look like this: here's a well-defined problem, here are the constraints, go fix it. But the prompts we get from real users don't really look like that," Schmidt says. "The model has to infer that the user has a problem and what they're trying to convey, identify the root cause, fix it, validate the fix, and report back."

Claude Fable 5 scored so well on these ambiguous tasks, the Cursor team started to feel suspicious. 

"One of two things is happening: either the model's very smart, or the model is cheating," he says. So the team looked into the traces, reading the model's actual reasoning on the hardest tasks, the ones where the prompt looks simple but cracking it requires understanding the whole system.

"We just kept seeing the model dig out wins that no other model was doing previously," he says. It was also getting there with fewer operations: token-efficient relative to the work it completed.

Then Schmidt put Claude Fable 5 on one of his favorite personal tests: landing on the moon.

A few weeks earlier he'd wired Claude Opus into a programmable space-flight simulator with a one-line prompt—build a rocket and land it on the moon—and let it run on a second monitor for twelve to sixteen hours. The model would launch, run out of fuel in orbit, add a lot more fuel, then fail to clear the atmosphere because the rocket was now too heavy. 

He re-ran the experiment with the same blank-slate prompt, this time using Claude Fable 5. A few minutes in, the rocket went up, parked in low orbit, and came back down. Same failure as before. Then Schmidt read the transcript.

"Fable decided it wouldn’t go to the moon on its first attempt. It wanted to do an initial mission just to go into orbit and collect telemetry, then use that to inform the next trip." A few attempts later, the engine noise on his second monitor stopped. There was a lander on the moon. The whole run took a couple of hours, against Opus's twelve-plus with no result.

"With Opus, it was doing local reasoning—thinking about what just happened and what's immediately about to happen," Schmidt says. "With Fable it's global reasoning. It's thinking about the entire mission."

Cursor runs all models through CursorBench, their internal benchmark for evaluating models on tasks that simulate real developer work.

### When to reach for the global optimum

Schmidt has settled on a simple rule for when to use Claude Fable 5 over cheaper, less intelligent models.

"If you have a good sense of what the path from A to B looks like, you might not need Fable. If you're at A and you have no idea where B is, Fable is an excellent choice,” he says. "When I want to build something the right way, Fable is the first model I think of."

Claude Fable 5 has also allowed his team to focus on projects the team had previously shelved—rewrites everyone agreed would be better but nobody could justify spending weeks on—because the model can carry enough of the skeleton. "It lowers the activation energy to work on these types of tasks," Schmidt says. "It lets us move in search of a global optimum rather than a local one."

It also changes how the team coordinates. Cursor runs lean, with intense individual ownership and few standups. Now, before touching shared code, Schmidt has an agent read his teammate's recent commits and flag conflicts, so neither of them has to stop what they’re doing to check in.

To balance cost and performance, his team pairs Claude Fable 5 with faster, lighter models for routine work and brings it in for the problems where capability is the constraint. In that configuration, he says, the combination is the most effective setup they've run.

“If I'm getting into a really gnarly problem–the p99 of problems–the thing I'm trying to optimize for is time to solution,” he says. “And I think Fable is the best model for solving our hardest problems.”  

Nate Schmidt tests new models across various evaluations, including putting it through the paces in a space-flight simulator.

### What's next

Despite putting the model through its paces on CursorBench and sending it to the moon, Schmidt is still looking for Claude Fable 5’s limits. Next, he wants to see how long the model can manage a back-end system unattended; days-to-weeks runs are his next experiment. Inside Cursor, the team is using the model to hunt performance bottlenecks and user pain points proactively rather than waiting for reports, and to build the more sophisticated, closer-to-reality eval environments that will measure whatever comes next.

"There's a class of problems people weren't even thinking about because it didn't seem approachable," he says. "With Fable, I'm excited to push at that."

Get started with Claude Fable.

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

Jul 17, 2026

### Zero risk isn't the job: a CISO's guide to agentic AI

Enterprise AI

Zero risk isn't the job: a CISO's guide to agentic AIZero risk isn't the job: a CISO's guide to agentic AI

Zero risk isn't the job: a CISO's guide to agentic AIZero risk isn't the job: a CISO's guide to agentic AI

Jul 16, 2026

### How Anthropic runs large-scale code migrations with Claude Code

Claude Code

How Anthropic runs large-scale code migrations with Claude CodeHow Anthropic runs large-scale code migrations with Claude Code

How Anthropic runs large-scale code migrations with Claude CodeHow Anthropic runs large-scale code migrations with Claude Code

Jul 16, 2026

### Working with Claude Fable 5 in Claude Cowork

Enterprise AI

Working with Claude Fable 5 in Claude CoworkWorking with Claude Fable 5 in Claude Cowork

Working with Claude Fable 5 in Claude CoworkWorking with Claude Fable 5 in Claude Cowork

Jul 15, 2026

### Working at the frontier: Why Base44 trusts Claude Fable 5 with their most challenging engineering work

Enterprise AI

Working at the frontier: Why Base44 trusts Claude Fable 5 with their most challenging engineering workWorking at the frontier: Why Base44 trusts Claude Fable 5 with their most challenging engineering work

Working at the frontier: Why Base44 trusts Claude Fable 5 with their most challenging engineering workWorking at the frontier: Why Base44 trusts Claude Fable 5 with their most challenging engineering work

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
