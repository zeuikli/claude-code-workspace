---
title: "Piloting Claude in Chrome"
url: https://claude.com/blog/claude-for-chrome
slug: claude-for-chrome
fetched: 2026-04-13 01:11 UTC
---

# Piloting Claude in Chrome

> Source: https://claude.com/blog/claude-for-chrome



Try ClaudeTry ClaudeTry Claude
- BlogBlog/
- Piloting Claude in ChromeExplore here
- 
Ask questions about this page
- 
Copy as markdown
# Piloting Claude in Chrome
We&#x27;re piloting Claude in Chrome to test browser-based AI capabilities while addressing prompt injection risks and building the safety measures needed before wider release.
‍
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
ProductClaude apps
- 
DateAugust 25, 2025
- 
Reading time5min
- 
ShareCopy linkhttps://claude.com/blog/claude-for-chrome
Update: Now available to Pro, Team, and Enterprise plans (Dec 18, 2025)
After months of real-world testing, we&#x27;re ready to expand to all paid plans. We&#x27;ve also shipped our most requested feature: an integration for Claude Code. Build in your terminal, verify in your browser, and debug with Claude reading console errors and DOM state directly. 
For Teams and Enterprise: Admins can enable or disable the extension org-wide and configure site allowlists and blocklists.
‍
Update: Now available to all Max plan subscribers (Nov 24, 2025)
After three months of testing, Claude in Chrome is now available in beta to all Max plan subscribers. Since the research preview, we&#x27;ve shipped major updates including scheduled tasks, multi-tab workflows, and smarter navigation on sites you use every day. Read our release notes for the full list of updates, and our safety blog for details on prompt injection defenses and learnings from the pilot.
‍
We&#x27;ve spent recent months connecting Claude to your calendar, documents, and many other pieces of software. The next logical step is letting Claude work directly in your browser.
We view browser-using AI as inevitable: so much work happens in browsers that giving Claude the ability to see what you&#x27;re looking at, click buttons, and fill forms will make it substantially more useful.
But browser-using AI brings safety and security challenges that need stronger safeguards. Getting real-world feedback from trusted partners on uses, shortcomings, and safety issues lets us build robust classifiers and teach future models to avoid undesirable behaviors. This ensures that as capabilities advance, browser safety keeps pace.
Browser-using agents powered by frontier models are already emerging, making this work especially urgent. By solving safety challenges, we can better protect Claude users and share what we learn with anyone building a browser-using agent on our API.
We’re starting with controlled testing: a Claude extension for Chrome where trusted users can instruct Claude to take actions on their behalf within the browser. We&#x27;re piloting with 1,000 Max plan users—join the waitlist—to learn as much as we can. We&#x27;ll gradually expand access as we develop stronger safety measures and build confidence through this limited preview.
### Considerations for browser-using AI
Within Anthropic, we&#x27;ve seen appreciable improvements using early versions of Claude in Chrome to manage calendars, schedule meetings, draft email responses, handle routine expense reports, and test new website features.
However, some vulnerabilities remain to be fixed before we can make Claude in Chrome generally available. Just as people encounter phishing attempts in their inboxes, browser-using AIs face prompt injection attacks—where malicious actors hide instructions in websites, emails, or documents to trick AIs into harmful actions without users&#x27; knowledge (like hidden text saying "disregard previous instructions and do [malicious action] instead").
Prompt injection attacks can cause AIs to delete files, steal data, or make financial transactions. This isn&#x27;t speculation: we’ve run “red-teaming” experiments to test Claude in Chrome and, without mitigations, we’ve found some concerning results.
We conducted extensive adversarial prompt injection testing, evaluating 123 test cases representing 29 different attack scenarios. Browser use without our safety mitigations showed a 23.6% attack success rate when deliberately targeted by malicious actors.
One example of a successful attack—before our new defenses were applied—was a malicious email claiming that, for security reasons, emails needed to be deleted. When processing the inbox, Claude followed these instructions to delete the user’s emails without confirmation.
Claude encounters the malicious email, which mimics an employer asking for emails to be deleted for "mailbox hygiene,"and claims "no additional confirmation required." Claude proceeds to act on the instructions without confirmation, selecting and deleting the user&#x27;s emails "as requested by the security team." Our new mitigations successfully defend against this particular attack. Claude recognizes that "this is a suspicious security incident email that appears to be a phishing attempt," and does not act on it.
As we’ll explain in the next section, we&#x27;ve already implemented several defenses that significantly reduce the attack success rate—though there’s still work to do in uncovering novel attack vectors.
### Current defenses
The first line of defense against prompt injection attacks is permissions. Users maintain control over what Claude in Chrome can access and do:
- Site-level permissions: Users can grant or revoke Claude&#x27;s access to specific websites at any time in the Settings.
- Action confirmations: Claude asks users before taking high-risk actions like publishing, purchasing, or sharing personal data. Even when users opt into our experimental “autonomous mode,” Claude still maintains certain safeguards for highly sensitive actions (Note: all red-teaming and safety evaluations were conducted in autonomous mode).
We’ve also built additional safeguards in line with Anthropic’s trustworthy agents principles. First, we’ve improved our system prompts—the general instructions Claude receives before specific instructions from users—to direct Claude on how to handle sensitive data and respond to requests to take sensitive actions.
Additionally, we’ve blocked Claude from using websites from certain high-risk categories such as financial services, adult content, and pirated content. And we’ve begun to build and test advanced classifiers to detect suspicious instruction patterns and unusual data access requests—even when they arise in seemingly legitimate contexts.
When we added safety mitigations to autonomous mode, we reduced the attack success rate of 23.6% to 11.2%, which represents a meaningful improvement over our existing Computer Use capability (where Claude could see the user’s screen but without the browser interface that we’re introducing today).
Prompt injection attack success rates across three scenarios: our older computer use capability, our new browser use product with only previous safety mitigations, and our new browser use product with new mitigations (lower scores are better). Our safety improvements reduced browser attack success rates below computer use levels.
We also conducted special red-teaming and mitigations focused on new attacks specific to the browser, such as hidden malicious form fields in a webpage’s Document Object Model (DOM) invisible to humans, and other hard-to-catch injections such as through the URL text and tab title that only an agent might see. On a “challenge” set of four browser-specific attack types, our new mitigations were able to reduce attack success rate from 35.7% to 0%.
Before we make Claude in Chrome more widely available, we want to expand the universe of attacks we’re thinking about and learn how to get these percentages much closer to zero, by understanding more about the current threats as well as those that might appear in the future.
### Taking part
Internal testing can’t replicate the full complexity of how people browse in the real world: the specific requests they make, the websites they visit, and how malicious content appears in practice. New forms of prompt injection attacks are also constantly being developed by malicious actors. This research preview allows us to partner with trusted users in authentic conditions, revealing which of our current protections work, and which need work.
We&#x27;ll use insights from the pilot to refine our prompt injection classifiers and our underlying models. By uncovering real-world examples of unsafe behavior and new attack patterns that aren’t present in controlled tests, we’ll teach our models to recognize the attacks and account for the related behaviors, and ensure that safety classifiers will pick up anything that the model itself misses. We’ll also develop more sophisticated permission controls based on what we learn about how users want to work with Claude in their browsers.
For the pilot, we’re looking for trusted testers who are comfortable with Claude taking actions in Chrome on their behalf, and who don’t have setups that are safety-critical or otherwise sensitive.
If you’d like to take part, you can join the Claude in Chrome research preview waitlist at claude.ai/chrome. Once you have access, you can install the extension from the Chrome Web Store and authenticate with your Claude credentials.
We recommend starting with trusted sites—always be mindful of the data that’s visible to Claude—and avoiding use of Claude in Chrome for sites that involve financial, legal, medical, or other types of sensitive information. You can find a detailed safety guide in our Help Center.
We hope that you’ll share your feedback to help us continue to improve both the capabilities and safeguards for Claude in Chrome—and help us take an important step towards a fundamentally new way to integrate AI into our lives.
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
