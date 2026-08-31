# Build a Tennis Game with IBM Bob — Step-by-Step Tutorial

> **What you'll build:** A fully playable browser tennis game in a single HTML file —  
> no framework, no server, no install. Just open it and play.
>
> **How long it takes:** ~90 minutes end-to-end, following this guide.  
> Each step is a prompt you paste into IBM Bob (or any AI coding assistant).

---

## Prerequisites

- A browser (Chrome, Firefox, Edge, Safari — any works)
- IBM Bob (or another AI coding assistant such as GitHub Copilot, Claude, or ChatGPT)
- A text editor — even Notepad will do; VS Code is nicer
- No Node.js, npm, or build tools needed

---

## How to use this tutorial

1. Copy the **prompt** shown in each step
2. Paste it into IBM Bob
3. Bob returns a complete HTML file — copy it into your editor and save as `index.html`
4. Open the file in your browser to test
5. Move on to the next step

Each step **builds on the previous one.** By the end you will have gone from zero to a full-featured game with power-ups, tournaments, and ball trails.

---

## Architecture overview

Every version is a **single self-contained `index.html`** with this structure:

```
index.html
├── <style>    — all CSS (body background, canvas border, buttons)
├── <canvas>   — the game is drawn here using HTML5 Canvas API
└── <script>
    ├── CONFIG / constants    — sizes, speeds, score limit
    ├── State variables       — ball, paddles, scores, current phase
    ├── Audio helpers         — Web Audio API beeps (no files!)
    ├── Confetti helpers      — particle system for celebrations
    ├── Game init             — reset functions for ball and paddles
    ├── Update logic          — physics, AI, collision detection, scoring
    ├── Draw functions        — one draw call per frame per element
    ├── Screen draw functions — name entry, setup, serve, end screens
    ├── Game loop             — requestAnimationFrame drives everything
    └── Input handlers        — keyboard + mouse + touch
```

This is **procedural JavaScript** — no classes, no modules. Perfect for vibe-coding with an AI assistant.

---

## Step 1 — The simplest possible game

**What you get:** A bouncing ball, two paddles, score counter, CPU opponent.  
**Time:** ~5 minutes

### Prompt

```
Create a single self-contained HTML file tennis game using HTML5 Canvas.

Requirements:
- Canvas 800×520 pixels, centered on a green court background
- Left paddle controlled by arrow keys (up/down) or W/S keys
- Right paddle is a simple CPU that tracks the ball at speed 3.2, but only 82% accurately so kids can beat it
- Yellow ball that bounces off top/bottom walls and paddles, speeding up slightly with each hit
- Score displayed at the top: YOU vs BOB
- First to 5 points wins
- Start screen with a PLAY button
- End screen with "YOU WIN!" or "BOB WINS!" and a PLAY AGAIN button
- No external files, no CDN, no npm — everything inline
```

**Test it:** Open `v1/index.html` from this repo to see the result.

### What to look for in the code

- **`requestAnimationFrame(loop)`** — this is the game loop. It runs ~60 times per second.
- **`updatePlay()`** — physics, collision detection, and CPU AI all happen here.
- **`draw()`** — clears the canvas and redraws everything each frame.
- **`ball.vx` / `ball.vy`** — velocity components. Flip `vy` on wall hit; flip `vx` on paddle hit.

---

## Step 2 — Add setup, themes, 2-player mode, and stats

**What you get:** A full-featured game with a setup screen, difficulty selector, court themes, 2-player support, localStorage stats, confetti, and sound.  
**Time:** ~20 minutes

### Prompt

