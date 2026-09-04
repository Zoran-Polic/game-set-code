#!/usr/bin/env bash
# test-tutorial.sh — End-to-end tutorial prompt tester for game-set-code
#
# Runs each tutorial step using `bob run` in headless mode, chains outputs,
# and validates each result with check-step.sh.
#
# Usage:
#   ./test-tutorial.sh [--steps 1,2,3a,3b,3c,3d] [--out-dir /tmp/tennis-test]
#
# Options:
#   --steps   Comma-separated list of steps to run (default: all)
#             Valid: 1, 2, 3a, 3b, 3c, 3d
#   --out-dir Output directory for generated HTML files (default: /tmp/tennis-test)
#   --help    Show this help
#
# Requirements:
#   - `bob` CLI in PATH (bob run --help)
#   - check-step.sh in the same directory as this script

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHECKER="$SCRIPT_DIR/check-step.sh"
DEFAULT_OUT="/tmp/tennis-test"
STEPS_TO_RUN="1,2,3a,3b,3c,3d"
OUT_DIR="$DEFAULT_OUT"

# ── Parse args ──────────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case "$1" in
    --steps)   STEPS_TO_RUN="$2"; shift 2 ;;
    --out-dir) OUT_DIR="$2";      shift 2 ;;
    --help|-h)
      sed -n '2,20p' "$0" | sed 's/^# \?//'
      exit 0
      ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

mkdir -p "$OUT_DIR"

if [[ ! -x "$CHECKER" ]]; then
  chmod +x "$CHECKER"
fi

# ── Prompt definitions ──────────────────────────────────────────────────────
PROMPT_1='Create a single self-contained HTML file tennis game using HTML5 Canvas.

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

Save the result as tennis.html'

PROMPT_2='Upgrade my tennis game HTML file with these features. Keep the single-file approach.

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

Save the result as tennis.html'

PROMPT_3A='Add two features to my tennis game HTML file:

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

Save the result as tennis.html'

PROMPT_3B='Add a power-up system to my tennis game HTML file:

Three power-up types that randomly appear on the court every 3–6 seconds:
- ⚡ Speed Boost: the ball fires at near-max speed on the next hit
- 🛡️ Big Paddle: the collecting player'"'"'s paddle grows 40% taller for ~6 seconds
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

Save the result as tennis.html'

PROMPT_3C='Add tournament mode to my tennis game HTML file:

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

Save the result as tennis.html'

PROMPT_3D='Combine all features into one tennis game HTML file:

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

Save the result as tennis.html'

# ── Step runner ──────────────────────────────────────────────────────────────
RESULTS=()
PREV_HTML=""

run_step() {
  local step="$1"
  local prompt="$2"
  local input_file="$3"   # empty for step 1
  local out_file="$OUT_DIR/step-${step}/tennis.html"

  mkdir -p "$(dirname "$out_file")"

  echo ""
  echo "══════════════════════════════════════════════"
  echo "  Running Step $step"
  echo "══════════════════════════════════════════════"

  local full_prompt="$prompt"

  # For steps 2+ inject the previous HTML into the prompt
  if [[ -n "$input_file" && -f "$input_file" ]]; then
    local prev_content
    prev_content=$(cat "$input_file")
    full_prompt="Here is my current tennis.html file:

\`\`\`html
${prev_content}
\`\`\`

${prompt}"
  fi

  # Run bob headless in the output directory
  bob run \
    --workspace "$(dirname "$out_file")" \
    --mode agent \
    --max-turns 30 \
    "$full_prompt" 2>&1 | tail -5

  if [[ ! -f "$out_file" ]]; then
    echo "  ⚠️  WARNING: tennis.html not found at expected path: $out_file"
    echo "  Searching for any .html output..."
    local found
    found=$(find "$OUT_DIR/step-${step}" -name "*.html" 2>/dev/null | head -1)
    if [[ -n "$found" ]]; then
      echo "  Found: $found — using it"
      cp "$found" "$out_file"
    else
      echo "  ❌ No HTML output found for step $step — skipping validation"
      RESULTS+=("Step $step: ❌ NO OUTPUT")
      return
    fi
  fi

  # Validate
  if bash "$CHECKER" "$step" "$out_file"; then
    RESULTS+=("Step $step: ✅ PASS")
  else
    RESULTS+=("Step $step: ❌ FAIL")
  fi

  PREV_HTML="$out_file"
}

# ── Main ─────────────────────────────────────────────────────────────────────
IFS=',' read -ra STEP_LIST <<< "$STEPS_TO_RUN"

# Steps 3a/3b/3c all branch from step 2 — track the step-2 output separately
STEP2_HTML=""

for step in "${STEP_LIST[@]}"; do
  step="${step// /}"  # trim spaces
  case "$step" in
    1)  run_step "1"  "$PROMPT_1"  ""           ; STEP2_HTML="" ;;
    2)  run_step "2"  "$PROMPT_2"  "$PREV_HTML" ; STEP2_HTML="$PREV_HTML" ;;
    3a) run_step "3a" "$PROMPT_3A" "${STEP2_HTML:-$PREV_HTML}" ;;
    3b) run_step "3b" "$PROMPT_3B" "${STEP2_HTML:-$PREV_HTML}" ;;
    3c) run_step "3c" "$PROMPT_3C" "${STEP2_HTML:-$PREV_HTML}" ;;
    3d) run_step "3d" "$PROMPT_3D" "${STEP2_HTML:-$PREV_HTML}" ;;
    *)  echo "Unknown step: $step (valid: 1, 2, 3a, 3b, 3c, 3d)"; exit 1 ;;
  esac
done

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo "══════════════════════════════════════════════"
echo "  SUMMARY"
echo "══════════════════════════════════════════════"
for r in "${RESULTS[@]}"; do
  echo "  $r"
done
echo ""
