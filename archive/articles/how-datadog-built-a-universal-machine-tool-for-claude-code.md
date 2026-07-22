---
title: "How Datadog built a “universal machine tool” for Claude Code | Claude by Anthropic"
url: https://claude.com/blog/how-datadog-built-a-universal-machine-tool-for-claude-code
slug: how-datadog-built-a-universal-machine-tool-for-claude-code
fetched: 2026-07-22 04:14 UTC
---

# How Datadog built a “universal machine tool” for Claude Code | Claude by Anthropic

> Source: https://claude.com/blog/how-datadog-built-a-universal-machine-tool-for-claude-code




# How Datadog built a “universal machine tool” for Claude Code

Datadog has an agent write specifications for a deterministic kernel to write application code.

‍

- Category

Claude Code

Enterprise AI

- Product

Claude Code

- Date

July 21, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-datadog-built-a-universal-machine-tool-for-claude-code

Agents, mechanization, and industrialization

All of Datadog engineers use AI coding tools for production code, and Claude Code drives at least two-thirds of that. With Claude Code, they generate personalized flows in their software development lifecycle in four distinct categories:

- Targeted changes: dozens of gnarly bug fixes, performance optimizations, and bridges to existing services. 
- Large refactors: refactoring a custom protobuf parser in three days as well as rewriting a metrics control from FoundationDB to Postgres in under three months. 
- Replacing large parts: new sharding algorithms and autoscaling redesigns. 
- Building entire systems: replacing MongoDB with Postgres, BYOC control planes, and ingestion pipelines from scratch.

As work flowed across this map, however, they saw it became more complex to generate on one axis and more ambiguous to verify on the other. 

## The flow problem

For engineers, flow used to mean a direct relationship between intent and code. You understood the problem, wrote the code, tested it, reviewed it, shipped it, operated it, repeated. With agents, the abstraction is changing rapidly. 

“You're no longer writing the code; you're shaping the work. You're deciding what the agent should see. What tools it should have, what success means, how failure should be detected…It's like everyone's promoted three levels up into the management chain, which they didn’t sign up for because they're engineers,” says Sesh Nalla, VP of engineering, Datadog.

With approaches like Claude Managed Agents, Datadog’s sessions run longer, sometimes for days. Each agent invents its own tools, its own glue code, and its own conventions. The agents become significantly more useful, but need humans to bridge the gap between agent execution and tools designed for humans.

Machine tools are the jigs, fixtures, gauges, and mills you see in manufacturing. They produce precise, repeatable parts that you assemble into larger, more complex machines like engines, aircraft, nuclear reactors, and lunar landing modules. They were the breakthrough of industrialization as parts became composable, inspectable, and replaceable.

Temper is what Sesh describes as Datadog’s attempt at a universal machine tool for agentic systems. In other words, the smallest kernel required for agents to build what they need in a safe and precise manner.

“This is the point where I felt we needed something more structural,” says Sesh. “If agents are going to build and operate large parts of our systems, of our databases, which are mission critical, they need the equivalent of this machine tool concept. Temper is that machine tool for Datadog.”

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

## The road to Temper

Mechanization means agents are doing more of the work now. And industrialization means work becomes repeatable, verifiable, controllable, and scalable. At Datadog, this didn’t happen all at once: the path to Temper led through three other projects, Courier, BitsEvolve, and Helix. Each one exposed the bottleneck for the next, and enabled them to grow their ambition.

In 2024, they introduced Courier, a distributed queuing system. It took them one year to build completely by hand and from scratch.

“The difficulty was not building the parts; it was making the interactions between them observable, testable, and verifiable,” says Sesh. “So we were rigorous with formal modeling and simulation… identified the parts where mistakes would be expensive or hard to reverse, and raised the rigor [there].” 

In September 2025, they built BitsEvolve, a closed-loop evolutionary optimization harness. A council of models generates code variants. A cascade of benchmarks, tests, and production observability decides what survives. 

“This was the first glimpse for me that parts of software could be cultivated like living organisms — grown through variation with feedback, and adaptation,” says Sesh. 

The catch: evolution is only as good as the environment it adapts within, and BitsEvolve’s bottleneck was this feedback loop. Then they built Helix, a Kafka-comparable streaming service. Claude Code did most of the construction with one human steering it. 

“To our disbelief, in a few days we had a fully functional Kafka comparable system,” says Sesh. “[It was quick to build] and we started shadowing it and we saw opportunities where it could be 2x to 5x cheaper.”

Getting it to production, though, took a lot more mileage: the operational hardening only earned over time and by more than one person and this is still in the process of rolling out. 

“The bottleneck moved again where agents could build large parts of the system…but then humans still have to coordinate to ship the work to production through tools and mechanisms built for humans,” says Sesh.

Datadog needed a way for agents to build their own tools in a verified, policy-driven runtime environment. That runtime was Temper.

## Temper

Agents can produce code faster than any team can review by hand, but they can make mistakes. 

For Sesh, that gap between what an agent generates and what passes verification is where the failure modes accumulate. However, simply wrapping an agent around a traditional codebase treats this as a throughput problem without closing the verification gap itself.

