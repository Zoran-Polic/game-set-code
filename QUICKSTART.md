# GAME, SET, CODE — Quick Start

**You need:** IBM Bob · a browser · a text editor · that's it.

Play on a laptop or a smartphone — both work equally from the very first version.

> **Can't break anything.** Every Bob response is a complete file.
> Paste the previous version back to undo anything, instantly.

---

## The 4 steps — one prompt each

| Step | What you get | Time |
|---|---|---|
| **1** | Bouncing ball · paddles · score · CPU · touch + keyboard | ~5 min |
| **2** | Name entry · themes · 2-player · stats · sound · confetti | ~20 min |
| **3** | Difficulty · ball trail · power-ups · tournament mode | ~40 min |
| **4** | Canvas fills any screen · phone keyboard · adaptive hints | ~10 min |

Full prompts and explanations: **[TUTORIAL.md](TUTORIAL.md)**

---

## Step 1 prompt — paste into IBM Bob

```
Create a single self-contained HTML file tennis game using HTML5 Canvas.

Requirements:
- Canvas 800×520 pixels, centered on a green court background
- Works on both desktop and smartphone — touch controls from the start:
  dragging on the left half of the canvas moves the player paddle,
  tapping anywhere serves the ball
- Left paddle controlled by arrow keys (up/down) or W/S keys on desktop
- Right paddle is a simple CPU that tracks the ball at speed 3.2,
  but only 82% accurately so beginners can beat it
- Yellow ball that bounces off top/bottom walls and paddles,
  speeding up slightly with each hit (max speed 11)
- Score displayed at the top: YOU vs BOB
- First to 5 points wins
- Start screen with a large PLAY button
- End screen with "YOU WIN!" or "BOB WINS!" and a PLAY AGAIN button
- Sound effects using Web Audio API — a short beep on paddle hit,
  a cheer on point scored (no external audio files)
- Mute toggle button fixed to top-right corner
- No external files, no CDN, no npm — everything inline in one file
```

Save what Bob gives you as `index.html`. Open in browser. Play it.

---

## After every step — play first, prompt second

Before asking Bob to change anything, **play the version you just got.**

- Does it feel fun?
- Is the CPU too hard or too easy?
- Is there one thing that feels off?

Describe that feeling in plain language. That description is your next prompt.

> *"The CPU is too fast — I want younger kids to be able to win."*
> *"The ball trail feels too long — shorten it to 4 positions."*
> *"The end screen disappears before I can read my stats — keep it until I tap."*

---

## Touch controls (works from Step 1)

| Action | How |
|---|---|
| Move paddle | Drag finger on the **left half** of screen |
| Move P2 paddle | Drag finger on the **right half** |
| Serve | Tap anywhere |
| Enter name | Tap the name box → phone keyboard appears |
| Mute / unmute | Tap 🔊 top-right corner |

---

## If something goes wrong

- **Bob gave me something that doesn't work** — describe exactly what is broken.
  Add: *"Keep everything else exactly as it is."*
- **I made it worse by prompting** — paste the previous version back into Bob
  and try a differently-worded prompt.
- **I lost track of where I was** — open the matching reference file from this repo
  (`v1/`, `v2/`, `v3a/`, `v3b/`, `v3c/`, `v3d/`) and continue from there.

---

## Live demo

🌐 [zoran-polic.github.io/game-set-code](https://zoran-polic.github.io/game-set-code/)

Share this link — anyone can play on their phone immediately, no install.

---

*For the full step-by-step guide, concept explanations, and 12 extension prompts → [TUTORIAL.md](TUTORIAL.md)*
