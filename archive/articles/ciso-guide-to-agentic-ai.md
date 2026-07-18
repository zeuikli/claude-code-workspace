---
title: "CISO&#x27;s guide to agentic AI | Claude by Anthropic"
url: https://claude.com/blog/ciso-guide-to-agentic-ai
slug: ciso-guide-to-agentic-ai
fetched: 2026-07-18 03:52 UTC
---

# CISO&#x27;s guide to agentic AI | Claude by Anthropic

> Source: https://claude.com/blog/ciso-guide-to-agentic-ai




# Zero risk isn't the job: a CISO's guide to agentic AI

Anthropic's Deputy CISO, Jason Clinton, shares his team's lessons learned adopting agentic AI, and the risk assessment framework they've developed for building and deploying agents securely.

- Category

Enterprise AI

- Product

No items found.

- Date

July 17, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/ciso-guide-to-agentic-ai

Security leaders are being asked to approve agentic AI use cases that did not even exist a few months ago. Boards want to know whether any of it is governed, and somewhere in your organization, an employee has already connected an agent to something without telling you.

Saying “no” to these requests produces shadow adoption, which has zero telemetry and generally no off switch. Saying “yes” without controls produces incidents, and the first serious agent incident at your company will set your AI program back. 

A CISO’s responsibility in the age of agentic AI is not to achieve zero risk. Instead, our jobs are to make agentic risk legible and bounded. This way, we can deliberately accept what we can manage, so the business moves on our terms instead of around us. 

In this article, I share our framework for evaluating agents for security risk, explain what “bounded” means in practice, and preview where our work is headed.

## External risk from AI versus internal risk in the post-Mythos era

In an earlier blog post, my colleagues and I shared how AI is collapsing the time between a vulnerability existing and a working exploit, highlighting how organizations can mitigate these risks. In the coming months, we expect that vast numbers of bugs that have sat unnoticed in code, sometimes for years, will be found by AI models and chained into working exploits. Frontier models like Claude Mythos Preview and Claude Mythos 5 are already finding serious vulnerabilities that years of human review missed, including in OpenBSD, the Linux Kernel and Mozilla Firefox.

These are serious risks to any GRC program. Mitigating and closing vulnerability gaps, as well as for preparing for the coming wave of exploits, should be a top priority. For this topic, we have prepared a separate doc: Preparing your security program for AI-accelerated offense. We’ll focus on internal risks for this guide.

## Governing internal risks

For many organizations, the most likely threat vector for agentic systems is a data leak enabled by connecting disparate systems through personal agents with insufficient oversight. Another concern is prompt injection: an attacker hides instructions inside content the agent reads, and the agent follows the attacker instead of the user. Any agent that touches untrusted content could then be exposed, depending on how robust the defenses of the model are. As models grow increasingly capable, they’re getting meaningfully better at resisting injection. While attack success rates keep falling, they’re not zero. There are many concerns outside of these two examples, and the deluge of new classes of concern can seem overwhelming.

### Four questions to ask 

When an agentic use case reaches our review process, we assess its risk by asking four questions: 

- What untrusted content does it ingest? Untrusted means anything an attacker could plausibly write or alter, including outside email, the open web, third-party documents, or public repositories. If the answer is "nothing," the agent-specific risk is near zero and you should move quickly.
- What actions can it take, and on whose behalf? Read-only is a different concern from read/write. Tool calls, code execution, and network egress each widen the aperture. Every action happens under some identity, and you need to know whose.
- What is the blast radius if it is misaligned? Scope X severity is the quick calculation: did the bad actor or alignment incident have access to one file or the whole org? Would it be an anomaly, an annoyance, a data exposure, or a true incident?
- What observability do I have? Can you tell agent actions from user actions? Does it land in your SIEM?

The four answers to these questions give you a picture of your risk, but the principle of least agency tells you what to do with it: grant the narrowest capability that still completes the task (see our Zero Trust for AI Agents white paper to learn more). Our default posture at Anthropic is admin-paced rollout: enable a small group, watch the telemetry, and then expand access. Apply these questions to a new paradigm for thinking about risky agentic systems.

