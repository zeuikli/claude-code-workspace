---
title: "Building AI agents for financial services"
url: https://claude.com/blog/building-ai-agents-in-financial-services
slug: building-ai-agents-in-financial-services
fetched: 2026-04-13 01:11 UTC
---

# Building AI agents for financial services

> Source: https://claude.com/blog/building-ai-agents-in-financial-services



Try ClaudeTry ClaudeTry Claude
- BlogBlog/
- Building AI agents for financial servicesExplore here
- 
Ask questions about this page
- 
Copy as markdownGuide: Building AI agents for financial services
Learn how teams at NBIM, Brex, and more build reliable AI agents with Claude on AWS Bedrock.
.button_tiny_icon {
  transition: color 300ms ease;
}
.button_tiny_wrap:hover .button_tiny_icon {
  color: var(--_button-style---icon-hover); 
}
.button_tiny_wrap:focus-within .button_tiny_icon {
  color: var(--_button-style---text-hover) !important;
}
.button_tiny_wrap:focus-within {
  color: var(--_button-style---text-hover) !important;
}
Read moreRead moreRead moreGuide: Building AI agents for financial services
NextNext
Learn how teams at NBIM, Brex, and more build reliable AI agents with Claude on AWS Bedrock.
Guide: Building AI agents for financial services
Learn how teams at NBIM, Brex, and more build reliable AI agents with Claude on AWS Bedrock.
.button_tiny_icon {
  transition: color 300ms ease;
}
.button_tiny_wrap:hover .button_tiny_icon {
  color: var(--_button-style---icon-hover); 
}
.button_tiny_wrap:focus-within .button_tiny_icon {
  color: var(--_button-style---text-hover) !important;
}
.button_tiny_wrap:focus-within {
  color: var(--_button-style---text-hover) !important;
}
Read moreRead moreRead more
# Building AI agents for financial services
Financial institutions are deploying autonomous AI systems to improve operations while navigating regulatory complexity and risk. Here&#x27;s how.
‍
- 
CategoryAgentsEnterprise AI
- 
ProductClaude Platform
- 
DateOctober 30, 2025
- 
Reading time5min
- 
ShareCopy linkhttps://claude.com/blog/building-ai-agents-in-financial-services
In financial services, AI agents are moving beyond pilot programs to deliver concrete business value.
In banking, wealth management, and insurance, autonomous AI agents are transforming how customers understand spending patterns and find savings opportunities. Among other use cases, these tools spot potential overdraft fees, suggest better savings strategies, and guide financial decisions. 
For instance, McKinsey research shows that financial institutions adopting AI agent workflows in fraud detection could generate two hundred to two thousand percent productivity gains, while Norges Bank Investment Management (NBIM) employees save hundreds of cumulative hours per week on analytical and operational tasks using Claude. 
For most organizations, the real challenge isn&#x27;t adopting AI agents. It&#x27;s building systems that navigate complex regulations, manage real-time risk, and protect customer assets while improving business outcomes.
## Moving beyond analysis: how agents change the game
Agents represent a fundamental shift in enterprise AI, replacing generative AI tools that depend upon constant human input and oversight with autonomous systems that handle long-running, context-heavy tasks with minimal – if any – intervention. 
This evolution is especially welcome in financial services, where data often lives in fragmented systems that don&#x27;t talk to each other, making it harder to see the complete picture of a customer&#x27;s financial health. Agentic systems can understand financial context, ingest information from multiple unrelated sources, process multiple kinds of data (transaction records, market data, regulatory documents), and apply all of these capabilities to taking meaningful actions within your customer’s existing financial workflows.
What does this look like in practice? Instead of an analyst manually pulling data from five different systems, reviewing it, and then updating a risk assessment, an agent can monitor transaction patterns across those systems, recognize concerning trends, draft updated risk recommendations based on current regulations, and route them to the right analyst for approval. The agent handles the coordination and analysis, while the analyst makes the final decision.
This shift from traditional AI to AI agents is particularly significant for financial services because it tackles the process completion problem. Financial workflows don&#x27;t just need information, they need actions taken across multiple systems to actually complete transactions and maintain compliance. Agents can bridge those gaps.
## Real-world results AI agents in finance 
AI-powered financial agents are already delivering real-world results in areas such as customer service, fraud detection, and workforce empowerment.
### Transforming customer interactions
Customer service operations are a natural starting point because this area has already proven successful. Financial institutions implementing AI-powered customer service are seeing measurable improvements:
- Multilingual virtual assistants now handle hundreds of millions of interactions annually, serving millions of users across different language groups.
- Customer service agents automate routine tasks like balance inquiries and card replacements, reducing wait times while delivering 24/7 responses and suggesting relevant products, turning support interactions into opportunities to actually help people manage their finances.
Intuit TurboTax, for example, built an AI financial assistant powered by Claude that generates clear and accurate tax explanations for millions of customers. The agentic implementation was so successful that the AI-powered experiences achieved higher customer ratings compared to non-Claude experiences in the previous tax season. 
### Combating fraud and financial crime
In fraud detection and cybercrime prevention, AI agents excel at spotting patterns that may slip past human analysts due to sheer volume. When you consider that financial institutions currently catch only about 2% of global financial crime, you can see why this matters.
AI agents monitor millions of transactions in real-time, working around the clock without the fatigue or cognitive limitations that affect human teams. McKinsey found that a single team member can effectively supervise more than 20 AI agents in financial crime-detection workflows.
For Brex, a modern financial platform, Claude powers their AI anomaly detection, reviewing 100% percent of transactions and providing critical aircover for financial professionals by proactively grouping related expenses, flagging policy concerns, and providing explanations with recommended actions. 
### Amplifying team capabilities
AI agents deliver tangible benefits right where your teams need them most. When implemented thoughtfully, these tools don&#x27;t replace your workforce but rather amplify what they can accomplish and let them focus on the high-value work that requires their knowledge and expertise. Here&#x27;s how financial services organizations like Block and Campfire are doing this:
- Design teams turn ideas into working prototypes without coding barriers
- Operations teams automate case ticket closure
- Accounting teams query financial data through natural language, perform flux analyses, and access audit support
## Unique challenges in financial services
Banks and financial institutions face unique challenges that make AI agent implementation more complex than typical enterprise deployments. When every decision potentially impacts customer finances, regulatory compliance, and institutional risk, the stakes are at a different level altogether.
The combination of complex financial contexts, regulatory requirements, and direct impact on customer outcomes creates an implementation environment where thoroughness trumps speed. These are some of the challenges you can expect to encounter.
### Integrating with legacy infrastructure
Financial institutions typically run on decades-old core banking systems that weren&#x27;t designed for real-time AI integration. Your loan origination system, trading platforms, and compliance databases often use different protocols, data formats, and security models.
Legacy system integration often shows up in:
- Core banking platform incompatibilities across vendors
- Departmental data silos requiring cross-system orchestration
- Legacy mainframe integration challenges
- Real-time synchronization needs for time-sensitive trading decisions
When tackling these challenges, teams need to make practical decisions about integration approaches. The first consideration involves connectivity: does the AI agent have direct integration capabilities with the necessary systems? If not, teams face two practical options: building custom connectors (typically through APIs or MCP approaches) or implementing middleware systems to bridge these communication gaps.
For early agentic solutions, look to integrate with modern platforms with APIs and standard protocols. If you decide you need to connect to legacy systems, you&#x27;ll need to develop middleware that can translate between these systems while maintaining transaction integrity and audit trails.
### Navigating regulatory complexity
A single transaction might trigger compliance requirements from multiple regulators, including SEC, FDIC, state banking authorities, and international bodies for cross-border payments. AI agents must understand not just what actions to take, but which regulatory frameworks apply to each decision and how to document actions for different audit requirements.
Some regulatory considerations that need to be part of your agent architecture include:
- SOC 2 and PCI DSS compliance for AI data processing workflows
- Evidence-based validation of risk assessment accuracy
- Documentation requirements for AI decision audit trails
Ensure you build observability and traceability into the agentic solutions from day one. You&#x27;ll want it simply from a troubleshooting perspective, but you&#x27;ll definitely need it from a regulatory one.
### Managing real-time risk
Unlike other industries where decisions can be reviewed later, financial agents often make choices that immediately impact customer accounts, market positions, or regulatory standing. This demands fail-safe architectures where agents can act quickly but always within predefined risk parameters that protect both customers and the institution.
Implementation requires:
- Transparent reasoning that financial professionals can validate and explain to clients
- Clear escalation pathways for complex or ambiguous financial situations
- Override capabilities allowing advisors to reject AI recommendations when client circumstances warrant
- Fail-safe defaults that prioritize customer protection over operational efficiency
Identify which actions will require human-in-the-loop authorization, either from a risk or regulatory perspective. For high-risk actions, consider how the system, agentic or otherwise, can fail in a known safe state.
## Practical deployment strategies
AI agents are already transforming financial operations for some companies. There are abundant examples of agents currently in production and delivering measurable impact on fraud detection, customer satisfaction, and operational efficiency. So, how do you build and deploy agents that address your specific operational challenges, while making sure they meet regulatory requirements and risk management standards?
### Finding your starting point
The best agent initiatives begin by targeting the things that everyone already agrees need fixing. Clear metrics make all the difference here, because they show whether the solution actually works and help build momentum for wider adoption.
Choose high-impact, low-risk targets
Target opportunities for adding agents within your organization to areas where the stakes are manageable, but the potential impact is meaningful.
Look for processes where human oversight already exists or where consequences of imperfect automation remain minimal: these are perfect for early adoption without introducing excessive organizational risk. Customer service triage, internal knowledge retrieval, and routine data validation are natural entry points where AI agents can immediately reduce workloads while humans remain in the verification loop.
Beyond immediate productivity gains, these initial agent deployments are extremely valuable learning experiences. Each low-risk implementation helps your teams develop practical understanding of agent capabilities, limitation patterns, and integration requirements without the pressure of mission-critical deadlines. Your technical staff learns to fine-tune prompts and monitoring systems in environments where mistakes are learning opportunities rather than costly errors.
Start simple, learn fast
Start with agents that handle one straightforward task, like flagging unusual transaction patterns, monitoring compliance deadlines, or automating document classification.
You&#x27;ll get tangible operational improvements while keeping human judgment firmly in the loop while building the organizational muscle memory needed for more ambitious agent applications. When you eventually tackle higher-risk use cases, you&#x27;ll have technical capabilities and confidence built through experience rather than theoretical assumptions about how agents might perform in your specific environment.
### Scaling across the organization
Success with initial implementations opens the door to enterprise-wide capabilities. The key is moving from point solutions to shared infrastructure that serves multiple departments.
Building reusable foundations
Your organization will get better results when you build foundational AI agent capabilities that serve multiple departments rather than deploying one-off solutions for individual problems.
For example, you might implement a document processing capability that could be used across your organization. The same AI system that automates bank reconciliations and invoice processing can help compliance teams analyze regulatory documents and support various departments with financial data extraction. Each department contributes use cases that strengthen the core capability while benefiting from improvements driven by other teams.
Earning trust with stakeholders
Agents interact with both your workforce and your customers, and each group will respond differently to AI-assisted processes. Trust-building matters as much as technical deployment.
For customers, transparency matters. Make it clear when they&#x27;re interacting with an AI agent versus a human, explain what the agent can and cannot do, and provide straightforward pathways to human specialists when needed. This clarity builds confidence and encourages broader adoption of AI-assisted services.
Internal adoption follows similar principles. Your organization already has change management processes for new systems. Apply them here. Staff need to understand how agents work, when to trust their recommendations, and how to escalate concerns.
Frame the conversation around enhancement rather than replacement. For example,  Block&#x27;s internal AI agent reached 4,000 active users out of 10,000 employees across 15 different job profiles (sales, design, product, customer success, and operations). Adoption doubled in one month, with user engagement increasing 40-50% weekly as employees found new ways to use it. 
The most successful implementations emphasize how AI enhances human capabilities rather than replacing them.
Advancing to complex use cases
At this stage, your organization has an augmented workforce, refined core capabilities, demonstrated wins, and experienced teams ready for larger challenges. The lessons learned from early implementations provide the foundation for more complex agent deployments.
The observability and human-in-the-loop mechanisms you built for simpler use cases become even more critical as complexity increases. More than ever, your implementation needs:
- Comprehensive audit trails that track every agent decision and data source used, enabling review and regulatory compliance
- Real-time monitoring systems that detect when agents encounter edge cases or uncertain scenarios requiring human judgment
- Escalation protocols that automatically route complex cases to appropriate specialists based on clear criteria
- Performance metrics that measure not just technical accuracy but business outcomes and workflow integration success
## Taking action
AI agents represent a significant opportunity to address persistent challenges in financial services. Success requires thoughtful implementation that balances technological capability with industry-specific requirements. This approach delivers quick wins that build confidence while establishing the foundation for more sophisticated initiatives.
The path forward demands partnership between technology and business teams. Financial services leaders who prioritize customer protection through robust testing and escalation pathways, and build modular systems that evolve with advancing AI capabilities, will lead the way.
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
