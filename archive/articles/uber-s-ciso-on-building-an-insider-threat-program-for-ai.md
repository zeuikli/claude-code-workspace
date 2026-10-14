---
title: "Uber&#x27;s CISO on building an insider threat program for AI"
url: https://claude.com/resources/articles/uber-s-ciso-on-building-an-insider-threat-program-for-ai
slug: uber-s-ciso-on-building-an-insider-threat-program-for-ai
fetched: 2026-10-14 05:46 UTC
---

# Uber&#x27;s CISO on building an insider threat program for AI

> Source: https://claude.com/resources/articles/uber-s-ciso-on-building-an-insider-threat-program-for-ai

> The importance of monitoring and observability for AI agents, and how Uber&#x27;s open-source tooling works alongside Anthropic&#x27;s Enterprise Frontier Safeguards.


# Uber's CISO on building an insider threat program for AI

Uber's CISO, Philip Martin, on the importance of monitoring and observability for AI agents, and how Uber's open-source tooling works alongside Enterprise Frontier Safeguards.

-

CategoryPerspectives

-

DateOctober 13, 2026

-

Reading time7 min

-

ShareCopy link

Uber runs one of the world's largest real-time marketplaces, with over 40 million trips and delivery orders a day. Philip Martin, Uber's Chief Information Security Officer (CISO), leads the team that protects Uber's data and the riders, drivers, and couriers who use the platform in the real world. His team started working with Claude on threat modeling before Claude Code existed, assembling context by hand. Now, with Claude Fable, Claude gathers that context itself from code, design docs, and ticket history.

Martin thinks AI agents need the same kind of insider threat program companies already run for their employees. We spoke with him about that idea, why he thinks so much about accidental misuse, and how Uber's open-source monitoring tools work alongside Enterprise Frontier Safeguards.

How are frontier models changing your security team’s work?

The really big difference between prior models and today’s frontier models is their ability to incorporate additional context over long time horizons, and as a result, generate really specific outputs. When we're doing security reviews or threat modeling for a given service application, we can let the models consume a lot more context about the service, whether that's the code itself, design documents, issues in Jira, or historical context on what the service is supposed to do and what it interacts with.

I see the same thing emerging with teams of agents. I can imagine a world in the not-too-distant future where each service has an agent associated with it that understands that service very well, and those agents can talk to each other, the same way the services might in production, about the threat model: this is my threat model, this is where my data comes from. That team-of-agents effect will take us to the next level of efficacy.

Uber worked with our team Enterprise Frontier Safeguards. Why was this important for Uber?

One thing Anthropic and Uber have in common is a bone-deep focus on safety, albeit in very different contexts. When Uber thinks about safety, we think about rider safety, protecting personal data. Anthropic wants to prevent the misuse of its frontier models, but Uber needs to protect our customer data, our trade secrets, and any other proprietary information. Enterprise Frontier Safeguards allow us to strike this balance: the safeguards are in place, but our data is not accessible to Anthropic without our permission.

It gives us control of our data and control of the risk mitigation and the actions we decide to take after a safeguard is triggered. I think we share a responsibility to make sure these models are used safely and effectively in the world.

When your team walked us through the design, it was clear that you heard our feedback. You put us in the driver's seat. This allows us to protect our data while still being responsible stewards of the capabilities of these models.

How Enterprise Frontier Safeguards fit with the safety monitoring you already run on AI deployments Uber?

We've done a ton of work since the very beginning on how we deploy AI safely within Uber. We recently open-sourced a product called AI Detection and Response (ADR) (opens in new tab), designed to gather real-time telemetry and take real-time action in the agent harnesses we deploy.

It complements Anthropic's safeguards, because we now have access to enhanced data to detect when an agent is acting outside its bounds and respond in real time. We have our own view of what's going on, plus output from Anthropic's classifier, and we can integrate both into our overall detection environment, much like a traditional cybersecurity one. It's all about assembling context effectively to reach a decision as fast, and with as much certainty, as possible.

I think we'll see Enterprise Frontier Safeguards feed into ADR as a data source. Together with our LLM gateway, which builds a perimeter and controls how AI is used within Uber, those make up our overall AI security architecture.

Where do you think defenders should prioritize their focus next when it comes to securing AI systems?

Number one is real-time detection and intervention: getting as close as we can to the human entering a prompt in a harness, to be able to tell them, "You probably don't want to do that," or "The tool this model is about to call, the place it's about to connect to, is probably not something you want to happen."

Number two is better understanding emerging patterns. We look at trends in model behavior and detect new behaviors we didn't know were possible. That becomes a cycle. We look at the data, in many cases with the assistance of LLMs, discover these behaviors as they appear, and build safeguards against them back into the real-time platform. Then new behaviors emerge, because constraints create new behaviors, and we find those too.

What would you tell other leaders who are hesitant about the monitoring frontier models require?

AI adoption is a business imperative. It's coming whether we want it or not, and it's going to bring real benefits to businesses and people around the world. But there's also real potential for harm, and the stakes rise as models get more capable and take on more complex, autonomous work.

Every company already runs an insider threat program for its people. Nobody argues about that. We accept the sometimes onerous data retention, and we monitor things we'd rather not monitor, because we know humans occasionally act outside the bounds of their role, for any number of reasons.

Frontier models introduce the same risk. These models may be directed to act outside the constraints we expect them to operate within. So we need the equivalent capability for AI. That insider threat program for models is going to be essential to rolling these systems out safely and securely.

Learn more about Enterprise Frontier Safeguards (opens in new tab).

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleOct 8, 2026

### How Block orchestrates Claude Fable across thousands of pull requests

Bradley Axen, Head of AI Capabilities at Block, on how his team evaluates new large language models, how Claude Fable 5 orchestrates company-wide code migrations, and why safeguards are a critical part of deploying frontier intelligence responsibly, at scale.

Claude Enterprise

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
