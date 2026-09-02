# Build a Tennis Game with IBM Bob
### A complete guide to AI-assisted development — from zero to a fully playable game

> **What you will build:** A browser tennis game in a single HTML file.
> No framework, no server, no install, no prior coding experience required.
> Open it on a laptop. Share the link and play it on a phone. Give it to anyone.
>
> **What you will actually learn:** How to build software by having a conversation
> with an AI assistant — the skill that works for any project, not just this game.

---

## Before you start — read this first

### You need exactly three things

| What | Details |
|---|---|
| **IBM Bob** | Your AI coding assistant — the engine of everything in this tutorial |
| **A browser** | Chrome, Firefox, Edge, or Safari — on a laptop, tablet, or smartphone |
| **A text editor** | Notepad, TextEdit, VS Code, or any app that saves plain `.txt` files |

That is the complete list. No Node.js. No npm. No terminal. No accounts to create.
No software to install beyond what you already have.

### Opening IBM Bob for the first time

Go to IBM Bob in your browser and start a new chat.
You will see a text box where you can type. That is where every prompt in this
tutorial goes. When Bob responds, it will give you a block of code — that is your
game file. Everything else in this tutorial explains what to do with it.

If you do not have access to IBM Bob yet, ask whoever invited you to this tutorial
to share the link. Once you have it open, you are ready.

---

### The most important thing to understand before writing a single prompt

**You cannot break anything.**

Every time Bob gives you code, you get a complete, self-contained file.
If you don't like what you get, you paste the previous version back and try a different prompt.
If you lose track of where you were, every working version is saved in this repository —
open any of the `v1`, `v2`, `v3a`, `v3b`, `v3c`, `v3d` folders and you are back on solid ground.

Bob can undo, redo, rewrite, and refine anything in this domain without limit.
There is no mistake you can make here that cannot be reversed in under a minute.

**That means: experiment freely. Ask for things that seem too ambitious.
Push Bob further than feels safe. The worst outcome is you paste the previous version back.**

This is not a cautious tutorial. It is an invitation to play.

---

### The feedback loop — the most important habit in this tutorial

Before you write your first prompt, understand the cycle that makes vibe-coding work.
Every step in this tutorial follows the same loop:

```
Prompt Bob  →  Receive the file  →  Save it  →  Open in browser  →  Play it
     ↑                                                                    |
     └────────────── Describe what to change  ←  Notice what feels off ──┘
```

**Stop prompting and start playing after every step.**
Your fingers will tell you what is wrong faster than reading the code ever will.
The best game designers are not necessarily the best programmers —
they are the people who play obsessively and notice what feels wrong.
**That skill is yours already.**

Prompt vocabulary you do not need: JavaScript, canvas, function, variable, array.
Prompt vocabulary you do need: *fast*, *slow*, *cluttered*, *fair*, *satisfying*, *boring*.

---

### What IBM Bob is — and how this tutorial uses it

IBM Bob is an AI coding assistant. You describe what you want in plain English.
Bob writes the code. You test it. You describe what to change. Bob rewrites it.
That loop — describe, receive, test, feel, refine — is the entire workflow.

You do not need to understand the code Bob writes to use this tutorial.
Understanding will come naturally as you read the "What is happening here" sections,
but it is never a prerequisite for moving to the next step.

The prompts in this tutorial are carefully written to produce good results,
but they are not magic spells. Bob will sometimes produce something slightly different
from what is shown here. That is normal. Test it, play it, and if something feels wrong,
the next section tells you exactly how to respond.

---

### Playing on a smartphone — no keyboard needed

The finished game is fully touch-screen playable from the very first version.
If you are following this tutorial on a phone, everything works.

| Action | How |
|---|---|
| Move your paddle | Drag finger on the **left half** of the screen |
| Move P2 paddle (2-player mode) | Drag finger on the **right half** of the screen |
| Serve the ball | Tap anywhere on the screen |
| Enter your name | Tap the name box — your phone keyboard appears automatically |
| Mute / unmute sound | Tap the 🔊 button in the top-right corner |

> **Share the link:** Once you have a working version, open it in a browser on your phone,
> share the URL with a friend, and they can play it on their phone immediately.
> No install. No account. Just a link.

---

## How this tutorial works

Each step gives you one prompt to paste into IBM Bob.
Bob returns a complete HTML file.
You save it as `index.html` and open it in your browser.
You play it. You notice what you like and what you want to change.
Then you move to the next step — or you go off-script and ask Bob for something else entirely.

### How to give Bob the previous file

From Step 2 onward, each prompt says "upgrade my tennis game HTML file."
To give Bob that context, paste the **entire contents** of your current `index.html`
into the chat before (or after) the prompt text. Bob reads both together.

