---
title: "How and when to use subagents in Claude Code"
url: https://claude.com/blog/subagents-in-claude-code
slug: subagents-in-claude-code
fetched: 2026-04-13 01:11 UTC
---

# How and when to use subagents in Claude Code

> Source: https://claude.com/blog/subagents-in-claude-code



Try ClaudeTry ClaudeTry Claude
- BlogBlog/
- How and when to use subagents in Claude CodeExplore here
- 
Ask questions about this page
- 
Copy as markdown
# How and when to use subagents in Claude Code
A practical guide to Claude Code subagents: when they help, how to direct them, and the signals that tell you delegation is worth it.
.button_main_icon {
  transition: color 300ms ease;
}
.button_main_wrap:hover .button_main_icon {
  color: var(--_button-style---icon-hover); 
}
.button_main_wrap:focus-within .button_main_icon {
  color: var(--_button-style---text-hover) !important;
}
.button_main_wrap:focus-within {
  color: var(--_button-style---text-hover) !important;
}
.button_main_icon {
  transition: color 300ms ease;
}
.button_main_wrap:hover .button_main_icon {
  color: var(--_button-style---icon-hover); 
}
.button_main_wrap:focus-within .button_main_icon {
  color: var(--_button-style---text-hover) !important;
}
.button_main_wrap:focus-within {
  color: var(--_button-style---text-hover) !important;
}
- 
CategoryClaude Code
- 
ProductClaude Code
- 
DateApril 7, 2026
- 
Reading time5min
- 
ShareCopy linkhttps://claude.com/blog/subagents-in-claude-code
Claude Code handles complex, multi-step projects well, but long sessions accumulate weight. Every file read, every tangent explored, every half-finished thought stays in the context window, slowing responses and driving up token costs.
Consider building a new feature in a large TypeScript monorepo. The main work is the implementation, but side tasks keep appearing: trace how an existing service handles auth, find the shared util for date formatting, check whether the design system already has a component close to what you need. None of these need the full project context, and running them inside the main session adds noise. What if you could run them in parallel?
Enter subagents. A subagent is an isolated Claude instance with its own context window. It takes a task, does the work, and returns only the result. Think of subagents as the browser tabs of a Claude Code session: a place to chase a tangent without losing the main thread.
In this article, we discuss when it makes sense to use subagents, how to invoke them, and when the overhead isn&#x27;t worth it.
## What is a subagent? 
Subagents are self-contained agents that operate with their own context windows. When Claude spawns a subagent, that assistant works independently to read files, explore code, or make changes. When it completes its task, the subagent returns only the relevant results to the main conversation.
Each subagent starts fresh, unburdened by the history of the conversation or invoked skills. Multiple subagents can run in parallel, and each can have different permissions: a research subagent might have read-only access, while an implementation subagent gets full editing capabilities.
Claude Code includes several built-in subagent types, including:
- General-purpose agents for complex multi-step tasks
- Plan agents that research codebases before presenting implementation strategies
- Explore agents optimized for fast, read-only code search 
Claude Code often spawns subagents on its own to handle assigned tasks. It&#x27;s also possible to direct that behavior explicitly and to define reusable specialists that Claude delegates to automatically. Knowing when to reach for subagents is what makes the feature useful. 
## When should you use subagents? 
Certain categories of work benefit clearly from subagent delegation. Learning to recognize them makes the feature far more effective.
### Research-heavy tasks
When understanding how something works is a prerequisite to changing it, a subagent can explore the codebase and return a summary rather than dumping dozens of files into the conversation.
The signal: Gathering context requires reading dozens of files.
The benefit: The main conversation stays clean, and synthesized findings arrive instead of raw content.
### Multiple independent tasks
When fixing errors across several files, updating patterns in multiple components, or making changes that don&#x27;t depend on each other, parallel subagents complete the task faster.
The signal: Sub-tasks have no dependencies between them.
The benefit: Three subagents working simultaneously generally finish the task in less time.
### Fresh perspective needed
When an unbiased review of an implementation is the goal, a subagent provides a clean slate because it doesn&#x27;t inherit the assumptions, context, or blind spots from the primary conversation.
The signal: Verification is needed without conversation history influencing the analysis.
The benefit: Cleaner, more objective feedback.
Pro-tip: The /clear command also resets context and conversation history, providing a similarly unbiased slate, but at the cost of losing that history entirely. A subagent achieves the same fresh perspective while the main conversation stays intact.
### Verification before committing
Before finalizing changes, an independent subagent can verify the implementation isn&#x27;t overfitting to tests or missing edge cases.
The signal: A second opinion is warranted before committing code.
The benefit: Catches issues that familiarity with the code might obscure.
### Pipeline workflows
When a task has distinct phases (i.e., design, then implement, then test), each stage benefits from focused attention.
The signal: Sequential stages with clear handoffs.
The benefit: Each subagent concentrates on its phase, without context from other stages creating noise.
‍Pro-tip: When a task requires exploring ten or more files, or involves three or more independent pieces of work, that&#x27;s a strong signal to direct Claude toward subagents.
## How to direct subagent usage
Several methods exist for invoking subagents, ranging from simple conversation to automated workflows. The right starting point depends on the workflow, and sophistication can be layered on as patterns emerge.
### Conversational invocation
The most flexible approach is simply asking Claude to use subagents in conversation. This works across all Claude Code interfaces: terminal, VS Code, JetBrains, the web, and desktop applications. 
Natural language patterns that reliably invoke subagents include:
- "Use a subagent to explore how authentication works in this codebase"
- "Have a separate agent review this code for security issues"
- "Research this in parallel. Check the API routes, database models, and frontend components simultaneously"
- "Spin up subagents to fix these TypeScript errors across the different packages"
Being explicit matters. Specify the scope, request parallel execution when tasks are independent, and describe the desired output.
Here&#x27;s an effective prompt structure:
`Use subagents to explore this codebase in parallel:
1. Find all API endpoints and summarize their purposes
2. Identify the database schema and relationships
3. Map out the authentication flow
Return a summary of each, not the full file contents.`
```
This prompt works because it clearly defines three independent tasks, explicitly requests parallel execution, and specifies the output format. Claude understands the intent and spawns appropriate subagents.
Tips for effective conversational invocation include:
- Scope tasks clearly. "Explore how payments work" beats "explore everything."
- Request parallelization explicitly. Say "these can run in parallel" or "work on all three simultaneously."
- Specify what should be returned. Summaries, specific findings, or recommendations. Naming the output format helps Claude deliver it.
- Ask for fresh context when unbiased analysis matters. "Use a subagent that does not see our previous discussion" ensures clean evaluation.
Pro-tip: When a subagent is taking a while, Ctrl+B sends it to the background. The conversation can continue while it runs, and results surface automatically when it finishes. The /tasks command shows anything running in the background.
### Custom subagents
When the same kind of subagent keeps getting requested (a security reviewer, a test writer, a docs proofreader), it can be defined once as a custom subagent. 
Claude then delegates to it automatically whenever a task matches its description, no prompting required.
Custom subagents live as markdown files in `.claude/agents/ `(project-level, shared with the team) or `~/.claude/agents/ `(user-level, available across all projects). Each one gets its own system prompt, tool permissions, and optionally its own model.
The easiest way to create one is the /agents command, which walks through setup interactively and can generate a first draft from a description. The file can also be written by hand, for example:
`---
name: security-reviewer
description: Reviews code changes for security vulnerabilities,
  injection risks, auth issues, and sensitive data exposure.
  Use proactively before commits touching auth, payments, or user data.