An agent that drifts out of alignment with your intent is indistinguishable from an insider attack. The security industry spent 2019-2022 formalizing insider risk as a discipline distinct from perimeter defense—recognizing that the most dangerous external attack vectoractor in a system is often one that compromises someone who already has legitimate access.

The operational difference is response time: Ponemon Institute's 2026 Cost of Insider Risks report found organizations took an average of 67 days to contain an insider incident—even after years of investment in dedicated insider risk programs. At agent execution speeds, responses measured in days are too long.

## The agentic identity spectrum

Everything we deploy sits at one of two ends of an identity access model spectrum. 

At one end is the system service account: a self-contained, single-purpose, least-privilege identity that does exactly one thing for the business, with no human identity attached. The incident-response agent (see below), a ticket triage agent, or an autonomous code reviewer are examples of these. Another example is Claude Tag, our new shared workspace agent that lets human teams collaborate with agents in shared workspaces like Slack by tagging in Claude. 

At the other end is the human credential. When an employee uses a chat interface or a personal agent harness like Claude Cowork on their laptop, the person at the keyboard is accountable for the outcome, the same way they are accountable for anything else done with their credentials.

The middle of the spectrum, where an agent carries a person's delegated identity into systems that person is not watching, is where accountability gets ambiguous. Ambiguous accountability is how incidents become unexplainable. 

An agent that drifts out of alignment with your intent is indistinguishable from an insider attack. The security industry spent 2019-2022 formalizing insider risk as a discipline distinct from perimeter defense—recognizing that the most dangerous external attack vector in a system is often one that compromises someone who already has legitimate access.

Ponemon Institute's 2026 Cost of Insider Risks report found organizations took an average of 67 days to contain an insider incident—even after years of investment in dedicated insider risk programs. At agent execution speeds, 67 days is the wrong unit of measurement entirely.

## Case study: an incident response agent

More than a year ago, we pointed Claude at our incident response process. Anyone who has been on-call for a production application knows the problem: you’re paged at 2 a.m. about a security incident, you spin up an incident response channel, you pull in the right people, and get to work. This process is tedious, documentation-heavy, and fast-moving. But, with the right context about your production environment codebase, the majority of it can be automated. 

So we built an agent to do it. We gave the agent access to three tools: read-only access to our production logs, which contain no PII; access to Slack, to open the incident channel and run the process; and the ability to draft a Google Doc for the postmortem after the incident is resolved. 

We ran it through the four questions: 

- Untrusted content: none. The inputs were our own logs and our own internal Slack, both inside the trust boundary, so an injection would require an insider or a compromised account rather than an anonymous attacker.
- Actions: reads everywhere, writes limited to new documents and Slack messages. No edits or deletes, no permission changes, no external endpoints.
- Blast radius: the worst outcome we could construct was some mildly sensitive log lines posted into an incident channel that was already locked down.
- Observability: every action landed in our SIEM, so anything unexpected would surface in minutes, not weeks.

While the agent wasn’t risk-free, it operated on a bounded write surface with full audit coverage, which was a risk profile we were comfortable with. 

However, there’s an interesting addendum to this story: with each model release, the agent got smarter. In November 2025, we moved this agent from Claude Opus 4 to Claude Opus 4.5 and changed nothing else—no new tools, permissions, or prompts. Immediately after this, for the first time, the intelligence uplift alone was enough for the agent to notice, mid-incident, that it had already found the root cause in a stack trace and that, in the absence of the human who hadn't arrived yet, it could try to fix production on its own by reaching out to another agent that had the appropriate code access to produce the code change. 

Post hoc, we reviewed logs: we watched it work through this in the thinking traces: I have done what I was asked to do. The human is not here. What if I fixed the problem? Inside of Anthropic we have an internal variant of Claude Tag-like technology which can write code changes and upload them for human review. On its own, it reached out over Slack to this Claude Tag-like instance and asked it to write the fix. The fix went to a pull request that a human reviewed before pushing it to production. 

The expanded blast radius that came from this emergent agent-to-agent communication was itself governed by our principles: the worst that could happen would be that a code change would be uploaded which contained a production log line. This agent-to-agent communication is now a regular part of our incidence response root cause and remediation practices; all with human-on-the-loop monitoring.

