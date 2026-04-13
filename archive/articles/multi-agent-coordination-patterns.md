---
title: "Multi-agent coordination patterns: Five approaches and when to use them"
url: https://claude.com/blog/multi-agent-coordination-patterns
slug: multi-agent-coordination-patterns
fetched: 2026-04-13 01:11 UTC
---

# Multi-agent coordination patterns: Five approaches and when to use them

> Source: https://claude.com/blog/multi-agent-coordination-patterns



Try ClaudeTry ClaudeTry Claude
- BlogBlog/
- Multi-agent coordination patterns: Five approaches and when to use themExplore here
- 
Ask questions about this page
- 
Copy as markdown
# Multi-agent coordination patterns: Five approaches and when to use them
Five multi-agent coordination patterns, their trade-offs, and when to evolve from one to another.
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
CategoryAgents
- 
ProductClaude Platform
- 
DateApril 10, 2026
- 
Reading time5min
- 
ShareCopy linkhttps://claude.com/blog/multi-agent-coordination-patterns
In an earlier post, we explored when multi-agent systems provide value and when a single agent is the better choice. This post is for teams that have made that call and now need to decide which coordination pattern fits their problem.
We&#x27;ve seen teams choose patterns based on what sounds sophisticated rather than what fits the problem at hand. We recommend starting with the simplest pattern that could work, watching where it struggles, and evolving from there. This post examines the mechanics and limitations of five patterns:
- Generator-verifier, for quality-critical output with explicit evaluation criteria
- Orchestrator-subagent, for clear task decomposition with bounded subtasks
- Agent teams, for parallel, independent, long-running subtasks
- Message bus, for event-driven pipelines with a growing agent ecosystem
- Shared-state, for collaborative work where agents build on each other&#x27;s findings
## Pattern 1: Generator-verifier
This is the simplest multi-agent pattern and among the most deployed. We introduced it as the verification subagent pattern in our previous post, and here we use the broader generator-verifier framing because the generator need not be an orchestrator. 
### How it works
‍
A generator receives a task and produces an initial output, which it passes to a verifier for evaluation. The verifier checks whether the output meets the required criteria and either accepts it as complete or rejects it with feedback. If rejected, that feedback is routed back to the generator, which uses it to produce a revised attempt. This loop continues until the verifier accepts the output or the maximum number of iterations is reached.
### Where it works well
Consider a support system that generates email responses to customer tickets. The generator produces an initial response using product documentation and ticket context. The verifier checks accuracy against the knowledge base, evaluates tone against brand guidelines, and confirms the response addresses each issue raised. Failed checks return to the generator with feedback that names the exact problem, such as a feature misattributed to the wrong pricing tier or a ticket issue left unanswered.
Use this pattern when output quality is critical and evaluation criteria can be made explicit. It’s effective for code generation (one agent writes code, another writes and runs tests), fact-checking, rubric-based grading, compliance verification, and any domain where an incorrect output costs more than an additional generation cycle.
### Where it struggles
The verifier is only as good as its criteria. A verifier told only to check whether output is good, with no further criteria, will rubber-stamp the generator&#x27;s output. Teams most often fail by implementing the loop without defining what verification means, which creates the illusion of quality control without the substance. (We discussed this early victory problem in the previous post.)
The pattern also assumes generation and verification are separable skills. If evaluating a creative approach is as hard as generating one, the verifier may not reliably catch problems.
Finally, iterative loops can stall. If the generator can&#x27;t address the verifier&#x27;s feedback, the system oscillates without converging. A maximum iteration limit with a fallback strategy (escalate to a human, return the best attempt with caveats) prevents this from becoming an infinite loop.
## Pattern 2: Orchestrator-subagent
Hierarchy defines this pattern. One agent acts as a team lead that plans work, delegates tasks, and synthesizes results. Subagents handle specific responsibilities and report back.
### How it works
A lead agent receives a task and determines how to approach it. It may handle some subtasks directly while dispatching others to subagents. Subagents complete their work and return results, which the orchestrator synthesizes into a final output.
Claude Code uses this pattern. The main agent writes code, edits files, and runs commands itself, dispatching subagents in the background when it needs to search a large codebase or investigate independent questions so work continues while results stream back. Each subagent operates in its own context window and returns distilled findings. This keeps the orchestrator&#x27;s context focused on the primary task while exploration happens in parallel.
### Where it works well
Consider an automated code review system. When a pull request arrives, the system needs to check for security vulnerabilities, verify test coverage, assess code style, and evaluate architectural consistency. Each check is distinct, requires different context, and produces a clear output. An orchestrator dispatches each check to a specialized subagent, collects the results, and synthesizes a unified review.
Use this pattern when task decomposition is clear and subtasks have minimal interdependence. The orchestrator maintains a coherent view of the overall goal while subagents stay focused on specific responsibilities.
### Where it struggles
The orchestrator becomes an information bottleneck. When a subagent discovers something relevant to another subagent&#x27;s work, that information has to travel back through the orchestrator. If the security subagent finds an authentication flaw that affects the architecture subagent&#x27;s analysis, the orchestrator must recognize this dependency and route the information appropriately. After several such handoffs, critical details are often lost or summarized away.
Sequential execution also limits throughput. Unless explicitly parallelized, subagents run one after another, meaning the system incurs multi-agent token costs without the speed benefit.
## Pattern 3: Agent teams
When work decomposes into parallel subtasks that can proceed independently for extended periods, orchestrator-subagent can become unnecessarily constraining.
### How it works
A coordinator spawns multiple worker agents as independent processes. Teammates claim tasks from a shared queue, work on them autonomously across multiple steps, and signal completion.
The difference from orchestrator-subagent is worker persistence. The orchestrator spawns a subagent for one bounded subtask, and the subagent terminates after returning a result. Teammates stay alive across many assignments, accumulating context and domain specialization that improve their performance over time. The coordinator assigns work and collects outcomes but doesn’t reset workers between tasks.
### Where it works well
Consider migrating a large codebase from one framework to another. A teammate can migrate each service independently, with its own dependencies, test suite, and deployment configuration. A coordinator assigns each service to a teammate, and each teammate works through the migration autonomously: dependency updates, code changes, test fixes, validation. The coordinator collects completed migrations and runs integration tests across the full system.
Use this pattern when subtasks are independent and benefit from sustained, multi-step work. Each teammate builds up context about its domain rather than starting fresh with each dispatch.
### Where it struggles
Independence is the critical requirement. Unlike orchestrator-subagent, where the orchestrator can mediate between subagents and route information, teammates operate autonomously and can&#x27;t easily share intermediate findings. If one teammate&#x27;s work affects another&#x27;s, neither is aware, and their outputs may conflict.
Completion detection is also harder. Since teammates work autonomously for variable durations, the coordinator must handle partial completion where one teammate finishes in two minutes and another takes twenty.
Shared resources compound both problems. When multiple teammates operate on the same codebase, database, or file system, two teammates may edit the same file or make incompatible changes. The pattern requires careful task partitioning and conflict resolution mechanisms.
## Pattern 4: Message bus
As agent count increases and interaction patterns grow complex, direct coordination becomes difficult to manage. A message bus introduces a shared communication layer where agents publish and subscribe to events.
### How it works
Agents interact through two primitives: publish and subscribe. Agents subscribe to the topics they care about, and a router delivers matching messages. New agents with new capabilities can start receiving relevant work without rewiring existing connections.
### Where it works well
A security operations automation system demonstrates where this pattern excels. Alerts arrive from multiple sources, and a triage agent classifies each by severity and type, routing high-severity network alerts to a network investigation agent and credential-related alerts to an identity analysis agent. Each investigation agent may publish enrichment requests that a context-gathering agent fulfills. Findings flow to a response coordination agent that determines the appropriate action.
This pipeline suits the message bus because events flow from one stage to the next, teams can add new agent types as threat categories evolve, and teams can develop and deploy agents independently. 
Use this pattern for event-driven pipelines where the workflow emerges from events rather than a predetermined sequence, and where the agent ecosystem is likely to grow.
### Where it struggles
The flexibility of event-driven communication makes tracing harder. When an alert triggers a cascade of events across five agents, understanding what happened requires careful logging and correlation. Debugging is harder than following an orchestrator&#x27;s sequential decisions.
Routing accuracy is also critical. If the router misclassifies or drops an event, the system fails silently, handling nothing but never crashing. LLM-based routers provide semantic flexibility but introduce their own failure modes.
## Pattern 5: Shared state
Orchestrators, team leads, and message routers in the previous patterns all centrally manage information flow. Shared state removes the intermediary by letting agents coordinate through a persistent store that all can read and write directly.
### How it works
Agents operate autonomously, reading from and writing to a shared database, file system, or document. There&#x27;s no central coordinator. Agents check the store for relevant information, act on what they find, and write their findings back. Work typically begins when an initialization step seeds the store with a question or dataset, and ends when a termination condition is met: a time limit, a convergence threshold, or a designated agent determining the store contains a sufficient answer.
### Where it works well
Consider a research synthesis system where multiple agents investigate different aspects of a complex question. One explores academic literature, another analyzes industry reports, a third examines patent filings, a fourth monitors news coverage. Each agent&#x27;s findings may inform the others&#x27; investigations. The academic literature agent might discover a key researcher whose company the industry agent should examine more closely.
With shared state, findings go directly into the store. The industry agent can see the academic agent&#x27;s discoveries immediately, without waiting for a coordinator to route the information. Agents build on each other’s work, and the shared store becomes an evolving knowledge base.
Shared state also removes the coordinator as a single point of failure. If any one agent stops, the others continue reading and writing. In orchestrator and message-bus systems, a coordinator or router failure halts everything.
### Where it struggles
Without explicit coordination, agents may duplicate work or pursue contradictory approaches. Two agents might independently investigate the same lead. Agent interactions produce system behavior rather than top-down design, which makes outcomes less predictable.
The harder failure mode is reactive loops. For example, Agent A writes a finding, Agent B reads it and writes a follow-up, Agent A sees the follow-up and responds. The system keeps burning tokens on work that isn’t converging. Duplicate work and concurrent writes have known engineering fixes (locking, versioning, partitioning). Reactive loops are a behavioral problem and need first-class termination conditions: a time budget, a convergence threshold (no new findings for N cycles), or a designated agent whose job is to decide when the store contains a sufficient answer. Systems that treat termination as an afterthought tend to cycle indefinitely or stop arbitrarily when one agent&#x27;s context fills.
## Choosing and evolving between patterns
The right pattern depends on a handful of structural questions about the system. In our previous post, we argued for context-centric decomposition, which divides work by what context each agent needs rather than by what type of work it does. That principle applies here too. The patterns differ in how they manage context boundaries and information flow.
### Orchestrator-subagent vs. agent teams
Both involve a coordinator dispatching work to other agents. The question is how long workers need to maintain their context.
- Choose orchestrator-subagent when subtasks are short, focused, and produce clear outputs. The code review system works well here because each check runs its analysis, generates a report, and returns within a single bounded invocation. The subagent doesn&#x27;t need to carry context across multiple cycles.
- Choose agent teams when subtasks benefit from sustained, multi-step work. The codebase migration fits here because each teammate develops real familiarity with its assigned service: the dependency graph, test patterns, deployment configuration. That accumulated context improves performance in ways one-shot dispatch can&#x27;t replicate.
When subagents need to retain state across invocations, agent teams are the better fit.
### Orchestrator-subagent vs. message bus
Both can handle multi-step workflows. The question is how predictable the workflow structure is.
- Choose orchestrator-subagent when the sequence of steps is known in advance. The code review system follows a fixed pipeline: receive a PR, run checks, synthesize results.
- Choose message bus when the workflow emerges from events and may vary based on what&#x27;s discovered. The security operations system can&#x27;t predict what alerts will arrive or what investigation paths they&#x27;ll require. New alert types may emerge that need new handling. The message bus accommodates that variability by routing events to capable agents rather than following a predetermined sequence.
As conditional logic accumulates in the orchestrator to handle an expanding variety of cases, the message bus makes that routing explicit and extensible.
### Agent teams vs. shared state
Both involve agents working autonomously. The question is whether agents need each other&#x27;s findings.
- Choose agent teams when agents work on separate partitions that don&#x27;t interact. The codebase migration fits here because each teammate handles its service and the coordinator combines results at the end.
- Choose shared state when agents&#x27; work is collaborative and findings should flow between them in real time. The research synthesis system is a better match because the academic agent&#x27;s discovery of a key researcher immediately becomes relevant to the industry agent&#x27;s investigation.
Once teammates need to communicate with each other rather than only share final results, shared state makes that more natural.
### Message bus vs. shared state
Both support complex multi-agent coordination. The question is whether work flows as discrete events or accumulates into a shared knowledge base.
- Choose message bus when agents react to events in a pipeline. The security operations system processes alerts stage by stage, with each event triggering the next before completing. The pattern is efficient at routing events to capable agents.
- Choose shared state when agents build on accumulated findings over time. The research synthesis system gathers knowledge continuously. Agents return to the store repeatedly, seeing what others have discovered and adjusting their investigations.
The message bus still has a router, which means a central component decides where events go. Shared state is decentralized. If eliminating single points of failure is a priority, shared state provides that more completely.
If agents in a message bus system are publishing events to share findings rather than trigger actions, shared state is a better fit.
## Getting started
Production systems often combine patterns. A common hybrid uses orchestrator-subagent for the overall workflow with shared state for a collaboration-heavy subtask. Another uses message bus for event routing with agent team-style workers handling each event type. These patterns are building blocks, not mutually exclusive choices.
The following table summarizes when each pattern is appropriate.
          Situation
          Pattern
          Quality-critical output, explicit evaluation criteria
          Generator-Verifier
          Clear task decomposition, bounded subtasks
          Orchestrator-Subagent
          Parallel workload, independent long-running subtasks
          Agent Teams
          Event-driven pipeline, growing agent ecosystem
          Message Bus
          Collaborative research, agents share discoveries
          Shared State
          No single point of failure required
          Shared State
