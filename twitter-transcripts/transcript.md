# Twitter 影片逐字稿

**來源**: https://x.com/eng_khairallah1/status/2054211760631185485
**語言**: 英文 (English)
**語音辨識模型**: OpenAI Whisper (base)
**片段數**: 174

> **⚠️ 辨識備註**: 影片為 Boris Cherny（Anthropic Staff，Claude Code 創作者）介紹 Claude Code 的演講。Whisper 將 "Claude Code" 誤辨識為 "Quad Code"（發音相似），請閱讀時自行替換。

---

## 逐字稿（含時間戳）

**[00:00 → 00:16]** Hello, everyone. I'm Boris. I'm a member of technical staff here at Anthropic, and I created quad code.

**[00:16 → 00:21]** And here to talk to you a little bit about some practical tips and tricks for using quad code.

**[00:21 → 00:28]** It's going to be very practical. I'm not going to go too much into the history or the theory or anything like this.

**[00:28 → 00:34]** And before we start, can we get a quick show of hands who is used quad code before?

**[00:34 → 00:41]** Yeah. That's what we like to see. For everyone that didn't raise your hands, I know you're not supposed to do this while people are talking.

**[00:41 → 00:48]** But if you can open your laptop and type this.

**[00:48 → 00:57]** And this will help you install quad code just so you can follow along for the rest of the talk.

**[00:57 → 01:06]** Oh, you need is no JS if you have it that should work.

**[01:06 → 01:16]** Yeah, if you don't have to follow along, but if you don't have it yet, this is your chance to install it so you can follow along.

**[01:16 → 01:25]** So what is quad code? Quad code is a new kind of AI assistant. And there's been different generations of AI assistants for coding.

**[01:25 → 01:31]** Most of them have been about completing like a line at a time, completing a few lines of code at a time.

**[01:31 → 01:43]** Quad code is not for that. It's fully agentic. So it's meant for building features for writing entire functions, entire files, fixing entire bugs at the same time.

**[01:43 → 01:58]** And what's kind of cool about quad code is it works with all of your tools. And you don't have to change out your workflow. You don't have to swap everything to start using it. So whatever IDE use if you use VS code or if you use X code or if you use JetBrains IDs.

**[01:58 → 02:08]** There's some people out on the topic that you can't pry them from their cold dead hands, but they use quad code because quad code works with every single ID, every terminal out there.

**[02:08 → 02:17]** It will work locally over remote SSH over team apps, whatever environment you're in, you can run it.

**[02:17 → 02:32]** It's general purpose. And this is something where if you haven't used these kind of free form coding assistants in the past, it can be kind of hard to figure out how to get started because you open it up and you just see a prompt bar and you might wonder, like, what do I do this? What do I type in?

**[02:32 → 02:47]** It's a power tool so you can use it for a lot of things, but also because it can do so much, we don't try to guide you towards a particular workflow because really you should be able to use it however you want as an engineer.

**[02:47 → 03:00]** As you open up quad code for the first time, there's a few things that we recommend doing to get your environments set up. And these are pretty straightforward. So run terminal setup, this will give you shift enter for new lines. So you don't have to do like backslashes, enter new lines.

**[03:00 → 03:08]** This is, you know, it makes it a little bit nicer to use. Do slash theme to set light mode or dark mode or Daltonized themes.

**[03:09 → 03:22]** You can do slash install GitHub app. So today, when we announced a GitHub app where you can add mention, a cloud on any GitHub issue or a poor request. So to install it, just run this command in your terminal.

**[03:23 → 03:34]** You can customize the set of allowed tools that you can use so you're not prompted for it every time. This is pretty convenient for stuff that I'm prompted about a bunch. I'll definitely customize it in this way so I don't have to accept it every time.

**[03:35 → 03:46]** And something that I actually do is for a lot of my prompts, I won't hand type them into a quad code. If you're on macOS, you can go into your system settings under accessibility is dictation and you can enable it.

**[03:46 → 04:00]** And so something I do is you just hit like the dictation key twice and you can just speak your prompt. And it helps a lot to have specific prompts. So this is actually pretty awesome. You can just talk to quad code and like you would another engineer and you don't have to type a lot of code.

**[04:05 → 04:17]** So when you're starting out with cloud code, it's so freeform and it can do everything. What do you start with? The thing I recommend above everything else is starting with code based Q&A. So just asking your question asking questions here code base.

**[04:17 → 04:28]** This is something that we teach new hires at Anthropic. So on the first day in technical onboarding you learn about cloud code, you download it, you get it set up. And then you immediately start asking questions about the code base.

**[04:29 → 04:36]** And in the past when you're doing technical onboarding, it's something that taxes the team a lot. Right, you have to ask other engineers on the team questions.

**[04:36 → 04:42]** You have to look around the code and this takes a while. You have to figure out how to use the tools that this takes a long time.

**[04:42 → 04:53]** With cloud code, you can just ask cloud code and it'll explore the code base. It'll answer these kind of questions. And so at Anthropic onboarding used to take about two or three weeks for technical hires. It's now about two or three days.

**[04:54 → 05:06]** What's also kind of cool about Q&A is we don't do any sort of indexing. So there's no remote database with your code. We don't upload it anywhere. Your code stays vocal. We do not train gendered of models on the code.

**[05:06 → 05:18]** So it's there. You control it. There's no indices or anything like this. And what that means is also there's no setup. So you start cloud, you download it, you start it. There's no indexing. You don't have to wait. You can just use it right away.

**[05:19 → 05:29]** This is a technical talk. So I'm going to show some very specific prompts and very specific code samples that you can use and hopefully improve and upload where your cloud code experience.

**[05:29 → 05:39]** So some kind of questions that you can ask is, you know, how is this particular piece of code used or how do I instantiate this thing and cloud code won't just do like a text search and try to answer this.

**[05:40 → 05:54]** It will often go a level deeper and it will try to find examples of how is this class instantiated, how is it used. And it'll give you a much deeper answer. So something that you would get out of a week year documentation instead of just like command F.

