# AutoMicLock GitHub Pages Redesign — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Full rewrite of `docs/index.html` + `docs/style.css` into a modern Apple Design System landing page with animated background, live GitHub stars, FAQ accordion, Before/After toggle, and menu bar preview mockup.

**Architecture:** Two-file static site — all markup in `index.html`, all styles in `style.css`, all JS inline at bottom of `index.html`. No build step, no dependencies beyond Google Fonts (Inter). Deployed as-is via GitHub Pages from the `docs/` folder.

**Tech Stack:** Vanilla HTML5, CSS3 (custom properties, keyframes, IntersectionObserver), ES6 JS (fetch, clipboard API), Google Fonts (Inter)

---

## File Map

| File | Action | Responsibility |
|---|---|---|
| `docs/index.html` | Full rewrite | All markup + inline JS |
| `docs/style.css` | Full rewrite | All styles (design tokens, layout, animations) |
| `docs/icon.png` | Keep | App icon used in nav, hero, footer |

---

### Task 1: CSS Foundation — Design Tokens + Reset

**Files:**
- Rewrite: `docs/style.css`

- [ ] **Step 1: Write the new style.css with design tokens and reset**

```css
/* docs/style.css */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

:root {
  --bg: #000000;
  --bg-card: rgba(255, 255, 255, 0.05);
  --bg-card-hover: rgba(255, 255, 255, 0.08);
  --border: rgba(255, 255, 255, 0.08);
  --border-hover: rgba(255, 255, 255, 0.15);
  --text-primary: #ffffff;
  --text-secondary: #8e8e93;
  --text-tertiary: #636366;
  --accent-blue: #0a84ff;
  --accent-green: #30d158;
  --accent-red: #ff453a;
  --accent-gold: #ffd60a;
  --gradient-text: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
  --radius-sm: 8px;
  --radius-md: 12px;
  --radius-lg: 20px;
  --radius-xl: 27px;
  --radius-pill: 980px;
  --shadow-icon: 0 24px 48px rgba(0, 0, 0, 0.6), 0 0 0 1px rgba(255, 255, 255, 0.08);
  --transition-base: 0.2s ease;
  --transition-slow: 0.5s ease;
}

*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
html { scroll-behavior: smooth; }
body {
  font-family: -apple-system, 'SF Pro Display', 'Inter', sans-serif;
  background: var(--bg);
  color: var(--text-primary);
  line-height: 1.6;
  -webkit-font-smoothing: antialiased;
  overflow-x: hidden;
}
.container { max-width: 1000px; margin: 0 auto; padding: 0 24px; }
.text-center { text-align: center; }

/* Scroll reveal base state */
.reveal {
  opacity: 0;
  transform: translateY(24px);
  transition: opacity var(--transition-slow), transform var(--transition-slow);
}
.reveal.visible { opacity: 1; transform: translateY(0); }

/* Animated Background */
.bg-glow {
  position: fixed;
  inset: 0;
  z-index: -1;
  pointer-events: none;
  background: radial-gradient(ellipse 700px 500px at 50% 30%, rgba(10,132,255,0.10) 0%, transparent 70%);
}
```

- [ ] **Step 2: Commit**

```bash
git add docs/style.css
git commit -m "style: CSS design tokens, reset, and scroll reveal foundation"
```

---

### Task 2: HTML Skeleton + Mouse-Tracking Background

**Files:**
- Rewrite: `docs/index.html`

- [ ] **Step 1: Write index.html skeleton**

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Auto MicLock: Force macOS to use built-in microphone</title>
  <meta name="description" content="A lightweight macOS utility that prevents macOS from automatically switching the microphone input to Bluetooth headphones.">
  <meta name="keywords" content="mac microphone keeps switching, stop AirPods microphone switching Mac, force Mac built-in microphone">
  <meta property="og:title" content="Auto MicLock for macOS">
  <meta property="og:description" content="Fix automatic microphone switching on Mac and improve your Bluetooth audio quality during calls.">
  <meta property="og:type" content="website">
  <meta property="og:image" content="icon.png">
  <link rel="icon" href="icon.png" type="image/png">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="bg-glow" id="bg-glow" aria-hidden="true"></div>

  <!-- Sections added in subsequent tasks -->

  <script>
    // Mouse-tracking background — lerp for smooth follow
    const bgGlow = document.getElementById('bg-glow');
    let mx = 50, my = 30, cx = 50, cy = 30;
    document.addEventListener('mousemove', function(e) {
      mx = (e.clientX / window.innerWidth) * 100;
      my = (e.clientY / window.innerHeight) * 100;
    });
    function animateGlow() {
      cx += (mx - cx) * 0.06;
      cy += (my - cy) * 0.06;
      bgGlow.style.background =
        'radial-gradient(ellipse 700px 500px at ' + cx + '% ' + cy + '%, rgba(10,132,255,0.10) 0%, transparent 70%)';
      requestAnimationFrame(animateGlow);
    }
    animateGlow();
  </script>
