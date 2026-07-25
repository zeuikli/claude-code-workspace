---
title: "How the product designer who built Claude Design uses it | Claude by Anthropic"
url: https://claude.com/blog/how-the-product-designer-who-built-claude-design-uses-it-to-explore-ideas-before-building-them
slug: how-the-product-designer-who-built-claude-design-uses-it-to-explore-ideas-before-building-them
fetched: 2026-07-25 04:06 UTC
---

# How the product designer who built Claude Design uses it | Claude by Anthropic

> Source: https://claude.com/blog/how-the-product-designer-who-built-claude-design-uses-it-to-explore-ideas-before-building-them




# How the product designer who built Claude Design uses it to explore ideas before building them

Nate Parrott, a product designer at Anthropic, shares how he uses Claude Design (in beta) to explore, iterate on, and share visual ideas early, from product prototypes to slide decks and animations.

- Category

Enterprise AI

- Product

Claude Design

- Date

July 24, 2026

- Reading time

5

min

- Share
Copy link
https://claude.com/blog/how-the-product-designer-who-built-claude-design-uses-it-to-explore-ideas-before-building-them

In the fall of 2025, I was the only product designer on Claude Code for VS Code, working with two engineers to reimagine everything Claude Code does for a friendly interface outside the terminal. We shipped the beta at the end of September, Opus 4.5 arrived in November, and the Claude Code team started shipping fast and aggressively. The engineers were shipping far more than before, while I was still delivering at the pace I always had. I needed to find a way to catch up.

Claude Code runs in the terminal, where everything is text-based, and my first attempt treated it that way: I copied output into Claude, added screenshots, and asked, "Here's a feature we want to add. Why don't you design it?" The results weren't good. For a month or so, as a side project, I kept looking for ways to improve Claude’s design output.

## Giving Claude an HTML playground

Eventually I stumbled onto the answer: Claude is really good with HTML. We think of HTML as the format for websites, but it's also a rich, interactive visual medium: anything you can make in a slide deck, a video file, or a PDF, you can make in a web page. So I prompted Claude to make HTML, and gave it a split-view interface where you could chat on the left and see the output on the right.

That was useful, but product design is driven by applying knowledge of the product and brand you work on, so as a next step I spent a while distilling the essence of Anthropic's brand (the fonts, colors, assets, and principles our products use) into prompts. This way, when I type my prompt into the tool, the output is compliant with the Anthropic brand guide.

I put all that into a small internal prototype and shared it with the team. Product designers picked it up immediately for interactive prototypes. Making a click-through prototype in traditional design tools means mocking up every state of every screen and wiring them together by hand. Here, you hand Claude your assets and say: make it work. Every artifact it delivers has a link you can share the way you'd share a doc.

## How Claude Design became a medium for visual work

I first realized how compelling Claude Design was at an idea pitch session during an Anthropic Labs team offsite: every person there threw together slides using it, often in the middle of the meeting before their turn to present. That session convinced the Labs team to staff it, and Claude Design went from a side project to a real project.

We stopped describing it as a tool for product mockups. Claude Design became a tool for producing any kind of visual communication: slide decks, landing pages, one-pagers you print as a PDF, emails, animations, visuals to share on social media. I think of it as one click above product design: you collaborate with Claude on visuals whose main job is communication and ideation. 

As models get better at vision, so does the range and quality of work Claude Design can do. Our latest Opus-class model, Claude Opus 5, is better than previous Opus models at reading the charts, diagrams, and screenshots, making it powerful when paired with Claude Design for creating presentation-worthy decks and memos.

## What Claude Design is not meant to do

Claude Design doesn't have an image model and isn’t built for image generation, so it's a poor fit for logo design—though that hasn’t stopped people from trying. The better approach here is to bring in the logo and assets you already have. The rest of the product works the same way: Claude creates options and starting points so you don’t have to stare at a blank canvas, and you choose what's good on its own, or as a combination of multiple versions. 

And if you're shipping production software, stick with Claude Code. Claude Code is for coding; Claude Design is for the other parts of the design work: early ideation, collaboration, or getting buy-in on a direction before anyone commits to building it. The two work together round-trip, so you can sync a prototype you started in Claude Code to Claude Design for iteration and editing on the canvas, or hand off a prototype you’re ready to build from Claude Design to Claude Code. As models get better at building production software, the work that matters most moves earlier in the process: having good ideas, getting everyone aligned, and collecting feedback while an idea is still early. 

## How I use Claude Design in my daily work

I use Claude Design every day for what you’d call bread-and-butter design work: wireframing early ideas, or generating 15 versions of a flow to collect feedback from colleagues. Some recent examples from my own work:

- The Claude Design intro animation. The animation that plays when you sign up for Claude Design was made in the tool itself, but not directly: I'm not an animator, so I first had Claude Design build me a bespoke video editor, then used that editor to make the animation.

- A subway-times app with adjustable animation controls for dialing in the physics of the motion. 