**[05:54 → 06:04]** Something that I do a lot also is ask it about get history. So for example, you know, why does this function have 15 arguments and why are the arguments named this weird way.

**[06:04 → 06:09]** And this is something I bet in all of our code basis. You have some function like this or some class like this.

**[06:09 → 06:18]** And cloud code can look through get history and it'll look to figure out how did these arguments get introduced and who introduced them and what was the situation. What are the issues that those commits linked to.

**[06:19 → 06:28]** And it'll look through all this and summarize it and you don't have to tell it that in all these in all this detail. You just ask it. So just say look through get history and I don't know to do this.

**[06:28 → 06:36]** The reason it knows by the way is not because we prompted it to there's nothing in the system prompt about looking through get history. It knows it because the model was awesome.

**[06:36 → 06:43]** And if you tell it to use get it don't know how to use get. So we're lucky to be building on such a good model.

**[06:43 → 06:53]** I often ask about GitHub issues. So you know, I can use web fetch and they can fetch issues and work up context on issues too. And this is pretty awesome.

**[06:53 → 07:05]** And this is something that I do every single Monday in our weekly stand up is I ask what did I ship this week and quad code looks the log knows my username and it'll just give me a nice read out everything I shipped.

**[07:05 → 07:11]** And I'll just copy and paste that into a docs.

**[07:11 → 07:18]** So yeah, that's tip number one for people that have not used quad code before if you're just showing it to someone for the first time on boarding your team.

**[07:18 → 07:27]** The thing we definitely recommend is start with code base Q&A. Don't start by using fancy tools. Don't start by editing code. Just start by asking questions about the code base and that'll teach people how to prompt.

**[07:27 → 07:34]** And it'll start teaching them this boundary of like what can quad code do. What is it capable of versus what do you need to hold this hand with a little bit more.

**[07:34 → 07:42]** What can be one shot it what can be two shot it three shot it what do you need to use interactive mode for an apple.

**[07:42 → 07:48]** Once you're pretty comfortable with Q&A you can dive into editing code. This is the next thing.

**[07:48 → 07:58]** And the cool thing about any sort of agentic, you know, like using an LM in an agentic ways you give it tools and it is just like magical it figures out how to use the tools.

**[07:58 → 08:08]** And with quad code we give it a pretty small set of tools. It's not a lot. And so it has a tool to edit files. It has a tool to run bash commands. It has a tool to search files.

**[08:08 → 08:14]** And it'll string these together to explore the code brainstorm and then finally make edits.

**[08:14 → 08:20]** And you don't have to prompt it specifically to use this tool and this tool and this tool you just say, you know, do this thing and it'll figure out how to do it.

**[08:20 → 08:27]** It'll string it together in the right way that makes sense for quad code.

**[08:27 → 08:37]** There's a lot of ways to use this. Something I like to do sometimes is before having cloud jump in to write code I'll ask it to brainstorm a little bit or make a plan.

**[08:37 → 08:47]** This is something we highly recommend and something I see sometimes is people, you know, they take quad code and they ask it, hey, implement this enormous like 3000 wine feature.

**[08:47 → 08:54]** And sometimes it gets this right on the first shot. But sometimes what happens is the thing that it builds is not at all the thing that you want it.

**[08:54 → 09:04]** And the easiest way to get the result you want is ask it to think first. So brainstorm ideas, make a plan run it by me as for approval before you write code.

**[09:04 → 09:15]** And you don't have to use plan mode. You don't have to use any special tools to do this. All you have to do is ask log and it'll know to do this. So just say before you write code, make a plan.

**[09:15 → 09:24]** This is also I want to think with this one this commit push for this is a really common in contation that I use. There's nothing special about it, but quad is kind of smart enough to interpret this so it'll make a commit.

**[09:24 → 09:35]** It'll push it to the branch make a branch and then make a pull request from young GitHub. You don't have to explain anything. It'll look through the code. It'll look through the history. It'll look through the get log by itself to figure out the commit format and all the stuff.

**[09:35 → 09:39]** And it'll make the commit and push it the right way.

**[09:39 → 09:47]** Again, we're not system promising to do this. It just knows how to do this. The model was good.

**[09:47 → 09:54]** As you get a little bit more advanced, you're going to want to start to plug in your team's tools. And this is where quad code starts to really shine.

**[09:54 → 10:02]** And there's generally two kinds of tools. So one is bash tools. And an example of this I just made up this like burly CLI. This isn't a real thing.

**[10:02 → 10:09]** You can tell quad code about this and you can tell it to use for example like dash dash help to figure out how to use it.

**[10:09 → 10:16]** And this is efficient. If you find yourself using it a lot, you can also dump this into your quad MD, which we'll talk about in a bit.

**[10:16 → 10:23]** So quad can remember this across sessions. But this is a common pattern we follow at Anthropic and we see external customers use to.

**[10:23 → 10:35]** And same thing with MCP quad code can use bash tools. You can use MCP tools. So you know, just tell it about the tools and you can add MCP tool and you can tell it how to use it. And it'll just start using it.

**[10:35 → 10:42]** And this is extremely powerful because when you start to use code on a new code base, you can just give it all of your tools.

**[10:42 → 10:52]** All the tools your team already uses for this code base and quad code can use it on your bath.

**[10:52 → 11:04]** There's a few common workflows. And this is the one that I talked about already. So kind of do a little bit of exploration, do a little bit of planning and ask me for confirmation before you start to write code.

**[11:04 → 11:16]** These other two on the right are extremely powerful. When cloud has some way to check its work. So for example, by writing unites or screen shotting and puppeteer or screen shotting the iOS simulator.

**[11:16 → 11:28]** Then it can iterate. And this is incredible because if you give it, for example, a mock and you say build this web UI, it'll get it pretty good. But if you had to iterate two or three times, often it gets it almost perfect.