This emergent behavior taught us two things. First: new capabilities can show up within the boundaries of an agent deployment. It’s important to limit access and actions, not around what you believed today's model limits are. Second: controls are effective even with stochastic agents like this. The new behavior was human-on-the-loop because it happened in a Slack channel, and the only write-like action still required a human review. 

Today, outside of incidence response, agent-to-agent communication within chat channels, with human on-the-loop where people work, is the norm.

## Case study: Claude Cowork

The incident response agent is a service account doing one job, in a bounded service account. Claude Cowork is at the human operator end of the spectrum: an employee at a keyboard is accountable for the outcome, and the agent then acts on their behalf, in systems they authorized—increasingly—running in the cloud. 

Claude Cowork's threat model is straightforward, because the agent is essentially Claude Code running either locally or inside a hosted interface. The desktop app remains required for local file access, browser use, and computer use; those capabilities reach the local machine directly and need the app to do so. The full system surface is therefore two-part: a (possibly remote) execution environment handling orchestration, MCP calls, and outbound network requests, and a local bridge for file and screen access.

The four questions outlined above produce different answers for every Claude Cowork use case. But with the right controls in place, you can bound them to better control any possible risk. 

Each control below is stated twice, first as the requirement any agent environment should be able to meet and then as how it is enforced in Claude Cowork:

Identity comes from your IdP: an agent's identity has to be issued and revoked where you already issue and revoke everything else, with your existing groups as the unit of policy. Claude Cowork uses SAML or OIDC for sign-in and SCIM for provisioning. On Enterprise plans, custom roles let you scope capability by group.

Connector allowlists draw your data boundary: allowslists for connectors (MCPs) let you decide which systems the agent can reach. Claude Cowork uses a two-gate model: an admin enables each connector org-wide, and each user then individually authorizes their own account. There is a per-role connector control, so enabling a connector makes it available to everyone in that role (groups from your IdP can be assigned to roles). The admin decision about which connectors to turn on is also the decision about which data the agent can reach. Keep connectors on the corporate side of your corporate/production data boundary or, if they access information from untrusted sources, ensure that human review is required for any destructive or one-way decision. For example, if a personal agent is being used for email but using web search results as a part of its input, an excellent default is to only allow draft emails to be created and never sent externally, automatically, without human review. If data must cross the boundary, it should go through the DLP or DSPM controls.

Per-tool, per-action approval is where risk reduction gets granular: the agent's tool list is a more fine-grained permission boundary, so you need to be able to remove any particular connector’s verbs/actions and not only that entire connector system. In Claude Enterprise Chat and Cowork, admins can now restrict which actions are available within each connector org-wide and per-role: allow drafting docs but never automatically send them, allow reads and searches but never deletes. If the failure mode that keeps you up at night is "the production database gets deleted," remove the delete verb from the agent's world entirely. It will never attempt an action that isn't in its tool list. (A note on this: Claude for Chrome and Claude Code enable more degrees of freedom and so are more risky, if not governed well. An agent could use an engineer’s browser to delete a production resource or their command line CSP tool to do the same. See our guide to securing Claude Code for more.)

Sandboxed execution keeps the agent's working environment away from production credentials: one principle that we hold constant at Anthropic is that the environment the agent loop runs in should never hold a credential worth stealing. In Claude Cowork's remote sessions, the agent loop runs in an isolated, temporary sandbox on Anthropic-managed infrastructure. Connector authorization tokens never enter the sandbox, because connector calls are made via a reverse proxy that injects real credentials, so the sandbox never holds a credential that can be exfiltrated. As of July 2026, more than 50% of all code submitted for pull requests at Anthropic is authored by our internal version of a Claude Tag-like system. The primary reasons we can run that safely are that all of it happens in ephemeral VMs separated from our production keys and accounts, with a human review before anything lands.

Egress allowlisting is your strongest control against prompt injection: all traffic leaving the agent's execution environment should pass through a proxy that environment cannot reconfigure or bypass, and only destinations you chose should be reachable. The reasoning is that, if an agent is compromised by something it read, then the attacker still has to get data out, and when outbound requests can only reach domains you chose, there is nowhere attacker-controlled to send anything. In Claude Cowork's remote sessions, all traffic leaving the sandbox passes through a mandatory proxy the sandbox cannot reconfigure or bypass, and only allowlisted destinations are reachable. The feature is also a part of Claude Managed Agents.

