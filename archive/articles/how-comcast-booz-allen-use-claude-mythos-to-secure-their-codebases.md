---
title: "How Comcast and Booz Allen use Claude Mythos to find exploit chains and secure their codebases"
url: https://claude.com/resources/articles/how-comcast-booz-allen-use-claude-mythos-to-secure-their-codebases
slug: how-comcast-booz-allen-use-claude-mythos-to-secure-their-codebases
fetched: 2026-10-12 00:45 UTC
---

# How Comcast and Booz Allen use Claude Mythos to find exploit chains and secure their codebases

> Source: https://claude.com/resources/articles/how-comcast-booz-allen-use-claude-mythos-to-secure-their-codebases

> Security teams at Comcast and Booz Allen used Claude Mythos-class models through Project Glasswing to find, validate, and fix vulnerabilities their existing scanners missed.


# How Comcast and Booz Allen use Claude Mythos to find exploit chains and secure their codebases

Security teams at Comcast and Booz Allen used Claude Mythos-class models through Project Glasswing to find, validate, and fix vulnerabilities their existing scanners missed.

-

CategoryPerspectives

-

DateOctober 6, 2026

-

Reading time9 min

-

ShareCopy link

Earlier this year, Anthropic launched Project Glasswing, a limited access program to give defenders of the world’s critical infrastructure a head start on securing their codebases. This week, we launched a new, expanded version of our Cyber Verification Program (CVP) that makes advanced cyber capabilities and reduced blocking classifiers available to qualifying security professionals.

As part of Project Glasswing, organizations defending critical infrastructure have put Claude Mythos models to work on the systems they defend. Across these organizations, one theme emerged: while existing cybersecurity tools can identify single vulnerabilities in a silo, exploit chains, where an attacker links several individually minor weaknesses into a path to something serious, are much harder to trace. Models like Claude Mythos help piece together code, configuration, and live application behavior so that organizations can catch both ordinary single-file bugs and the sophisticated cross-system vulnerabilities that only appear when components interact.

We spoke with security leaders from Comcast and Booz Allen who participated in the program about what Claude Mythos-class models found in their environments and how it’s changing the way their teams defend against attacks.

## Comcast: Separating findings from exploitable vulnerabilities

Comcast, a global media and technology company, used Claude Mythos Preview to identify a critical authentication vulnerability in a public-facing platform during an assessment covering 258 business-critical systems and approximately 170 million lines of code. The issue could have allowed an attacker to bypass authentication controls and was remediated before any evidence of exploitation was observed.

“Discovery is becoming faster,” said Noopur Davis, EVP, Chief Information Security and Product Privacy Officer, Comcast. “Discovery is becoming easier. The volume of findings is enormous. Validation of these volumes of findings is the new bottleneck."

The finding emerged from Claude Mythos Preview's ability to reason across a complex software ecosystem rather than evaluating individual files or components in isolation. The vulnerability was not caused by a single defective component. Instead, it arose from the interaction of multiple systems and assumptions that appeared correct when reviewed independently. By maintaining context across code, configuration, and application behavior, Claude Mythos Preview identified a security gap that emerged across multiple interacting components, making it difficult to detect through conventional approaches.

“Frontier AI models are making it much easier to generate findings at scale,” said Davis. “But a finding becomes a vulnerability only after validation confirms the underlying issue, and a vulnerability becomes exploitable only when it can actually be exploited in the target environment.”

Comcast engineers validated the finding against the running application and confirmed that the underlying security issue could be reached in practice. The team then traced the root cause, implemented remediation, and verified that the vulnerability had not been exploited prior to being fixed. The finding was representative of a broader pattern observed: some of the highest-impact issues identified by Claude Mythos-class models emerged not from individual coding errors, but from subtle interactions across complex software environments.

“Early access probably accelerated our understanding of the security capabilities of frontier AI models by about a year,” Davis said. “We really appreciate the community that Anthropic has built around this program - it allows participants to share lessons learned, thus helping the wider ecosystem.”

## Booz Allen: Piecing together exploit chains

Booz Allen builds and deploys technology for defense, civil, national security, and commercial missions, and its cyber practice works to close the speed gap between AI-powered adversaries and traditional cyber defenses. This includes running red-team exercises and building defenses for customers facing AI-enabled adversaries.

Booz Allen’s security assessments run for a fixed period of time, and engineers can read only so much source code, configuration, and compiled software before they end. Wider coverage alone wouldn't close that gap, because real attacks usually work by chaining small weaknesses across code, configuration, identity, and deployment settings, and tracing those connections by hand across a large software portfolio is slow even for a skilled operator.

Booz Allen used Claude Mythos Preview to review far more software than a short engagement window would normally allow, and to identify weaknesses that could be strung together into exploit chains.

“Mythos was surprising in its ability to reason across boundaries rather than only identify isolated code issues,” said Sahil Sanghvi, Vice President of AI Engineering at Booz Allen. “It helped connect application behavior, configuration, identity, permissions, and deployment context into coherent security hypotheses.” The work also moved from discovery to remediation faster than his team expected, with the model helping to draft fixes and assemble evidence for the engineers who owned the affected systems.

In one case, a Claude Mythos-class model found a flaw in the code that runs when a device first powers on, before the operating system loads. That code decides whether the device should lock itself or erase its data, and it makes that call using a security key stored on the machine. The key had been left unprotected, so the operating system it was meant to restrain could swap in a key an attacker controlled and then feed the machine instructions it would trust. An attacker could hold off the lock-or-erase step indefinitely, keeping a lost, stolen, or compromised device fully accessible when it should have shut itself down.

There were several opportunities for the system to lock the key, and each was missed. When the key was first saved, the setting that would have protected it was switched off. The code that wrote it to the hardware passed that setting along without correcting it. A separate safeguard that could have locked the key afterward was never turned on. Claude found the vulnerability by following that one setting through two different programs written in two different languages, then confirming that nothing ever locked the key.

“Mythos can create a large candidate set quickly, but teams still need to validate findings, deduplicate systemic patterns, and route issues to the right owners,” said Brad Medairy, President of National Cybersecurity, Booz Allen. "One analyst reviewed eight production systems across 138 repositories in twelve days. Without Mythos, a portfolio review at that scale would have taken us several months with a larger team."

For Booz Allen, that points to a different way of running security review, one where operators keep the judgment calls while the model extends how much of the portfolio they can keep under watch.

“Our research shows that frontier models have the ability to autonomously execute the full cyber kill chain,” Medairy said. “Organizations must operate continuous cyber security reviews and defenses to keep pace.”

## What’s next

As models with the capabilities of Claude Mythos become part of everyday security work, organizations can examine their own systems the way a skilled attacker would, tracing how code, configuration, and legacy components interact and closing the gaps between them before anyone else finds a way through. We built Project Glasswing to give defenders that capability first, and we’ll keep expanding access via our new Cyber Verification Program (CVP) so that more of the organizations running critical software can put it to work.

Learn more about the Cyber Verification Program (CVP).

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleOct 8, 2026

### How Block orchestrates Claude Fable across thousands of pull requests

Bradley Axen, Head of AI Capabilities at Block, on how his team evaluates new large language models, how Claude Fable 5 orchestrates company-wide code migrations, and why safeguards are a critical part of deploying frontier intelligence responsibly, at scale.

Claude Enterprise

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