- Instagram-style color controls. I asked Claude to let me tweak an app's color scheme with sliders and presets rather than describing colors in words. 

- A redesign of Claude Design itself. Two teammates, Helen and Andrew, and I have been riffing on a new design for the editor, inside the tool. We won't ship it as-is, but it's how we explore what the product could become.

## Best practices for using Claude Design

- Do the thinking before you prompt. The best and most efficient way to get output that matches your vision, is to tell Claude what you need up front. I spend a lot of time writing prompts before I design. Sometimes I dictate them in Claude Design with the voice button. Other times I type them in the Notes app on my phone from the couch, or record a voice note on a walk and paste the transcript later. Whichever method of communicating you prefer, figure out what you want while you're away from the computer, so Claude can execute your exact vision when you sit down.
- Tell Claude what it should look like. Left undirected, Claude picks one of its favorite aesthetics. You'd probably recognize them. Head that off by specifying fonts and colors, or providing a moodboard of images for inspiration, or asking Claude to brainstorm font-and-color pairings and going back and forth until a pairing feels right. 
- Turn recurring work into a design system. Upload your brand files and assets such as logos, slide decks, screenshots, typography specs, and anything else you reuse, and Claude will analyze them and generate a design system. This way, each artifact you make afterward starts from your choices, rather than a blank slate.
- Ask for ten options, then remix. Most of them won't be good, and that's fine; one or two will be. Then say, "I like option B and a little of option D. Give me five riffs that smoosh those together." 
- Sketch what you can't describe. If you have a layout in your head and no words for it, draw it on paper and upload a photo.
- Point and talk. Instead of writing a paragraph identifying which element you mean, click on it and speak. You need to have dictation enabled on your device, then select “comment” and click into the comment box. Your words will appear in the comment box as if you are typing.
- Wireframe first when fidelity doesn't matter. Asking for wireframes is much faster, and it keeps Claude focused on the higher-level structure of a design instead of the visuals. This is a great way to try many different ideas quickly.
- Make the last mile manual. Use the direct editing tools (rearrange, delete, edit text, resize, change colors) for final touches instead of prompting for them. Direct edits use no tokens, and small calls like sizing and alignment are better eyeballed anyway.
- Give Claude your real context. If you're designing a feature for an existing app or website, connect GitHub: Claude will fetch your components and existing screens and use them as a starting point, and with a few tries it can recreate your existing designs with pretty high fidelity. Web search and MCP connections work in Claude Design too, whenever the design depends on outside information.
- Keep working alongside Claude. You don’t have to wait for Claude to deliver a finished result before prompting new changes or tasks. You can queue up multiple messages at once, or keep talking while Claude is still working on the previous turn.

## Make it alive

There's a Bret Victor talk every designer should watch at some point, called Stop Drawing Dead Fish. From the blurb: "Everything we draw should be alive by default."

I'd encourage designers, in Claude Design or any other tool, to think about how to make their creations alive. My favorite Claude Design creations are the ones that don't fit into existing boxes: docs with interactive simulations, slide decks that talk to you, diagrams that are also videos, designs that are also their own editors. Code, specifically HTML, is an amazing medium for creativity, and it's finally somewhat easy for designers to create with.

Claude Design took its current shape because people at Anthropic kept finding uses I hadn't planned for; it is now available in beta on Claude Pro, Max, Team, and Enterprise plans. Try it and take it somewhere we haven't thought of yet.

This article was written by Nate Parrott, a product designer at Anthropic, and expresses his opinions, usage patterns, and advice on Claude Design.

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

Jul 24, 2026

### Claude models explained: choosing the best model for your use case

Enterprise AI

Claude models explained: choosing the best model for your use caseClaude models explained: choosing the best model for your use case

Claude models explained: choosing the best model for your use caseClaude models explained: choosing the best model for your use case

Jul 23, 2026

### Four role-based certifications for the people who put Claude to work for customers

Enterprise AI

Four role-based certifications for the people who put Claude to work for customersFour role-based certifications for the people who put Claude to work for customers

Four role-based certifications for the people who put Claude to work for customersFour role-based certifications for the people who put Claude to work for customers

Jul 21, 2026

### How Anthropic secures its AI-native software development lifecycle

Claude Code

How Anthropic secures its AI-native software development lifecycleHow Anthropic secures its AI-native software development lifecycle

How Anthropic secures its AI-native software development lifecycleHow Anthropic secures its AI-native software development lifecycle

Jul 17, 2026

### Zero risk isn't the job: a CISO's guide to agentic AI

Enterprise AI

Zero risk isn't the job: a CISO's guide to agentic AIZero risk isn't the job: a CISO's guide to agentic AI

Zero risk isn't the job: a CISO's guide to agentic AIZero risk isn't the job: a CISO's guide to agentic AI

## Transform how your organization operates with Claude

See pricing

See pricingSee pricing

Contact sales

Contact salesContact sales

Get the developer newsletter

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

Thank you! You’re subscribed.

Sorry, there was a problem with your submission, please try again later.
