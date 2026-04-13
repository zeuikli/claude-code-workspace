---
title: "Improving frontend design through Skills"
url: https://claude.com/blog/improving-frontend-design-through-skills
slug: improving-frontend-design-through-skills
fetched: 2026-04-13 01:11 UTC
---

# Improving frontend design through Skills

> Source: https://claude.com/blog/improving-frontend-design-through-skills



Try ClaudeTry ClaudeTry Claude
- BlogBlog/
- Improving frontend design through SkillsExplore here
- 
Ask questions about this page
- 
Copy as markdown
# Improving frontend design through Skills
Best practices for building richer, more customized frontend design with Claude and Skills.
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
ProductClaude apps
- 
DateNovember 12, 2025
- 
Reading time5min
- 
ShareCopy linkhttps://claude.com/blog/improving-frontend-design-through-skills
You might notice that when you ask an LLM to build a landing page without guidance, it will almost always conform to Inter fonts, purple gradients on white backgrounds, and minimal animations. 
The issue?  Distributional convergence. During sampling, models predict tokens based on statistical patterns in training data. Safe design choices–those that work universally and offend no one–dominate web training data. Without direction, Claude samples from this high-probability center.
For developers building customer-facing products, this generic aesthetic undermines brand identity and makes AI-generated interfaces immediately recognizable—and dismissible.
### The steerability challenge
The good news is that Claude is highly steerable with the right prompting. Tell Claude to "avoid Inter and Roboto" or "use atmospheric backgrounds instead of solid colors," and results improve immediately. This sensitivity to guidance is a feature; it means Claude can adapt to different design contexts, constraints, and aesthetic preferences. 
But this creates a practical challenge: the more specialized the task, the more context you need to provide. For frontend design, effective guidance spans typography principles, color theory, animation patterns, and background treatment. You need to specify which defaults to avoid and which alternatives to prefer across multiple dimensions.
You could pack all this into a system prompt, but then every request–debugging Python, analyzing data, writing emails–carries frontend design context. The question becomes: how do you provide Claude with domain-specific guidance exactly when needed, without permanent context overhead for unrelated tasks?
## Skills: dynamic context loading
This is precisely what Skills were designed for: delivering specialized context on demand without permanent overhead. A skill is a document (often markdown) containing instructions, constraints, and domain knowledge, stored in a designated directory that Claude can access through simple file-reading tools. Claude can leverage these skills to dynamically load in information it needs at runtime, progressively enhancing its context instead of loading everything upfront. 
When equipped with these skills and the necessary tools to read them, Claude can autonomously identify and load relevant skills based on the task at hand. For instance, when asked to build a landing page or create a React component, Claude can load a frontend design skill and apply its instructions just-in-time. This is the essential mental model: skills are prompts and contextual resources that activate on demand, providing specialized guidance for specific task types without incurring permanent context overhead.
This allows developers to reap the benefits of Claude’s steerability without overloading the context window by stuffing disparate instructions across many tasks into the system prompt. As we’ve previously explained, too many tokens in the context window can result in degradation of performance, so keeping the contents of the context window lean and focused is extremely important for eliciting the best performance from the model. Skills solve for this by making effective prompts reusable and contextual.
## Prompting for better frontend output
We can unlock significantly better UI generations from Claude, without permanent context overhead, by creating a frontend design skill.  The core insight is to think about frontend design the way a frontend engineer would. The more you can map aesthetic improvements to implementable frontend code, the better Claude can execute.
Leveraging this insight, we identified several areas where targeted prompting works well: typography, animations, background effects, and themes. These all translate cleanly to code that Claude can write. Implementing this in your prompts does not require detailed technical instructions, just using targeted language that engages the model to think more critically about these design axes is enough to elicit stronger outputs. This maps closely with the guidance we provided in our context engineering blog article, about prompting the model at the right altitude, avoiding the two extremes of low-altitude hardcoded logic like specifying exact hex codes and vague high-altitude guidance that assumes shared context.
### Typography
To see this in action, let&#x27;s start by viewing typography as one dimension we can influence via prompting. The prompt below specifically steers Claude to use more interesting fonts:
`<use_interesting_fonts>
Typography instantly signals quality. Avoid using boring, generic fonts.
Never use: Inter, Roboto, Open Sans, Lato, default system fonts
Here are some examples of good, impactful choices:
- Code aesthetic: JetBrains Mono, Fira Code, Space Grotesk
- Editorial: Playfair Display, Crimson Pro
- Technical: IBM Plex family, Source Sans 3
- Distinctive: Bricolage Grotesque, Newsreader
Pairing principle: High contrast = interesting. Display + monospace, serif + geometric sans, variable font across weights.
Use extremes: 100/200 weight vs 800/900, not 400 vs 600. Size jumps of 3x+, not 1.5x.
Pick one distinctive font, use it decisively. Load from Google Fonts.
</use_interesting_fonts>`
```
Output generated with base prompt:
Output generated with base prompt and typography section
‍
Interestingly, the mandate to use more interesting fonts seems to encourage the model to improve other aspects of the design as well. 
Typography alone leads to significant improvement, but fonts are just one dimension. What about cohesive aesthetics across the entire interface? 
### Themes
Another dimension we can prompt for is designs inspired by well-known themes and aesthetics. Claude has a rich understanding of popular themes; we can use this to communicate the specific aesthetics we want our frontend to embody. Here’s an example:
`<always_use_rpg_theme>
Always design with RPG aesthetic:
- Fantasy-inspired color palettes with rich, dramatic tones
- Ornate borders and decorative frame elements
- Parchment textures, leather-bound styling, and weathered materials
- Epic, adventurous atmosphere with dramatic lighting
- Medieval-inspired serif typography with embellished headers
</always_use_rpg_theme>`
```
This produces the following RPG-themed UI:
Typography and themes show targeted prompting works. But manually specifying each dimension is tedious. What if we could combine all these improvements into one reusable asset?
### A general-purpose prompt
The same principle extends to other design dimensions: prompting for motion (animations and micro-interactions) adds polish that static designs lack, while guiding the model toward more interesting background choices creates depth and visual interest. This is where a comprehensive skill shines.
Bringing this all together, we developed a ~400 token prompt – compact enough to load without bloating context (even when loaded as a skill) – that dramatically improves frontend output across typography, color, motion, and backgrounds:
`<frontend_aesthetics>
You tend to converge toward generic, "on distribution" outputs. In frontend design,this creates what users call the "AI slop" aesthetic. Avoid this: make creative,distinctive frontends that surprise and delight. 
Focus on:
- Typography: Choose fonts that are beautiful, unique, and interesting. Avoid generic fonts like Arial and Inter; opt instead for distinctive choices that elevate the frontend&#x27;s aesthetics.
- Color & Theme: Commit to a cohesive aesthetic. Use CSS variables for consistency. Dominant colors with sharp accents outperform timid, evenly-distributed palettes. Draw from IDE themes and cultural aesthetics for inspiration.
- Motion: Use animations for effects and micro-interactions. Prioritize CSS-only solutions for HTML. Use Motion library for React when available. Focus on high-impact moments: one well-orchestrated page load with staggered reveals (animation-delay) creates more delight than scattered micro-interactions.
- Backgrounds: Create atmosphere and depth rather than defaulting to solid colors. Layer CSS gradients, use geometric patterns, or add contextual effects that match the overall aesthetic.
Avoid generic AI-generated aesthetics:
- Overused font families (Inter, Roboto, Arial, system fonts)
- Clichéd color schemes (particularly purple gradients on white backgrounds)
- Predictable layouts and component patterns
- Cookie-cutter design that lacks context-specific character
Interpret creatively and make unexpected choices that feel genuinely designed for the context. Vary between light and dark themes, different fonts, different aesthetics. You still tend to converge on common choices (Space Grotesk, for example) across generations. Avoid this: it is critical that you think outside the box!
</frontend_aesthetics>`
```
In the example above, we start by giving Claude general context on the problem and what we&#x27;re trying to solve for. We&#x27;ve found that giving the model this type of high-level context is a helpful prompting tactic to calibrate outputs. We then identify the vectors of improved design we discussed before and give targeted advice to encourage the model to think more creatively across all of these dimensions.
We also include additional guidance at the end to prevent Claude from converging to a different local maximum. Even with explicit instructions to avoid certain patterns, the model can default to other common choices (like Space Grotesk for typography). The final reminder to "think outside the box" reinforces creative variation.
### Impact on frontend design
With this skill active, Claude&#x27;s output improves across several types of frontend designs, including: 
Example 1: SaaS landing page
Caption: AI-generated SaaS landing page with generic Inter font, purple gradient, and standard layout. No skills were used.Caption: AI-generated frontend generated using the same prompt as the rendering above in addition to the frontend skill, now with distinctive typography, cohesive color scheme, and layered backgrounds.
Example 2: Blog layout
AI-generated blog layout with default system fonts and flat white background. No skills were used.AI-generated blog layout using the same prompt as well as the frontend skill, featuring editorial typeface with atmospheric depth and refined spacing.
Example 3: Admin dashboard
AI-generated admin dashboard with standard UI components with minimal visual hierarchy. No skills were used.
‍
AI-generated admin dashboard with bold typography, cohesive dark theme, and purposeful motion, using the same prompt in addition to the frontend skill.
## Improving artifact quality in claude.ai with Skills
Design taste isn&#x27;t the only limitation. Claude also faces architectural constraints when building artifacts. Artifacts are interactive, editable content (like code or documents) that Claude creates and displays alongside your chat.
In addition to the issue with design taste explored above, Claude has another default behavior that limits its ability to generate fantastic frontend artifacts in claude.ai. Currently, when asked to create a frontend, Claude just builds a single HTML file with CSS and JS. This is because Claude understands that frontends must be single HTML files to be properly rendered as artifacts.
In the same way you’d expect a human developer to only be able to create very basic frontends if they could only write HTML/CSS/JS in a single file, we hypothesized that Claude would be able to generate more impressive frontend artifacts if we gave it instructions to use richer tooling.
This led us to create a web-artifacts-builder skill which leverages Claude’s ability to use a computer and guides Claude to build artifacts using multiple files and modern web technologies like React, Tailwind CSS and shadcn/ui. Under the hood, the skill exposes scripts that (1) help Claude efficiently set up a basic React repo and (2) bundle everything into a single file using Parcel to meet the single-HTML-file requirement after it is done editing. This is one of the core benefits of skills - by giving Claude access to scripts to execute boilerplate actions, Claude is able to minimize token usage while increasing reliability and performance.
With the web-artifacts-builder skill, Claude could leverage shadcn/ui&#x27;s form components and Tailwind&#x27;s responsive grid system to create a more comprehensive artifact.
Example 1: Whiteboard app
For example, when prompted to create a whiteboard app without the web-artifacts-builder skill, Claude outputted a very basic interface:
On the other hand, when using the new web-artifacts-builder skill, Claude generated a much cleaner and more featureful application out-of-the-box that included drawing different shapes and text:
‍
Example 2: Task Manager App
Similarly, when asked to create a task management app, without the skill, Claude generated a functional but very minimal application:
With the skill, Claude generated an app that was more featureful out of the box. For example, Claude included a “Create New Task” form component that allows users to set an associated Category and Due Date on tasks:
‍
To try out this new skill in Claude.ai, simply enable the skill and then ask Claude to “use the web-artifacts-builder skill” when building artifacts.
## Optimizing Claude’s frontend design capabilities with Skills
This frontend design skill demonstrates a broader principle about language model capabilities: models often have the ability to do more than they express by default. Claude has strong design understanding, but distributional convergence obscures it without guidance. While you could add these instructions to your system prompt, this entails that every request carries frontend design context, even when this knowledge isn’t relevant to the task at hand. Instead, using Skills transforms Claude from a tool that needs constant guidance into one that brings domain expertise to every task. 
Skills are also highly customizable – you can create your own tailored to your specific needs. This allows you to define the exact primitives you want to bake into the skill, whether that&#x27;s your company&#x27;s design system, specific component patterns, or industry-specific UI conventions. By encoding these decisions into a Skill, you transform component parts of an agent’s thinking into a reusable asset that your entire development team can leverage. The skill becomes organizational knowledge that persists and scales, ensuring consistent quality across projects.
This pattern extends beyond frontend work. Any domain where Claude produces generic outputs despite having more expansive understanding is a candidate for Skill development. The method is consistent: identify convergent defaults, provide concrete alternatives, structure guidance at the right altitude, and make it reusable through Skills.
For frontend development, this means Claude can generate distinctive interfaces without per-request prompt engineering. To get started, explore our frontend design cookbook or try out our new frontend design plugin in Claude Code.
Feeling inspired? To create your own frontend skills, check out our skill-creator.
‍
Acknowledgements
Written by Anthropic&#x27;s Applied AI team: Prithvi Rajasekaran, Justin Wei, and Alexander Bricken, alongside our marketing partners Molly Vorwerck and Ryan Whitehead.
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