tools: Read, Grep, Glob
model: sonnet
---
You are a security-focused code reviewer. Analyze the provided
changes for:
- SQL injection, XSS, and command injection risks
- Authentication and authorization gaps
- Sensitive data in logs, errors, or responses
- Insecure dependencies or configurations
Return a prioritized list of findings with file:line references
and a recommended fix for each. Be critical. If you find nothing,
say so explicitly rather than inventing issues.`
```
With this in place, Claude routes matching work to the subagent automatically. It can also be invoked by name: "Have the security-reviewer look at the staged changes."
Custom subagents work best when:
- A specialist should be available for Claude to delegate to automatically when a task matches
- The work benefits from a tightly scoped system prompt and restricted tools
- The configuration should be shared across a team or reused across projects
Pro-tip: The description field is what Claude uses to decide when to delegate. Be specific about the trigger conditions, not just the capability. "Reviews code for security issues before commits" routes better than "security expert."
For the full configuration reference, including permission modes and how project and user subagents interact, see our Claude Code subagents docs.
### CLAUDE.md instructions
Custom subagents define who the specialists are. CLAUDE.md files define the rules for when Claude should reach for them. If every code review should go through a read-only subagent, or every architecture question should trigger a research pass first, CLAUDE.md is where that policy lives. Claude reads it at the start of every conversation, so the behavior stays consistent across sessions and teammates without anyone needing to remember to ask.
CLAUDE.md is a good fit for subagent instructions when:
- Code reviews should always use read-only subagents
- The project has specific research patterns Claude should follow
- Consistent behavior is needed across team members and sessions
Here’s an example of a simple CLAUDE.md file that triggers a subagent given specific conditions:
`## Code review standards
When asked to review code, ALWAYS use a subagent with READ-ONLY access
(Glob, Grep, Read only). The review should ALWAYS check for:
- Security vulnerabilities
- Performance issues
- Adherence to project patterns in /docs/architecture.md
Return findings as a prioritized list with file:line references.`
```
With the above CLAUDE.md file, every code review request automatically uses the defined pattern, eliminating the need to specify it each time.
For more on CLAUDE.md files, see Customizing Claude Code for your codebase: setting up a CLAUDE.md file and our Claude Code CLAUDE.md file docs. 
### Skills
For complex multi-step workflows that run repeatedly, skills provide a reusable interface. Define a skill once in .claude/skills/, then invoke it with /skill-name or let Claude load it automatically when a task matches its description.
Skills differ from CLAUDE.md files in scope. CLAUDE.md files are always loaded and shapes every interaction. A skill is loaded on demand, either because it was invoked explicitly or because Claude matched the current task to the skill&#x27;s description field. That makes skills the right place for workflows that should be available but not applied to every prompt.
Skills fit well when:
- Certain actions get run regularly
- Different team members need access to the same complex operation
- Standardizing how certain tasks are performed across the team matters
Here’s an example of a deep-review skill for comprehensive code review:
`# .claude/skills/deep-review/SKILL.md
---
name: deep-review
description: Comprehensive code review that checks security,
  performance, and style in parallel. Use when reviewing staged
  changes before a commit or PR.
