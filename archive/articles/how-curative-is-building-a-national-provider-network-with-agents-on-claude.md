---
title: "How Curative is building a national provider network with agents on Claude"
url: https://claude.com/resources/articles/how-curative-is-building-a-national-provider-network-with-agents-on-claude
slug: how-curative-is-building-a-national-provider-network-with-agents-on-claude
fetched: 2026-11-11 07:28 UTC
---

# How Curative is building a national provider network with agents on Claude

> Source: https://claude.com/resources/articles/how-curative-is-building-a-national-provider-network-with-agents-on-claude

> How Curative built a hierarchy of agents on Claude to sign provider contracts about 50 times faster than its team did in 2025.


# How Curative is building a national provider network with agents on Claude

Curative’s deal-making agent negotiates 2,000+ provider contracts a week.

-

CategoryBest practices

-

ProductClaude Platform, Claude Code

-

AuthorsCamy Pearson, Michael Segner

-

DateNovember 10, 2026

-

Reading time10 min

-

ShareCopy link

In our series, How startups build with Claude, we highlight how startups are transforming their industries with AI. In this article, we share how Curative built a hierarchy of agents on Claude to sign provider contracts about 50 times faster than its team did in 2025.

The quick pitch

NameCurative

Founded2020; launched its health plan in 2022

FoundersFred Turner (CEO), Isaac Turner (CTO), Tami Wilson-Ciranna (President)

StackClaude Platform, Claude Code, bespoke claims system

Growth$150M Series B at a $1.275B valuation. 165,000+ members and 1,200+ employers (Dec 2025). 23,000 provider contracts signed with Gwen. 2,000 to 2,400 new contracts a week, up from 2,100 in all of 2025.

Curative sells health insurance to employers, with $0 copays and $0 deductibles for in-network care once members complete a Baseline Visit. Curative didn’t start out in insurance. It started as a lab startup and ended up processing 10% of all US COVID-19 tests according to their internal estimates. As a result, they started working with nearly every insurer in the country.

Its British founders, used to a system where patients don’t pay for care, saw inefficiencies and set out to build a payer focused on prevention. They realized they had significantly underestimated how hard building a national network would be.

“Sometimes naivety is good in startups, because you don’t know that it’s impossible. And then along the way you figure out a way to make it not impossible,” said Curative CEO Fred Turner. “Last year we signed 2,100 contracts, twice as many as we did the year before, but at 2,000 a year, we realized it would still be a 30-year build. There is a reason there are only a handful of national networks and they were all built about 30 years ago.”

Curative needed to accelerate contract signings, but hiring alone couldn’t close a gap that size.

Their solution: Gwen, an agent that works one provider deal from initial outreach to signature, surrounded by smaller agents that review its rates, check its messages, answer its questions, and escalate to humans for non-standard pricing.

Here is how they built it and what broke along the way.

## Gwen: the provider contracts agent

Gwen works both inbound and outbound leads. Each run of Gwen handles a single provider, mostly on Claude Opus, so nothing from other deals influences it.

For example, if a practice fills in the form on Curative’s website, Gwen will research the practice and reply with proposed rates based on a purchased claims data set and price-transparency files payers are now required to publish. Gwen will show providers these market rate data to help with negotiations.

The rate reviewer runs on Sonnet. When Gwen wants to exceed its standard rate template, it writes out why, and the reviewer decides whether the rate makes sense.

“For a long time there was a big approval queue where Gwen had to get rates approved if she wanted to go a certain amount above the template, but we relaxed over time. Having a second agent review rates worked better than just giving Gwen more authority,” said Fred.

The Sonnet rate reviewer clears about two-thirds of Gwen’s requests and then anything non-standard goes to Fred for approval.

“The requests I see are from a big medical group or someone with a weird request that would come to me even if this wasn’t an agent-led motion,” said Fred.

Outbound deals take more persistence, because practices are busy. Some providers’ replies come after the fourteenth email and the ninth fax.

Image used with permission from Curative.

A judge, which runs on Haiku, reads every communication before it’s sent. Curative added it after Gwen copied providers on internal notes about how high it could go. A blocked message comes back with the reason, so Gwen can rewrite it and try again.

Each contract takes about 20 million tokens to complete, roughly a tenth of the original cost. These efficiencies enable one of Curative’s core strategies: signing smaller providers that have often been overlooked by larger networks.

“The agent will happily give you the same level of attention whether you are a large hospital system or if you’re a solo provider,” Fred explained. “From that agent’s perspective, this provider is its only focus.”

During negotiations, Gwen checks practice redlines against Curative’s policy document, then writes Python to merge both sides’ changes into a final document.

From form to signature, the process can be as quick as an hour. Once the contract is signed, a separate credentialing agent checks the provider’s licenses, and agents load the provider’s data and contract so claims can price against it.

Curative’s contracting team has grown from 45 to about 55 people since Gwen launched, each about 2.5 times as productive. They hand Gwen cold outreach and paperwork and take over warm leads by phone. Curative pays its contracting team on Gwen’s deals too, so people and agents share one target.

“People’s work becomes more about the relationship and less about paperwork,” said Fred.

