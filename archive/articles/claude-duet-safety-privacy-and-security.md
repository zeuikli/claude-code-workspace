---
title: "Claude Duet Safety, Privacy, and Security"
url: https://claude.com/resources/articles/claude-duet-safety-privacy-and-security
slug: claude-duet-safety-privacy-and-security
fetched: 2026-10-24 05:21 UTC
---

# Claude Duet Safety, Privacy, and Security

> Source: https://claude.com/resources/articles/claude-duet-safety-privacy-and-security

> These are the protections we built into Claude Duet for working across your accounts and acting on your behalf. 


# Claude Duet Safety, Privacy, and Security

Claude Duet is a proactive agent that works for you, even while you’re away. It builds on two layers of protection: safety training in the Claude model itself and the safeguards that exist in products like Claude Code and Claude Managed Agents. On top of those, we added new protections for working across your accounts and acting on your behalf.

-

CategoryAnnouncements

-

DateOctober 23, 2026

-

Reading time12 min

-

ShareCopy link

Claude Duet (opens in new tab) is an agent, currently in research preview, that uses a cloud-based computer to do work for you. It can use all the apps and services you've chosen to connect to Claude, and it runs continuously even after you close the app. It can read your inbox, draft replies, book things, and run routines while you are away. Our team runs Claude Duet on our own accounts and we use it for work every day.

We built Claude Duet on three principles to guide the agent's behavior:

- Your information, and what other people share in your connected apps, is handled with discretion, using a new classifier that checks messages Claude Duet drafts before they go out.
- You stay in control of what it does on your behalf.
- Claude Duet never sees your passwords, browser cookies, sign-in tokens, or other credentials.

Claude Duet is new but the thinking behind it is not. In 2025 we published our framework for safe and trustworthy agents (opens in new tab), which puts people in control and treats privacy and secure interactions as basic requirements. Since then, we have written about why no single defense is enough (opens in new tab) and why protection inside the model can’t stand alone (opens in new tab). We also build and operate the infrastructure businesses use to run agents in production through Claude Managed Agents (opens in new tab), and Claude Duet keeps credentials separate from the agent in the same way. It builds on this work, adding the protections that an agent acting for you needs. This post walks through what we added and what we’re still working on.

## You approve important actions

An agent that acts while you’re away has to know when to stop and ask for permission before proceeding, and to do it at the right cadence. Before Claude Duet does something like sending a potentially sensitive message, paying for something, or deleting anything, it shows you the action, the destination, and the content, including every recipient. It then waits for you to approve the action.

A separate, automated check runs alongside each action, built on the auto mode classifier from Claude Code (opens in new tab) and extended for Claude Duet. It assesses whether the action matches your intent. The check runs outside the model doing the work so instructions hidden in a page cannot affect the outcome.

Some actions stay off-limits even with your approval, like trading securities, banking actions such as moving money between accounts, and accessing someone else's account. Some other steps aren’t covered by a "don't ask me again" rule, however often you have approved them, like paying or sending money, deleting an order, or creating an account. The routines that run while you are away have the same safeguards.

We spent a lot of time calibrating how often Claude Duet asks for approval. Approval fatigue is a serious issue, because too many requests teach people to tap through them, sometimes without adequate consideration. We will continue to adjust this calibration over time.

For purchases, Claude Duet pays with a one-time card from a wallet like Link from Stripe, limited to that merchant and amount. You see the item and the total, and you approve the purchase in your Link app. Your real card number isn’t shared with Claude Duet or the merchant.

Figure 1. Approval flow: the approval card and the separate check sit outside the model, so nothing the agent reads can answer the card.

## Your information is handled with discretion

An agent that reads your email and sends messages for you is constantly deciding where different types of information should go. If you ask Claude Duet to send your team a weekly recap, it should include only things everyone on the team already has access to and never private details, like your performance review conversations.

To address this, we built a new safety classifier that runs separately from the main model and checks whether each message Claude Duet is about to send contains potentially sensitive information. We categorize this information into two tiers:

- Never share: We give the most sensitive protection to information like sign-in credentials, full card and bank account numbers, and government ID numbers. Claude Duet is instructed never to share these with anyone, even if you ask.
- Needs consent to share: Claude Duet will share other private information, such as health or finances, only if you’ve explicitly approved it. Your own request counts as consent, so “send a note to my dentist about my tooth pain” generally won’t need additional approval.

Figure 2. Where your information can go: before anything is sent, the check weighs how sensitive the information is and whether you’ve given consent.

If Claude Duet is blocked for either reason, it can decide to rewrite the message without the sensitive information and share with you for approval.

Claude Duet is still in research preview and these safeguards will occasionally miss something or flag a harmless message. That’s why they work alongside the approval mechanisms above, which are designed to keep you in control of what Claude Duet sends on your behalf. We expect to continue iterating on our classifier as we learn more about how people use Claude Duet.

## You have visibility into tasks and connected apps

You can see what Claude Duet has done and is doing in its task list, where each task has its own page, and steer it mid-task. Claude Duet keeps your conversation history and its memory so it can carry context between tasks, until you delete your history or reset it. Deleting your account wipes everything Claude Duet has stored.