```
Upgrade my tennis game HTML file with these features. Keep the same single-file approach.

1. Name entry screen before setup — player types their name, press Enter to confirm
2. Setup screen with clickable buttons for:
   - Difficulty: Easy / Medium / Hard (controls CPU speed and accuracy)
   - Court theme: Classic green / Night blue / Clay red — each changes court + paddle colors
   - Ball style: tennis ball, soccer ball, basketball, star emoji, heart emoji, or classic circle
   - Mode: 1 Player (vs CPU) or 2 Players (P2 uses I/K keys and right-side mouse/touch)
3. Player stats stored in localStorage — wins, losses, current streak, best streak
4. Confetti particle burst on win (canvas particles, no CSS animation)
5. Sound effects using Web Audio API — pock on paddle hit, cheer on point, fanfare on win, click on buttons
6. Mute toggle button fixed to top-right corner
7. Touch support — dragging on left half of canvas moves P1 paddle; right half moves P2 paddle
8. Top CONFIG block for easy customisation (nonprofit name, game title, score limit)
```

**Test it:** Open `v2/index.html` from this repo.

### Key concepts introduced in this step

#### The CONFIG block
```js
const CONFIG = {
  nonprofitName: 'IBM Community',
  gameTitle:     '🎾 TENNIS!',
  poweredBy:     'Powered by IBM Bob',
  scoreToWin:    5,
  themes: { ... },
  ballEmojis: [...],
};
```
A single object at the top means anyone can customise the game without reading the game logic.

#### localStorage for persistence
```js
let stats = { wins: 0, losses: 0, streak: 0, bestStreak: 0 };
try {
  const saved = JSON.parse(localStorage.getItem('ibmTennisStats') || '{}');
  Object.assign(stats, saved);
} catch(e) {}
```
Wrapped in `try/catch` because localStorage can fail in private browsing.

#### Sound with no audio files
```js
function beep(freq, dur, type = 'square', vol = 0.15) {
  const ctx = new AudioContext();
  const o = ctx.createOscillator();
  const g = ctx.createGain();
  o.connect(g); g.connect(ctx.destination);
  o.frequency.value = freq;
  g.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + dur);
  o.start(); o.stop(ctx.currentTime + dur);
}
```
The Web Audio API synthesises tones in real time — no `.mp3` files needed.

---

## Step 3a — Progressive difficulty + ball trail

**What you get:** The CPU gets faster every 2 points, adding tension as the game progresses. The ball leaves a ghost trail.  
**Time:** ~10 minutes

### Prompt

```
Add two features to my tennis game HTML file:

1. Progressive difficulty (single-player only):
   - CPU speed increases every 2 total points scored in the current game
   - Maximum of 8 speed boosts (capped so it never becomes impossible)
   - Show a small "⚡ LVL X" badge in the score area while playing
   - Play a short ascending tone when the CPU levels up

2. Ball trail effect:
   - Keep a ring buffer of the last 8 ball positions
   - Draw them behind the ball each frame with decreasing opacity (newest = most opaque)
   - Scale down older positions slightly so they taper to a point
   - Works for both canvas-drawn balls and emoji balls
```

**Test it:** Open `v3a/index.html`.

### Key concepts introduced

#### Ring buffer (fixed-size history)
```js
let trail = [];   // positions array, max TRAIL_LENGTH items

// Before moving the ball each frame:
trail.push({ x: ball.x, y: ball.y });
if (trail.length > TRAIL_LENGTH) trail.shift();  // drop oldest
```

#### Drawing with decreasing opacity
```js
for (let i = 0; i < trail.length; i++) {
  const age = (i + 1) / trail.length;   // 0 = oldest, 1 = newest
  ctx.globalAlpha = age * 0.35;
  ctx.beginPath();
  ctx.arc(trail[i].x, trail[i].y, BALL_R * (0.4 + age * 0.5), 0, Math.PI * 2);
  ctx.fill();
}
ctx.globalAlpha = 1;   // always reset after custom alpha!
```

---

## Step 3b — Power-ups

**What you get:** Three collectible power-ups that appear on the court. The ball picks them up on contact.  
**Time:** ~15 minutes

### Prompt

