---
title: "The advisor strategy: Give Sonnet an intelligence boost with Opus"
url: https://claude.com/blog/the-advisor-strategy
slug: the-advisor-strategy
fetched: 2026-04-13 01:11 UTC
---

# The advisor strategy: Give Sonnet an intelligence boost with Opus

> Source: https://claude.com/blog/the-advisor-strategy



Try ClaudeTry ClaudeTry Claude
- BlogBlog/
- The advisor strategy: Give agents an intelligence boostExplore here
- 
Ask questions about this page
- 
Copy as markdown
# The advisor strategy: Give agents an intelligence boost
Pair Opus as an advisor with Sonnet or Haiku as an executor, and get near Opus-level intelligence in your agents at a fraction of the cost.
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
DateApril 9, 2026
- 
Reading time5min
- 
ShareCopy linkhttps://claude.com/blog/the-advisor-strategy
Developers who want to better balance intelligence and cost have converged on what we call the advisor strategy: pair Opus as an advisor with Sonnet or Haiku as an executor. This brings near Opus-level intelligence to your agents while keeping costs near Sonnet levels.
Today we&#x27;re introducing the advisor tool on the Claude Platform to make the advisor strategy a one-line change in your API call.
## Build cost-effective agents with the advisor strategy 
With the advisor strategy, Sonnet or Haiku runs the task end-to-end as the executor, calling tools, reading results, and iterating toward a solution. When the executor hits a decision it can&#x27;t reasonably solve, it consults Opus for guidance as the advisor. Opus accesses the shared context and returns a plan, a correction, or a stop signal, and the executor resumes. The advisor never calls tools or produces user-facing output, and only provides guidance to the executor.
This inverts a common sub-agent pattern, where a larger orchestrator model decomposes work and delegates to smaller worker models. In the advisor strategy, a smaller, more cost-effective model drives and escalates without decomposition, a worker pool, or orchestration logic. Frontier-level reasoning applies only when the executor needs it, and the rest of the run stays at executor-level cost.
In our evaluations, Sonnet with Opus as an advisor showed a 2.7 percentage point increase on SWE-bench Multilingual1 over Sonnet alone, while reducing cost per agentic task by 11.9%.
## The advisor tool 
We’re bringing the advisor strategy to our API with the advisor tool, a server-side tool which Sonnet and Haiku know to invoke when they need guidance or help with a specific task.
In our evaluations, Sonnet with an Opus advisor improved scores across BrowseComp2 and Terminal-Bench 2.03 benchmarks while costing less per task than Sonnet alone.
The advisor strategy also works with Haiku as the executor. On BrowseComp, Haiku with an Opus advisor scored 41.2%, more than double its solo score of 19.7%. Haiku with an Opus advisor trails Sonnet solo by 29% in score but costs 85% less per task. The advisor adds cost relative to Haiku alone, but the combined price is still a fraction of what Sonnet costs, making it a strong option for high-volume tasks that require a balance of intelligence and cost.
Declare advisor_20260301 in your Messages API request, and the model handoff happens inside a single /v1/messages request—no extra round-trips or context management. The executor model decides when to invoke it. When it does, we route the curated context to the advisor model, return the plan, and the executor continues all within the same request.
`response = client.messages.create(
    model="claude-sonnet-4-6",  # executor
    tools=[
        {
            "type": "advisor_20260301",
            "name": "advisor",
            "model": "claude-opus-4-6",
            "max_uses": 3,
        },
        # ... your other tools
    ],
    messages=[...]
)
# Advisor tokens reported separately
# in the usage block.`
```
Pricing. Advisor tokens are billed at the advisor model&#x27;s rates; executor tokens are billed at the executor model&#x27;s rates. Since the advisor only generates a short plan (typically 400-700 text tokens) while the executor handles the full output at its lower rate, the overall cost stays well below running the advisor model end-to-end. 
Built-in cost controls. Set max_uses to cap advisor calls per request. Advisor tokens are reported separately in the usage block so you can track spend per tier.
Works alongside your existing tools. The advisor tool is just another entry in your Messages API request. Your agent can search the web, execute code, and consult Opus in the same loop.
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
