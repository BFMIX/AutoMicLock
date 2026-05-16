# AutoMicLock — GitHub Pages Redesign Spec
**Date:** 2026-05-14  
**Status:** Approved  
**Scope:** Full rewrite of `docs/index.html` + `docs/style.css`

---

## Goal

Modernise the GitHub Pages landing page. Apple Design System aesthetic, vanilla HTML/CSS/JS (zero dependencies), animated background, all content preserved and enhanced.

---

## Design System

**Source:** ui-ux-pro-max skill (Hero-Centric + App Store Style patterns)

- **Font:** `-apple-system, 'SF Pro Display', 'Inter', sans-serif` — Inter loaded from Google Fonts
- **Background:** `#000000` (pure black)
- **Text primary:** `#ffffff`
- **Text secondary:** `#8e8e93` (Apple system gray)
- **Accent blue:** `#0a84ff` (Apple blue)
- **Accent green:** `#30d158` (Apple green)
- **Card bg:** `rgba(255,255,255,0.05)`
- **Card border:** `rgba(255,255,255,0.08)`
- **Border radius:** `12px` cards, `980px` pills, `27px` app icon

---

## Page Structure (top → bottom)

### 1. Navbar (sticky)
- Backdrop blur `blur(20px)`, bg `rgba(0,0,0,0.75)`, border-bottom `1px solid rgba(255,255,255,0.08)`
- Left: `docs/icon.png` (28px, radius 7px) + "Auto MicLock" text
- Right: pill button "⬇ Download Free" → `#github/releases/latest`
- Hides on scroll down, reappears on scroll up (JS)

### 2. Hero
- Eyebrow label: "macOS Utility · Free & Open Source" (uppercase, blue, small)
- `docs/icon.png` — 120px, radius 27px, floating animation (CSS keyframe)
- H1: "Lock your mic." + gradient span "Unlock HD audio." (`#4facfe` → `#00f2fe`)
- Subtitle (max 560px)
- CTA buttons: "⬇ Download for macOS" (white pill) + "View on GitHub" (ghost pill)
- Meta badges row: "★ N stars" (gold, live via GitHub API) + "macOS 13+" + "Intel & Apple Silicon" + "Open Source"

### 3. Menu Bar Preview
- Section showing what the app looks like running in the macOS menu bar
- Mockup: dark macOS menubar strip with app icon + lock icon visible
- Label underneath: "Lives quietly in your menu bar. Always on, never intrusive."
- Pure CSS/HTML mockup (no image needed)

### 4. Before / After Toggle
- Two states: **Without AutoMicLock** / **With AutoMicLock**
- Toggle button switches between states
- WITHOUT: waveform flat/muffled visualization, label "HFP mode — Hands-Free Profile", badge "⚡ Low quality"
- WITH: waveform rich visualization, label "A2DP mode — High Fidelity", badge "✓ HD Audio"
- CSS-only transition between states

### 5. Problem / Solution
- Two glass cards side by side
- Problem card: red icon, "The Problem", existing text
- Solution card: green icon, "The Solution", existing text
- Scroll reveal animation on enter

### 6. How It Works (Technical)
- 3 cards: CoreAudio Event-Driven · No External Dependencies · SMAppService
- Colored h3 (blue / purple / green)
- `<code>` inline tags preserved
- Scroll reveal

### 7. Compatible Apps
- Grid of 5 badges: Zoom · Google Meet · Microsoft Teams · Discord · OBS Studio
- "Works with any Bluetooth device" subtitle
- Scroll reveal

### 8. FAQ Accordion
- 5 questions, CSS-only accordion (checkbox hack or `<details>`/`<summary>`)
- Smooth `max-height` transition
- Full width single column (not 2-col grid)

### 9. Terminal Install
- Section title: "For Power Users"
- Code block: `curl -fsSL https://... | bash`
- Copy button top-right of block — JS copies to clipboard, shows "✓ Copied!" for 2s then resets
- Monospace font, green text `#32d74b` on black

### 10. Footer
- `docs/icon.png` (24px) + "Auto MicLock"
- Links: GitHub Repository · MIT License
- Copyright line

---

## Animated Background (mouse-tracking)

- Single `<div class="bg-glow">` fixed, `pointer-events: none`, `z-index: -1`
- JS: `mousemove` listener updates CSS custom properties `--mx` and `--my` (mouse position as %)
- CSS: `radial-gradient(circle at var(--mx) var(--my), rgba(10,132,255,0.12), transparent 60%)`
- Smooth follow: CSS `transition: background-position 0.3s ease` or JS lerp on rAF for smoothness
- Fallback: static blue glow at top-center if no mouse (touch devices)

---

## Animations

| Element | Animation |
|---|---|
| App icon (hero) | `float` keyframe — `translateY(0 → -10px)`, 6s infinite |
| Sections on scroll | `IntersectionObserver` → adds `.visible` class → `opacity: 0 → 1` + `translateY(20px → 0)`, 0.5s ease |
| Navbar | Hide/show on scroll direction (JS, threshold 50px) |
| FAQ items | `max-height` transition `0 → auto` (via fixed max-height value) |
| Copy button | `"Copy" → "✓ Copied!"` text swap, green flash, 2s timeout |
| Before/After | CSS transition on opacity/transform when toggle changes |
| Hover cards | `translateY(-4px)` on `.glass:hover`, 0.2s ease |

---

## GitHub Stars (live)

```js
fetch('https://api.github.com/repos/BFMIX/AutoMicLock')
  .then(r => r.json())
  .then(d => {
    document.querySelector('.stars-count').textContent = '★ ' + d.stargazers_count;
  })
  .catch(() => {}); // silent fail — badge stays hidden or shows fallback
```

Fallback: badge hidden if API fails (no ugly "undefined stars").

---

## Files Changed

| File | Action |
|---|---|
| `docs/index.html` | Full rewrite |
| `docs/style.css` | Full rewrite |
| `docs/icon.png` | Keep as-is (used in nav, hero, footer) |

No new files. No build step. No dependencies beyond Google Fonts (Inter).

---

## Out of Scope

- No video/GIF (placeholder stays hidden until recorded)
- No dark/light mode toggle (always dark)
- No i18n
- No analytics