```
Add a power-up system to my tennis game HTML file:

Three power-up types that randomly appear on the court every 3–6 seconds:
- ⚡ Speed Boost: the ball fires at near-max speed on the next hit
- 🛡️ Big Paddle: the paddle height grows by 40% for ~6 seconds  
- 🎯 Aim Assist: the CPU aims less accurately for ~5 seconds / player aims better

Behaviour:
- Only one power-up on the court at a time
- Power-up appears as a pulsing, glowing emoji circle in the middle third of the court
- The ball collects it on contact (proximity check)
- The power-up goes to the side whose ball direction indicates they just hit it
- Show a colour-coded progress bar above the active paddle during the effect
- Display a flash message on collection ("⚡ SPEED BOOST!")
- Play a rising three-note pickup sound on collection
- Power-ups clear between points
```

**Test it:** Open `v3b/index.html`.

### Key concepts introduced

#### Proximity collision detection
```js
const dx = ball.x - powerup.x;
const dy = ball.y - powerup.y;
if (Math.hypot(dx, dy) < BALL_R + POWERUP_RADIUS) {
  // collected!
}
```
`Math.hypot` is the cleanest way to compute 2D distance.

#### Pulsing animation without CSS
```js
activePowerup.pulse++;  // increments every frame
const scale = 1 + 0.12 * Math.sin(activePowerup.pulse * 0.12);
```
A sine wave driven by a frame counter gives smooth looping animation.

#### Timed effects with frame countdown
```js
// On collection:
playerEffect = { id: 'grow', framesLeft: 350 };

// Each frame in updatePlay():
if (playerEffect) {
  playerEffect.framesLeft--;
  if (playerEffect.framesLeft <= 0) playerEffect = null;
}

// In draw:
const pct = playerEffect.framesLeft / 350;
ctx.fillRect(pad.x, pad.y - 10, (pad.w + 2) * pct, 6);  // progress bar
```

---

## Step 3c — Tournament mode (best of 3 sets)

**What you get:** A full best-of-3 match. Each game is one set. A set-end overlay shows the score and auto-transitions. The match-end screen shows the full history.  
**Time:** ~15 minutes

### Prompt

```
Add tournament mode to my tennis game HTML file:

Rules:
- A match is best of 3 sets (first to win 2 sets wins the match)
- A set is first to 5 points (existing score limit)
- After a set ends, show a set-end overlay for 3 seconds with the set score, then auto-start the next set
- After the match ends, show a detailed match-end screen

Set-end overlay must show:
- Who won the set and the score (e.g. "YOU WIN SET 2!  4 – 3")
- Current match standing (e.g. "Match: YOU 1 · BOB 1")
- "Next set starting..." countdown message

Match-end screen must show:
- Winner announcement
- Score of every set played
- Final set tally
- Win/loss stats from localStorage
- Play Again and Setup buttons

Scoreboard changes:
- Replace the stats ribbon at the bottom during play with set history scores
- Add set dots to the score display (filled yellow circle per set won, hollow per remaining)
- Show "SET X" label between the dot groups
```

**Test it:** Open `v3c/index.html`.

### Key concepts introduced

#### Nested state machine
The game now has phases within phases — `phase` controls the top-level screen, and `setHistory` accumulates results:

```
phase: 'serve' → 'play' → 'point' → 'serve' → ...
                                  ↓ (set over)
                              'setEnd' (3 sec) → 'serve' (new set)
                                              ↓ (match over)
                                          'matchEnd'
```

#### Accumulating history
```js
let setHistory = [];

// When a set ends:
setHistory.push({ p: playerScore, c: cpuScore });

// To display it:
setHistory.forEach((s, i) => {
  ctx.fillText(`Set ${i+1}: YOU ${s.p} – ${s.c} BOB`, W/2, y);
});
```

---

## Step 3d — Full edition (everything combined)

**What you get:** All three v3 features working together: progressive difficulty + ball trail + power-ups + tournament mode.  
**Time:** ~15 minutes

### Prompt