**[11:28 → 11:37]** So the trick is give it some sort of tool that it can use for feedback to check its work. And then based on that, it will iterate by itself and you're going to get a much better result.

**[11:37 → 11:51]** So whatever your domain is, if it's unites or integration test or screenshots for apps or web or anything, just give it a way to see its result and it'll iterate and get better.

**[11:51 → 12:02]** So these are the next steps teach cloud how to use your tools and figure out the right workflow. If you want quad to jump in a code, if you wanted to brainstorm a little bit, make a plan, if you wanted to iterate, kind of have some sense of that.

**[12:02 → 12:24]** So you know how to prompt quad to do what you want. As you go deeper, beyond tools, you want to start to give cloud more context. And the more context, the smarter the decisions will be because as an engineer working in a code base, you have a ton of context in your head about your systems and all the history and everything else. So you, there's different ways to give this to quad.

**[12:24 → 12:36]** And as you give cloud more context, it will do better. There's different ways to do this. The simplest one is what we call quad M D and cloud dot M D is the special file name.

**[12:36 → 12:51]** The simplest place to put it is in the project route. So the same director, you start quad in, put a quad M D in there and that will get automatically read into context at the start of every session. And essentially the first user turn will include the quad M D.

**[12:51 → 13:03]** And this one you don't usually check into source control. So, you should check into source control, share with your team so that you can read it once and share it with your team.

**[13:03 → 13:18]** This one you don't check in. It's just for you. The kinds of things you put in quad M D. It's like common bash commands, common MCP tools, architectural decisions, important files, anything that you would kind of typically need to know in order to work in this code base.

**[13:18 → 13:35]** And I keep it pretty short because if it gets too long, it's just going to use up a bunch of context and it's usually not that useful. So just try to keep it as short as you can. And for, for example, in our code base, we have common bash commands, we have a style guide, we have a few core files, kind of things like that.

**[13:35 → 13:54]** So, you can put them in other nested child directories and cloud will pull them in on demand. So, these are the quad M D's that will get pulled in automatically. But then also you can put in put quad M D's in nested directories and those will get put those will get automatically pulled when cloud works in those directories.

**[13:54 → 14:05]** And of course, if you're a company, maybe you want a quad M D that shared across all the different code bases and you want to manage it on behalf of your users and you can put in your enterprise route and that will get pulled in automatically.

**[14:08 → 14:18]** There's a ton of ways to pull in context. I actually had a lot of trouble putting this fight together just to communicate the breadth of ways you can do this. But, quad M D is pulled in automatically.

**[14:18 → 14:34]** And we also use slash commands. So, this is dot quad slash commands and this can be in your home directory or it can be checked into your project and this is for slash commands. And over here, we have a few examples of the slash commands that we have in cloud code itself.

**[14:34 → 14:43]** And so, for example, if you're in the cloud code repo and you see issues getting labeled, that's actually this workflow running here. It's label GitHub issues.

**[14:43 → 14:56]** And we have a GitHub action running, the same one we talked about this morning, where quad code will run this command and it's just a slash command, it'll run and it'll label the issues so humans don't have to. It just saves us a bunch of time.

**[14:56 → 15:09]** And of course, you can add mentioned files to pull them into context. And like I said before, quad M D's in nested directory get pulled in when quad works in that directory.

**[15:09 → 15:33]** So, give quad more context and it's definitely worth taking the time to tune context. You can run it through a prompt and proveer, consider who the context is for if you want to pull it in every time, if you want to pull it in on demand, if you want to share it with the team, if it's a personal preference, definitely take the time to tune it. This will improve performance dramatically if you do it right.

**[15:33 → 15:48]** And if you're advanced, you're going to want to think about this a little bit more of this kind of hierarchy of different ways to pull in everything. So like not just quad M D, but also config and kind of everything about quad, you can pull in in this hierarchical way.

**[15:48 → 15:54]** So projects are specific to your Git repo and this you can check in or you can make it just for you.

**[15:54 → 16:05]** And you can have global configs that are across all your projects or you can have enterprise policies. And this essentially a global config that you roll out for all of your employees, everyone on your team automatically.

**[16:05 → 16:20]** And this slide is like pretty information dense, but the point is this applies to a lot of stuff. So you can do this for splash commands, you can do it for permissions. So for example, if you have a batch command that you would run for all your employees, like all your employees use this like test command, for example.

**[16:20 → 16:34]** And then you just check it into this enterprise policies file. And then any employee when they run this command, it will be auto approved, which is pretty convenient. And you can also use this to block commands. So for example, let's say there's a URL that should never be fetched.

**[16:34 → 16:41]** Just add it to this config and that'll make it so an employee cannot override it. And that that your role can never be fetched.

**[16:41 → 16:46]** And then you can also just keep your code base safe.

**[16:46 → 17:01]** And then same thing for mcp servers, have a mcp JSON file, check it into the code base that way any time someone runs quad code in your code base, they'll be prompted to install the mcp servers and share it with the team.

**[17:01 → 17:10]** So I'm not sure which of these to use. This is like a kind of an insane matrix because we support a lot of stuff and engineer workflows are very flexible in every company's difference. We kind of want to support everything.

**[17:10 → 17:15]** So if you're not sure how to get started, I would recommend start with shared project context.

**[17:15 → 17:26]** You write this once and then you share it with everyone on the team and you get this kind of network effect where you know someone does a little bit of work and everyone on the team benefits.

**[17:26 → 17:35]** So I'm going to use tools built into quad to manage this. So as an example, if you run slash memory, you can see all the different memory files that are getting pulled in.

**[17:35 → 17:45]** So maybe I have a enterprise policy, I have my user memory, I have project, quad Md, and then maybe there's a nested, quad Md. That's only pulled in for certain directories.

**[17:45 → 17:57]** So in summary, when you do slash memory, you can edit particular memory files when you type pound sign to remember something you can pick which memory you wanted to go to.

**[17:57 → 18:00]** So yeah, that's the next step. Take the time to configure.