</body>
</html>
```

- [ ] **Step 2: Open in browser — move mouse, blue glow follows cursor on black page**

- [ ] **Step 3: Commit**

```bash
git add docs/index.html
git commit -m "feat: HTML skeleton with mouse-tracking background glow"
```

---

### Task 3: Navbar

**Files:**
- Modify: `docs/index.html` — add nav after bg-glow div
- Modify: `docs/style.css` — append navbar styles

- [ ] **Step 1: Add navbar HTML** (after `<div class="bg-glow" ...>`)

```html
<nav class="navbar" id="navbar">
  <div class="container nav-inner">
    <a href="#" class="nav-brand">
      <img src="icon.png" alt="Auto MicLock" class="nav-icon">
      <span>Auto MicLock</span>
    </a>
    <a href="https://github.com/BFMIX/AutoMicLock/releases/latest" class="nav-cta">
      Download Free
    </a>
  </div>
</nav>
```

- [ ] **Step 2: Append navbar styles to docs/style.css**

```css
/* Navbar */
.navbar {
  position: sticky; top: 0; z-index: 100;
  background: rgba(0,0,0,0.75);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--border);
  transition: transform var(--transition-base);
}
.navbar.hidden { transform: translateY(-100%); }
.nav-inner {
  display: flex; justify-content: space-between; align-items: center;
  padding-top: 14px; padding-bottom: 14px;
}
.nav-brand {
  display: flex; align-items: center; gap: 10px;
  font-size: 0.95rem; font-weight: 600;
  color: var(--text-primary); text-decoration: none;
}
.nav-icon { width: 28px; height: 28px; border-radius: 7px; border: 1px solid var(--border); }
.nav-cta {
  background: var(--text-primary); color: var(--bg);
  padding: 8px 18px; border-radius: var(--radius-pill);
  font-size: 0.85rem; font-weight: 600; text-decoration: none;
  transition: opacity var(--transition-base);
}
.nav-cta:hover { opacity: 0.85; }
```

- [ ] **Step 3: Add hide-on-scroll JS** (append inside the `<script>` block before closing tag)

```javascript
var lastScroll = 0;
var navbar = document.getElementById('navbar');
window.addEventListener('scroll', function() {
  var current = window.scrollY;
  if (current > lastScroll && current > 50) {
    navbar.classList.add('hidden');
  } else {
    navbar.classList.remove('hidden');
  }
  lastScroll = current;
}, { passive: true });
```

- [ ] **Step 4: Verify — sticky nav, blurs background, hides when scrolling down**

- [ ] **Step 5: Commit**

```bash
git add docs/index.html docs/style.css
git commit -m "feat: sticky navbar with hide-on-scroll behavior"
```

---

### Task 4: Hero Section + GitHub Stars

**Files:**
- Modify: `docs/index.html` — add header after nav
- Modify: `docs/style.css` — append hero styles

- [ ] **Step 1: Add hero HTML** (after `</nav>`)

```html
<header class="hero">
  <div class="container hero-inner">
    <p class="eyebrow">macOS Utility &middot; Free &amp; Open Source</p>
    <img src="icon.png" alt="Auto MicLock icon" class="hero-icon">
    <h1>Lock your mic.<br><span class="gradient-text">Unlock HD audio.</span></h1>
    <p class="hero-subtitle">
      Prevents macOS from switching your microphone to Bluetooth &mdash;
      keeping your AirPods in high-fidelity mode during every call.
    </p>
    <div class="cta-group">
      <a href="https://github.com/BFMIX/AutoMicLock/releases/latest" class="btn btn-primary">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
        Download for macOS
      </a>
      <a href="https://github.com/BFMIX/AutoMicLock" class="btn btn-secondary">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"/></svg>
        View on GitHub
      </a>
    </div>
    <div class="hero-badges">
      <span class="badge badge-gold" id="stars-badge" style="display:none">
        &#9733; <span id="stars-count"></span>
      </span>
      <span class="badge">macOS 13+</span>
      <span class="badge">Intel &amp; Apple Silicon</span>
      <span class="badge">Open Source</span>
    </div>
  </div>