Temper reverses this equation: instead of producing application code, agents produce specifications. The kernel reads each specification, verifies it through four layers of analysis, and deploys the running system the specification describes. Because the specification is both the artifact that gets proved and the artifact that gets executed, there is no drift between what was verified and what is running.

“Temper changes the center of the system. The agent no longer needs to keep inventing disconnected tools for every local need. Instead, it produces precise descriptions as specifications of the intent and problem domain. It is a machine tool in the same sense that a jig or a CNC machine, where you give them specifications of what your screw threading needs to be. It's extremely repeatable. You can run them and you can build aircraft and complex things like that with them,” says Sesh.

So in this case, the agent does not improvise the final mechanism each time. It can produce a precise description and iterate with Temper (or a Temper-like mechanism) to make something work first and then later turn that into something repeatable, checkable and reusable so you could actually build a software factory around your code base.

Each capability is described by three contracts:

- Behavior: the states, the transitions, the preconditions, and the safety properties that must hold. 
- Data contract: the entity types, their properties, and the actions each type supports, published in machine-parseable form so an agent can discover the full API without documentation.
- Authorization: default-deny, scope-based approval, with denials recorded as pending decisions a human can approve and hot-load into the policy engine.

Every spec passes four independent layers before the kernel will load it. Symbolic reasoning proves each guard is satisfiable and each invariant is inductive. Exhaustive state exploration visits every reachable state. 

Deterministic simulation runs the actual production code path with seeded fault injection — drops, delays, reordering, crashes — so failures reproduce exactly under the same seed. 

Randomized property testing runs about a thousand pseudorandom action sequences and shrinks any violation to a minimal counterexample. On a small spec, the whole cascade runs in well under a second.

## The dark factory for Helix

Simon Willison popularized the term dark factory, a software process where agents keep working without humans on the virtual factory floor. In the Helix dark factory, Temper plays three roles. 

It is the agent control plane for managed agents — sessions, roles, work queues, lifecycle. It is the tool-builder layer, letting agents bridge SDLC tooling (Git, CI, deployment) with small Temper apps. And it is the Helix control API, the lifecycle surface around the data plane that exercises the workload.

“The surprise was it started to feel more general than agent infrastructure. A lot of software, if you squint, is just control logic around database APIs: state, policies around mutation, lifecycle transitions, integrations with external systems. Temper could be universal in a sense that it can be applied to any software that has the shape I described,” says Sesh.

## Why not just build a CRUD app?

“Claude Code can [build a CRUD app in TypeScript or Python] very well. However, in normal CRUD apps, the control logic is spread across routes, database constraints, service code, background jobs, and documentation. It may have good tests and coverage, but the operational mode, which generally takes the form of a state machine, is implicit in the codebase,” says Sesh.

“Temper makes that state machine explicit. The agent produces a precise description, not arbitrary code. The compilation step is outside the LLM, the same way you hand Rust code to the Rust compiler. The transition table is data, not spaghetti control flow buried in service methods. Agents can change it dynamically, with safety, and hot-reload it without going through CI,” he explains.

## Where this is going

The idea behind Temper is that each artifact should be small enough to fit in your head. High-assurance software like aviation and financial systems has been built this way for decades, but the cost of achieving that rigor with humans was too high for general software until agents entered the picture.

The industrial revolution became possible because machine tools made parts composable, inspectable, and replaceable, so we could build ever-larger and more complex machines. 

“If agents can build software autonomously inside factories with this kind of discipline, maybe we don't need to stop at dark factories. Software built this way starts to feel like an organism we can grow, cultivate, and evolve through feedback, selection, and adaptation,” says Sesh.

          Best practices from the Datadog team

          Is your real bottleneck generation or verification?
          Assume verification. Agents already produce code faster than any team can review; the gap between what's generated and what's proven is where the failure modes pile up. Invest there, not in more throughput.

          What should the agent actually emit?
          Specs for control logic (not code), and proof carrying for arbitrary code. Put compilation and proof outside the LLM — hand the spec to a deterministic kernel so the artifact that gets verified is the artifact that runs.

          Is your control logic explicit, or scattered across the codebase?
          Pull the state machine out of routes, service methods, and background jobs and make it data: a transition table an agent can read, modify, and hot-reload under policy.

          Can a human hold each artifact in their head to comprehend?
          If not, you're back where you started. Keep every generated piece small enough to reason about.

Watch the full session for a live demo and deeper discussion of how Datadog built Temper, a constrained framework that turns one-off agent tools into secure, reusable components that compound across sessions and teams.

‍

FAQ

No items found.

## Related posts

Explore more product news and best practices for teams building with Claude.

Jul 21, 2026

### How Anthropic secures its AI-native software development lifecycle

Claude Code

How Anthropic secures its AI-native software development lifecycleHow Anthropic secures its AI-native software development lifecycle

How Anthropic secures its AI-native software development lifecycleHow Anthropic secures its AI-native software development lifecycle

Jul 16, 2026

### How Anthropic runs large-scale code migrations with Claude Code

Claude Code

How Anthropic runs large-scale code migrations with Claude CodeHow Anthropic runs large-scale code migrations with Claude Code

How Anthropic runs large-scale code migrations with Claude CodeHow Anthropic runs large-scale code migrations with Claude Code

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