Most Bob interfaces have a way to attach or paste large blocks of text —
look for a paperclip icon, a code block button, or simply paste the file contents
directly into the message box before the prompt. Either way works.

If you are unsure, just paste the full file contents first, then the prompt on a new line.
Bob will figure out what is the file and what is the instruction.

**The steps build on each other.** Each prompt says "upgrade my tennis game" —
you always give Bob the file it just produced, so the full context carries forward.
Only Step 1 starts from nothing.

**The reference versions are always there.** Every step has a working result saved
in this repository (`v1/index.html`, `v2/index.html`, etc.). If your version diverges
or something stops working, open the reference version, continue from there, and keep going.

**Save before you change.** Before asking Bob to make a significant change,
save a copy of the file you have. If the new version is worse, you have an immediate
fallback. Rename it `index-v2-working.html` or anything you will recognise.

---

## A note on saving files

**Windows users:** When you save a new file in Notepad, it may default to
`index.html.txt` — adding `.txt` invisibly. The browser will not recognise it as
a web page. In the Save dialog, change "Save as type" to *All Files (*.*)* and
name it `index.html` explicitly.

**If the browser shows a blank page or raw code:** The file probably saved with
the wrong extension. Rename it to end in `.html` and reload.

**If nothing appears at all:** Make sure you are opening the file in a browser
(double-click it, or drag it onto an open browser window) — not in a text editor.

---

## The architecture — what Bob is building for you

Every version in this tutorial is a single `index.html` file with this structure.
You do not need to memorise this — it is here so you can find your way around when you are curious.

```
index.html
├── <style>     — how everything looks (colours, sizes, layout)
├── <canvas>    — a drawing surface; the entire game is drawn here 60 times per second
└── <script>
    ├── CONFIG       — one place to change the game title, score limit, colours
    ├── State        — variables that remember where everything is right now
    ├── Audio        — sound effects generated by the browser, no audio files needed
    ├── Physics      — how the ball moves, bounces, and speeds up
    ├── AI           — how the CPU opponent decides where to move
    ├── Draw         — instructions for painting every frame
    ├── Screens      — the start screen, setup screen, end screen
    ├── Game loop    — the engine that runs everything 60 times per second
    └── Input        — keyboard, mouse, and touch all handled here
```

This is plain JavaScript — no frameworks, no libraries, no build step.
Bob writes it all from a description. You do not need to write any of it yourself.

---

## Step 1 — The first game

**What you get:** A bouncing ball, two paddles, a score, and a CPU opponent.
Playable on laptop keyboard and smartphone touch screen.
**Time:** about 5 minutes.

### The prompt

Copy this exactly and paste it into IBM Bob:

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

### Test it

Save the file Bob gives you as `index.html`. Open it in your browser.
Play a full game against the CPU. Try it on your phone too.

**Reference version:** `v1/index.html` in this repository.

### What is happening here

- **The canvas** is like a whiteboard. Bob's code clears it and redraws everything 60 times
  per second — that is what makes the ball appear to move smoothly.
- **The game loop** (`requestAnimationFrame`) is the engine driving those 60 redraws.
  Every game ever made has one. You just got yours for free.
- **Touch + keyboard together** — the same code handles both. Dragging a finger and
  pressing an arrow key both update the same variable (`playerPad.y`).
  The input method does not matter to the game logic.

### If something feels off

Play the game. Then ask yourself: does anything feel wrong?
Some things people often notice after Step 1:

- *"The CPU is too fast"* →
  `Make the CPU paddle slower and less accurate — I want young children to be able to win most of the time.`
- *"The ball is too fast"* →
  `Reduce the starting ball speed and the maximum speed slightly.`
- *"The game looks plain"* →
  `Make the court look more like a real outdoor tennis court — brighter green, white court lines, blue sky at the top.`
- *"The PLAY button is hard to tap on a phone"* →
  `Make the PLAY and PLAY AGAIN buttons larger — minimum 80px tall — and easier to tap on a small screen.`

Any of these is a valid next prompt. You do not have to follow the steps in order.
Bob will incorporate your change and give you back a complete updated file.

**This is the core skill: play it, feel it, describe what you want different, trust Bob.**

---

## Step 2 — Setup screen, themes, 2-player mode, and stats

**What you get:** A name entry screen. A setup screen where you choose difficulty,
court theme, ball style, and game mode. Win/loss stats that survive page reloads.
Confetti on win. Richer sound. Full 2-player mode.
**Time:** about 20 minutes.

### The prompt