</header>
```

- [ ] **Step 2: Append hero styles to docs/style.css**

```css
/* Hero */
@keyframes float {
  0%, 100% { transform: translateY(0); }
  50%       { transform: translateY(-10px); }
}
.hero { padding: 90px 0 70px; text-align: center; }
.hero-inner { display: flex; flex-direction: column; align-items: center; }
.eyebrow {
  font-size: 0.72rem; font-weight: 600;
  letter-spacing: 0.12em; text-transform: uppercase;
  color: var(--accent-blue); margin-bottom: 28px;
}
.hero-icon {
  width: 120px; height: 120px;
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-icon);
  animation: float 6s ease-in-out infinite;
  margin-bottom: 32px;
}
h1 {
  font-size: clamp(2.4rem, 6vw, 3.8rem);
  font-weight: 800; letter-spacing: -0.04em; line-height: 1.05;
  margin-bottom: 20px;
}
.gradient-text {
  background: var(--gradient-text);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
.hero-subtitle {
  font-size: 1.15rem; color: var(--text-secondary);
  max-width: 560px; margin: 0 auto 36px;
}
.cta-group {
  display: flex; gap: 12px; justify-content: center;
  flex-wrap: wrap; margin-bottom: 28px;
}
.btn {
  display: inline-flex; align-items: center; gap: 8px;
  padding: 13px 26px; border-radius: var(--radius-pill);
  font-size: 0.95rem; font-weight: 600; text-decoration: none;
  transition: transform var(--transition-base), box-shadow var(--transition-base), opacity var(--transition-base);
}
.btn-primary {
  background: var(--text-primary); color: var(--bg);
  box-shadow: 0 4px 20px rgba(255,255,255,0.15);
}
.btn-primary:hover { transform: scale(1.02); box-shadow: 0 8px 28px rgba(255,255,255,0.22); }
.btn-secondary {
  background: rgba(255,255,255,0.08); color: var(--text-primary);
  border: 1px solid var(--border);
}
.btn-secondary:hover { background: rgba(255,255,255,0.13); }
.hero-badges { display: flex; gap: 10px; justify-content: center; flex-wrap: wrap; align-items: center; }
.badge {
  display: inline-flex; align-items: center; gap: 5px;
  background: rgba(255,255,255,0.05); border: 1px solid var(--border);
  border-radius: var(--radius-pill); padding: 5px 12px;
  font-size: 0.75rem; font-weight: 500; color: var(--text-secondary);
}
.badge-gold {
  background: rgba(255,214,10,0.07); border-color: rgba(255,214,10,0.25);
  color: var(--accent-gold);
}
```

- [ ] **Step 3: Add GitHub stars fetch JS** (append in `<script>` block)

```javascript
fetch('https://api.github.com/repos/BFMIX/AutoMicLock')
  .then(function(r) { return r.json(); })
  .then(function(d) {
    if (typeof d.stargazers_count === 'number') {
      document.getElementById('stars-count').textContent = d.stargazers_count + ' stars';
      document.getElementById('stars-badge').style.display = 'inline-flex';
    }
  })
  .catch(function() {});
```

- [ ] **Step 4: Verify — floating icon animation, gradient headline, buttons, stars badge (if online)**

- [ ] **Step 5: Commit**

```bash
git add docs/index.html docs/style.css
git commit -m "feat: hero section with floating icon, CTAs, and live GitHub stars"
```

---

### Task 5: Menu Bar Preview

**Files:**
- Modify: `docs/index.html` — add section after `</header>`
- Modify: `docs/style.css` — append menubar styles

- [ ] **Step 1: Add menu bar section HTML**

```html
<main>
<section class="section menubar-section reveal">
  <div class="container text-center">
    <p class="section-eyebrow">Always running, never in the way</p>
    <h2>Lives quietly in your menu bar.</h2>
    <p class="section-desc">One click to enable. Runs silently at login. Zero CPU on standby.</p>
    <div class="menubar-mockup">
      <div class="menubar-strip">
        <span class="menubar-left">
          <span class="menubar-apple">&#xF8FF;</span>
          <span class="menubar-appname">Finder</span>
          <span class="menubar-menu">File</span>
          <span class="menubar-menu">Edit</span>
          <span class="menubar-menu">View</span>
        </span>
        <span class="menubar-right">
          <span class="menubar-time">9:41</span>
          <span class="menubar-appicon-wrap">
            <img src="icon.png" alt="" class="menubar-appicon">
            <span class="menubar-dot" aria-hidden="true"></span>
          </span>
          <span class="menubar-sysicon">&#9776;</span>
          <span class="menubar-sysicon">&#128267;</span>
        </span>
      </div>
      <div class="menubar-dropdown">
        <div class="menubar-dd-header">
          <img src="icon.png" alt="" class="menubar-dd-icon">
          <div>
            <div class="menubar-dd-title">Auto MicLock</div>
            <div class="menubar-dd-status">Microphone locked</div>
          </div>
        </div>
        <div class="menubar-divider"></div>
        <div class="menubar-dd-item menubar-dd-active">
          <span class="menubar-check">&#10003;</span> Lock microphone input
        </div>
        <div class="menubar-dd-item">
          <span class="menubar-check"></span> Launch at Login
        </div>
        <div class="menubar-divider"></div>
        <div class="menubar-dd-item menubar-dd-muted">Quit Auto MicLock</div>
      </div>
    </div>
  </div>
</section>
```

Note: `</main>` closing tag added in Task 10 (footer task).

- [ ] **Step 2: Append menubar + shared section styles to docs/style.css**

```css
/* Shared section styles */
.section { padding: 80px 0; }
.section-eyebrow {
  font-size: 0.72rem; font-weight: 600;
  letter-spacing: 0.1em; text-transform: uppercase;
  color: var(--accent-blue); margin-bottom: 12px;
}
.section h2 {
  font-size: clamp(1.8rem, 4vw, 2.6rem);
  font-weight: 700; letter-spacing: -0.03em; margin-bottom: 12px;
}
.section-desc {
  color: var(--text-secondary); font-size: 1.05rem;
  margin-bottom: 48px; max-width: 600px;
  margin-left: auto; margin-right: auto;
}

/* Menu Bar Mockup */
.menubar-mockup {
  max-width: 700px; margin: 0 auto;
  border-radius: var(--radius-lg); overflow: hidden;
  border: 1px solid var(--border);
  box-shadow: 0 32px 64px rgba(0,0,0,0.6);
}
.menubar-strip {
  background: rgba(28,28,30,0.98);
  display: flex; justify-content: space-between; align-items: center;
  padding: 0 16px; height: 28px;
  font-size: 0.7rem; color: rgba(255,255,255,0.85);
  border-bottom: 1px solid rgba(255,255,255,0.06);
}
.menubar-left, .menubar-right { display: flex; align-items: center; gap: 12px; }
.menubar-apple { font-size: 0.85rem; }
.menubar-appname { font-weight: 600; }
.menubar-menu { color: rgba(255,255,255,0.7); }
.menubar-time { font-size: 0.68rem; font-weight: 500; }
.menubar-appicon-wrap { position: relative; display: flex; align-items: center; }
.menubar-appicon { width: 16px; height: 16px; border-radius: 3px; }
.menubar-dot {
  width: 5px; height: 5px; background: var(--accent-green);
  border-radius: 50%; position: absolute; bottom: -1px; right: -2px;
  box-shadow: 0 0 4px rgba(48,209,88,0.8);
}
.menubar-sysicon { font-size: 0.75rem; opacity: 0.7; }
.menubar-dropdown { background: rgba(28,28,30,0.98); padding: 8px 0; }
.menubar-dd-header { display: flex; align-items: center; gap: 12px; padding: 10px 16px 12px; }
.menubar-dd-icon { width: 36px; height: 36px; border-radius: 8px; }
.menubar-dd-title { font-size: 0.85rem; font-weight: 600; }
.menubar-dd-status { font-size: 0.75rem; color: var(--accent-green); margin-top: 2px; }
.menubar-divider { height: 1px; background: var(--border); margin: 4px 0; }
.menubar-dd-item {
  display: flex; align-items: center; gap: 8px;
  padding: 6px 16px; font-size: 0.82rem; color: var(--text-primary);
}
.menubar-dd-active { color: var(--accent-blue); }
.menubar-dd-muted { color: var(--text-secondary); }
.menubar-check { width: 14px; font-size: 0.75rem; color: var(--accent-blue); }
```

- [ ] **Step 3: Verify mockup looks like a real macOS menu bar with dropdown visible**

- [ ] **Step 4: Commit**

```bash
git add docs/index.html docs/style.css
git commit -m "feat: macOS menu bar preview mockup section"
```

---

### Task 6: Before / After Toggle

**Files:**
- Modify: `docs/index.html` — add section after menubar section
- Modify: `docs/style.css` — append before/after styles

- [ ] **Step 1: Add Before/After HTML**

```html
<section class="section ba-section reveal">
  <div class="container text-center">
    <p class="section-eyebrow">The difference is dramatic</p>
    <h2>Hear the difference.</h2>
    <p class="section-desc">HFP profile collapses audio quality. AutoMicLock keeps A2DP active at all times.</p>
    <div class="ba-toggle-group" role="group" aria-label="Audio quality comparison">
      <button class="ba-btn ba-active" id="btn-without" onclick="setBA('without')">Without AutoMicLock</button>
      <button class="ba-btn" id="btn-with" onclick="setBA('with')">With AutoMicLock</button>
    </div>
    <div class="ba-card" id="ba-without">
      <div class="ba-waveform waveform-bad" aria-hidden="true">
        <span style="height:12px"></span><span style="height:20px"></span>
        <span style="height:14px"></span><span style="height:18px"></span>
        <span style="height:10px"></span><span style="height:22px"></span>
        <span style="height:16px"></span><span style="height:12px"></span>
        <span style="height:20px"></span><span style="height:14px"></span>
        <span style="height:10px"></span><span style="height:18px"></span>
        <span style="height:12px"></span><span style="height:20px"></span>
        <span style="height:8px"></span>
      </div>
      <span class="ba-badge ba-badge-bad">HFP Profile &mdash; Low Quality</span>
      <p class="ba-desc">Bluetooth mic active. Audio downgraded to Hands-Free Profile &mdash; muffled, distorted, like a 2003 phone call.</p>
    </div>
    <div class="ba-card ba-hidden" id="ba-with">
      <div class="ba-waveform waveform-good" aria-hidden="true">
        <span style="height:20px"></span><span style="height:40px"></span>
        <span style="height:55px"></span><span style="height:65px"></span>
        <span style="height:55px"></span><span style="height:70px"></span>
        <span style="height:60px"></span><span style="height:75px"></span>
        <span style="height:60px"></span><span style="height:70px"></span>
        <span style="height:55px"></span><span style="height:65px"></span>
        <span style="height:45px"></span><span style="height:30px"></span>
        <span style="height:16px"></span>
      </div>
      <span class="ba-badge ba-badge-good">A2DP Profile &mdash; HD Audio</span>
      <p class="ba-desc">Built-in mic active. Headphones stay in high-bandwidth A2DP mode &mdash; crystal-clear stereo, full frequency range.</p>
    </div>
  </div>
</section>
```

- [ ] **Step 2: Append Before/After styles to docs/style.css**

```css
/* Before / After */
.ba-toggle-group {
  display: inline-flex;
  background: rgba(255,255,255,0.05); border: 1px solid var(--border);
  border-radius: var(--radius-pill); padding: 4px; gap: 4px;
  margin-bottom: 32px;
}
.ba-btn {
  background: none; border: none;
  color: var(--text-secondary); font-family: inherit;
  font-size: 0.85rem; font-weight: 600;
  padding: 8px 20px; border-radius: var(--radius-pill);
  cursor: pointer; transition: all var(--transition-base);
}
.ba-active {
  background: var(--bg-card-hover);
  color: var(--text-primary);
  border: 1px solid var(--border-hover);
}
.ba-card {
  background: var(--bg-card); border: 1px solid var(--border);
  border-radius: var(--radius-lg); padding: 40px;
  max-width: 680px; margin: 0 auto;
  transition: opacity 0.3s ease;
}
.ba-hidden { display: none; }
.ba-waveform {
  display: flex; align-items: center; justify-content: center;
  gap: 4px; height: 80px; margin-bottom: 20px;
}
.ba-waveform span { width: 4px; border-radius: 2px; display: block; }
.waveform-bad span { background: var(--accent-red); opacity: 0.6; }
@keyframes wave {
  0%, 100% { transform: scaleY(1); }
  50%       { transform: scaleY(1.6); }
}
.waveform-good span {
  background: var(--accent-green);
  animation: wave 0.8s ease-in-out infinite;
}
.waveform-good span:nth-child(1)  { animation-delay: 0.00s; }
.waveform-good span:nth-child(2)  { animation-delay: 0.05s; }
.waveform-good span:nth-child(3)  { animation-delay: 0.10s; }
.waveform-good span:nth-child(4)  { animation-delay: 0.15s; }
.waveform-good span:nth-child(5)  { animation-delay: 0.20s; }
.waveform-good span:nth-child(6)  { animation-delay: 0.25s; }
.waveform-good span:nth-child(7)  { animation-delay: 0.30s; }
.waveform-good span:nth-child(8)  { animation-delay: 0.35s; }
.waveform-good span:nth-child(9)  { animation-delay: 0.40s; }
.waveform-good span:nth-child(10) { animation-delay: 0.45s; }
.waveform-good span:nth-child(11) { animation-delay: 0.50s; }
.waveform-good span:nth-child(12) { animation-delay: 0.55s; }
.waveform-good span:nth-child(13) { animation-delay: 0.60s; }
.waveform-good span:nth-child(14) { animation-delay: 0.65s; }
.waveform-good span:nth-child(15) { animation-delay: 0.70s; }
.ba-badge {
  display: inline-block; padding: 5px 14px;
  border-radius: var(--radius-pill); font-size: 0.78rem; font-weight: 600;
  margin-bottom: 12px;
}
.ba-badge-bad  { background: rgba(255,69,58,0.12); color: var(--accent-red);   border: 1px solid rgba(255,69,58,0.25); }
.ba-badge-good { background: rgba(48,209,88,0.12); color: var(--accent-green); border: 1px solid rgba(48,209,88,0.25); }
.ba-desc { color: var(--text-secondary); font-size: 0.95rem; max-width: 480px; margin: 0 auto; }
```

- [ ] **Step 3: Add toggle JS** (append in script block)

```javascript
function setBA(state) {
  var withoutCard = document.getElementById('ba-without');
  var withCard    = document.getElementById('ba-with');
  var btnWithout  = document.getElementById('btn-without');
  var btnWith     = document.getElementById('btn-with');
  if (state === 'without') {
    withoutCard.classList.remove('ba-hidden');
    withCard.classList.add('ba-hidden');
    btnWithout.classList.add('ba-active');
    btnWith.classList.remove('ba-active');
  } else {
    withoutCard.classList.add('ba-hidden');
    withCard.classList.remove('ba-hidden');
    btnWithout.classList.remove('ba-active');
    btnWith.classList.add('ba-active');
  }
}
```

- [ ] **Step 4: Verify — toggle switches cards, green waveform animates in "With" state**

- [ ] **Step 5: Commit**

```bash
git add docs/index.html docs/style.css
git commit -m "feat: Before/After audio quality toggle with animated waveform"
```

---

### Task 7: Problem/Solution + How It Works + Compatible Apps

**Files:**
- Modify: `docs/index.html` — append 3 sections
- Modify: `docs/style.css` — append styles

- [ ] **Step 1: Add 3 sections HTML** (after Before/After section)

```html
<section class="section reveal">
  <div class="container split-layout">
    <div class="card glass">
      <div class="card-icon card-icon-red">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
      </div>
      <h3>The Problem</h3>
      <p>macOS automatically switches your microphone input to Bluetooth devices when they connect. Because of Bluetooth bandwidth limits, activating the headset microphone forces the connection into a low-quality &ldquo;Hands-Free Profile&rdquo;. This instantly ruins audio quality, making everything sound muffled and distorted like a bad phone call.</p>
    </div>
    <div class="card glass">
      <div class="card-icon card-icon-green">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
      </div>
      <h3>The Solution</h3>
      <p>Auto MicLock silently monitors your system audio. If macOS attempts to switch the input to your Bluetooth headset, the app instantly forces the input back to your Mac&rsquo;s built-in microphone. Your Bluetooth headphones remain in high-fidelity mode (AAC/SBC) at all times.</p>
    </div>
  </div>
</section>

<section class="section reveal">
  <div class="container text-center">
    <p class="section-eyebrow">Under the hood</p>
    <h2>How it works.</h2>
    <p class="section-desc">Unlike hacky scripts that run infinite loops, Auto MicLock is a <strong>100% native macOS app</strong> written in pure Swift.</p>
    <div class="tech-grid">
      <div class="tech-card">
        <h4 class="tech-title tech-blue">CoreAudio Event-Driven</h4>
        <p>Uses native <code>AudioObjectAddPropertyListenerBlock</code> to listen for hardware changes. Only wakes up when macOS tries to change the default input &mdash; <strong>0% CPU usage</strong> on standby.</p>
      </div>
      <div class="tech-card">
        <h4 class="tech-title tech-purple">No External Dependencies</h4>
        <p>Does not rely on Automator, SwitchAudioSource, or bash loops. Directly sets the <code>kAudioDeviceTransportTypeBuiltIn</code> device via low-level system APIs.</p>
      </div>
      <div class="tech-card">
        <h4 class="tech-title tech-green">SMAppService</h4>
        <p>Uses the modern macOS 13+ background service API to launch silently at login without creating messy <code>LaunchAgents</code> or plist files.</p>
      </div>
    </div>
  </div>
</section>

<section class="section reveal">
  <div class="container text-center">
    <h2>Better audio quality everywhere.</h2>
    <p class="section-desc">Maintain stable, high-fidelity sound during calls and recordings.</p>
    <div class="apps-grid">
      <div class="app-badge">Zoom</div>
      <div class="app-badge">Google Meet</div>
      <div class="app-badge">Microsoft Teams</div>
      <div class="app-badge">Discord</div>
      <div class="app-badge">OBS Studio</div>
    </div>
    <p class="compat-note">Works automatically with AirPods, Sony WH-1000XM, Bose QuietComfort, Beats, and any Bluetooth headset that triggers macOS auto-switch.</p>
  </div>
</section>
```

- [ ] **Step 2: Append styles to docs/style.css**

```css
/* Problem / Solution */
.split-layout { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
.glass {
  background: var(--bg-card); border: 1px solid var(--border);
  border-radius: 24px; padding: 40px;
  transition: transform var(--transition-base), background var(--transition-base);
}
.glass:hover { transform: translateY(-4px); background: var(--bg-card-hover); }
.card-icon {
  width: 44px; height: 44px; border-radius: var(--radius-sm);
  display: flex; align-items: center; justify-content: center;
  margin-bottom: 20px;
}
.card-icon-red   { background: rgba(255,69,58,0.15);  color: var(--accent-red); }
.card-icon-green { background: rgba(48,209,88,0.15); color: var(--accent-green); }
.glass h3 { font-size: 1.3rem; font-weight: 700; margin-bottom: 12px; }
.glass p  { color: var(--text-secondary); font-size: 1rem; line-height: 1.7; }

/* Technical cards */
.tech-grid {
  display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 20px; text-align: left;
}
.tech-card {
  background: var(--bg-card); border: 1px solid var(--border);
  border-radius: var(--radius-md); padding: 28px;
}
.tech-title { font-size: 1rem; font-weight: 700; margin-bottom: 10px; }
.tech-blue   { color: var(--accent-blue); }
.tech-purple { color: #bf5af2; }
.tech-green  { color: var(--accent-green); }
.tech-card p { color: var(--text-secondary); font-size: 0.9rem; line-height: 1.65; }
code {
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
  font-size: 0.85em; background: rgba(255,255,255,0.08);
  padding: 2px 6px; border-radius: 4px; color: #e5e5ea;
}

/* Compatible apps */
.apps-grid { display: flex; gap: 12px; justify-content: center; flex-wrap: wrap; margin-bottom: 24px; }
.app-badge {
  background: var(--bg-card); border: 1px solid var(--border);
  border-radius: var(--radius-md); padding: 14px 22px;
  font-size: 0.9rem; font-weight: 600;
  transition: border-color var(--transition-base), background var(--transition-base);
}
.app-badge:hover { border-color: var(--border-hover); background: var(--bg-card-hover); }
.compat-note { color: var(--text-secondary); font-size: 0.9rem; max-width: 600px; margin: 0 auto; }
```

- [ ] **Step 3: Verify 3 sections render — hover on glass cards lifts them**

- [ ] **Step 4: Commit**

```bash
git add docs/index.html docs/style.css
git commit -m "feat: Problem/Solution, How It Works, Compatible Apps sections"
```

---

### Task 8: FAQ Accordion

**Files:**
- Modify: `docs/index.html` — append FAQ section
- Modify: `docs/style.css` — append FAQ styles

- [ ] **Step 1: Add FAQ HTML**

```html
<section class="section faq-section reveal">
  <div class="container">
    <h2 class="text-center">Frequently Asked Questions</h2>
    <div class="faq-list">

      <details class="faq-item">
        <summary class="faq-q">
          Why does macOS switch microphones automatically?
          <span class="faq-chevron" aria-hidden="true">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>
          </span>
        </summary>
        <div class="faq-a"><p>Apple designed macOS to default to the newest connected audio device. While convenient for speakers, it's highly problematic for Bluetooth headphones because activating their microphone degrades the output audio quality drastically due to Bluetooth profile limitations.</p></div>
      </details>

      <details class="faq-item">
        <summary class="faq-q">
          Why doesn't Apple just fix this?
          <span class="faq-chevron" aria-hidden="true">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>
          </span>
        </summary>
        <div class="faq-a"><p>Apple assumes that if you connect a headset, you want to use its microphone. They haven't provided a user-facing toggle to say "always prefer my Mac's built-in microphone". Auto MicLock exists to provide that missing toggle.</p></div>
      </details>

      <details class="faq-item">
        <summary class="faq-q">
          Does this actually improve audio quality?
          <span class="faq-chevron" aria-hidden="true">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>
          </span>
        </summary>
        <div class="faq-a"><p>Yes. By preventing your Mac from using the Bluetooth microphone, your headphones stay in the high-bandwidth A2DP profile (stereo, high bitrate). You will hear colleagues and music in full HD, while they hear you clearly through your Mac's internal microphone.</p></div>
      </details>

      <details class="faq-item">
        <summary class="faq-q">
          Do I need to keep the app open?
          <span class="faq-chevron" aria-hidden="true">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>
          </span>
        </summary>
        <div class="faq-a"><p>Auto MicLock sits quietly in your macOS Menu Bar. Enable "Launch at Login" from the menu so it runs automatically in the background every time you start your Mac. You never have to think about it again.</p></div>
      </details>

      <details class="faq-item">
        <summary class="faq-q">
          Is it free and open source?
          <span class="faq-chevron" aria-hidden="true">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>
          </span>
        </summary>
        <div class="faq-a"><p>Yes, 100% free and open source. Built with native Swift and CoreAudio APIs — zero telemetry, no data collection, and no impact on your Mac's performance.</p></div>
      </details>

    </div>
  </div>
</section>
```

- [ ] **Step 2: Append FAQ styles to docs/style.css**

```css
/* FAQ Accordion */
.faq-section h2 { margin-bottom: 40px; }
.faq-list { max-width: 700px; margin: 0 auto; display: flex; flex-direction: column; gap: 12px; }
.faq-item {
  background: var(--bg-card); border: 1px solid var(--border);
  border-radius: var(--radius-md); overflow: hidden;
  transition: border-color var(--transition-base);
}
.faq-item[open] { border-color: var(--border-hover); }
.faq-item[open] .faq-chevron { transform: rotate(180deg); }
.faq-q {
  display: flex; justify-content: space-between; align-items: center;
  padding: 18px 22px; font-size: 1rem; font-weight: 600;
  cursor: pointer; list-style: none; color: var(--text-primary); gap: 16px;
}
.faq-q::-webkit-details-marker { display: none; }
.faq-chevron {
  flex-shrink: 0; color: var(--text-secondary);
  transition: transform 0.25s ease; display: flex;
}
.faq-a {
  padding: 0 22px 18px;
  animation: faqOpen 0.25s ease;
}
.faq-a p { color: var(--text-secondary); font-size: 0.95rem; line-height: 1.7; }
@keyframes faqOpen {
  from { opacity: 0; transform: translateY(-6px); }
  to   { opacity: 1; transform: translateY(0); }
}
```

- [ ] **Step 3: Verify — click items to open/close, chevron rotates, animation smooth**

- [ ] **Step 4: Commit**

```bash
git add docs/index.html docs/style.css
git commit -m "feat: FAQ accordion with smooth open/close animation"
```

---

### Task 9: Terminal Install + Copy Button

**Files:**
- Modify: `docs/index.html` — append install section
- Modify: `docs/style.css` — append install styles

- [ ] **Step 1: Add install section HTML**

```html
<section class="section install-section reveal">
  <div class="container text-center">
    <p class="section-eyebrow">Power Users</p>
    <h2>Install from terminal.</h2>
    <p class="section-desc">One command. Done.</p>
    <div class="code-wrapper">
      <div class="code-block">
        <code id="install-cmd">curl -fsSL https://raw.githubusercontent.com/BFMIX/AutoMicLock/main/install.sh | bash</code>
      </div>
      <button class="copy-btn" id="copy-btn" onclick="copyInstall()" aria-label="Copy install command">
        <svg class="icon-copy" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="9" y="9" width="13" height="13" rx="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>
        <svg class="icon-check" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" style="display:none"><polyline points="20 6 9 17 4 12"/></svg>
        <span id="copy-label">Copy</span>
      </button>
    </div>
  </div>
</section>
```

- [ ] **Step 2: Append install styles to docs/style.css**

```css
/* Terminal Install */
.install-section .section-desc { margin-bottom: 28px; }
.code-wrapper { position: relative; display: inline-block; max-width: 100%; }
.code-block {
  background: #0d0d0d; border: 1px solid #2a2a2a;
  border-radius: var(--radius-md); padding: 18px 72px 18px 22px;
  overflow-x: auto; max-width: 100%;
}
.code-block code {
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
  font-size: 0.9rem; color: #32d74b;
  background: none; padding: 0; white-space: nowrap;
}
.copy-btn {
  position: absolute; top: 50%; right: 12px;
  transform: translateY(-50%);
  background: rgba(255,255,255,0.07); border: 1px solid var(--border);
  border-radius: var(--radius-sm); color: var(--text-secondary);
  font-size: 0.75rem; font-weight: 600; font-family: inherit;
  padding: 6px 10px; cursor: pointer;
  display: flex; align-items: center; gap: 5px;
  transition: all var(--transition-base);
}
.copy-btn:hover { background: rgba(255,255,255,0.12); color: var(--text-primary); }
.copy-btn.copied {
  color: var(--accent-green);
  border-color: rgba(48,209,88,0.3);
  background: rgba(48,209,88,0.08);
}
```

- [ ] **Step 3: Add copy JS** (append in script block — uses separate SVG elements, no DOM manipulation of SVG paths)

```javascript
function copyInstall() {
  var cmd = document.getElementById('install-cmd').textContent;
  navigator.clipboard.writeText(cmd).then(function() {
    var btn    = document.getElementById('copy-btn');
    var label  = document.getElementById('copy-label');
    var iconCopy  = btn.querySelector('.icon-copy');
    var iconCheck = btn.querySelector('.icon-check');
    btn.classList.add('copied');
    label.textContent = 'Copied!';
    iconCopy.style.display  = 'none';
    iconCheck.style.display = 'block';
    setTimeout(function() {
      btn.classList.remove('copied');
      label.textContent = 'Copy';
      iconCopy.style.display  = '';
      iconCheck.style.display = 'none';
    }, 2000);
  }).catch(function() {});
}
```

- [ ] **Step 4: Verify — click Copy, paste in terminal editor to confirm command, see "Copied!" state for 2s**

- [ ] **Step 5: Commit**

```bash
git add docs/index.html docs/style.css
git commit -m "feat: terminal install section with clipboard copy button"
```

---

### Task 10: Footer + Scroll Reveal + Responsive + Deploy

**Files:**
- Modify: `docs/index.html` — close `<main>`, add footer, add scroll reveal JS
- Modify: `docs/style.css` — append footer + responsive

- [ ] **Step 1: Add footer HTML** (after last section, before `<script>`)

```html
</main>

<footer class="site-footer">
  <div class="container footer-inner">
    <div class="footer-left">
      <img src="icon.png" alt="Auto MicLock" class="footer-icon">
      <span>Auto MicLock</span>
    </div>
    <div class="footer-right">
      <a href="https://github.com/BFMIX/AutoMicLock">GitHub</a>
      <a href="https://github.com/BFMIX/AutoMicLock/blob/main/LICENSE">MIT License</a>
    </div>
  </div>
  <div class="container">
    <p class="copyright">Made for macOS. Open source utility to force built-in microphone.</p>
  </div>
</footer>
```

- [ ] **Step 2: Append footer + responsive styles to docs/style.css**

```css
/* Footer */
.site-footer {
  border-top: 1px solid var(--border);
  padding: 36px 0; margin-top: 40px;
}
.footer-inner {
  display: flex; justify-content: space-between; align-items: center;
  margin-bottom: 20px;
}
.footer-left { display: flex; align-items: center; gap: 10px; font-weight: 600; font-size: 0.9rem; }
.footer-icon { width: 24px; height: 24px; border-radius: 6px; }
.footer-right { display: flex; gap: 24px; }
.footer-right a {
  color: var(--text-secondary); text-decoration: none;
  font-size: 0.85rem; transition: color var(--transition-base);
}
.footer-right a:hover { color: var(--text-primary); }
.copyright { text-align: center; color: var(--text-tertiary); font-size: 0.8rem; }

/* Responsive */
@media (max-width: 768px) {
  h1 { font-size: 2.4rem; }
  .split-layout { grid-template-columns: 1fr; }
  .cta-group { flex-direction: column; align-items: center; }
  .footer-inner { flex-direction: column; gap: 20px; text-align: center; }
  .footer-right { gap: 16px; }
  .tech-grid { grid-template-columns: 1fr; }
  .menubar-menu { display: none; }
}
```

- [ ] **Step 3: Add scroll reveal JS** (append in script block)

```javascript
var revealObserver = new IntersectionObserver(function(entries) {
  entries.forEach(function(entry) {
    if (entry.isIntersecting) {
      entry.target.classList.add('visible');
      revealObserver.unobserve(entry.target);
    }
  });
}, { threshold: 0.12 });
document.querySelectorAll('.reveal').forEach(function(el) {
  revealObserver.observe(el);
});
```

- [ ] **Step 4: Full page review checklist in browser**

Open `docs/index.html` and verify:
- [ ] Mouse glow follows cursor smoothly across the page
- [ ] Navbar hides when scrolling down, reappears when scrolling up
- [ ] App icon floats gently in the hero
- [ ] GitHub stars badge appears when online
- [ ] Menu bar mockup shows app icon with green dot
- [ ] Before/After toggle switches waveforms correctly
- [ ] Problem/Solution cards lift 4px on hover
- [ ] FAQ items open/close with chevron rotation
- [ ] Copy button shows green "Copied!" state for 2s then resets
- [ ] All `.reveal` sections fade in on scroll
- [ ] At 375px width: layout stacks, CTAs stack, footer stacks

- [ ] **Step 5: Final commit**

```bash
git add docs/index.html docs/style.css
git commit -m "feat: footer, scroll reveal, responsive — complete GitHub Pages redesign"
```

- [ ] **Step 6: Push and verify live**

```bash
git push origin main
```

Wait ~60s then open `https://bfmix.github.io/AutoMicLock/` and run the checklist above on the live site.

---

## Self-Review

**Spec coverage:**
- Navbar sticky + hide/show — Task 3
- Hero with icon.png, float, gradient, CTAs — Task 4
- GitHub stars live — Task 4
- Mouse-tracking background — Task 2
- Menu bar preview mockup — Task 5
- Before/After toggle — Task 6
- Problem/Solution glass cards — Task 7
- How It Works 3 tech cards — Task 7
- Compatible apps grid — Task 7
- FAQ accordion (details/summary) — Task 8
- Terminal install + copy button — Task 9
- Scroll reveal — Task 10
- Responsive — Task 10
- Footer — Task 10

**No placeholders. No innerHTML with user content. All code complete.**
