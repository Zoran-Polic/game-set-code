# 🎾 GAME, SET, CODE — Tennis Mini-Game

**IBM Volunteer Event · Sep 9, 2026 · Durham, NC · Built with IBM Bob**

---

## ▶ Play it now — no install, just click

| | Link |
|---|---|
| 🌐 **Play in browser** | **[zoran-polic.github.io/game-set-code](https://zoran-polic.github.io/game-set-code/)** |
| 📖 **Step-by-step tutorial** | [TUTORIAL.md](TUTORIAL.md) |
| 📐 **Game spec** | [SPEC.md](SPEC.md) |

> **Laptop or phone — just open the link and play.**
> Works on any modern browser: Chrome, Firefox, Edge, Safari.
> Keyboard + mouse on desktop · full touch controls on mobile · no install, no login.

---

## Versions

| Version | File | Play live | Description |
|---|---|---|---|
| **v1** | `v1/index.html` | [▶ Play v1](https://zoran-polic.github.io/game-set-code/v1/) | Simple baseline — ball, paddles, score |
| **v2** | `v2/index.html` | [▶ Play v2](https://zoran-polic.github.io/game-set-code/v2/) | Setup screen, themes, 2-player, stats |
| **v3a** | `v3a/index.html` | [▶ Play v3a](https://zoran-polic.github.io/game-set-code/v3a/) | + Progressive difficulty + ball trail |
| **v3b** | `v3b/index.html` | [▶ Play v3b](https://zoran-polic.github.io/game-set-code/v3b/) | + Power-ups (⚡ speed · 🛡️ grow · 🎯 aim) |
| **v3c** | `v3c/index.html` | [▶ Play v3c](https://zoran-polic.github.io/game-set-code/v3c/) | + Tournament mode (best of 3 sets) |
| **v3d** | `v3d/index.html` | [▶ Play v3d](https://zoran-polic.github.io/game-set-code/v3d/) | 🏆 Full edition — everything combined |
| **latest** | `index.html` | [▶ Play latest](https://zoran-polic.github.io/game-set-code/) | Always the newest version (= v3d) |

Each version is a **single self-contained HTML file** — download any one and open it locally with no internet needed.

---

## v2 Features (base for all v3 variants)

- **Player name entry** — personalised start screen
- **Difficulty selector** — Easy / Medium / Hard (CPU speed + accuracy)
- **2-Player mode** — P1: arrow keys / WS · P2: IK keys or right-side mouse/touch
- **3 Court themes** — Classic (green), Night (dark blue), Clay (red)
- **6 Ball styles** — Tennis ball, soccer, basketball, star, heart, classic
- **Win/loss tracker** — stored in localStorage; streak counter
- **Confetti** on win
- **Sound** — Web Audio API pock + cheer + fanfare; mute button
- **Touch/mouse support** — drag paddle on left half (P1) or right half (P2)
- **Fully offline** — single self-contained HTML file, no CDN, no network

---

## v3 Features

### v3a — Progressive Difficulty + Ball Trail
- CPU speed increases every 2 total points scored — **Level 1 → 9**
- Level badge shown in score area
- Ball leaves a **ghost trail** of 8 fading copies behind it

### v3b — Power-ups
- **⚡ Speed Boost** — next paddle hit fires the ball fast
- **🛡️ Big Paddle** — your paddle grows by 40% for a few seconds
- **🎯 Aim Assist** — CPU aims less accurately / you aim better
- Power-ups appear as glowing items on court; ball collection triggers them
- Colour-coded progress bar above each paddle shows remaining duration

### v3c — Tournament Mode
- **Best of 3 sets** — first to win 2 sets wins the match
- Set score history displayed in bottom ribbon
- Set dot display in scoreboard (🟡 dots per set won)
- Set-end overlay with intermediate results; auto-advances to next set
- Match-end screen shows full set history + final result

### v3d — Full Edition (everything combined)
- All of v3a + v3b + v3c together
- Progressive CPU speed resets each set
- Power-ups reset between sets
- Level indicator in top-right corner during play

---

## Controls

### Laptop / keyboard

| Action | Player 1 | Player 2 (2P mode) |
|---|---|---|
| Move up | `↑` or `W` | `I` |
| Move down | `↓` or `S` | `K` |
| Serve / advance | `Space` or `Enter` | — |

### Phone / tablet (touch)

| Action | How |
|---|---|
| Move your paddle | Drag on the **left half** of the screen |
| Move P2 paddle (2P mode) | Drag on the **right half** |
| Serve | Tap anywhere |
| Enter your name | Tap the name box → keyboard appears; tap **OK ✓** |

---

## Customising for your nonprofit

Edit the `CONFIG` block at the top of any `index.html`:

```js
const CONFIG = {
  nonprofitName: 'IBM Community',   // ← change this
  gameTitle:     '🎾 TENNIS!',      // ← change this
  poweredBy:     'Powered by IBM Bob',
  scoreToWin:    5,   // points to win a set
  setsToWin:     2,   // sets to win the match (v3c / v3d only)
  ...
};
```

---

## IBM Bob Prompting Reference

Prompts used / useful for the volunteer session:

1. *"Create a single HTML file tennis game using HTML5 Canvas. Two paddles, bouncing ball, score display. Player controls left paddle with arrow keys."*
2. *"Add a setup screen with difficulty selector (Easy/Medium/Hard) that controls CPU speed."*
3. *"Add 2-player mode where the second player uses I and K keys."*
4. *"Add court theme options — green grass, night blue, clay red."*
5. *"Store win/loss stats in localStorage and show a streak counter."*
6. *"Add confetti particles on win using canvas."*
7. *"Make the ball optionally render as an emoji instead of a drawn circle."*
8. *"Make the CPU progressively faster every 2 points scored — show a level badge."*
9. *"Add a ball trail effect — draw ghost copies of the last 8 ball positions with fading opacity."*
10. *"Add power-up items that appear on the court. Three types: speed boost, big paddle, aim assist. Ball collects them on contact."*
11. *"Add tournament mode — best of 3 sets. Show set scores, a dot scoreboard, and a set-end overlay before the next set begins."*

---

## About

Built entirely through [IBM Bob](https://ibm.com/bob) prompts — every line of code generated by AI.  
See [TUTORIAL.md](TUTORIAL.md) for the full step-by-step guide.