**[18:00 → 18:10]** Quad Md, mcp servers, all the stuff that your team uses so that you can use it once configure once and then share it with everyone.

**[18:10 → 18:18]** An example of this is in our apps repo for anthropic. This is like the repo that we have all of our web and apps code in.

**[18:18 → 18:36]** There's a puppeteer mcp server and we share this with the team. And there's a mcp json check then. So any engineer working that repo can use puppeteer in order to pilot and to went us and to screenshot automatically and iterate so that every engineer doesn't have to install with themselves.

**[18:36 → 18:48]** This is a talk about pro tips. I just want to take a quick interview to talk about some common key bindings that people may not know. It's very hard to build for terminal. It's also very fun. It feels like rediscovering this new design language.

**[18:48 → 19:00]** But something about terminals is it's extremely minimal. And so sometimes it's hard to discover these key bindings and here's just a quick reference sheet. So anytime you can hit shift tab to accept edits.

**[19:00 → 19:08]** And this switches you into auto accept edits mode. So bash commands to need approval, but edits are auto accepted. And you can always ask quad to undo them later.

**[19:08 → 19:18]** For example, I'll do this if I know quads on the ray track or if it's writing unit tests and iterating on tests. I'll usually just switch into auto accept mode. So I don't have to okay every single edit.

**[19:18 → 19:31]** Any time you want cloud to remember something. So for example, if it's not using a tool correctly and you wanted to use it correctly from the non just type the pound sign and then tell it what to remember and it'll remember it will incorporate it into quad md automatically.

**[19:31 → 19:41]** If you ever want to drop down to bash mode, so just run a bash command. You can hit the exclamation mark and type in your command that'll run locally, but that also goes into the context window.

**[19:41 → 19:54]** So quad will see it on the next turn. And this is pretty good for long running commands if you know exactly what you want to do or any command that you want to get into context and quad will see the command and the output.

**[19:54 → 20:05]** You can add mentioned thousand folders anytime you can hit escape to stop what quad is doing no matter what what is doing you can always say if we hit escape. It's not going to crop the session. It's not going to mess anything up.

**[20:05 → 20:20]** If you quad is doing a file edit, I'll hit escape. I'll tell it what to do differently or maybe it suggested a twenty line edit and I'm like actually 19 of these lines with perfect but one line you should change. I'll hit escape. I'll tell it that and then I'll tell it to redo that.

**[20:20 → 20:31]** You can hit escape twice to jump back in history. And then after you're done with the session, you can start cloud with the resume to resume that session if you want or dash dash continue.

**[20:31 → 20:44]** Any time if you want to see more output hit controller and that'll show you the entire output the same thing that plot season its context window.

**[20:44 → 20:55]** The next thing I want to talk about is the cloud code SDK. So we talked about this at the top right after this. Say it is doing a session. I think just across the hallway and he's going to go super deep on the SDK.

**[20:55 → 21:06]** If you use the dash p flag and cloud, this is what the SDK is. And we've been waiting a bunch of features over the last few weeks to make it even better.

**[21:06 → 21:13]** So yeah, you can build on top of this. You can do cool stuff. This is exactly the thing that cloud code uses. It's exactly the same SDK.

**[21:13 → 21:24]** And so for example, something you can do is cloud dash p. So this is the the CLI SDK. You can pass up. You can pass a prompt. You can pass some allowed tools which could include specific batch commands.

**[21:24 → 21:31]** And you can tell which format you want. So you might want JSON or you might want streaming JSON. If you want to process this somehow.

**[21:31 → 21:49]** So this is awesome for building on. We use this in CI all the time. We use this for incident response. We use this in all sorts of pipelines. So really convenient. Just think of it as like a unique utility. You give it a prompt. It gives you JSON. You can use this in any way. You can pipe into it. You can pipe out of it.

**[21:50 → 21:58]** The piping is also pretty cool. So you can use like, for example, Git status and pipe this in and you know, use jq to select the result.

**[21:58 → 22:08]** The combinations are endless. And it's sort of this new idea. It's like a super intelligent, unique utility. And I think we barely scratch the surface of how to use this. We're just figuring this out.

**[22:09 → 22:16]** You can read from like a GCP bucket, read, you know, like a giant log and pipe it in and tell cloud to figure out what's interesting about this log.

**[22:16 → 22:23]** You can fetch data from like the century CLA. You can also pipe it in and have cloud do something about it.

**[22:23 → 22:33]** The final thing, and this is probably like the most advanced use cases we see, I'm sort of a quad-normy.

**[22:33 → 22:40]** So I'll have usually like one cloud running at a time and maybe I'll have like a few terminal tabs for a few different repos running at a time.

**[22:40 → 22:43]** When I look at power users in and out of entropic.

**[22:43 → 22:49]** Almost always they're going to have like SSH sessions. They'll have like Tmux tunnels into their cloud sessions.

**[22:50 → 22:55]** They're going to have a bunch of checkouts of the same repo so that they can run a bunch of quads in parallel in that repo.

**[22:55 → 22:59]** Or they're using get work trees to have some kind of isolation as they do this.

**[22:59 → 23:07]** And we're actively working on making this easier to use. But for now, like these are some ideas for how to do more work in parallel with quad.

**[23:07 → 23:10]** You can run as many sessions as you want.

**[23:10 → 23:15]** And there's a lot that you can get done in parallel.

**[23:15 → 23:19]** So yeah, that's it. I wanted to also leave some time for Q&A.

**[23:19 → 23:22]** So I think this is the last slide that I have.

**[23:22 → 23:26]** And yeah, if folks have questions, there's Mike's on both sides.

**[23:26 → 23:29]** And yeah, we'd love to answer any questions.

**[23:29 → 23:36]** Thank you.

**[23:36 → 23:44]** I did.

**[23:44 → 23:51]** I did.

**[23:51 → 24:02]** Hey, Boris. Thanks for building a cloud code. And I was wondering what was the hardest implementation, like part of the implementation for you of building it.