```
Combine all these features into one tennis game HTML file:

From v3a: Progressive CPU difficulty (speed increases every 2 points, up to 8 boosts) + ball trail (8-position ring buffer, fading ghost copies)
From v3b: Power-ups (⚡ speed boost · 🛡️ big paddle · 🎯 aim assist) — spawn every 3–6 seconds, ball collects on proximity, coloured progress bar on paddle, flash message on pickup
From v3c: Tournament mode (best of 3 sets, set-end overlay, match-end screen with full history, set dots in scoreboard)

Integration rules:
- CPU speed boost resets to base speed at the start of each set
- Power-ups clear between sets (and between points)
- Level indicator moves to top-right corner of the court (not cluttering the score strip)
- Set history replaces the stats ribbon at the bottom during play
```

**Test it:** Open `v3d/index.html` or the root `index.html` — they are the same file.

---

## Full version progression summary

| Version | Lines | What's new |
|---|---|---|
| v1 | ~530 | Canvas game loop, physics, CPU AI, start/end screens |
| v2 | ~800 | Setup screen, themes, 2P, localStorage stats, confetti, sound, touch |
| v3a | ~830 | Progressive difficulty, ball trail |
| v3b | ~950 | Power-up system (spawn, collect, effects, UI) |
| v3c | ~940 | Tournament mode (sets, overlays, history screen) |
| v3d | ~870 | All features combined, tuned to work together |

---

## Concepts reference card

| Concept | Where it appears | One-liner |
|---|---|---|
| Game loop | Every version | `requestAnimationFrame(loop)` — runs 60×/sec |
| State machine | Every version | `phase` variable controls which screen draws |
| Collision detection | Every version | Ball vs paddle: bounding-box + velocity direction check |
| Ball physics | Every version | `ball.x += ball.vx` each frame; flip component on bounce |
| CPU AI | Every version | Move toward `ball.y * missFactor` — imperfect on purpose |
| Web Audio API | v1+ | `createOscillator()` — synthesised beeps, no MP3 files |
| Canvas particles | v2+ | Confetti: array of `{x, y, vx, vy, life}` objects, remove when `life ≤ 0` |
| localStorage | v2+ | `JSON.stringify` / `JSON.parse` — persist stats across sessions |
| Ring buffer | v3a+ | `push` + `shift` at fixed max length — efficient sliding window |
| Proximity check | v3b+ | `Math.hypot(dx, dy) < r1 + r2` — circle-circle collision |
| Frame countdown | v3b+ | `framesLeft--` each update — simple timer without `setTimeout` |
| Accumulating state | v3c+ | `setHistory.push({p, c})` — grow array of results over time |
| CONFIG block | v2+ | Top-level object for nonprofit customisation without touching logic |

---

## Going further — prompt ideas

Once you've completed all the steps, try these on your own:

```
Add a rally counter that shows the current streak of consecutive hits without a miss.
Show it in the middle of the court and make it glow when it reaches 10.
```

```
Add a "ghost ball" mode where the ball turns invisible for 1 second after each serve,
then reappears. Toggle it as a difficulty option on the setup screen.
```

```
Add a simple particle burst at the exact point where the ball hits a paddle —
tiny sparks that fly outward and fade over 20 frames.
```

```
Add a shot angle indicator: when the player's paddle is moving, show a faint dotted
arc predicting where the ball will go after the hit. Hide it 0.5 seconds after each hit.
```

```
Add an achievement system: show a toast notification for milestones like
"First win!", "3 in a row!", "Survived level 5!". Store them in localStorage.
```

---

## About this project

This game was built at the **IBM Volunteer Event: GAME, SET, CODE**  
**Date:** September 9, 2026 | IBM RTP, Durham NC  
**Built with:** [IBM Bob](https://ibm.com/bob) — IBM's AI coding assistant  
**Target audience:** Children ages 5–10 at nonprofit early education programs

Every line of code in this repository was generated through prompts to IBM Bob,
then refined through follow-up prompts — exactly the workflow you followed in this tutorial.

---

*Happy coding!  🎾*