---
Run three parallel subagent reviews on the staged changes:
1. Security review - check for vulnerabilities, injection risks,
   authentication issues, and sensitive data exposure
2. Performance review - check for N+1 queries, unnecessary iterations,
   memory leaks, and blocking operations
3. Style review - check for consistency with project patterns
   documented in /docs/style-guide.md
Synthesize findings into a single summary with priority-ranked issues.
Each issue should include the file, line number, and recommended fix.`
```
In the code snippet above, /deep-review triggers a three-part subagent analysis on demand. Because the description mentions reviewing staged changes before commits, Claude can also reach for this skill automatically when that context comes up.
A skill is a directory, not a single file. Alongside `SKILL.md,` it can hold templates Claude fills in, example outputs showing the expected format, or scripts Claude executes as part of the workflow. The legacy `.claude/commands/ `format was a single flat file, so everything had to live in the prompt itself.
For more on using skills with Claude Code, see our Claude Code skills docs.
### Hooks
Hooks are user-defined shell commands, HTTP endpoints, or LLM prompts that execute automatically at specific points in Claude Code&#x27;s lifecycle. Hooks can automate subagent workflows based on events. Hooks trigger on specific actions and run subagent tasks without manual invocation.
Hooks are the right tool when:
- Every commit should be reviewed automatically before it&#x27;s created
- Security checks should run without anyone remembering to ask
- CI-like quality gates belong in the local development process
Here is an example of a Stop hook that blocks Claude from ending its turn until a test is passed:
`{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/check-tests.sh"
          }
        ]
      }
    ]
  }
}`
```
And the script at `.claude/hooks/check-tests.sh`:
`#!/bin/bash
INPUT=$(cat)
STOP_HOOK_ACTIVE=$(echo "$INPUT" | jq -r &#x27;.stop_hook_active // false&#x27;)
# Don&#x27;t loop forever — if we already blocked once this turn, let it through
if [ "$STOP_HOOK_ACTIVE" = "true" ]; then
  exit 0
fi
if ! npm test --silent > /dev/null 2>&1; then
  jq -n &#x27;{
    decision: "block",
    reason: "Tests are failing. Run `npm test` to see the failures and fix them before finishing."
  }&#x27;
  exit 0
