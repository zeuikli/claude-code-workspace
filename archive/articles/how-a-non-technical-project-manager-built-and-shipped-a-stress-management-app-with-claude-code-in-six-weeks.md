---
title: "How a non-technical project manager built and shipped a stress management app with Claude Code in six weeks"
url: https://claude.com/blog/how-a-non-technical-project-manager-built-and-shipped-a-stress-management-app-with-claude-code-in-six-weeks
slug: how-a-non-technical-project-manager-built-and-shipped-a-stress-management-app-with-claude-code-in-six-weeks
fetched: 2026-05-02 04:17 UTC
---

# How a non-technical project manager built and shipped a stress management app with Claude Code in six weeks

> Source: https://claude.com/blog/how-a-non-technical-project-manager-built-and-shipped-a-stress-management-app-with-claude-code-in-six-weeks




# How a non-technical project manager built and shipped a stress management app with Claude Code in six weeks

Kostiantyn Vlasenko had never written a line of code when he set out to build Respiro. Just over a month later, his product was live on the App Store.

- Category

Claude Code

- Product

Claude Code

- Date

May 1, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-a-non-technical-project-manager-built-and-shipped-a-stress-management-app-with-claude-code-in-six-weeks

In our series, Day zero: founder stories, we profile the builders behind some of the worldâs most interesting and inspiring startups. In this article, we highlight Kostiantyn Vlasenko, a winner of the Claude Opus 4.6 Hackathon and creator of Respiro.

          Founder
          Kostiantyn Vlasenko

          Country
          Ukraine

          Startup
          Respiro

Fifteen minutes before joining the video call for this interview, Kostiantyn Vlasenko was feeling nervous. He was so preoccupied with thinking through what he wanted to say, though, that he actually didn't notice his own anxietyâbut his phone did.

"The app detected this and alerted me, 'Mate, you can just go and do a short box breathing session. Box breathing has previously helped you de-stress,'" he says.

That app, Respiro, is Vlasenko's creation. Although a project manager with a decade of experience, heâd never shipped a line of code until February 2026 when he decided to build a project for the Built With Opus 4.6 Claude Code Hackathon. A month later, Respiro (an iOS app for science-backed stress management) is live on the Apple App Store, has hundreds of users, and runs on an architecture involving 15+ specialized subagents that Vlasenko built and orchestrates himself.Â 

He did it all with Claude Code, in 72 hours, with no team and no programming experience.Â 

## The problem no app could solve

As a project manager at Mythical Games, Kyiv-based Vlasenko has spent ten years managing stakeholder pressure, team dynamics, and the relentless pace of product releases. He found that breathing techniques and mindfulness helped keep his stress level under control; what he couldnât find was a stress management tool that kicked in during moments of actual stress.

"The existing apps could notify me to do some deep breathing at 10:00 PM or whatever. But they didnât understand that I'm stressed right now," he explains. He was on vacation in the mountains of western Ukraine when the idea crystallized: build an app that detects stress signals from your personal device(s) in real time, and then intervenes with a guided mindful breathing exercise at the moments when you need it most. The only problem was that he didn't know how to build apps.

## Managing agents like people

At the time, Vlasenko was using Claude for automating work tasks like Jira updates and posting meeting notes in Slack and had only recently started using the Claude Code CLI. âAnd then I thought, okay, I'm familiar with how my team members write code using Claude. Why canât I do it too?â he says.Â 

He quickly realized that his project management background was more important than his coding skills. "I have a lot of experience managing real people," he said. "I realized this was the same thing, only managing agents inside my IDE, and I was really surprised how easy it was."

Vlasenko jokes that his first prompt was essentially Hey Claude, just give me an application that will make me less stressed but, even so, he says, the initial result amazed him. "Wow, this is impressive. It's not just in my head, it's inside my phone right now, and it works!"

But Vlasenko didn't stop there. He used Claude to research how agent systems work and which Apple APIs could feed his stress-detection logic, and then had Claude help build out a multi-agent architecture: a TCA architect agent, a Swift developer agent, a Metal specialist, a code reviewer, and more, all running in parallel across different modules.Â 

Claude also made pivoting painless: when the initial React Native-based MVP of Respiro became problematic because Vlasenko lacked an Android phone to test on, he used Claude Code to rewrite the app in Swift, from scratch, in a few hours.Â 

All told, he says, going from initial idea to a full-featured App Store-ready version of Respiro took just under six weeks.

## From Claude Code code to App Store

Building the app was one thing. Shipping it was another, and Vlasenko had never navigated the Apple Developer Program before. He used Claude to guide him through the sometimes confusing process, step by step.

"When I got stuck, I could just take a screenshot and ask Claude, 'Hey, what should I press here?'" he says. He used the same approach to set up other third-party services, like Sentry for logging and Amplitude for analytics. âI'd tell Claude, I completed the sign-in, here's the API key and 99 percent of the time Claude got it on the first try,â Vlasenko said. The other one percent of the time, he continued, âI just needed to refine and give more clarity to what I was asking for in the first prompt, and within a few more tries Claude gives me the results I want.â