```
Upgrade my tennis game HTML file with these features. Keep the single-file approach.

1. Name entry screen — player types their name, press Enter or tap OK to confirm.
   On touch devices, tapping the name box triggers the native phone keyboard.

2. Setup screen with buttons for:
   - Difficulty: Easy / Medium / Hard (controls CPU speed and accuracy)
   - Court theme: Classic green / Night blue / Clay red
   - Ball style: tennis ball, soccer ball, basketball, star ⭐, heart ❤️, circle
   - Mode: 1 Player (vs CPU) or 2 Players (P2 uses I/K keys or right-side touch)

3. Player stats stored in localStorage — wins, losses, current streak, best streak
   Shown on the end screen. Persist across page reloads.

4. Confetti particle burst on win — canvas particles, no CSS animation.

5. Sound effects using Web Audio API:
   - Pock on paddle hit
   - Ascending chime on point scored
   - Fanfare on match win
   - Click sound on button press

6. Mute toggle button fixed to top-right corner, min 56×56px for easy tapping.

7. Top CONFIG block for easy customisation:
   const CONFIG = { gameTitle, scoreToWin, themes, ballEmojis }

8. Touch support already works for paddle drag — make sure 2P right-side
   touch drag works correctly for the second player too.
```

### Test it

Play through the full flow: enter your name, choose settings, play a match,
win (or let the CPU win), check the end screen stats. Try 2-player mode.
Try it on a phone — tap the name box and confirm the phone keyboard appears.

**Reference version:** `v2/index.html`.

### What is happening here

#### The CONFIG block — change anything without touching the game logic

```js
const CONFIG = {
  gameTitle:  '🎾 TENNIS!',
  scoreToWin: 5,
  themes: {
    classic: { court: '#3a8a40', sky: '#87ceeb', ... },
    night:   { court: '#1a237e', sky: '#0d0d0d', ... },
    clay:    { court: '#b5651d', sky: '#f4a460', ... },
  },
};
```

One object at the top. Change `scoreToWin` to 3 for a faster game.
Change `gameTitle` to your school's name. No other code needs to change.

#### localStorage — memory that survives the browser closing

```js
let stats = { wins: 0, losses: 0, streak: 0, bestStreak: 0 };
try {
  const saved = JSON.parse(localStorage.getItem('tennisStats') || '{}');
  Object.assign(stats, saved);
} catch(e) {}
```

`localStorage` is a small key-value store built into every browser.
The `try/catch` wrapper protects against private browsing mode, where it is disabled.

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

The Web Audio API synthesises tones mathematically in real time.
No `.mp3` files, no CDN, no internet connection needed.

#### The hidden input trick — phone keyboard on a canvas

The HTML canvas element cannot receive keyboard input directly.
To trigger the phone keyboard when a player taps the name box,
Bob adds an invisible `<input>` element off-screen and focuses it:

```html
<input id="nameInput" type="text"
  style="position:fixed; opacity:0; top:50%; left:50%; width:1px; height:1px;
         font-size:16px;">
<!-- font-size:16px prevents iOS from auto-zooming the page on focus -->
```

When the player taps the name area on the canvas, the code calls `.focus()`
on this invisible input. The phone keyboard appears. The player types.
The value syncs back into the game state in real time.

> **Why it works:** `focus()` must be called inside a user gesture handler
> (a tap or click event). Calling it automatically on page load is blocked
> by browsers to prevent unwanted keyboard pop-ups.

### If something feels off

- *"The setup screen has too many options — it's overwhelming"* →
  `Simplify the setup screen — show only Difficulty and Mode. Remove the theme and ball style selectors.`
- *"The name entry is confusing on mobile"* →
  `Make the name entry box larger and more obvious on the name screen. The OK button should be big and clearly labelled.`
- *"The confetti feels slow"* →
  `Make the confetti burst faster and more energetic — more particles, higher initial velocity.`

---

## Step 3a — Progressive difficulty and ball trail

**What you get:** The CPU gets smarter as the game goes on — each 2 points scored
makes it slightly faster, up to a maximum. The ball leaves a fading ghost trail
that makes fast rallies feel dramatic.
**Time:** about 10 minutes.

### The prompt

```
Add two features to my tennis game HTML file:

1. Progressive difficulty (single-player only):
   - CPU speed increases every 2 total points scored in the current game
   - Maximum of 8 speed boosts (capped so it never becomes impossible)
   - Show a small "⚡ LVL X" badge near the score while playing
   - Play a short ascending tone when the CPU levels up

2. Ball trail effect:
   - Keep a ring buffer of the last 8 ball positions
   - Draw them behind the ball each frame with decreasing opacity
     (newest position = most opaque, oldest = nearly invisible)
   - Scale down older positions slightly so the trail tapers to a point
   - Works for both canvas-drawn balls and emoji balls
```

### Test it

Play until the CPU reaches Level 3 or 4. Notice how the game shifts from easy
to tense. Watch the ball trail — does it feel satisfying? Too long? Too short?
Does the level badge feel intrusive, or does it add to the excitement?

**Reference version:** `v3a/index.html`.

### What is happening here

#### The ring buffer — a fixed-size sliding history