For most use cases, we recommend starting with orchestrator-subagent. It handles the widest range of problems with the least coordination overhead. Observe where it struggles, then evolve toward other patterns as specific needs become clear.
‍In upcoming posts, we will examine each pattern in depth with production implementations and case studies. For background on when multi-agent systems are worth the investment, see Building multi-agent systems: when and how to use them.
## Acknowledgements
Written by Cara Phillips, with contributions from Eugene Yang, Jiri De Jonghe, Samuel Weller, and Erik S.
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
        if (needs) {
          if (currentMode !== "slider" || !currentConfig || currentConfig !== vp.config) initializeSlider();
        } else {
          if (currentMode !== "grid") initializeGrid();
        }
      }
      function onPrev() {
        currentApi && currentApi.previous({ duration: 0.45, ease: "power1.inOut" });
      }
      function onNext() {
        currentApi && currentApi.next({ duration: 0.45, ease: "power1.inOut" });
      }
      function handleResize() {
        evaluateAndUpdate();
      }
      if (window.ResizeObserver) {
        resizeObserver = new ResizeObserver(debounce(handleResize, 200));
        resizeObserver.observe(document.documentElement);
      }
      window.addEventListener("resize", debounce(handleResize, 200));
      evaluateAndUpdate();
      function cleanup() {
        if (resizeObserver) resizeObserver.disconnect();
        if (currentApi) currentApi.kill && currentApi.kill();
      }
      root._sliderCleanup = cleanup;
      function addClonesForLooping() {
        Array.prototype.slice.call(track.querySelectorAll('[data-slider-clone="true"]')).forEach(function (n) {
          n.remove();
        });
        var widths = cards.map(function (el) {
          return el.getBoundingClientRect().width;
        });
        var avgW = widths.reduce((a, b) => a + b, 0) / Math.max(widths.length, 1);
        var needAcross = Math.ceil((viewport.clientWidth * 1.5) / Math.max(avgW, 1));
        var clonesEachSide = Math.max(2, needAcross);
        for (var i = 0; i < clonesEachSide; i++) {
          var src = cards[cards.length - 1 - (i % cards.length)];
          var clone = src.cloneNode(true);
          clone.setAttribute("data-slider-clone", "true");
          clone.setAttribute("data-slider-origin-index", src.getAttribute("data-slider-origin-index"));
          track.insertBefore(clone, track.firstChild);
        }
        for (var j = 0; j < clonesEachSide; j++) {
          var src2 = cards[j % cards.length];
          var clone2 = src2.cloneNode(true);
          clone2.setAttribute("data-slider-clone", "true");
          clone2.setAttribute("data-slider-origin-index", src2.getAttribute("data-slider-origin-index"));
          track.appendChild(clone2);
        }
      }
      function buildLoopingSlider() {
        var items = Array.prototype.slice.call(track.children);
        var tl = horizontalLoop(items, {
          paused: true,
          draggable: true,
          center: CENTER_MODE ? viewport : false,
          speed: 1,
          snap: false,
          onChange: function (el) {
            var mapped = parseInt(el.getAttribute("data-slider-origin-index") || "0", 10) || 0;
            activeIndex = mapped;
            updateDots();
            updateMobileCounter();
            updateButtonsState();
            updateActiveSlide(el);
          },
          _trigger: viewport,
        });
        tl.pause(0);
        var api = {
          toIndex: function (i, vars) {
            var idxInItems = tl.findNearestIndexForOrigin(i);
            return tl.toIndex(idxInItems, vars);
          },
          next: (vars) => {
            var target = tl.findNearestIndexForOrigin((activeIndex + 1) % originalLength);
            return tl.toIndex(target, vars);
          },
          previous: (vars) => {
            var target = tl.findNearestIndexForOrigin((activeIndex - 1 + originalLength) % originalLength);
            return tl.toIndex(target, vars);
          },
          current: () => activeIndex,
          kill: () => {
            try {
              if (tl.draggable) tl.draggable.kill();
            } catch (e) {}
            try {
              tl.kill();
            } catch (e) {}
          },
        };
        api.toIndex(0, { duration: 0 });
        updateMobileCounter();
        return api;
      }
      function buildLinearSlider(config) {
        var items = cards.slice();
        var cur = 0;
        var bounds = { minX: 0, maxX: 0 };
        var offsets = [];
        var draggable;
        function innerViewportWidth() {
          var cs = getComputedStyle(viewport);
          var padL = parseFloat(cs.paddingLeft) || 0;
          var padR = parseFloat(cs.paddingRight) || 0;
          return Math.max(0, viewport.clientWidth - padL - padR);
        }
        function measure() {
          return new Promise(function (resolve) {
            requestAnimationFrame(function () {
              requestAnimationFrame(function () {
                var trackW = track.scrollWidth;
                if (!trackW || trackW < 1) {
                  var last = items[items.length - 1];
                  trackW = last ? last.offsetLeft + last.offsetWidth : 0;
                }