In fact, Vlasenko considers Claudeâs vision capabilities to be its most under-appreciated feature. âYou send Claude a screenshot to analyze and it tells you what it sees. Then you use this to have Claude guide you through even the most complex UX, â he explained. âLike, I had to create an API token on Meta and I was just getting lost in their interface, but Claude really understands and guides you everywhere you need to go.â

Marketing Respiro is also a Claude-assisted endeavor. When Vlasenko needed analytics, Claude went beyond integrating Amplitudeâs basic SDK to set up full user funnels, retention metrics, and active tracking for daily and monthly users. When he needed content, Claude started writing his blog posts and helping him create TikToks. Claude also suggested a growth strategy Vlasenko says he never would have thought of: reaching out to psychologists and mindfulness practitioners who could recommend Respiro to their clients. He tried it. It worked. Practitioners started recommending the app.

## Founder mode at work

The skills Vlasenko developed building Respiro werenât only applied to his side project. He's now committing code releases and directly shipping features as part of his day job at Mythical Games. Moreover, he's become an internal advocate for the development process he developed while building Respiro, sharing his Claude folder and workflows with the engineering team.

"Most of them came back saying, Hey, this workflow is much better than what I have right now! " he noted. As a result, Mythical now has a small internal team delivering work entirely through Claude. It was not, however, a completely frictionless transition for all involved, Vlasenko observed. "It's hard for some engineers to switch the mindset of not completely controlling every line of code,â he said. âFor me, it was easy because I don't have a deep programming background and it just felt like a natural way of working.â

For Vlasenko, the experience of building Respiro has erased any boundaries between what's possible and what isn't. He's building voice-guided practices and motion exercises into the appâs next release, working from a roadmap Claude helped him write and logging seven or eight hours of coding sessions after finishing his regular workday.

"I would say that Claude Code is my new addiction," he said.

          The Claude Code Day Zero Questionnaire™

          In which we ask founders the same silly questions to learn more about the person behind the keyboard.

          Who or what inspires you?
          LeBron James. His discipline, consistency, and long-term mindset are incredibly inspiring. He didn't just rely on talent; he built one of the all-time greatest careers through relentless focus and execution. Also, Warren Buffett â very different field, but the same core traits: patience, consistency, and clarity of thinking over decades. I really admire people who achieve greatness not by luck, but by staying consistent for a very long time.

          If you could go back in time, what would you have done differently and why?
          I wish I had realized earlier that building a product is actually the easy part. Communicating its value is much harder! Today, it's surprisingly easy to build something high-quality, especially with tools like Claude. But getting people to understand why it matters, why they should care â that's the real challenge.

          If someone wrote a book about your startup journey, what would it be titled?
          "Autonomous by Design"

          What does your workspace look like?

            About 70% of the time, I work on my MacBook connected to an external monitor, keyboard, and mouse. Around 20% just on my laptop when I'm not at home. And about 10% â from my phone, usually when I get an idea and don't want to wait. Also, my cat is often on the desk keeping me company (and making sure I don't work non-stop for too many hours).

          How many browser tabs do you have open right now?
          Right now â around 5. I try to keep it minimal. Usually, I have a YouTube video playing in the background â I like listening to true crime or founder podcasts. I also actively run a Threads account where I share what I'm building, experiments, Claude workflows, and help others set up their own systems.

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

Apr 30, 2026

### Lessons from building Claude Code: Prompt caching is everything

Claude Code

Lessons from building Claude Code: Prompt caching is everythingLessons from building Claude Code: Prompt caching is everything

Lessons from building Claude Code: Prompt caching is everythingLessons from building Claude Code: Prompt caching is everything

Apr 29, 2026

### Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

Agents

Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and WarpClaude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

Claude API skill now in CodeRabbit, JetBrains, Resolve AI, and WarpClaude API skill now in CodeRabbit, JetBrains, Resolve AI, and Warp

Apr 28, 2026

### Onboarding Claude Code like a new developer: Lessons from 17 years of development

Claude Code

Onboarding Claude Code like a new developer: Lessons from 17 years of developmentOnboarding Claude Code like a new developer: Lessons from 17 years of development

Onboarding Claude Code like a new developer: Lessons from 17 years of developmentOnboarding Claude Code like a new developer: Lessons from 17 years of development

Apr 20, 2026

### Meet the winners of our Built with Opus 4.6 Claude Code hackathon

Claude Code

Meet the winners of our Built with Opus 4.6 Claude Code hackathon Meet the winners of our Built with Opus 4.6 Claude Code hackathon

Meet the winners of our Built with Opus 4.6 Claude Code hackathon Meet the winners of our Built with Opus 4.6 Claude Code hackathon

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! Youâre subscribed.

Sorry, there was a problem with your submission, please try again later.