**[24:02 → 24:06]** I think there's a lot of tricky parts.

**[24:06 → 24:12]** I think one part that is especially tricky is the things that we do to make bash command safe.

**[24:12 → 24:17]** Bash is inherently pretty dangerous and it can change system state in unexpected ways.

**[24:17 → 24:24]** But at the same time, if you have to manually approve every single bash command, it's super annoying as an engineer.

**[24:24 → 24:28]** And you can't really be productive because you're constantly proving every command.

**[24:28 → 24:34]** And just kind of navigating how to do this safely in a way that that scales across the different kinds of code bases people have.

**[24:34 → 24:39]** Everyone runs their code in a Docker container was pretty tricky.

**[24:39 → 24:42]** And essentially the thing we landed on is there's some commands that are read only.

**[24:42 → 24:47]** There's some static analysis that we do in order to figure out which commands can be combined in safe ways.

**[24:47 → 24:56]** And then we have this pretty complex tiered permission system so that you can allow us to block with commands at different levels.

**[24:56 → 25:08]** You mentioned giving an image to cloud code which made me wonder if there's some sort of multi model functionality that I'm not aware of is that are you just pointing it at an image on the file system or something.

**[25:08 → 25:15]** Yeah, so quad code is fully multi model. It has been from the start. It's in a terminal. So it's a little hard to discover.

**[25:15 → 25:21]** But yeah, you can take a image and just drag and drop it in that will work. You can give it a file path that will work.

**[25:21 → 25:26]** You can copy and paste the image in and that works too.

**[25:26 → 25:32]** So I'll use this pretty often for if I have like a mock of something I'll just drag and drop drop in the mock I'll tell it to implement it.

**[25:32 → 25:39]** I'll give it up a tier server so it can iterate against it. And yeah, it's just fully automated.

**[25:39 → 25:46]** Hey, why did you build a CLI tool instead of an IDE?

**[25:46 → 26:00]** I think there's probably two reasons. One is we started this adentropic and adentropic people use a broad range of IDs and some people use VS code other people used said or X code or VAM or EMAX.

**[26:00 → 26:06]** And it was just hard to build something that works for everyone. And so terminal is just a common denominator.

**[26:06 → 26:18]** And the second thing is adentropic. We see up close how fast the model is getting better. And so I think there's a good chance that by the end of the year people aren't using IDs anymore.

**[26:18 → 26:34]** And so we want to get ready for this future and we want to avoid over investing in UI and other layers on top given that the way the models are progressing it just it may not be useful work pretty soon.

**[26:34 → 26:46]** How much of you? I don't know if this is is this on. How much of you use code for machine learning modeling almost that auto ML experience. I was curious what the experience has been so far with that.

**[26:46 → 26:52]** Yeah, I think I think the question was how much are we using quad code for machine learning and modeling.

**[26:52 → 27:04]** We actually use it for this a bunch. So both engineers and researchers adentropic use quad code every day. I think about 80% of people adentropic that are technical use quad code every day.

**[27:04 → 27:09]** And hopefully you can see that in the product and the kind of the amount of love and dog fooding we've put into it.

**[27:09 → 27:15]** But this includes researchers who use tools like the notebook notebook tool to edit and run notebooks.

**[27:15 → 27:18]** Thank you.

**[27:18 → 27:22]** All right. That's it. Thanks.

**[27:45 → 27:52]** Thank you.

---

## 完整純文字

