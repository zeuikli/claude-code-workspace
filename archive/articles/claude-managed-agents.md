---
title: "Claude Managed Agents: get to production 10x faster"
url: https://claude.com/blog/claude-managed-agents
slug: claude-managed-agents
fetched: 2026-04-13 01:11 UTC
---

# Claude Managed Agents: get to production 10x faster

> Source: https://claude.com/blog/claude-managed-agents



Try ClaudeTry ClaudeTry Claude
- BlogBlog/
- Claude Managed Agents: get to production 10x fasterExplore here
- 
Ask questions about this page
- 
Copy as markdown
# Claude Managed Agents: get to production 10x faster
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
CategoryProduct announcements
- 
ProductClaude Platform
- 
DateApril 8, 2026
- 
Reading time5min
- 
ShareCopy linkhttps://claude.com/blog/claude-managed-agents
Today, we&#x27;re launching Claude Managed Agents, a suite of composable APIs for building and deploying cloud-hosted agents at scale.
Until now, building agents meant spending development cycles on secure infrastructure, state management, permissioning, and reworking your agent loops for every model upgrade. Managed Agents pairs an agent harness tuned for performance with production infrastructure to go from prototype to launch in days rather than months.
Whether you&#x27;re building single-task runners or complex multi-agent pipelines, you can focus on the user experience, not the operational overhead.
Managed Agents is available today in public beta on the Claude Platform.
## Build and deploy agents 10x faster
Shipping a production agent requires sandboxed code execution, checkpointing, credential management, scoped permissions, and end-to-end tracing. That&#x27;s months of infrastructure work before you ship anything users see.
Managed Agents handles the complexity. You define your agent&#x27;s tasks, tools, and guardrails and we run it on our infrastructure. A built-in orchestration harness decides when to call tools, how to manage context, and how to recover from errors.
Managed Agents includes:
- Production-grade agents with secure sandboxing, authentication, and tool execution handled for you.
- Long-running sessions that operate autonomously for hours, with progress and outputs that persist even through disconnections.
- Multi-agent coordination so agents can spin up and direct other agents to parallelize complex work (available in research preview, request access here).‍
- Trusted governance, giving agents access to real systems with scoped permissions, identity management, and execution tracing built in.Claude Managed Agents architecture
## Designed to make the most of Claude
Claude models are built for agentic work. Managed Agents is purpose-built for Claude, enabling you to get better agent outcomes with less effort. 
With Managed Agents, you define outcomes and success criteria, and Claude self-evaluates and iterates until it gets there (available in research preview, request access here). It also supports traditional prompt-and-response workflows when you want tighter control. 
In internal testing around structured file generation, Managed Agents improved outcome task success by up to 10 points over a standard prompting loop, with the largest gains on the hardest problems.
Session tracing, integration analytics, and troubleshooting guidance are built directly into the Claude Console, so you can inspect every tool call, decision, and failure mode.
## What teams are building
Teams are already shipping 10x faster with Managed Agents across a range of production use cases. Coding agents that read a codebase, plan a fix, and open a PR. Productivity agents that join a project, pick up tasks, and deliver work alongside the rest of the team. Finance and legal agents that process documents and extract what matters. In each case, shipping in days meant providing value to users faster.
- Notion lets teams delegate work to Claude directly inside their workspace (available now in private alpha inside Notion Custom Agents). Engineers use it to ship code, while knowledge workers use it to produce websites and presentations. Dozens of tasks can run in parallel while the whole team collaborates on the output.
- Rakuten shipped enterprise agents across product, sales, marketing and finance that plug into Slack and Teams, letting employees assign tasks and get back deliverables like spreadsheets, slides, and apps. Each specialist agent was deployed within a week.
- Asana built AI Teammates, collaborative AI agents that work alongside humans inside Asana projects, taking on tasks and drafting deliverables. The team used Managed Agents to add advanced features dramatically faster than they would have been able to otherwise.
- Vibecode helps their customers go from prompt to deployed app using Managed Agents as the default integration, powering a new generation of AI-native apps. Users can now spin up that same infrastructure at least 10x quicker than before.‍
- Sentry paired Seer, their debugging agent, with a Claude-powered agent that writes the patch and opens the PR, so developers go from a flagged bug to a reviewable fix in one flow. The integration shipped in weeks instead of months on Managed Agents.
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
          toIndex: (i, vars) => applyIndex(i, vars),
          next: next,
          previous: previous,
          current: () => cur,
          kill: function () {
            try {
              draggable && draggable.kill();
            } catch (e) {}
          },
        };
      }
      function horizontalLoop(items, config) {
