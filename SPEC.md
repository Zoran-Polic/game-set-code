# GAME, SET, CODE — Tennis Mini-Game Specification

**Event:** IBM Volunteer Event — GAME, SET, CODE: Vibe Code a Tennis Mini-Game with IBM Bob  
**Date:** Wed Sep 9, 2026 | 10:30 AM–12:00 PM EDT  
**Location:** Room G104, Building 500, Durham, NC  
**Target audience:** Young children in nonprofit early education programs (approx. ages 5–10)

---

## Goals

1. Teach basic cause-and-effect / input-output thinking through play
2. Introduce the concept of a "game loop" without naming it
3. Be immediately playable with zero instruction reading
4. Be deliverable as a single HTML file — no server, no install, no internet required

---

## Platform

| Constraint | Decision |
|---|---|
| Delivery format | Single self-contained `index.html` file |
| Runtime | Any modern browser (Chrome, Firefox, Edge, Safari) |
| Dependencies | None — no CDN, no npm, no build step |
| Controls | Keyboard (arrow keys / WASD) for paddle; mouse optional |
| Screen size | Designed for 800×600; scales to full screen |
| Offline | ✅ Fully offline — all assets inline |

---

## Gameplay

### Core mechanic — Pong-style tennis

- **Ball** bounces around the play area
- **Player paddle** (left side) — controlled by the child
- **Computer paddle** (right side) — simple AI, beatable by a young child
- Ball speeds up slightly after each successful rally to add excitement
- Round ends when either side misses the ball

### Win condition

- First to **5 points** wins the set
- After a set ends: celebratory animation + "Play Again?" button
- Score resets; new set begins

### Difficulty

- Computer AI is intentionally slow and slightly inaccurate — children should win most of the time
- Ball starts at a friendly speed; max speed capped so it never becomes frustrating

---

## Visual Design

- **Theme:** Bright outdoor tennis court (green court, white lines)
- **Color palette:** Court green `#4caf50`, sky blue `#87ceeb`, white `#ffffff`, yellow ball `#f9e44a`
- **Paddles:** Rounded rectangles — left paddle bright blue (player), right paddle orange (computer)
- **Ball:** Yellow circle with subtle shadow
- **Score display:** Large, bold numbers at top — easy to read at a glance
- **Font:** System sans-serif, large size — readable by young children
- **No text-heavy UI** — icons and colors do the work

---

## Audio (optional / stretch)

- Soft "pock" sound on paddle hit (generated via Web Audio API — no files needed)
- Crowd cheer on point scored (short tone sequence)
- All audio off by default; toggle button in corner (respects quiet classrooms)

---

## Screens

### 1. Start screen
- Game title: **"TENNIS!"** in large colorful letters
- Single large button: **"PLAY"**
- Simple animated ball bouncing in background

### 2. Game screen
- Court view with both paddles and ball
- Score top-center: `YOU  3 — 2  BOB` (or similar fun name for CPU)
- Subtle "SERVE →" prompt on first ball of each point

### 3. End screen
- Winner announcement: **"YOU WIN! 🎾"** or **"BOB WINS! 🤖"**
- Confetti/star animation (CSS only)
- **"PLAY AGAIN"** button — large, centered

---

## Controls

| Action | Key |
|---|---|
| Move paddle up | `↑` or `W` |
| Move paddle down | `↓` or `S` |
| Start / serve | `Space` or click PLAY button |

Mouse/touch: clicking/tapping above or below the paddle moves it (accessibility fallback)

---

## Code Structure

Single `index.html` file containing:

```
index.html
├── <style>         — all CSS inline
├── <canvas>        — game rendered on HTML5 Canvas (800×600)
└── <script>        — vanilla JS game loop
    ├── Constants    (sizes, speeds, colors, score limit)
    ├── State        (ball, paddles, scores, gamePhase)
    ├── Input        (keydown/keyup listeners)
    ├── Update       (ball physics, collision, AI, scoring)
    ├── Draw         (clear + render all elements each frame)
    ├── AI           (simple CPU paddle tracking with lag)
    └── Game loop    (requestAnimationFrame)
```

No classes required — simple procedural JS is fine and easier to vibe-code with Bob.

---

## IBM Bob Prompting Strategy (for the volunteer session)

Suggested prompts to use during the event:

1. *"Create a single HTML file tennis game using HTML5 Canvas. Two paddles, a bouncing ball, score display. Player controls left paddle with arrow keys."*
2. *"Make the computer paddle move slower and miss sometimes so young kids can win easily."*
3. *"Add a start screen with a PLAY button and an end screen with PLAY AGAIN when someone reaches 5 points."*
4. *"Add a 'pock' sound using the Web Audio API when the ball hits a paddle. No external files."*
5. *"Make it look like a bright outdoor tennis court with green, blue, and yellow colors."*

---

## Stretch Goals (if time allows)

- [ ] Two-player mode (second player uses mouse or `I`/`K` keys)
- [ ] Difficulty selector: Easy / Medium (affects CPU speed)
- [ ] Player name entry on start screen
- [ ] Animated scoreboard between sets
- [ ] Mobile touch controls (drag paddle with finger)

---

## Deliverable

- `index.html` — single file, fully self-contained
- Test checklist before handoff:
  - [ ] Opens in Chrome with no errors
  - [ ] Ball bounces correctly off top/bottom walls and paddles
  - [ ] Score increments correctly
  - [ ] Computer AI is beatable by a child
  - [ ] Start and end screens work
  - [ ] "Play Again" resets cleanly
  - [ ] No external URLs or CDN dependencies
