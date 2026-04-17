---
title: "Best practices for using Claude Opus 4.7 with Claude Code"
url: https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code
slug: best-practices-for-using-claude-opus-4-7-with-claude-code
fetched: 2026-04-17 04:10 UTC
---

# Best practices for using Claude Opus 4.7 with Claude Code

> Source: https://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code



Try ClaudeTry ClaudeTry Claude
- BlogBlog/
- Best practices for using Claude Opus 4.7 with Claude CodeExplore here
- 
Ask questions about this page
- 
Copy as markdown
# Best practices for using Claude Opus 4.7 with Claude Code
Learn how to use recalibrated effort levels, adaptive thinking, and new defaults to optimize your Claude Code setup with Opus 4.7.
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
DateApril 16, 2026
- 
Reading time5min
- 
ShareCopy linkhttps://claude.com/blog/best-practices-for-using-claude-opus-4-7-with-claude-code
Opus 4.7 is our strongest generally available model to date for coding, enterprise workflows, and long-running agentic tasks. It handles ambiguity better than Opus 4.6, is much more capable at finding bugs and reviewing code, carries context across sessions more reliably, and can reason through ambiguous tasks with less direction.
In our launch announcement, we noted that two changes—an updated tokenizer and a proclivity to think more at higher effort levels, especially on later turns in longer sessions—impact token usage. As a result, when replacing Opus 4.6 with Opus 4.7, it can take some tuning to achieve the best performance. A few tweaks to prompts and harnesses can make a big difference. 
This post walks through what’s changed and how to most effectively use Opus 4.7 in Claude Code.
## Structuring interactive coding sessions
Opus 4.7’s token usage and behavior can differ depending on whether you’re deploying more autonomous, asynchronous coding agents with a single user turn or more interactive, synchronous coding agents with multiple user turns. In interactive settings, it reasons more after user turns: this improves its coherence, instruction following, and coding quality over long sessions, but it also tends to use more tokens.
To get the most out of Opus 4.7 in Claude Code, we’ve found it’s helpful to treat Claude more like a capable engineer you’re delegating to than a pair programmer you’re guiding line by line:
- Specify the task up front, in the first turn. Well-specified task descriptions that incorporate intent, constraints, acceptance criteria, and relevant file locations give Opus 4.7 the context it needs to deliver stronger outputs. Ambiguous prompts conveyed progressively across many turns tend to reduce both token efficiency and, sometimes, overall quality.
- Reduce the number of required user interactions. Every user turn adds reasoning overhead. Batch your questions and give the model the context it needs to keep moving.
- Use auto mode when appropriate. For tasks where you trust the model to execute safely without frequent check-ins, auto mode cuts cycle time. It’s an especially good fit for long-running tasks where you’ve provided full context up front. Auto mode is now available in research preview for Claude Code Max users—you can toggle it on using Shift+Tab.
- Set up notifications for completed tasks. Ask Claude to play a sound when it’s done with a task, and it can create its own hook-based notifications.
## Recommended effort settings for Opus 4.7
The default effort level for Opus 4.7 in Claude Code is now `xhigh`. This is a new effort level between `high` and `max` that gives users more control over the tradeoff between reasoning and latency on hard problems. We recommend xhigh for most agentic coding work, especially for intelligence-sensitive tasks like designing APIs and schemas, migrating legacy code, and reviewing large codebases. 
Here’s some additional guidance for each effort level:
- `medium` and `low`: Available for cost-sensitive, latency-sensitive, or tightly scoped work. The model will be less capable on harder tasks than it would be at higher effort levels, but it still outperforms Opus 4.6 running at the same effort level—sometimes with fewer tokens.
- `high`: Balances intelligence and cost. Choose high if you’re running concurrent sessions or want to spend less without a large quality drop. 
- `xhigh` (default, recommended): The best setting for most coding and agentic uses. It has strong autonomy and intelligence without the runaway token usage that max can produce on long agentic runs.
- `max`: Squeezes out additional performance on genuinely hard problems, but shows diminishing returns and is more prone to overthinking. Use it deliberately for tasks like testing the model’s maximum ceiling in evals and for extremely intelligence-sensitive and non-cost-sensitive uses. 
If you’re upgrading to the new model, we recommend experimenting with effort rather than just porting over an old setting. You can toggle between effort levels during the same task to more effectively manage token usage and reasoning. 
We’ve set the default effort level for Opus 4.7 to xhigh because we believe it’s the best setting for most coding tasks. If you’re an existing Claude Code user but you haven’t manually set your effort level, you’ll be upgraded to `xhigh` automatically. You can still adjust your effort manually.
## Working with adaptive thinking
Extended Thinking with a fixed thinking budget is not supported in Opus 4.7. Instead, Opus 4.7 offers adaptive thinking. This makes thinking optional at each step and allows the model to decide when to use more thinking based on context. It can respond to simple queries quickly, skip thinking when a step doesn’t benefit from it, and invest its thinking tokens where they’re most likely to be useful. Over an agentic run, this can add up to faster responses and a better user experience.
Adaptive thinking has improved meaningfully in this release—in particular, Opus 4.7 is less prone to overthinking.
If you want more control over the thinking rate, prompt for it directly:
- If you want more thinking, try something like, “Think carefully and step-by-step before responding; this problem is harder than it looks.”
- If you want less thinking, try something like, “Prioritize responding quickly rather than thinking deeply. When in doubt, respond directly.” You’ll save tokens but may lose some accuracy on harder steps. 
## Behavior changes worth knowing
A handful of default behaviors have changed between Opus 4.6 and 4.7 and are worth knowing about if you’ve carefully tuned your prompts or harnesses for the older model.
Response length is calibrated to task complexity. Opus 4.7 isn’t as default-verbose as Opus 4.6. You can expect shorter answers on simple lookups and longer ones on open-ended analysis. If your use case relies on a specific length or style, state that explicitly in your prompt. We find that positive examples of the voice you want work better than negative “Don’t do this” instructions.
The model calls tools less often and reasons more. This produces better results in many cases. If you want more tool use (say, more aggressive search or file reading during agentic work), provide guidance that explicitly describes when and why the tool should be used.
It spawns fewer subagents by default. Opus 4.7 tends to be more judicious about when to delegate work to subagents. If your use case benefits from parallel subagents (for example, fanning out across files or independent items), we recommend spelling that out. For example:
Do not spawn a subagent for work you can complete directly in a single response (e.g., refactoring a function you can already see). Spawn multiple subagents in the same turn when fanning out across items or reading multiple files.
## What to try next
Opus 4.7 performs better on long-running tasks than prior models. This makes it a good fit for tasks where supervision used to be the bottleneck, like complex multi-file changes, ambiguous debugging, code review across a service, and multi-step agentic work.
We recommend keeping effort at `xhigh` and seeing how far your first turn takes you.
Learn more in our Opus 4.7 prompting guide and our article on context and session management in Claude Code.
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
                bestDist = d;
                best = k;
              }
            }
            applyIndex(best, { duration: 0.25, ease: "power2.out" });
          },
        })[0];
        (async function init() {
          await measure();
          draggable && draggable.applyBounds(bounds);
          gsap.set(track, { x: -offsets[0] });
          activeIndex = 0;
          updateMobileCounter();
          updateButtonsState();
          updateActiveSlide(cards[0]);
        })();
        return {