Fred also believes faster contracting helps small practices stay independent. “If you start a medical practice and it takes three months to get in network and credentialed, you’re just not getting paid for three months,” he said.

Gwen is not Curative’s only agent. Brad, another Opus-based agent, helps sell Curative’s plan to employers, mainly through brokers. Brad follows up with brokers on each quote and helps underwriters move faster by pulling employee data out of the spreadsheets underwriters used to scrub by hand.

Using human-agent teams, Curative can now answer emailed or faxed claims disputes in under 30 minutes, with a letter specific to that claim. “Claims dispute responses used to take about 90 days and now take under 30 minutes by email or fax,” said Fred. “Most payers use a set of templates that are mail-merged together. That leaves a provider deeply unsatisfied, because usually the template doesn’t actually explain what’s going on. Now providers get a customized letter that explains the specifics of the individual claim, what’s happening, and why.”

All of their agents sit on bespoke claims, prior authorization, and finance systems that 13 engineers rebuilt this year with Claude Code. The team had once sized building a claims system alone at 100 engineer-years.

“We’re not trying to plug [these agents] into a claim system,” Fred said. “The claim system is Python running in AWS, and it has an MCP and it has an API, and Claude wrote it, so it understands it.”

## What Curative learned from building agents that negotiate with people

Here’s what the Curative team learned about how to build agents that negotiate with people.

- Start with one general tool. “We started off with, ‘Oh, we’ll have tools,’ and that doesn’t work that well, because redlining is quite complex,” Fred said. “What we found works best is that the model just has one tool, which is run Python, and it does all the redlining with a docx library. It works beautifully.”
- Meet people on their channel. A fax tool more than doubled Gwen’s win rate. Many providers now handwrite on a printed fax and fax it back. “It’s meeting people where they are,” said Curative CTO Isaac Turner. “Yes, they have email, but really they’re comfortable in fax.”
- Keep each run isolated. One Gwen run sees one provider and keeps no memory across deals. Brad, Curative’s sales agent, does keep memories, which works but needs care. “You can end up making notes that are wrong and then get into these doom loops, where it has a bad memory that can never be cleared,” Fred noted.
- Improve the system from outside the run. Every few days, Fred gives Claude Code the same prompt: sample the last 10,000 runs, flag anything weird, and open a PR to fix it. “The improvement loops come from running Claude Code over lots of historic conversations and asking how could this have gotten better,” he said.
- Experiment away from PHI first. For a long time Gwen was barred from protected health information (PHI), so early mistakes were in lower-risk settings. Where agents touch PHI now, back-end controls limit what enters a conversation, and agent activity is logged for audit. “We learned how to do it there and then transferred it over into PHI land,” said Fred. Signing Business Associate Agreements (BAAs), the contracts HIPAA requires before a vendor can handle PHI, has gotten easier too. “Anthropic especially has been very good about getting HIPAA-compliant versions of the latest services out very quickly,” said Isaac. “We’ve been able to onboard these new technologies very quickly despite it being regulated.”
- Watch what the agent starts doing on its own and make sure it matches your risk profile. When providers asked for a flyer to share internally, Gwen made one with its Python tool, with no policy telling it to. When a front desk turned away a member at an in-network practice, Gwen asked the office to train its staff, then checked that the member got in.

## Where Curative is going next

Next, Curative plans to bring agents to care navigation, extending the reach of the 130 people who guide and coach its members.

Fred expects agents on the provider side too. A large share of claims disputes already appear to be written by agents, and he hopes providers will use agents to negotiate contracts. “There’s a clearing price, and the faster you find the clearing price, everybody can get on with providing care,” he said.

Best practices from the Curative team

How much authority should an agent start with?Less than you think it can handle. Gwen began with a human approval queue for any rate above the template. Curative loosened the limits in steps and for more deterministic decisions, then added the rate reviewer, with Fred still approving what it doesn’t clear.

What happens when the agent gets it wrong?Plan for it, and compare it with the alternative. “The bar isn’t perfect,” Isaac said. “The bar is, if you had a thousand people signing contracts, how many mistakes would they make that you regret?”

How do you audit hundreds of thousands of messages?Log everything, put a judge agent on every outbound message, and have Claude Code sample the runs.

Start building with the Claude Platform today.

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleNov 9, 2026

### Safely scaling multi-agent teams with Claude Fable 5.2

How a team of 1,000 agents running an early version of Claude Fable 5.2 reproduced a formal proof of Fermat's Last Theorem with general tools, a shared database, and layered safety controls.

(opens in new tab)

ArticleNov 9, 2026

### Which Claude model should you build with?

How to choose between Claude Fable 5.2, Opus 5.5, Sonnet 5.5, and Haiku 5.5 by task, cost, and effort level.

Claude PlatformClaude Code

(opens in new tab)

ArticleOct 27, 2026

### Manage costs and demonstrate ROI for Claude Code on Google Cloud

Best practices for managing costs and measuring return on investment for Claude Code on Google Cloud.

Claude Code

ArticleOct 22, 2026

### Building agents: When to fold subagents into your main agent loop

When building agents in Claude Platform, using fewer subagents in favor of progressively disclosed context and tools can improve quality while reducing cost and latency. Here’s when and how to migrate.

Claude Platform