Hello, everyone. I'm Boris. I'm a member of technical staff here at Anthropic, and I created quad code. And here to talk to you a little bit about some practical tips and tricks for using quad code. It's going to be very practical. I'm not going to go too much into the history or the theory or anything like this. And before we start, can we get a quick show of hands who is used quad code before? Yeah. That's what we like to see. For everyone that didn't raise your hands, I know you're not supposed to do this while people are talking. But if you can open your laptop and type this. And this will help you install quad code just so you can follow along for the rest of the talk. Oh, you need is no JS if you have it that should work. Yeah, if you don't have to follow along, but if you don't have it yet, this is your chance to install it so you can follow along. So what is quad code? Quad code is a new kind of AI assistant. And there's been different generations of AI assistants for coding. Most of them have been about completing like a line at a time, completing a few lines of code at a time. Quad code is not for that. It's fully agentic. So it's meant for building features for writing entire functions, entire files, fixing entire bugs at the same time. And what's kind of cool about quad code is it works with all of your tools. And you don't have to change out your workflow. You don't have to swap everything to start using it. So whatever IDE use if you use VS code or if you use X code or if you use JetBrains IDs. There's some people out on the topic that you can't pry them from their cold dead hands, but they use quad code because quad code works with every single ID, every terminal out there. It will work locally over remote SSH over team apps, whatever environment you're in, you can run it. It's general purpose. And this is something where if you haven't used these kind of free form coding assistants in the past, it can be kind of hard to figure out how to get started because you open it up and you just see a prompt bar and you might wonder, like, what do I do this? What do I type in? It's a power tool so you can use it for a lot of things, but also because it can do so much, we don't try to guide you towards a particular workflow because really you should be able to use it however you want as an engineer. As you open up quad code for the first time, there's a few things that we recommend doing to get your environments set up. And these are pretty straightforward. So run terminal setup, this will give you shift enter for new lines. So you don't have to do like backslashes, enter new lines. This is, you know, it makes it a little bit nicer to use. Do slash theme to set light mode or dark mode or Daltonized themes. You can do slash install GitHub app. So today, when we announced a GitHub app where you can add mention, a cloud on any GitHub issue or a poor request. So to install it, just run this command in your terminal. You can customize the set of allowed tools that you can use so you're not prompted for it every time. This is pretty convenient for stuff that I'm prompted about a bunch. I'll definitely customize it in this way so I don't have to accept it every time. And something that I actually do is for a lot of my prompts, I won't hand type them into a quad code. If you're on macOS, you can go into your system settings under accessibility is dictation and you can enable it. And so something I do is you just hit like the dictation key twice and you can just speak your prompt. And it helps a lot to have specific prompts. So this is actually pretty awesome. You can just talk to quad code and like you would another engineer and you don't have to type a lot of code. So when you're starting out with cloud code, it's so freeform and it can do everything. What do you start with? The thing I recommend above everything else is starting with code based Q&A. So just asking your question asking questions here code base. This is something that we teach new hires at Anthropic. So on the first day in technical onboarding you learn about cloud code, you download it, you get it set up. And then you immediately start asking questions about the code base. And in the past when you're doing technical onboarding, it's something that taxes the team a lot. Right, you have to ask other engineers on the team questions. You have to look around the code and this takes a while. You have to figure out how to use the tools that this takes a long time. With cloud code, you can just ask cloud code and it'll explore the code base. It'll answer these kind of questions. And so at Anthropic onboarding used to take about two or three weeks for technical hires. It's now about two or three days. What's also kind of cool about Q&A is we don't do any sort of indexing. So there's no remote database with your code. We don't upload it anywhere. Your code stays vocal. We do not train gendered of models on the code. So it's there. You control it. There's no indices or anything like this. And what that means is also there's no setup. So you start cloud, you download it, you start it. There's no indexing. You don't have to wait. You can just use it right away. This is a technical talk. So I'm going to show some very specific prompts and very specific code samples that you can use and hopefully improve and upload where your cloud code experience. So some kind of questions that you can ask is, you know, how is this particular piece of code used or how do I instantiate this thing and cloud code won't just do like a text search and try to answer this. It will often go a level deeper and it will try to find examples of how is this class instantiated, how is it used. And it'll give you a much deeper answer. So something that you would get out of a week year documentation instead of just like command F. Something that I do a lot also is ask it about get history. So for example, you know, why does this function have 15 arguments and why are the arguments named this weird way. And this is something I bet in all of our code basis. You have some function like this or some class like this. And cloud code can look through get history and it'll look to figure out how did these arguments get introduced and who introduced them and what was the situation. What are the issues that those commits linked to. And it'll look through all this and summarize it and you don't have to tell it that in all these in all this detail. You just ask it. So just say look through get history and I don't know to do this. The reason it knows by the way is not because we prompted it to there's nothing in the system prompt about looking through get history. It knows it because the model was awesome. And if you tell it to use get it don't know how to use get. So we're lucky to be building on such a good model. I often ask about GitHub issues. So you know, I can use web fetch and they can fetch issues and work up context on issues too. And this is pretty awesome. And this is something that I do every single Monday in our weekly stand up is I ask what did I ship this week and quad code looks the log knows my username and it'll just give me a nice read out everything I shipped. And I'll just copy and paste that into a docs. So yeah, that's tip number one for people that have not used quad code before if you're just showing it to someone for the first time on boarding your team. The thing we definitely recommend is start with code base Q&A. Don't start by using fancy tools. Don't start by editing code. Just start by asking questions about the code base and that'll teach people how to prompt. And it'll start teaching them this boundary of like what can quad code do. What is it capable of versus what do you need to hold this hand with a little bit more. What can be one shot it what can be two shot it three shot it what do you need to use interactive mode for an apple. Once you're pretty comfortable with Q&A you can dive into editing code. This is the next thing. And the cool thing about any sort of agentic, you know, like using an LM in an agentic ways you give it tools and it is just like magical it figures out how to use the tools. And with quad code we give it a pretty small set of tools. It's not a lot. And so it has a tool to edit files. It has a tool to run bash commands. It has a tool to search files. And it'll string these together to explore the code brainstorm and then finally make edits. And you don't have to prompt it specifically to use this tool and this tool and this tool you just say, you know, do this thing and it'll figure out how to do it. It'll string it together in the right way that makes sense for quad code. There's a lot of ways to use this. Something I like to do sometimes is before having cloud jump in to write code I'll ask it to brainstorm a little bit or make a plan. This is something we highly recommend and something I see sometimes is people, you know, they take quad code and they ask it, hey, implement this enormous like 3000 wine feature. And sometimes it gets this right on the first shot. But sometimes what happens is the thing that it builds is not at all the thing that you want it. And the easiest way to get the result you want is ask it to think first. So brainstorm ideas, make a plan run it by me as for approval before you write code. And you don't have to use plan mode. You don't have to use any special tools to do this. All you have to do is ask log and it'll know to do this. So just say before you write code, make a plan. This is also I want to think with this one this commit push for this is a really common in contation that I use. There's nothing special about it, but quad is kind of smart enough to interpret this so it'll make a commit. It'll push it to the branch make a branch and then make a pull request from young GitHub. You don't have to explain anything. It'll look through the code. It'll look through the history. It'll look through the get log by itself to figure out the commit format and all the stuff. And it'll make the commit and push it the right way. Again, we're not system promising to do this. It just knows how to do this. The model was good. As you get a little bit more advanced, you're going to want to start to plug in your team's tools. And this is where quad code starts to really shine. And there's generally two kinds of tools. So one is bash tools. And an example of this I just made up this like burly CLI. This isn't a real thing. You can tell quad code about this and you can tell it to use for example like dash dash help to figure out how to use it. And this is efficient. If you find yourself using it a lot, you can also dump this into your quad MD, which we'll talk about in a bit. So quad can remember this across sessions. But this is a common pattern we follow at Anthropic and we see external customers use to. And same thing with MCP quad code can use bash tools. You can use MCP tools. So you know, just tell it about the tools and you can add MCP tool and you can tell it how to use it. And it'll just start using it. And this is extremely powerful because when you start to use code on a new code base, you can just give it all of your tools. All the tools your team already uses for this code base and quad code can use it on your bath. There's a few common workflows. And this is the one that I talked about already. So kind of do a little bit of exploration, do a little bit of planning and ask me for confirmation before you start to write code. These other two on the right are extremely powerful. When cloud has some way to check its work. So for example, by writing unites or screen shotting and puppeteer or screen shotting the iOS simulator. Then it can iterate. And this is incredible because if you give it, for example, a mock and you say build this web UI, it'll get it pretty good. But if you had to iterate two or three times, often it gets it almost perfect. So the trick is give it some sort of tool that it can use for feedback to check its work. And then based on that, it will iterate by itself and you're going to get a much better result. So whatever your domain is, if it's unites or integration test or screenshots for apps or web or anything, just give it a way to see its result and it'll iterate and get better. So these are the next steps teach cloud how to use your tools and figure out the right workflow. If you want quad to jump in a code, if you wanted to brainstorm a little bit, make a plan, if you wanted to iterate, kind of have some sense of that. So you know how to prompt quad to do what you want. As you go deeper, beyond tools, you want to start to give cloud more context. And the more context, the smarter the decisions will be because as an engineer working in a code base, you have a ton of context in your head about your systems and all the history and everything else. So you, there's different ways to give this to quad. And as you give cloud more context, it will do better. There's different ways to do this. The simplest one is what we call quad M D and cloud dot M D is the special file name. The simplest place to put it is in the project route. So the same director, you start quad in, put a quad M D in there and that will get automatically read into context at the start of every session. And essentially the first user turn will include the quad M D. And this one you don't usually check into source control. So, you should check into source control, share with your team so that you can read it once and share it with your team. This one you don't check in. It's just for you. The kinds of things you put in quad M D. It's like common bash commands, common MCP tools, architectural decisions, important files, anything that you would kind of typically need to know in order to work in this code base. And I keep it pretty short because if it gets too long, it's just going to use up a bunch of context and it's usually not that useful. So just try to keep it as short as you can. And for, for example, in our code base, we have common bash commands, we have a style guide, we have a few core files, kind of things like that. So, you can put them in other nested child directories and cloud will pull them in on demand. So, these are the quad M D's that will get pulled in automatically. But then also you can put in put quad M D's in nested directories and those will get put those will get automatically pulled when cloud works in those directories. And of course, if you're a company, maybe you want a quad M D that shared across all the different code bases and you want to manage it on behalf of your users and you can put in your enterprise route and that will get pulled in automatically. There's a ton of ways to pull in context. I actually had a lot of trouble putting this fight together just to communicate the breadth of ways you can do this. But, quad M D is pulled in automatically. And we also use slash commands. So, this is dot quad slash commands and this can be in your home directory or it can be checked into your project and this is for slash commands. And over here, we have a few examples of the slash commands that we have in cloud code itself. And so, for example, if you're in the cloud code repo and you see issues getting labeled, that's actually this workflow running here. It's label GitHub issues. And we have a GitHub action running, the same one we talked about this morning, where quad code will run this command and it's just a slash command, it'll run and it'll label the issues so humans don't have to. It just saves us a bunch of time. And of course, you can add mentioned files to pull them into context. And like I said before, quad M D's in nested directory get pulled in when quad works in that directory. So, give quad more context and it's definitely worth taking the time to tune context. You can run it through a prompt and proveer, consider who the context is for if you want to pull it in every time, if you want to pull it in on demand, if you want to share it with the team, if it's a personal preference, definitely take the time to tune it. This will improve performance dramatically if you do it right. And if you're advanced, you're going to want to think about this a little bit more of this kind of hierarchy of different ways to pull in everything. So like not just quad M D, but also config and kind of everything about quad, you can pull in in this hierarchical way. So projects are specific to your Git repo and this you can check in or you can make it just for you. And you can have global configs that are across all your projects or you can have enterprise policies. And this essentially a global config that you roll out for all of your employees, everyone on your team automatically. And this slide is like pretty information dense, but the point is this applies to a lot of stuff. So you can do this for splash commands, you can do it for permissions. So for example, if you have a batch command that you would run for all your employees, like all your employees use this like test command, for example. And then you just check it into this enterprise policies file. And then any employee when they run this command, it will be auto approved, which is pretty convenient. And you can also use this to block commands. So for example, let's say there's a URL that should never be fetched. Just add it to this config and that'll make it so an employee cannot override it. And that that your role can never be fetched. And then you can also just keep your code base safe. And then same thing for mcp servers, have a mcp JSON file, check it into the code base that way any time someone runs quad code in your code base, they'll be prompted to install the mcp servers and share it with the team. So I'm not sure which of these to use. This is like a kind of an insane matrix because we support a lot of stuff and engineer workflows are very flexible in every company's difference. We kind of want to support everything. So if you're not sure how to get started, I would recommend start with shared project context. You write this once and then you share it with everyone on the team and you get this kind of network effect where you know someone does a little bit of work and everyone on the team benefits. So I'm going to use tools built into quad to manage this. So as an example, if you run slash memory, you can see all the different memory files that are getting pulled in. So maybe I have a enterprise policy, I have my user memory, I have project, quad Md, and then maybe there's a nested, quad Md. That's only pulled in for certain directories. So in summary, when you do slash memory, you can edit particular memory files when you type pound sign to remember something you can pick which memory you wanted to go to. So yeah, that's the next step. Take the time to configure. Quad Md, mcp servers, all the stuff that your team uses so that you can use it once configure once and then share it with everyone. An example of this is in our apps repo for anthropic. This is like the repo that we have all of our web and apps code in. There's a puppeteer mcp server and we share this with the team. And there's a mcp json check then. So any engineer working that repo can use puppeteer in order to pilot and to went us and to screenshot automatically and iterate so that every engineer doesn't have to install with themselves. This is a talk about pro tips. I just want to take a quick interview to talk about some common key bindings that people may not know. It's very hard to build for terminal. It's also very fun. It feels like rediscovering this new design language. But something about terminals is it's extremely minimal. And so sometimes it's hard to discover these key bindings and here's just a quick reference sheet. So anytime you can hit shift tab to accept edits. And this switches you into auto accept edits mode. So bash commands to need approval, but edits are auto accepted. And you can always ask quad to undo them later. For example, I'll do this if I know quads on the ray track or if it's writing unit tests and iterating on tests. I'll usually just switch into auto accept mode. So I don't have to okay every single edit. Any time you want cloud to remember something. So for example, if it's not using a tool correctly and you wanted to use it correctly from the non just type the pound sign and then tell it what to remember and it'll remember it will incorporate it into quad md automatically. If you ever want to drop down to bash mode, so just run a bash command. You can hit the exclamation mark and type in your command that'll run locally, but that also goes into the context window. So quad will see it on the next turn. And this is pretty good for long running commands if you know exactly what you want to do or any command that you want to get into context and quad will see the command and the output. You can add mentioned thousand folders anytime you can hit escape to stop what quad is doing no matter what what is doing you can always say if we hit escape. It's not going to crop the session. It's not going to mess anything up. If you quad is doing a file edit, I'll hit escape. I'll tell it what to do differently or maybe it suggested a twenty line edit and I'm like actually 19 of these lines with perfect but one line you should change. I'll hit escape. I'll tell it that and then I'll tell it to redo that. You can hit escape twice to jump back in history. And then after you're done with the session, you can start cloud with the resume to resume that session if you want or dash dash continue. Any time if you want to see more output hit controller and that'll show you the entire output the same thing that plot season its context window. The next thing I want to talk about is the cloud code SDK. So we talked about this at the top right after this. Say it is doing a session. I think just across the hallway and he's going to go super deep on the SDK. If you use the dash p flag and cloud, this is what the SDK is. And we've been waiting a bunch of features over the last few weeks to make it even better. So yeah, you can build on top of this. You can do cool stuff. This is exactly the thing that cloud code uses. It's exactly the same SDK. And so for example, something you can do is cloud dash p. So this is the the CLI SDK. You can pass up. You can pass a prompt. You can pass some allowed tools which could include specific batch commands. And you can tell which format you want. So you might want JSON or you might want streaming JSON. If you want to process this somehow. So this is awesome for building on. We use this in CI all the time. We use this for incident response. We use this in all sorts of pipelines. So really convenient. Just think of it as like a unique utility. You give it a prompt. It gives you JSON. You can use this in any way. You can pipe into it. You can pipe out of it. The piping is also pretty cool. So you can use like, for example, Git status and pipe this in and you know, use jq to select the result. The combinations are endless. And it's sort of this new idea. It's like a super intelligent, unique utility. And I think we barely scratch the surface of how to use this. We're just figuring this out. You can read from like a GCP bucket, read, you know, like a giant log and pipe it in and tell cloud to figure out what's interesting about this log. You can fetch data from like the century CLA. You can also pipe it in and have cloud do something about it. The final thing, and this is probably like the most advanced use cases we see, I'm sort of a quad-normy. So I'll have usually like one cloud running at a time and maybe I'll have like a few terminal tabs for a few different repos running at a time. When I look at power users in and out of entropic. Almost always they're going to have like SSH sessions. They'll have like Tmux tunnels into their cloud sessions. They're going to have a bunch of checkouts of the same repo so that they can run a bunch of quads in parallel in that repo. Or they're using get work trees to have some kind of isolation as they do this. And we're actively working on making this easier to use. But for now, like these are some ideas for how to do more work in parallel with quad. You can run as many sessions as you want. And there's a lot that you can get done in parallel. So yeah, that's it. I wanted to also leave some time for Q&A. So I think this is the last slide that I have. And yeah, if folks have questions, there's Mike's on both sides. And yeah, we'd love to answer any questions. Thank you. I did. I did. Hey, Boris. Thanks for building a cloud code. And I was wondering what was the hardest implementation, like part of the implementation for you of building it. I think there's a lot of tricky parts. I think one part that is especially tricky is the things that we do to make bash command safe. Bash is inherently pretty dangerous and it can change system state in unexpected ways. But at the same time, if you have to manually approve every single bash command, it's super annoying as an engineer. And you can't really be productive because you're constantly proving every command. And just kind of navigating how to do this safely in a way that that scales across the different kinds of code bases people have. Everyone runs their code in a Docker container was pretty tricky. And essentially the thing we landed on is there's some commands that are read only. There's some static analysis that we do in order to figure out which commands can be combined in safe ways. And then we have this pretty complex tiered permission system so that you can allow us to block with commands at different levels. You mentioned giving an image to cloud code which made me wonder if there's some sort of multi model functionality that I'm not aware of is that are you just pointing it at an image on the file system or something. Yeah, so quad code is fully multi model. It has been from the start. It's in a terminal. So it's a little hard to discover. But yeah, you can take a image and just drag and drop it in that will work. You can give it a file path that will work. You can copy and paste the image in and that works too. So I'll use this pretty often for if I have like a mock of something I'll just drag and drop drop in the mock I'll tell it to implement it. I'll give it up a tier server so it can iterate against it. And yeah, it's just fully automated. Hey, why did you build a CLI tool instead of an IDE? I think there's probably two reasons. One is we started this adentropic and adentropic people use a broad range of IDs and some people use VS code other people used said or X code or VAM or EMAX. And it was just hard to build something that works for everyone. And so terminal is just a common denominator. And the second thing is adentropic. We see up close how fast the model is getting better. And so I think there's a good chance that by the end of the year people aren't using IDs anymore. And so we want to get ready for this future and we want to avoid over investing in UI and other layers on top given that the way the models are progressing it just it may not be useful work pretty soon. How much of you? I don't know if this is is this on. How much of you use code for machine learning modeling almost that auto ML experience. I was curious what the experience has been so far with that. Yeah, I think I think the question was how much are we using quad code for machine learning and modeling. We actually use it for this a bunch. So both engineers and researchers adentropic use quad code every day. I think about 80% of people adentropic that are technical use quad code every day. And hopefully you can see that in the product and the kind of the amount of love and dog fooding we've put into it. But this includes researchers who use tools like the notebook notebook tool to edit and run notebooks. Thank you. All right. That's it. Thanks. Thank you.