```js
let trail = [];

// Each frame, before moving the ball:
trail.push({ x: ball.x, y: ball.y });
if (trail.length > 8) trail.shift();  // drop the oldest position
```

`push` adds to the end. `shift` removes from the start.
The array never grows longer than 8 items — it slides forward in time.
This pattern appears everywhere: undo history, autocomplete suggestions,
network packet buffers. You just built one.

#### Drawing opacity that fades with age

```js
for (let i = 0; i < trail.length; i++) {
  const age = (i + 1) / trail.length;  // 0 = oldest, 1 = newest
  ctx.globalAlpha = age * 0.35;
  ctx.beginPath();
  ctx.arc(trail[i].x, trail[i].y, BALL_R * (0.4 + age * 0.5), 0, Math.PI * 2);
  ctx.fill();
}
ctx.globalAlpha = 1;  // always reset — leaving this out breaks all subsequent drawing
```

### If something feels off

- *"The CPU levels up too fast — it becomes impossible too quickly"* →
  `Make the CPU level up every 4 points instead of every 2, and reduce the maximum boosts to 5.`
- *"The trail is distracting"* →
  `Shorten the ball trail to 4 positions and reduce its maximum opacity to 0.2.`
- *"I want the trail to match the ball colour"* →
  `Make the ball trail colour match the current ball style — same colour as the ball itself.`

---

## Step 3b — Power-ups

**What you get:** Three collectible power-ups that appear randomly on the court.
The ball picks them up on contact. Each one swings the game for a few seconds —
enough to turn a losing position into a win, or waste a lead.
**Time:** about 15 minutes.

### The prompt

```
Add a power-up system to my tennis game HTML file:

Three power-up types that randomly appear on the court every 3–6 seconds:
- ⚡ Speed Boost: the ball fires at near-max speed on the next hit
- 🛡️ Big Paddle: the collecting player's paddle grows 40% taller for ~6 seconds
- 🎯 Aim Assist: the CPU aims less accurately for ~5 seconds

Behaviour:
- Only one power-up on the court at a time
- Appears as a pulsing glowing emoji circle in the middle third of the court
- The ball collects it on contact (proximity check using Math.hypot)
- The power-up goes to the side whose ball direction shows they just hit it
- Show a colour-coded progress bar above the active paddle during the effect
- Flash a message on collection ("⚡ SPEED BOOST!")
- Play a rising three-note pickup sound on collection
- Power-ups clear between points
```

### Test it

Play until a power-up appears. Aim for it deliberately. Notice that it assigns
to the side that hit the ball toward it — this is the fairness mechanic.
Does the CPU ever collect them? (It should.) Does the progress bar feel clear?
Does collecting a power-up feel exciting, or does it feel like clutter?

**Reference version:** `v3b/index.html`.

### What is happening here

#### Circle collision with `Math.hypot`

```js
const dx = ball.x - powerup.x;
const dy = ball.y - powerup.y;
if (Math.hypot(dx, dy) < BALL_R + POWERUP_RADIUS) {
  // ball has touched the power-up
}
```

`Math.hypot(dx, dy)` is the straight-line distance between two points —
the Pythagorean theorem in one function. If that distance is less than
the sum of both radii, the circles overlap. This is circle-circle collision detection.

#### Timed effects with a frame countdown

```js
// When a power-up is collected:
playerEffect = { id: 'grow', framesLeft: 350 };

// Every frame in the update loop:
if (playerEffect) {
  playerEffect.framesLeft--;
  if (playerEffect.framesLeft <= 0) playerEffect = null;
}
```

No `setTimeout`, no `Date.now()`. The game already runs a loop 60 times per second —
a counter that decrements each frame *is* a timer. 350 frames ÷ 60 fps ≈ 5.8 seconds.

### If something feels off

- *"Power-ups appear too often and the court feels cluttered"* →
  `Make power-ups appear every 8–12 seconds instead of every 3–6.`
- *"The progress bar is hard to see"* →
  `Make the power-up progress bar taller (12px) and add a label showing the effect name above it.`
- *"I want the CPU to never get power-ups — it should always go to the player"* →
  `Change the power-up system so the player always collects the power-up regardless of ball direction.`

---

## Step 3c — Tournament mode

**What you get:** A full best-of-3 match. Each game is one set.
A set-end overlay shows the score and auto-transitions with a countdown.
The match-end screen shows the complete history — every set, every score.
**Time:** about 15 minutes.

### The prompt