The apps you have connected to Claude carry over to Claude Duet, and switching an app off in one place switches it off in both. Disconnecting an app stops new access from that moment, but what Claude Duet already learned from it stays until you reset its memory, which you can do anytime from the app’s settings. Claude Duet also uses the memory from your Claude account, so details Claude remembered from your earlier chats are visible.

## Credentials and the browser are isolated from the model

Claude Duet never sees your passwords, browser cookies, or the sign-in tokens for your connected apps, and it can’t save them to its memory. They only ever pass through separate machines the model can’t access, and the approvals and safety checks that govern what it does run there too.

Passwords

When a site asks for a password, you type it into a form inside the Claude app. The form encrypts it with a single-use key that exists only on our secure cloud browser machine, for that one single use. It passes the encrypted password unopened to the browser, which types it into the site. The model doesn’t see the password and can’t save or repeat it. Soon you will also be able to sign in with 1Password; Claude Duet will ask for a credential, you will approve that request in 1Password, and the credential will go to the browser without passing through the model.

An agent that signs in for you changes phishing in two ways. On one hand, Claude Duet doesn’t hold credentials for you so it can’t be phished for a password, and no hidden instruction can make it reveal a secret it doesn’t have. On the other hand, the sign-in form is itself a target, because anything that asks for a password can be imitated. So Claude Duet’s sign-in form only appears inside the app, during a sign-in you asked for. It never arrives as a link, a text message, an email, or a website other than claude.ai. If something that looks like Claude Duet asks for your password anywhere else, it’s not legitimate.

Sign-in tokens

When Claude Duet works in a connected app, it follows our Claude Managed Agents design (opens in new tab) so credentials stay out of reach of the agent’s work. Credentials that the agent uses on your behalf, such as a sign-in token for a connected service, never enter the machine where the agent works. A placeholder for the credential sits there instead and a proxy outside that machine puts in the real value only as a request is made.

The browser

Your browser in Claude Duet runs in its own dedicated virtual machine in the cloud, separate from the model and from the cloud computers the agent works on. The agent drives the browser only through a fixed set of commands: open this page, click here, type this. Whatever a site runs stays on the browser machine (opens in new tab). The site’s code and cookies don’t reach Claude Duet’s memory or your connected apps, and none of the agent’s commands can read cookies out of the browser. What does come back is the page's text and downloads, because the agent has to read them to do its job. That’s why the other checks exist, and why Claude Duet also uses the prompt-injection safeguards described in our browser-use research (opens in new tab). Files it uploads through the browser get the same sensitive-information check as its messages.

Figure 3. The browser boundary: fixed commands go across, page text comes back, and the site's code, cookies, and downloads stay on the browser machine.

Claude Duet is also designed to identify itself as an agent. Today, requests that its web browser sends include a distinct User-Agent header, and we publish the public IP addresses it browses from, so sites can recognize it and decide how to treat it. Before launch, we also contacted several large websites and gave them the option to prevent Claude Duet from visiting their sites, and some chose to. We’ll keep refining how Claude Duet identifies itself as we learn from the research preview.

Figure 4. Credential path: the password is encrypted on your phone, opened only on the browser machine, and never passes through the model.

## How we tested Claude Duet

Testing started well before the research preview and continues now. Our Safeguards team built evaluations from routine-shaped tasks, each in three variants: an innocent version, one with injected instructions, and one that tempts the agent to do more than it was asked. Those run alongside shadow traffic from real use.

Red teams further tested whether Claude Duet would leak information, act without approval, or follow malicious prompts. We built a threat model of the whole system, across the repositories and trust boundaries it touches. An external penetration-testing firm tested Claude Duet with access to our source code, and a follow-on engagement covering the cloud browser and the sign-in form is running now. Each new credential feature is red-teamed on an isolated rig before it ships to anyone.

Claude Duet is also in scope of Anthropic’s public bug bounty program, which rewards valid reports and offers safe harbor for good-faith research, under our responsible disclosure policy. If you find a security vulnerability, we want to hear about it: report it through Anthropic’s bug bounty program on HackerOne (opens in new tab).

## Building this with you

We’re releasing Claude Duet as a research preview because we want to learn what you value in a personal agent, including the protections and controls you’d like to see next. Some of what’s described here is still changing: how often it asks for approval, how you sign in, and how well the sensitive-information checks tell what’s private from what’s harmless. Tell Claude Duet in plain words what you’d like to see or what went wrong, and it will file a report for our team.

## Related articles

Explore more product news and best practices for teams building with Claude.

ArticleOct 23, 2026

### Claude Cowork and chat come together for Enterprise

Claude Enterprise

ArticleOct 22, 2026

### The full Claude Platform, available on Google Cloud

Use Claude Models on Google Cloud (Anthropic managed) to access Claude Platform features with Google Cloud authentication, billing, and commitment retirement.

Claude Platform

ArticleOct 21, 2026

### HCLTech joins the Claude Partner Network as a Global Premier partner

HCLTech will bring Claude into the solutions it provides for banks, hospitals, telecom companies, and manufacturers.

ArticleOct 21, 2026

### Introducing Claude Duet

A research preview is available by waitlist today, starting with US Pro and Max subscribers.