Telemetry goes to your SIEM over OpenTelemetry: agent actions have to be distinguishable from user actions in the system where you already investigate things, and the vendor should deliver that as a stream you can point somewhere, not a dashboard you have to visit. In Claude Cowork, admins can configure an OTLP endpoint in Organization settings and the agent streams every tool invocation—tool name, MCP server, parameters, success or failure, and duration—alongside user identity and session context. Note: Claude Cowork activity is not currently captured in Anthropic's Compliance API or formal audit logs, but we know that this is an important customer need. The OpenTelemetry stream is the native monitoring path, and prompt content is included in Claude Cowork's OTel output by default, unlike Claude Code where it is opt-in. If your retention or privacy review has an opinion about prompt content in your SIEM, have it before you turn the stream on.

There is an org-wide off switch: In Claude Cowork's Organization settings, a single toggle disables connectors for every user simultaneously, active sessions included. On Enterprise plans, the same control surface lets you go narrower before you go to zero: RBAC lets you pull access from specific groups while leaving others running, and per-connector controls let you disable write operations on a specific integration without touching the rest of the deployment. The right incident response plan has all three layers mapped out before you need them.

## Governance doesn’t have to be a bottleneck

The observation I hear most from other CISOs is that they are being asked to move fast by their boards and governance (i.e., answering these questions and mandating these controls) makes security seem like the bottleneck. It doesn't have to. 

In fact, our Governance, Risk, and Compliance teams run agents of their own. Examples include security-questionnaire responses and reading vendor questionnaire responses and subprocessor-change notifications, and flagging the ones we should object to.

Here are three things we've learned from running them:

- Take the risk register first. A register reviewed quarterly can't govern systems that change faster than the risk governance process can document new risks. Find a way to automate this, possibly integrating an agent with the security review process. 
- Understand who built them and why. In our case, non-engineers built the GRC agents, with Claude Code, on an internal platform for hosting business apps. People route around security because the sanctioned path is slow, and that's the origin of most shadow adoption. A compliance analyst who can build the tool they need, where you can see it, isn't shadow adoption.
- Human accountability is part of the workflow. Deliberately accepting risk is an act performed by humans with the authority to accept it. If you have ISO 42001 or something like it, with a live risk register and an executive risk council behind it, the output lands somewhere: re-scores reach the people who can accept them, flagged vendor terms reach the people who negotiate them. If you already have ISO 27001, often adding 42001 is an incremental addition with your current auditor.

## Design your security protocol for evolving model intelligence

If you design your new program for what the model can do today, you will be behind by the time your program launches. Design for where the model will be in six months. Increased model intelligence enables more degrees of freedom and obsoletes elaborate scaffolds with meticulous prompts; if you lean on these for controls, they will be cut out of agents in future generations of internal applications leaving you without a control point.  

Agents that hold their own accounts and run multi-day workstreams already operate inside Anthropic and other organizations with tools like Claude Tag, and they need to be governed the way you govern people: identity, least privilege, monitoring, and an insider-risk program that can respond in minutes. The organizations that build that muscle now, on low-risk agents like the examples above, will be ready to say yes when the high-autonomy use cases arrive.

## Getting started

The framework above is only useful if it changes a decision in your organization. Here are three places to start: 

- Pick the agentic use case with the most internal pressure and run it through the four questions. The goal is to find the conditions under which you would approve it, not to produce a verdict.
- Take the seven requirements above to the teams and vendors building agents whom you already pay. Ask your IdP, your SIEM, and any agent vendor which of these they can show you working in your stack today.
- Decide your trust boundary. Write down what counts as untrusted content in your environment. Every future agent decision gets easier once that line exists.

Waiting for zero risk means waiting forever. The web is adversarial, the models are evolving fast, and the organizations that learn to size and accept this risk now are the ones that get the advantage.

For the controls, attestations, and white papers behind this post, start at trust.anthropic.com. Check out our companion piece on defending against AI-accelerated offense.

‍This article was written by Jason Clinton, Deputy CISO, Anthropic.

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

### Working at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problems

Enterprise AI

Working at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problemsWorking at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problems

Working at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problemsWorking at the frontier: How Cursor knew Claude Fable 5 was ready for the hardest 1% of problems

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
