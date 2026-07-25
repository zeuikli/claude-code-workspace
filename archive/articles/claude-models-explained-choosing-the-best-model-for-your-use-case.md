---
title: "Claude models explained: choosing the best model for your use case | Claude by Anthropic"
url: https://claude.com/blog/claude-models-explained-choosing-the-best-model-for-your-use-case
slug: claude-models-explained-choosing-the-best-model-for-your-use-case
fetched: 2026-07-25 04:06 UTC
---

# Claude models explained: choosing the best model for your use case | Claude by Anthropic

> Source: https://claude.com/blog/claude-models-explained-choosing-the-best-model-for-your-use-case




# Claude models explained: choosing the best model for your use case

- Category

Enterprise AI

Agents

Claude Code

- Product

Claude Code

Claude Cowork

Claude Design

Claude Enterprise

Claude Platform

- Date

July 24, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/claude-models-explained-choosing-the-best-model-for-your-use-case

## Our advice: start smart

One of the most frequent questions we hear is “what model should I choose for this workload?” As we have released more model classes and versions, the answer has become more nuanced.

This article covers those details including a description of each model class, the top questions to ask when selecting a model, and other best practices.

But to put aside the nuance for a moment, our default recommendation is to start with the most intelligent generally available model and use effort level to dial in performance and cost. 

Cost-per-task is often lower for more intelligent models, especially at lower effort levels, even if the price-per-token is higher. This is because more capable models often take fewer turns and less thinking time to get most tasks right. Starting with a smaller model can also make it harder to distinguish between model failures and setup failures. 

Of course, as use cases arise that are more latency or cost-sensitive, you can test lower tier models until you find your ideal fit. 

Some organizations may also choose to start with the most cost effective model and move up classes until the quality bar is met. We include both directional approaches in our documentation on model selection.

## The Claude model family

### Mythos / Fable

Mythos is Anthropic’s most capable model class, with frontier capabilities across domains. This model class is especially capable at coding, long-running agent tasks, and solving problems AI has not reliably handled before. 

The Mythos class ships in two packages of the same underlying model. Claude Mythos is for trusted organizations handling dual-use cybersecurity and biology work while Claude Fable is packaged with additional safeguards that make the model safe for use by the general public. Both require limited data retention so they can be used safely.

### Opus

Opus is our powerful model class for reasoning-intensive enterprise tasks. Opus models consistently rank among leading models on key industry benchmarks such as GDPval-AA for knowledge work and Terminal-Bench 2.1 for agentic coding.

The choice between Opus and Fable may not seem clear on the surface, as both excel at coding, long-running agents, and knowledge work. In real-world situations, larger models such as Fable tend to have more wisdom, creativity, and writing skills despite having similar benchmark scores to models such as Opus.

The general rule of thumb is if your evals or internal testing show Opus struggling on some tasks, then Fable is the answer. If Opus already clears the quality bar, then its speed and price profile may make it the better choice.

### Sonnet

Sonnet is our versatile model class for everyday tasks. Sonnet provides a balance of performance, cost, and speed for the widest set of general purpose use cases, including high-volume sub-agents in multi-agent orchestration setups. 

### Haiku

Haiku is our lowest cost and fastest model class. Haiku models are designed for high-frequency workloads where latency and cost matter.

## How to choose which Claude model is best for your workload

Our model classes don’t specialize in one type of work. We don’t recommend one model class for finance and another for science. Every Claude model is trained to excel in areas like coding, agentic tasks, and knowledge work. 

The main difference across model classes is in how hard a problem they can reliably carry, and what that capability costs in price and speed. When choosing a model, ask:

How hard is this task? If it typically takes a lot of time, involves multiple steps, or is previously unsolved then a more capable model class is appropriate.

What are the latency needs? If the model is involved in high-frequency customer facing workloads, then Sonnet is often the best choice. 

What are the access constraints? Mythos is only available to organizations under Project Glasswing. Not all organizations make all model classes available to all roles. 

What are the unit economics? Higher volumes of production may be more appropriate for lower classes of models, particularly if evaluations show those tasks are completed satisfactorily. Models are priced differently per token and will have different price-per-task costs based on their capabilities and effort level.

Effort level also impacts the balance of quality, speed, and cost. Higher-class models at higher efforts offer the best possible performance, and higher-class models at lower efforts can sometimes be more efficient than smaller models. 

Curves are illustrative and not plotted from benchmark data.

Curves are illustrative and not plotted from benchmark data.

To learn more read Choosing a Claude model and effort level in Claude Code.

## Combining models’ strengths with the advisor strategy

The advisor strategy allows faster, lower-cost worker models to call more intelligent models to check their plan and evaluate their work, leading to improved performance.

This method, where the executor model is coached only when needed, improves performance by a substantial amount. For example, on SWE-bench Pro Sonnet 5 with a Fable 5 advisor is within 10% of Fable 5’s score at 63% of the price of using Fable 5 for the whole task.

## How evals and benchmarks help with model choice

Two common ways to see if model capabilities are sufficient for your needs are to use standard benchmarks and custom evaluations. 

Benchmarks are a set of pre-determined tasks or scenarios, often for a specific domain, with known solutions. These can be helpful directional guides for evaluating capabilities across model classes and providers. The challenge arises when evaluating powerful models, such as Opus and Fable, which can solve almost all of the questions on the test (often referred to as saturation).

In these cases, we recommend organizations use the models on real workloads or test them with their own evaluations to make a decision on which model is the right choice. Typically, evaluations are a curated set of problems drawn from production — including difficult tasks where your current tools fall short, with success criteria your team defines.

This is where the capability and creativity of frontier models start to separate from the pack and from one another. We’ve written extensively on the best practices for developing custom agent evaluations.

## Making the smart choice

There is no one-size-fits-all approach to AI model selection, which is why we make multiple model classes available. Ultimately, the best way to select a model is to understand the basics of each model class and understand your use case in-depth. That means building, maintaining, and deploying strong evaluations.

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

Jul 24, 2026

### How the product designer who built Claude Design uses it to explore ideas before building them

Enterprise AI

How the product designer who built Claude Design uses it to explore ideas before building themHow the product designer who built Claude Design uses it to explore ideas before building them

How the product designer who built Claude Design uses it to explore ideas before building themHow the product designer who built Claude Design uses it to explore ideas before building them

Jul 24, 2026

### The new rules of context engineering for Claude 5 generation models

Claude Code

The new rules of context engineering for Claude 5 generation models The new rules of context engineering for Claude 5 generation models

The new rules of context engineering for Claude 5 generation models The new rules of context engineering for Claude 5 generation models

Jul 23, 2026

### Four role-based certifications for the people who put Claude to work for customers

Enterprise AI

Four role-based certifications for the people who put Claude to work for customersFour role-based certifications for the people who put Claude to work for customers

Four role-based certifications for the people who put Claude to work for customersFour role-based certifications for the people who put Claude to work for customers

Jul 22, 2026

### Building verification loops in Claude Code with skills

Claude Code

Building verification loops in Claude Code with skillsBuilding verification loops in Claude Code with skills

Building verification loops in Claude Code with skillsBuilding verification loops in Claude Code with skills

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