fi
exit 0`
```
When Claude finishes its turn, the Stop event fires. The script runs the test suite—if tests fail, it returns JSON with `decision: "block"` and a `reason`. Claude Code reads that, doesn&#x27;t let Claude stop, and feeds the reason back into the conversation as instruction to keep working. The `stop_hook_active` guard at the top prevents infinite loops: if Claude is already continuing because of a previous stop-hook block, the script lets it exit.
Hooks represent the most automated approach to subagent orchestration. Conversational invocation or CLAUDE.md instructions are the better starting point; hooks come later, as workflows mature.
For complete hooks configuration, see Claude Code power user customization: how to configure hooks or our Claude Code hooks docs.
## Practical patterns for using subagents
The following patterns demonstrate subagent direction applied to common scenarios.
### Research before implementing
When adding a feature to unfamiliar code, delegating research to a subagent first keeps the implementation discussion informed rather than exploratory, for example: 
`Before I implement user notifications, use a subagent to research:
- How are emails currently sent in this codebase?
- What notification patterns already exist?
- Where should new notification logic live based on the current architecture?
Summarize findings, then we&#x27;ll plan the implementation together.`
```
A synthesized summary arrives instead of twenty files of raw context, and the implementation discussion starts from a solid foundation.
### Parallel modifications
When the same pattern needs updating across multiple files, parallel subagents finish faster and maintain focus, for example: 
`Use parallel subagents to update the error handling in these files:
- src/api/users.ts
- src/api/orders.ts
- src/api/products.ts
Each should follow the pattern established in src/api/auth.ts.
Work on all three simultaneously.`
```
Three subagents working in parallel complete in roughly the time one would take. Each focuses on its file without context from the others creating confusion or inconsistency.
### Independent review
After implementing something complex, verification from a subagent that hasn&#x27;t been influenced by the implementation journey catches what familiarity obscures, for example: 
`Use a fresh subagent with read-only access to review my implementation of the payment flow. It should not see our previous discussion. I want an unbiased review.
Check for: security vulnerabilities, unhandled edge cases, and error handling gaps. Be critical.`
```
The review subagent evaluates the code without knowing what tradeoffs were considered, what approaches were rejected, or what assumptions were made. This outside perspective surfaces issues the main conversation might miss.
### Pipeline workflow
For multi-stage tasks, chaining subagents with explicit handoffs between phases keeps each stage focused, for example: 
`Let&#x27;s build this feature as a pipeline:
1. First subagent: Design the API contract and write it to docs/api-spec.md
2. Second subagent: Implement the backend endpoints based on that spec
3. Third subagent: Write integration tests for the implementation
Each stage should complete before the next begins. Use the output
files as the handoff mechanism between stages.`
```
Using a pipeline workflow, each stage in the task receives focused context. The design subagent isn&#x27;t distracted by implementation concerns, the implementation subagent works from a clean spec, and the testing subagent evaluates the result independently. 
## When shouldn’t you use subagents? 
While subagents are a useful feature, subagents carry overhead. Each one spins up its own context, consumes tokens, and adds a layer of indirection between the developer and the work. They&#x27;re worth that cost when context isolation, parallelism, or a fresh perspective actually helps. 
For smaller or tightly sequential tasks, sticking to the main conversation is usually simpler, for example: 
- Sequential, dependent work. When step two needs the full output of step one, and step three needs both, a single session handling the chain is usually cleaner than a relay of subagents passing state through files.
- Same-file edits. Two subagents editing the same file in parallel is a recipe for conflict. In this scenario, keep tightly coupled changes in one context window.
- Small tasks. For a quick fix or a focused question, the overhead of delegation outweighs the benefit. Just prompt or ask in your main conversation.  
- Too many specialist agents. It&#x27;s tempting to define a custom subagent for everything, but flooding Claude with options makes automatic delegation less reliable. Most teams settle on a handful of well-scoped agents rather than a sprawling roster.
- Work that needs agents to coordinate with each other. Subagents report back to the main conversation but can&#x27;t talk to one another. For tasks where subagents need to communicate, use agent teams. With agent teams, subagents coordinate across separate sessions rather than within one, which makes them heavier and more expensive. For more guidance on when to use subagents vs Agent Teams, check out our Claude Code agent teams docs.
The signals described earlier (i.e., needing a second opinion, a lack of dependencies between sub-tasks, and extensive research) make it clear when delegation to a subagent is worth it.
## Start conversational, automate later
Subagents deliver their full value when used deliberately. The automatic invocation Claude provides is helpful, but knowing when to delegate research, parallelize work, and request a fresh perspective produces better results than leaving it to chance.
When using subagents, start with conversational prompts. Notice which requests keep occurring and build automation as those patterns clarify. The goal is to make subagent delegation effortless, so your attention stays on the work that matters.
[data-slider-shell]{ display: none; }
[data-slider-track] > [data-slider-card]{
  flex: 0 0 auto;
  width: auto; 
  min-width: 0;
  box-sizing: border-box;
  padding-left: 1rem;
  padding-right: 1rem;
}
[data-slider-prev],
[data-slider-next] {
  transition: opacity 0.3s ease;
}
[data-slider-prev].is-disabled,
[data-slider-next].is-disabled {
  opacity: 0.3;
  pointer-events: none;
  cursor: default;
}
[data-slider-dot] {
    width: 1.75rem;
    justify-content: center;
    display: flex;
    height: 1.75rem;
    align-items: center;
}
[data-slider-dot] span {
	display: block;
  width: 0.3125rem;
  height: 0.3125rem;
  border-radius: 999px;
  background: var(--_theme---border-secondary);
  transition: background 0.3s ease;
}
[data-slider-dot].is-active span {
  background: var(--_theme---foreground-primary);
}
  document.addEventListener("DOMContentLoaded", function () {
    try {
      gsap.registerPlugin(Draggable);
    } catch (e) {
      return;
    }
    if (typeof Draggable === "undefined") return;
    function debounce(fn, wait) {
      let t;
      return (...a) => {
        clearTimeout(t);
        t = setTimeout(() => fn(...a), wait);
      };
    }
    document.querySelectorAll("[data-slider]").forEach(function (root) {
      if (root.dataset.scriptInitialized) return;
      root.dataset.scriptInitialized = "true";
      var viewportConfigs = {
        desktop: { minWidth: 1200, slidesToShow: parseInt(root.getAttribute("data-slider-desktop-threshold")) || 4 },
        tablet: { minWidth: 768, maxWidth: 1199, slidesToShow: parseInt(root.getAttribute("data-slider-tablet-threshold")) || 2 },
        mobile: { maxWidth: 767, slidesToShow: 1 },
      };
      var loopAttr = (root.getAttribute("data-slider-loop") || "").toLowerCase();
      var centerAttr = (root.getAttribute("data-slider-center") || "").toLowerCase();
      var LOOP = loopAttr === "true" || loopAttr === "1" || loopAttr === "";
      var CENTER_MODE = centerAttr === "true" || centerAttr === "1";
      var grid = root.querySelector("[data-slider-grid]");
      var shell = root.querySelector("[data-slider-shell]");
      var viewport = shell && shell.querySelector("[data-slider-viewport]");
      var track = shell && shell.querySelector("[data-slider-track]");
      var prevBtn = shell && shell.querySelector("[data-slider-prev]");
      var nextBtn = shell && shell.querySelector("[data-slider-next]");
      var controls = shell && shell.querySelector("[data-slider-controls]");
      var dotsWrap = shell && shell.querySelector("[data-slider-dots]");
      var mobileActive = shell && shell.querySelector("[data-slider-mobile-active]");
      var mobileTotal = shell && shell.querySelector("[data-slider-mobile-total]");
      if (!grid || !shell || !viewport || !track) return;
      try {
        viewport.style.touchAction = "pan-y";
      } catch (e) {}
      var cards = Array.prototype.slice.call(grid.querySelectorAll("[data-slider-card]"));
      if (!cards.length) return;
      var placeholders = new Map();
      cards.forEach(function (card) {
        var m = document.createComment("card-slot");
        card.parentNode.insertBefore(m, card);
        placeholders.set(card, m);
      });
      var currentMode = "grid";
      var currentApi = null;
      var currentConfig = null;
      var activeIndex = 0;
      var originalLength = cards.length;
      var resizeObserver = null;
      function updateActiveSlide(currentSlide) {
        Array.prototype.slice.call(track.querySelectorAll("[data-slider-card]")).forEach(function (s) {
          s.classList.remove("is-active");
        });
        (currentSlide || cards[activeIndex]) && (currentSlide || cards[activeIndex]).classList.add("is-active");
      }
      function getViewportConfig() {
        var w = window.innerWidth;
        if (w >= viewportConfigs.desktop.minWidth) return { key: "desktop", config: viewportConfigs.desktop };
        if (w >= viewportConfigs.tablet.minWidth) return { key: "tablet", config: viewportConfigs.tablet };
        return { key: "mobile", config: viewportConfigs.mobile };
      }
      function shouldUseSlider() {
        var vp = getViewportConfig();
        return cards.length > vp.config.slidesToShow;
      }
      function moveCardsToTrack() {
        cards.forEach(function (c, i) {
          c.setAttribute("data-slider-origin-index", String(i));
          track.appendChild(c);
        });
        grid.style.display = "none";
      }
      function moveCardsBackToGrid() {
        Array.prototype.slice.call(track.querySelectorAll('[data-slider-clone="true"]')).forEach(function (n) {
          n.remove();
        });
        cards.forEach(function (c) {
          var m = placeholders.get(c);
          if (m && m.parentNode) m.parentNode.insertBefore(c, m);
          c.classList.remove("is-active");
        });
        gsap.set(cards, { clearProps: "all" });
        gsap.set(track, { clearProps: "all" });
        grid.style.display = ""; // 👈 show grid again
      }
      function ensureDots(count) {
        if (!dotsWrap) {
          dotsWrap = document.createElement("div");
          dotsWrap.setAttribute("data-slider-dots", "");
          (controls || shell).appendChild(dotsWrap);
        }
        if (dotsWrap.childElementCount !== count) {
          dotsWrap.innerHTML = "";
          var frag = document.createDocumentFragment();
          for (var i = 0; i < count; i++) {
            (function (ii) {
              var b = document.createElement("button");
              b.type = "button";
              b.setAttribute("data-slider-dot", "");
              b.setAttribute("aria-label", "Go to item " + (ii + 1));
              var span = document.createElement("span");
              b.appendChild(span);
              b.addEventListener("click", function () {
                currentApi && currentApi.toIndex(ii, { duration: 0.5, ease: "power1.inOut" });
              });
              frag.appendChild(b);
            })(i);
          }
          dotsWrap.appendChild(frag);
        }
        dotsWrap.style.display = LOOP ? "" : "none";
        updateDots();
      }
      function updateDots() {
        if (!dotsWrap || !LOOP) return;
        Array.prototype.slice.call(dotsWrap.querySelectorAll("[data-slider-dot]")).forEach(function (d, i) {
          var on = i === activeIndex;
          d.classList.toggle("is-active", on);
          d.setAttribute("aria-current", on ? "true" : "false");
        });
      }
      function updateMobileCounter() {
        if (mobileActive) mobileActive.textContent = String(activeIndex + 1);
        if (mobileTotal) mobileTotal.textContent = String(originalLength);
      }
      function setBtnState(btn, disabled) {
        if (!btn) return;
        btn.disabled = !!disabled;
        btn.classList.toggle("is-disabled", !!disabled);
        btn.setAttribute("aria-disabled", disabled ? "true" : "false");
      }
      function updateButtonsState() {
        if (!currentConfig) return;
        if (LOOP) {
          setBtnState(prevBtn, false);
          setBtnState(nextBtn, false);
          return;
        }
        var maxIndex = Math.max(0, originalLength - currentConfig.slidesToShow);
        setBtnState(prevBtn, activeIndex <= 0);
        setBtnState(nextBtn, activeIndex >= maxIndex);
      }
      function showControls(show) {
        if (controls) controls.style.display = show ? "" : "none";
      }
      function initializeSlider() {
        var vp = getViewportConfig();
        currentConfig = vp.config;
        if (currentApi) {
          currentApi.kill && currentApi.kill();
          currentApi = null;
        }
        gsap.set(track, { clearProps: "all" });
        gsap.set(cards, { clearProps: "all" });
        shell.style.display = "block";
        moveCardsToTrack();
        track.style.display = "flex";
        track.style.flexWrap = "nowrap";
        track.style.willChange = "transform";
        gsap.set(track, { x: 0, xPercent: 0 });
        requestAnimationFrame(() => {
          requestAnimationFrame(() => {
            if (LOOP) addClonesForLooping();
            ensureDots(originalLength);
            currentApi = LOOP ? buildLoopingSlider() : buildLinearSlider(currentConfig);
            prevBtn && prevBtn.addEventListener("click", onPrev);
            nextBtn && nextBtn.addEventListener("click", onNext);
            showControls(true);
            updateButtonsState();
            currentMode = "slider";
          });
        });
      }
      function initializeGrid() {
        if (currentApi) {
          currentApi.kill && currentApi.kill();
          currentApi = null;
        }
        prevBtn && prevBtn.removeEventListener("click", onPrev);
        nextBtn && nextBtn.removeEventListener("click", onNext);
        shell.style.display = "none";
        moveCardsBackToGrid();
        showControls(false);
        currentMode = "grid";
        currentConfig = null;
      }
      function evaluateAndUpdate() {
        var needs = shouldUseSlider();
        var vp = getViewportConfig();