```
Add tournament mode to my tennis game HTML file:

Rules:
- A match is best of 3 sets (first to win 2 sets wins the match)
- A set is first to 5 points (existing score limit)
- After a set ends, show a set-end overlay for 3 seconds
  with the set score, then auto-start the next set
- After the match ends, show a detailed match-end screen

Set-end overlay must show:
- Who won the set and the score (e.g. "YOU WIN SET 2!  4 – 3")
- Current match standing (e.g. "Match: YOU 1 · BOB 1")
- "Next set starting in 3..." countdown

Match-end screen must show:
- Winner announcement
- Score of every set played
- Final set tally
- Win/loss stats from localStorage
- Play Again and Setup buttons

Scoreboard changes during play:
- Add set dots to the score display (filled circle per set won, hollow per remaining)
- Show "SET X" label between the dot groups
- Replace the stats ribbon at the bottom with set history scores
```

### Test it

Play a full 3-set match. Watch the overlay between sets — does the 3-second
countdown feel right, or too fast? Check the match-end screen shows the correct
per-set scores. Test that Play Again resets everything cleanly.
Try deliberately losing a set to check the standings update correctly.

**Reference version:** `v3c/index.html`.

### What is happening here

#### A state machine inside a state machine

The `phase` variable has always controlled which screen to show.
Tournament mode adds transitions *within* the game phase:

```
'serve' → 'play' → 'point' → 'serve' (loop within a set)
                            ↓ set over
                         'setEnd' — 3-second overlay — auto → 'serve' (new set)
                                                              ↓ match over
                                                           'matchEnd'
```

Every screen, transition, and overlay is just a value of `phase`.
This pattern — a variable that controls which code runs — scales to any complexity.

#### Accumulating history across sets

```js
let setHistory = [];

// When a set ends:
setHistory.push({ player: playerScore, cpu: cpuScore });

// To display it on the match-end screen:
setHistory.forEach((s, i) => {
  ctx.fillText(`Set ${i+1}:  YOU ${s.player} – ${s.cpu}  BOB`, W/2, y);
  y += 32;
});
```

### If something feels off

- *"3 seconds between sets is too long — the game loses momentum"* →
  `Reduce the set-end overlay to 2 seconds. Keep the countdown but start it at 2.`
- *"The match-end screen disappears before I finish reading it"* →
  `Make the match-end screen stay until the player taps Play Again — remove any auto-dismiss.`
- *"The set dots are too small to see on a phone"* →
  `Make the set indicator dots larger — at least 18px diameter — and increase the spacing between them.`

---

## Step 3d — Full edition (everything together)

**What you get:** All three v3 features running simultaneously —
progressive difficulty, ball trail, power-ups, and tournament mode —
tuned to work together without conflicts. This is the complete game.
**Time:** about 15 minutes.

### The prompt

```
Combine all features into one tennis game HTML file:

From v3a:
- Progressive CPU difficulty: speed increases every 2 points, up to 8 boosts
- Ball trail: 8-position ring buffer, fading ghost copies behind the ball

From v3b:
- Power-ups (⚡ speed boost · 🛡️ big paddle · 🎯 aim assist)
  — spawn every 3–6 seconds, ball collects on proximity,
  coloured progress bar on active paddle, flash message on pickup

From v3c:
- Tournament mode: best of 3 sets, set-end overlay, match-end screen
  with full per-set history, set dots in the scoreboard

Integration rules:
- CPU speed boost resets to base speed at the start of each new set
- Power-ups clear between sets and between points
- Level indicator sits in the top-right corner of the court
- Set history replaces the stats ribbon at the bottom during play
```

### Test it

Play a full tournament match. Specifically check:
- The CPU levels up within a set but resets when the next set begins
- Power-ups clear cleanly between points and between sets
- The ball trail, level badge, and set dots all appear without visual clutter
- Collecting a power-up during a tense rally feels exciting, not confusing

**Reference version:** `v3d/index.html` (also the root `index.html`).

### What is happening here

Combining features is not just adding code together — it requires deliberate
integration rules to prevent features from breaking each other. Three principles
this step follows:

**State resets at boundaries.** The CPU speed boost is a per-set state change.
Without an explicit reset at set-start, Level 6 from Set 1 would carry into Set 2.
The integration rules in the prompt are exactly these boundary resets.

**Single responsibility for display space.** The stats ribbon and the set history
both want the same space at the bottom of the canvas. The integration rule
("set history replaces the stats ribbon") resolves the conflict explicitly rather
than letting them overlap.

**Test the combinations, not just the features.** A power-up collected on the last
point of a set needs to: clear the effect, clear the power-up, trigger the set-end
overlay, and reset the CPU speed — all in the same frame. Playing through these
moments is how you find integration bugs that code review cannot catch.

---

## Step 4 — Native smartphone polish

**What you get:** Your game already plays on phones — touch paddle control
has been there since Step 1. This step makes it *feel native*: the canvas
fills any screen without scrolling, the phone keyboard appears automatically
for name entry, and every hint text adapts to the device in hand.
**Time:** about 10 minutes.

### The prompt

