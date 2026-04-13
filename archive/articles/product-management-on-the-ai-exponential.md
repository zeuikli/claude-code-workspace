---
title: "Product management on the AI exponential "
url: https://claude.com/blog/product-management-on-the-ai-exponential
slug: product-management-on-the-ai-exponential
fetched: 2026-04-13 01:11 UTC
---

# Product management on the AI exponential 

> Source: https://claude.com/blog/product-management-on-the-ai-exponential



Try ClaudeTry ClaudeTry Claude
- BlogBlog/
- Product management on the AI exponential Explore here
- 
Ask questions about this page
- 
Copy as markdown
# Product management on the AI exponential 
Claude Code’s Head of Product Cat Wu shares how product management teams are adapting their workflows and roadmaps in the face of rapidly evolving model intelligence.
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
DateMarch 19, 2026
- 
Reading time5min
- 
ShareCopy linkhttps://claude.com/blog/product-management-on-the-ai-exponential
Since Claude Sonnet 3.5 (new) in October 2024, I made a habit of testing every new model by asking Claude Code (an internal tool at the time) to add a table tool to Excalidraw. With each new model, Claude got a little further but still failed. 
Then, with the release of Opus 4 in June 2025, Claude started occasionally succeeding, enough that we turned the exercise into a pre-recorded demo for the Claude 4 model launch to show what had become possible with our latest model.
Less than a year later, Opus 4.6 can one-shot Excalidraw feature requests reliably enough that we feel comfortable doing it live, in front of thousands of professional developers.
The speed of model progress keeps expanding what&#x27;s possible. The traditional product management playbook is built on the assumption that what&#x27;s technologically possible at the start of a project is roughly what&#x27;s possible at the end. PMs would gather enough information upfront to make confident bets about the future, then execute against a plan over the course of months. 
Exponentially improving models break that assumption. The constraints you designed around might disappear mid-project. You&#x27;re building on ground that&#x27;s rising underneath you, and teams need to reorganize around that reality. The new product management rhythm is rapid experimentation, consistent shipping, and doubling down on what works.
Not surprisingly, one of the most common questions I get as a product manager at Anthropic is how our role is changing. Here&#x27;s what I&#x27;ve learned.
## My journey to product management with Claude Code
I started my career as a product engineer at startups like Scale AI and Dagster, and then became a venture capitalist, a role in which I still wrote code to automate the tedious parts of my job, like scanning X for the announcement of new companies or detecting when open source projects were gaining momentum.
I joined Anthropic in August 2024 as a product manager on the Research PM team, which bridges our research team and real-world customers to deliver better models. When Claude Code became available internally that fall, I used it to accelerate the more manual parts of my job, including building Streamlit apps to analyze large-scale user feedback and running evals to help the company find new benchmarks to trust. The low barrier to building also meant I could explore well beyond my usual role, like creating RL environments to better understand training.
These projects took hundreds of hours of prompting Claude Code powered by Sonnet 3.5 (new), but not a single line of code written by hand.
## Designing a new product management workflow
Tools like Claude Code and Cowork are blurring the lines between distinct roles in the product development life cycle. 
Claude Code isn’t the only tool powering my workflow. Over time, I&#x27;ve settled into a natural division of labor across three products: a chat collaborator (Claude.ai), agentic coding tool (Claude Code), and a knowledge work tool (Cowork). 
Claude.ai is where I talk to Claude as a thought partner without needing it to take action. I bounce ideas for strategy docs, how to handle tricky situations, and get quick answers.
Claude Code is where I build prototypes, evals, and scripts, many of which call Claude API. I use this when the output is code.
Cowork is where I do everything else, from getting to inbox zero, tracking and acting on a todo list, creating slide decks, understanding the history of a decision by searching Slack, and booking my work travel.
I’ve talked with product managers across the industry who&#x27;ve found their own versions of this workflow:
“Claude has raised the ceiling on what good product teams can build, and dramatically shortened the distance between idea and prototype. Getting something tangible in front of customers used to take weeks of building. Now I&#x27;ll start in Claude Cowork, pulling in context from Slack, our codebase, and docs, then move into Claude Code to have something demo-able in a couple of hours. Good product teams have always tested their ideas with real customers, and that instinct hasn&#x27;t changed. What has is how many more high-quality ideas we can actually put through the loop.” - Bihan Jiang, Director of Product, Decagon“To me, being a PM in an AI-native world is both creative and academic. Each new model release changes what’s possible, and in building Datadog’s Bits AI SRE agent we study its strengths and failure modes through offline evaluation on real-world production incidents. We also design tight feedback loops, refining the UX to surface where the agent struggles and turning those insights into product improvements. In that sense, a PM’s craft has shifted from defining certainty upfront to accelerating discovery.” - Kai Xin Tai, Senior Product Manager, Datadog
One of the most exciting parts of being a product manager today is that these workflows are constantly evolving and giving us more leverage.
## Leaning into the AI exponential
METR. (2026, March). Task-Completion Time Horizons of Frontier AI Models. https://metr.org/time-horizons/
METR finds that, about half the time, Opus 4.6 can complete software tasks which take humans almost 12 hours. When we first started building Claude Code, Sonnet 3.5 (new) was the frontier model and METR measured that it could do tasks that would take a human around 21 minutes. That&#x27;s a roughly 41x jump in 16 months.
The Claude Code team has evolved to keep pace with how quickly models improve. Our roles are blending together: designers ship code, engineers make product decisions, product managers build prototypes and evals. This works because clear strategy and goals let everyone prioritize autonomously. The product manager’s job is to create clarity in the ambiguity that rapid model progress creates, push the team to think bigger about what’s possible, and clear the path to shipping faster.
Here are four shifts we’ve embraced:
Plan in short sprints
Traditional product manager thinking treats exploration as something that happens before the roadmap gets locked. You do your research, you write the PRD, and you hand it off for the engineering team to build. 
Instead of a long-term roadmap, we encourage everyone on the team (engineers, product managers, designers) to take on side quests. A side quest is a short self-directed experiment you run outside your official roadmap—an afternoon spent prototyping an idea, testing a capability you assumed was out of reach, or just seeing what happens when you push the model harder than you expect to.
Some of Anthropic’s most popular features—Claude Code on Desktop, the AskUserQuestion tool, and todo lists—emerged this way.
Encourage demos and evals over docs
Our team has largely replaced documentation-first thinking with prototype-first thinking. Instead of hosting traditional stand-ups, we share demos of new ideas. Internal users try them, and the ones with real engagement get polished and shared more broadly. Because you can prototype in an afternoon, wrong bets are cheap.
For example, when Noah shared his plugins spec with Claude Code, the prototype that came back was close to production ready. That prototype anchored what the team ultimately shipped since it enabled the team to quickly validate the UX.
Pro-tip: after you write a spec, send it to Claude Code and see if it can build it. Even a rough prototype changes the conversation.
In addition to demos, evals can also help make an abstract product feel more concrete. For example, for agent teams which lets users coordinate multiple Claude Code instances working together, Conner hand-crafted a set of evals to understand when agent teams work well, when they don’t, and what to fix. Measuring whether the feature is working makes it easier to improve it.
Revisit features with new models
Now, you ship a feature, then a better model comes out and your feature could be dramatically better. Every model release is an implicit prompt to revisit what you&#x27;ve already built.
The best way to catch these moments is to be a daily active user and deliberately ask it to do things you think might be too hard. Sometimes it works, and that’s a signal that the product needs to catch up.
That’s how Claude Code with Chrome happened. We noticed users were building web apps with Claude Code and then manually switching to Claude in Chrome to test it. Users were manually prompting and copying and pasting instructions between these two tools. It worked well enough that we realized this should be a built-in feature. If users are hacking something together, that’s scaffolding you can build into the product.
When prototyping these ideas, always optimize for capability first. Use more tokens than you think you need. It&#x27;s a common mistake to cut token costs too early and ship something much less capable as a result. You can always bring costs down later as cheaper models catch up, but first you need to know whether the feature is even possible.
Do the simple thing
At Anthropic, we have a guiding principle across every team: do the simple thing that works.
If your product cleverly works around a model limitation, that workaround becomes unnecessary complexity when the next model drops. That&#x27;s why "do the simple thing" matters: the simpler your implementation, the easier it is to swap in new capabilities when they arrive.
When we first launched todo lists in Claude Code, the model wouldn&#x27;t reliably check off items as it completed them. So we added system reminders every few messages that would periodically nudge the agent to update its own todo list. It worked, but it was a hack. With the next model, the behavior came for free and we removed the reminders entirely. We&#x27;ve seen this pattern repeatedly: our system prompt and tool descriptions used to be heavily engineered to compensate for model limitations, and we&#x27;ve been able to cut the prompting with each model, including a 20% reduction for Opus 4.6.
## Looking forward
Many product managers are used to having tight control over the full product experience, but AI pushes you to let go in order to move quickly. When it comes to building AI products in particular, it feels like surfing a wave where the most important thing is to stay on it. As a perfectionist, this was the hardest shift for me to get comfortable with, but the product manager’s role is now to identify the handful of true non-negotiables and let the rest go.
The net effect of these shifts is that product teams can move significantly faster. When a product manager can go from idea to working prototype in an afternoon, the gap between “what if we tried…” and “here, try this” nearly disappears. 
At Anthropic, product managers aren’t the only ones transforming their workflows with Claude. Our data science, finance, marketing, legal, and design teams picked up these tools on their own. The whole organization moves at the same speed instead of waiting on handoffs.
The PM role now is to track both things at once: how AI is changing the way you work, and how it&#x27;s changing what&#x27;s possible in your product. Do that well, and you stop being surprised when the table tool finally works. You&#x27;re the one who saw it coming. 
Start building better products with Claude Code.
‍
Acknowledgments: This article was written by Cat Wu, the Head of Product for Claude Code at Anthropic. You can find her on X and LinkedIn. She&#x27;d like to thank Bihan Jiang and Kai Xin Tai for their contributions to this piece. 
‍
‍
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
                var innerW = innerViewportWidth();
                var maxOffset = Math.max(0, trackW - innerW);
                offsets = items.map(function (el) {
                  var left = el.offsetLeft;
                  var w = el.offsetWidth;
                  var target = CENTER_MODE ? left + w / 2 - innerW / 2 : left;
                  if (target < 0) target = 0;
                  if (target > maxOffset) target = maxOffset;
                  return target;
                });
                bounds.maxX = 0;
                bounds.minX = -maxOffset;
                resolve();
              });
            });
          });
        }
        function applyIndex(i, vars) {
          var maxIndex = Math.max(0, items.length - config.slidesToShow);
          i = Math.max(0, Math.min(maxIndex, i));
          cur = i;
          activeIndex = cur;
          updateMobileCounter();
          updateButtonsState();
          updateActiveSlide(cards[cur]);
          var x = -offsets[i];
          return gsap.to(track, Object.assign({ x: x, duration: 0.45, ease: "power1.inOut" }, vars));
        }
        function next(vars) {
          return applyIndex(cur + 1, vars);
        }
        function previous(vars) {
          return applyIndex(cur - 1, vars);
        }
        draggable = Draggable.create(track, {
          type: "x",
          bounds: bounds,
          inertia: false,
          trigger: viewport,
          dragClickables: true,
          minimumMovement: 4,
          onPressInit: async function () {
            gsap.killTweensOf(track);
            await measure();
            this.applyBounds(bounds);
            gsap.set(track, { x: -offsets[cur] });
          },
          onRelease: function () {
            var xNow = this.x;
            var best = 0,
              bestDist = Infinity;
            var maxIndex = Math.max(0, items.length - config.slidesToShow);
            for (var k = 0; k <= maxIndex; k++) {
              var targetX = -offsets[k];
              var d = Math.abs(xNow - targetX);
              if (d < bestDist) {