```
Polish my tennis game for smartphones. Touch paddle control already works —
this step is about layout, name entry, and adaptive instructions.

1. Responsive canvas layout:
   The canvas should fill the viewport on any screen size
   (phone portrait, tablet landscape, desktop widescreen)
   without scrolling or letterboxing.
   Use CSS min() to size it: width fills the screen,
   height preserves the 800×560 aspect ratio.
   Use 100dvh alongside 100vh for the browser address bar on mobile.

2. Native mobile name entry:
   When the player taps the name input area on the canvas, focus a hidden
   off-screen <input> element to trigger the native phone keyboard.
   Show a visible OK ✓ button to confirm (instead of requiring Enter).
   Set font-size:16px on the hidden input to prevent iOS auto-zoom.

3. Adaptive hint text — detect touch vs keyboard at runtime:
   const isTouchDevice = () =>
     ('ontouchstart' in window) || (navigator.maxTouchPoints > 0);
   Call this when drawing each screen (not once at startup —
   a laptop with a touchscreen can switch modes).

   Touch hints:          "Drag your side to move · tap to serve"
   Keyboard hints:       "↑↓ or W/S to move · Space to serve"
   2P touch:             "Drag left (P1) · right (P2) · tap to serve"

4. Minimum 56×56px touch targets for the mute button and all UI buttons.

Keep all existing keyboard and mouse controls working on desktop.
Do not remove or break any gameplay features.
```

### Test it

Open the finished file on your phone. Does the canvas fill the screen without
scrollbars? Tap the name box — does the phone keyboard appear?
Type your name and tap OK. Play a full game using only touch.
Then open it on a laptop and confirm keyboard controls still work.
Try rotating your phone to landscape — the canvas should adapt.

> 🌐 **Live version:** [zoran-polic.github.io/game-set-code](https://zoran-polic.github.io/game-set-code/)

### What is happening here

#### Responsive canvas with CSS `min()`

```css
#gameCanvas {
  width:  min(100vw, calc(95dvh * 800 / 560));
  height: min(95dvh, calc(100vw * 560 / 800));
}
```

`min()` picks the smaller of two values, so the canvas never overflows either
dimension. The fractions (`800/560`) preserve the aspect ratio.
`dvh` (dynamic viewport height) shrinks when the mobile browser address bar
is visible, preventing the canvas from hiding behind it.

#### Detecting touch vs keyboard at runtime

```js
const isTouchDevice = () =>
  ('ontouchstart' in window) || (navigator.maxTouchPoints > 0);
```

Called *while drawing each screen*, not once at startup.
A Surface Pro user might detach the keyboard mid-game.
The instruction text updates automatically.

#### What the hidden input trick solves

The canvas element cannot be focused for text input — it is a drawing surface,
not a form field. On a phone, no keyboard will appear unless the browser has
an `<input>` or `<textarea>` to focus. The hidden input (introduced in Step 2)
solves this: it is invisible, off-screen, and zero-sized, but it is a real input
that the browser can focus. When `.focus()` is called inside a tap handler,
the phone keyboard appears as if the player tapped a normal text field.
The typing syncs to game state via the `input` event listener in real time.

### If something feels off

- *"On my phone the canvas is too small and there are black bars on the sides"* →
  `The canvas should fill the full screen width on portrait phones — remove any max-width constraint and use 100vw.`
- *"The phone keyboard covers the OK button when I type my name"* →
  `Move the name entry box and OK button to the top third of the canvas so they stay visible above the phone keyboard.`
- *"The hint text is too small to read on a phone"* →
  `Increase the font size of all in-game hint text to at least 18px when a touch device is detected.`

---

## The vibe-coding mindset — how to prompt well

You do not need to be a programmer to use Bob effectively.
But a few habits make the difference between good results and great results.

### Be specific about what you see, not what you think the code should do

| ❌ Vague | ✅ Specific |
|---|---|
| "Make it better" | "The CPU paddle snaps instantly to the ball — make it feel like it has weight and momentum" |
| "Fix the bug" | "When I miss the ball, the next serve fires immediately with no pause — add a 1-second delay" |
| "Make it more fun" | "Add a short screen-flash effect when someone scores a point" |
| "Improve the graphics" | "Draw a net in the middle of the court — a thin white rectangle with a small white post at the top" |

### Always describe the constraint alongside the change

> "Add a slow-motion effect when the ball is about to go out of bounds —
> **but only for half a second and only if the player is close to the ball**."

Constraints are what separate a fun feature from a broken one.
Bob respects them.

### Trust the first result — then refine

Bob's first answer is rarely perfect and does not need to be.
Accept it, test it, then give a follow-up prompt that describes specifically
what to change. Two focused prompts reliably beat one overly-specified prompt.

### When Bob gets it wrong

Sometimes Bob misunderstands a prompt. Sometimes the result has a bug.
Neither is a reason to stop.

The recovery is always the same:
1. Describe exactly what is wrong in plain language
2. Add: *"The rest of the game should stay exactly as it is."*
3. If Bob introduces a new problem while fixing the old one: paste the previous
   working version back into the chat and try a differently-worded prompt

Bob learns from context within a session. Describe what you tried and what happened.
The more specific your description of the problem, the more targeted the fix.

---

## Going further — 12 prompts to take this anywhere

Once you have completed all the steps, the game is yours to take in any direction.
These prompts work as starting points — modify them, combine them, or use them
as inspiration for something entirely your own.

---

**Visual — make it look different**

*Makes the court feel like a real venue rather than a flat diagram:*
```
Draw a proper tennis net in the middle of the court —
a thin white rectangle, 6px wide, with a small white post at the top.
The ball should not pass through it — treat it as a wall it bounces off.
```

*Adds a sense of depth without any 3D code:*
```
Add a shadow beneath the ball that grows larger and lighter
as the ball moves toward the center of the court and smaller
and darker as it moves toward the walls.
This should make the court feel three-dimensional.
```

*Makes every paddle hit feel physical:*
```
Add a particle burst at the exact pixel where the ball hits a paddle —
12 small sparks that fly outward in random directions and fade over 20 frames.
Match the spark colour to the paddle colour.
```

---

**Gameplay — make it play different**

*Rewards long rallies and creates natural tension:*
```
Add a rally counter in the middle of the court that shows the current
number of consecutive hits without a miss. Make it glow yellow when
it reaches 5 and pulse red when it reaches 10.
Reset it to zero when either player misses.
```

*Creates a memory and prediction challenge:*
```
Add a "ghost ball" mode as an option on the setup screen.
When active, the ball turns invisible for 1.5 seconds after each serve,
then reappears. The player has to predict where it will be.
```

*Injects chaos at random moments:*
```
Add a wall that appears randomly in the middle of the court for 4 seconds
then disappears. The ball bounces off it. It should appear in a random
vertical position but always be a fixed size (80px tall, 12px wide).
```

---

**Social — make it better to share**

*Lets someone brag about a win in a text message:*
```
Add a shareable score card on the match-end screen.
It shows: player name, final score, longest rally, number of power-ups collected.
Display it as a styled box with a "Copy result" button that copies
a plain-text version to the clipboard, formatted like:
🎾 TENNIS! — [name] won 2-1 (Sets) · Best rally: 14 · Power-ups: 3
```

*Rewards consistency and gives players something to chase:*
```
Add an achievement system. Show a toast notification for:
- "First Win!" on the first win
- "Hot Streak! 🔥" after 3 wins in a row
- "Survived Level 5! ⚡" when the CPU reaches level 5 and the player is still winning
- "Power-up Hunter! 🎯" after collecting 5 power-ups in one match
Store unlocked achievements in localStorage and show a trophy count on the end screen.
```

---

**Platform — make it reach more people**

*Turns the end screen into a way to spread the game:*
```
Add a QR code to the end screen that encodes the game's URL
so anyone who watches can scan it and play immediately.
Generate the QR code using only canvas drawing — no external libraries.
```

*Lets someone add the game to their phone home screen and play offline:*
```
Make the game installable as a Progressive Web App.
Add a manifest.json section inline in the HTML (as a <script type="application/json">)
and a minimal service worker registered from within the HTML file
so the game works offline and can be added to the phone home screen.
Keep everything in one file.
```

*The next question every kid asks — "can we play against each other?":*
```
Add real-time 2-player mode over the network using WebSockets.
One player hosts (their browser acts as the server via a free WebSocket relay).
The other player joins by entering a 4-digit room code.
Each player controls one paddle from their own device.
Keep the single-file approach — use a public WebSocket relay service (e.g. wss://relay.peerjs.com)
so no server setup is needed.
```

---

**Completely different direction — use this as a template**

*The same physics engine, audio, and layout — totally different game:*
```
I want to change this tennis game into a brick-breaker game.
Keep the canvas size, the audio system, the CONFIG block, the localStorage stats,
the confetti, and the responsive layout.
Replace the two paddles and CPU with: a single paddle at the bottom
that the player controls, and a grid of 5×8 coloured bricks at the top.
The ball bounces off the paddle and destroys bricks on contact.
The game ends when all bricks are cleared (win) or the ball passes the paddle (lose).
```

*Keeps the visual engine but teaches a completely different skill:*
```
Turn this tennis game into a typing speed game for kids.
Keep the canvas, audio, confetti, and responsive layout.
Show a word in the middle of the screen. The player types it as fast as possible
on a keyboard or taps the letters on an on-screen keyboard drawn on the canvas.
Track words per minute. Show 10 words per round. Store the best score in localStorage.
```

---

## How to build anything with Bob — the transferable skill

The tennis game is finished. The skill you used to build it applies to anything.

Here is the pattern, stripped to its core:

**1. Describe the simplest possible version.**
Not the full vision — the first slice. Something you can test in under 5 minutes.
Bob is better at producing a small thing well than a large thing approximately.

**2. Save it before you change it.**
Before asking Bob to make any significant change, save a copy of the current file.
Name it something you will recognise. If the next version is worse, you are one
file-open away from being back on solid ground.

**3. Test it with real use.**
Not "does the code look right" — does it *feel* right when you use it?
The gap between those two questions is where the real design work happens.

**4. Describe one change at a time.**
Compound prompts ("change X and also Y and also Z") produce compound errors.
One change per prompt keeps the results clean and the debugging trivial.

**5. Treat every output as a draft.**
Bob's first answer is a starting point, not a finished product.
The best outputs come from a conversation, not a single prompt.

**6. Name what you feel, not what you think the fix is.**
"This feels unfair when the CPU gets a power-up" is a better prompt
than "reduce the CPU power-up probability to 0.3."
Bob can reason about fairness. You might not know the right probability.
Describe the experience; let Bob find the mechanism.

---

## Version history

| Version | File | What is new |
|---|---|---|
| v1 | `v1/index.html` | Canvas game loop, physics, CPU AI, start/end screens, touch paddle control |
| v2 | `v2/index.html` | Name entry, setup screen, themes, 2-player, localStorage stats, confetti, sound |
| v3a | `v3a/index.html` | Progressive CPU difficulty, ball trail |
| v3b | `v3b/index.html` | Power-up system (spawn, collect, effects, progress bar) |
| v3c | `v3c/index.html` | Tournament mode (sets, overlays, match history screen) |
| v3d | `v3d/index.html` | All v3 features combined and integrated |
| v4 | `index.html` *(root — no subfolder)* | Responsive canvas, native phone keyboard, adaptive hint text |

---

## Concepts reference card

For the curious — every concept used in this game, where it first appears, and what it does.

| Concept | First appears | What it does |
|---|---|---|
| Game loop | v1 | `requestAnimationFrame(loop)` — runs ~60 times/sec, drives everything |
| State machine | v1 | `phase` variable controls which screen draws and which input is active |
| Ball physics | v1 | `ball.x += ball.vx` each frame; flip `vx` on paddle hit, `vy` on wall hit |
| Collision detection | v1 | Bounding-box check (paddle) + velocity direction check (is the ball moving toward it?) |
| CPU AI | v1 | Move toward `ball.y * missFactor` — intentionally imperfect |
| Web Audio API | v1 | `createOscillator()` — synthesised tones, no audio files |
| Touch input | v1 | `touchmove` / `touchstart` events; `e.touches[0]` for the first finger |
| CONFIG block | v2 | Top-level object; change the game without touching logic |
| localStorage | v2 | `JSON.stringify` / `JSON.parse` — persist stats across sessions |
| Canvas particles | v2 | Confetti: array of `{x,y,vx,vy,life}` objects; remove when `life ≤ 0` |
| Hidden input trick | v2 | Off-screen `<input>` focused programmatically to trigger mobile keyboard |
| Ring buffer | v3a | `push` + `shift` at fixed max length — efficient sliding window of history |
| Frame countdown | v3b | `framesLeft--` each update — simple timer without `setTimeout` |
| Proximity collision | v3b | `Math.hypot(dx, dy) < r1 + r2` — circle-circle overlap test |
| Sine animation | v3b | `Math.sin(frame * 0.12)` — smooth looping pulse without CSS |
| Nested state machine | v3c | Phases within phases — set flow inside match flow |
| Accumulating history | v3c | `array.push(result)` — grow a record of results over time |
| Responsive canvas | v4 | CSS `min()` — fills any viewport without JS |
| Runtime device detect | v4 | `isTouchDevice()` — adapts hints without two code paths |

---

## About this project

Every line of code in this repository was generated through prompts to **IBM Bob** —
IBM's AI coding assistant — then refined through follow-up prompts.
No code was written by hand. The workflow described in this tutorial
is exactly how the game was built.

That same workflow applies to any project: a game, a tool, a website, a script,
a data analysis, a presentation generator, a personal dashboard.
The only prerequisite is being able to describe what you want.

**If you can describe it, you can build it.**

---

*This game was originally built for the IBM Volunteer Event: GAME, SET, CODE,
at IBM RTP, Durham NC, on September 9, 2026.*

**Live demo:** [zoran-polic.github.io/game-set-code](https://zoran-polic.github.io/game-set-code/)
**IBM Bob:** [ibm.com/products/watson-code-assistant](https://www.ibm.com/products/watson-code-assistant)

---

*Happy building. 🎾*
