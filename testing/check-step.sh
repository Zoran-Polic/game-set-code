#!/usr/bin/env bash
# check-step.sh — Behavioural validator for game-set-code tutorial outputs
#
# Usage:
#   check-step.sh <step> <html-file>
#
# Steps: 1 | 2 | 3a | 3b | 3c | 3d
#
# Exit code: 0 = all checks passed, 1 = one or more checks failed

set -euo pipefail

STEP="${1:-}"
FILE="${2:-}"

if [[ -z "$STEP" || -z "$FILE" ]]; then
  echo "Usage: $0 <step> <html-file>"
  echo "Steps: 1 | 2 | 3a | 3b | 3c | 3d"
  exit 1
fi

if [[ ! -f "$FILE" ]]; then
  echo "ERROR: file not found: $FILE"
  exit 1
fi

PASS=0
FAIL=0

check() {
  local desc="$1"
  local pattern="$2"
  if grep -qP "$pattern" "$FILE" 2>/dev/null || grep -q "$pattern" "$FILE" 2>/dev/null; then
    echo "  ✅  $desc"
    (( PASS++ )) || true
  else
    echo "  ❌  $desc  [pattern: $pattern]"
    (( FAIL++ )) || true
  fi
}

check_absent() {
  local desc="$1"
  local pattern="$2"
  if ! grep -q "$pattern" "$FILE" 2>/dev/null; then
    echo "  ✅  $desc"
    (( PASS++ )) || true
  else
    echo "  ❌  $desc (unwanted pattern found: $pattern)"
    (( FAIL++ )) || true
  fi
}

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Checking Step $STEP — $(basename "$FILE")"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

case "$STEP" in

  1)
    echo "  Step 1: The first game"
    echo ""
    check "Canvas element present"                    "<canvas"
    check "Ball bounces — speed increase per hit"     "speed.*hit\|vx\|vy\|ball\.speed\|BALL_SPEED\|speedInc\|speedUp"
    check "Ball speed capped (max 11)"                "11\|maxSpeed\|MAX_SPEED\|speed.*cap\|cap.*speed"
    check "Arrow key controls"                        "ArrowUp\|ArrowDown\|arrowup\|arrowdown"
    check "W/S key controls"                          "KeyW\|KeyS\|key.*['\"]w['\"]"
    check "CPU AI with accuracy"                      "acc\|accuracy\|0\.82\|0\.68\|0\.94"
    check "Score: first to 5"                        "scoreToWin.*5\|5.*scoreToWin\|toWin.*5\|winScore.*5\|score.*>=.*5\|>= 5\|=== 5"
    check "YOU vs BOB score labels"                   "YOU\|BOB"
    check "Start screen / PLAY button"                "PLAY\|play.*btn\|startScreen\|PHASE_START\|phase.*start"
    check "End screen (win/lose)"                     "YOU WIN\|BOB WINS\|PLAY AGAIN\|playAgain"
    check "Web Audio API — no external files"         "AudioContext\|createOscillator\|OscillatorNode"
    check "Mute toggle button"                        "muteBtn\|mute.*btn\|toggle.*mute\|muted"
    check "Touch — left-half drag"                    "touchmove\|touchstart\|touches\[0\]"
    check "No external CDN/files"                     "inline\|no.*CDN\|self.contained"
    check_absent "No <script src= external"          '<script src="http'
    ;;

  2)
    echo "  Step 2: Setup screen, themes, 2-player, stats"
    echo ""
    # Step 1 features must still be present
    check "Canvas still present"                      "<canvas"
    check "Web Audio API retained"                    "AudioContext\|createOscillator"
    check "Touch controls retained"                   "touchmove\|touchstart"
    # Step 2 additions
    check "Name entry screen"                         "nameInput\|name.*screen\|playerName\|PHASE_NAME\|phase.*name"
    check "Hidden input for mobile keyboard"          "opacity:0\|opacity: 0\|opacity:0.0\|pointer-events:none\|pointerEvents.*none"
    check "Setup screen"                              "setupScreen\|PHASE_SETUP\|phase.*setup\|difficulty.*Easy\|Easy.*Medium.*Hard"
    check "Difficulty: Easy/Medium/Hard"              "Easy.*Medium.*Hard\|Easy.*speed\|Medium.*speed"
    check "3 court themes"                            "Classic\|Night\|Clay"
    check "6 ball styles"                             "soccer\|basketball\|star\|heart"
    check "2-player mode"                             "2P\|2 Player\|twoPlayer\|mode.*2\|KeyI\|KeyK"
    check "P2 I/K keyboard controls"                  "KeyI\|KeyK\|['\"]i['\"].*['\"]k['\"]"
    check "P2 right-side touch"                       "right.*half\|canvas.*width.*\/.*2\|clientX.*>\|x.*>.*W"
    check "localStorage stats"                        "localStorage\|tenniStats\|tennisStats"
    check "Wins/losses/streak stored"                 "wins\|losses\|streak"
    check "Confetti particles"                        "confetti\|particle\|Confetti"
    check "Fanfare sound"                             "fanfare\|Fanfare\|sndFanfare\|win.*melody\|8.*note"
    check "Click sound for buttons"                   "sndClick\|click.*sound\|clickSnd"
    check "CONFIG block"                              "const CONFIG\|CONFIG ="
    check "Mute button 56px minimum"                  "56px\|min-width.*56\|width.*56"
    ;;

  3a)
    echo "  Step 3a: Progressive difficulty + ball trail"
    echo ""
    # Step 2 features must still be present
    check "Name entry retained"                       "nameInput\|playerName\|PHASE_NAME"
    check "Setup screen retained"                     "Easy.*Medium.*Hard\|PHASE_SETUP"
    check "localStorage retained"                     "localStorage"
    check "Confetti retained"                         "confetti\|Confetti"
    # Step 3a additions
    check "CPU level variable"                        "cpuLevel\|cpu_level\|cpuLvl"
    check "Level up every 2 points"                   "PROG_POINTS_PER_LEVEL\|pointsPerLevel\|every.*2\|2.*points\|floor.*\/.*2"
    check "Max 8 speed boosts"                        "PROG_MAX_BOOSTS\|maxBoosts\|MAX_BOOSTS\|8.*boost\|boost.*8"
    check "Level badge displayed"                     "LVL\|lvl\|levelBadge\|drawLevel\|level.*badge"
    check "Level-up sound"                            "levelUp.*sound\|tone.*660\|tone.*880\|levelUpCheck\|levelUpSnd"
    check "Trail ring buffer"                         "trail\|TRAIL_LEN\|trailLen\|ring.*buffer"
    check "Trail max 8 positions"                     "TRAIL_LEN.*8\|8.*trail\|trail.*8\|trail\.length.*8\|> 8\|> TRAIL"
    check "Trail opacity fades"                       "opacity\|globalAlpha\|alpha.*trail\|trail.*alpha"
    check "Trail size tapers"                         "radius.*trail\|trail.*radius\|scale.*trail\|0\.35\|0\.45"
    check "Trail cleared on reset"                    "trail.*length.*0\|trail\.length = 0\|trail.*reset\|resetBall"
    ;;

  3b)
    echo "  Step 3b: Power-ups"
    echo ""
    # Step 2 features must still be present
    check "Name entry retained"                       "nameInput\|playerName\|PHASE_NAME"
    check "Setup screen retained"                     "Easy.*Medium.*Hard\|PHASE_SETUP"
    check "localStorage retained"                     "localStorage"
    # Step 3b additions
    check "Power-up object/state"                     "powerup\|powerUp\|power_up\|POWERUP"
    check "Speed Boost type"                          "speed.*boost\|speedBoost\|SPEED_BOOST\|Speed Boost"
    check "Big Paddle type"                           "big.*paddle\|bigPaddle\|BIG_PADDLE\|Big Paddle\|grow.*paddle"
    check "Aim Assist type"                           "aim.*assist\|aimAssist\|AIM_ASSIST\|Aim Assist"
    check "Only one power-up at a time"               "powerup.*null\|null.*powerup\|activePowerup\|currentPowerup"
    check "Proximity check with Math.hypot"           "Math\.hypot\|hypot"
    check "Spawn every 3-6 seconds"                   "3.*6.*second\|spawnTimer\|spawn.*timer\|3000\|6000\|180\|360"
    check "Progress bar above paddle"                 "progress.*bar\|progressBar\|effectBar\|bar.*effect"
    check "Flash message on collection"               "SPEED BOOST\|BIG PADDLE\|AIM ASSIST\|flashMsg\|flash.*message\|collectMsg"
    check "Rising three-note pickup sound"            "pickup.*sound\|sndPickup\|three.*note\|powerup.*sound\|tone.*powerup"
    check "Power-ups clear between points"            "powerup.*null\|clearPowerup\|reset.*powerup\|powerup.*clear"
    check "Pulsing/glowing effect on spawn"           "pulse\|glow\|sin.*frame\|Math\.sin"
    ;;

  3c)
    echo "  Step 3c: Tournament mode"
    echo ""
    # Step 2 features must still be present
    check "Name entry retained"                       "nameInput\|playerName\|PHASE_NAME"
    check "Setup screen retained"                     "Easy.*Medium.*Hard\|PHASE_SETUP"
    check "localStorage retained"                     "localStorage"
    # Step 3c additions
    check "Sets tracking variables"                   "setsP1\|setsP2\|sets.*won\|setScore\|SET_TO_WIN\|setsToWin"
    check "Best of 3 (first to 2 sets)"               "2.*set\|set.*2\|SET_TO_WIN.*2\|setsToWin.*2\|first.*2"
    check "Set-end overlay phase"                     "setEnd\|SET_END\|PHASE_SET_END\|phase.*set.*end\|setOver"
    check "3-second countdown between sets"           "countdown\|3.*second\|3000\|setTimer\|180\|COUNT"
    check "Set score shown in overlay"                "set.*score\|score.*set\|setHistory\|set.*result"
    check "Match standings in overlay"                "Match.*YOU\|Match.*BOB\|matchScore\|match.*standing"
    check "Match-end screen"                          "matchEnd\|MATCH_END\|PHASE_MATCH_END\|match.*end\|matchOver"
    check "Per-set history on match-end screen"       "setHistory\|set.*history\|history.*set\|Set 1\|Set 2"
    check "Set dots in scoreboard"                    "dot\|setDot\|filled.*circle\|set.*dot\|●\|○"
    check "SET X label in scoreboard"                 "SET [0-9]\|SET.*label\|setLabel\|currentSet"
    check "Stats on match-end screen"                 "wins\|losses\|streak.*end\|stats.*match"
    check "Play Again + Setup buttons on match-end"   "Play Again\|playAgain\|PLAY AGAIN"
    ;;

  3d)
    echo "  Step 3d: Full edition (3a + 3b + 3c combined)"
    echo ""
    # All Step 2 features
    check "Name entry retained"                       "nameInput\|playerName\|PHASE_NAME"
    check "Setup screen retained"                     "Easy.*Medium.*Hard\|PHASE_SETUP"
    check "localStorage retained"                     "localStorage"
    check "Confetti retained"                         "confetti\|Confetti"
    # From 3a
    check "CPU level (3a)"                            "cpuLevel\|cpu_level\|cpuLvl"
    check "Trail ring buffer (3a)"                    "trail\|TRAIL_LEN"
    check "Level badge (3a)"                          "LVL\|levelBadge\|drawLevel"
    # From 3b
    check "Power-ups (3b)"                            "powerup\|powerUp\|POWERUP"
    check "Math.hypot collision (3b)"                 "Math\.hypot\|hypot"
    check "Progress bar (3b)"                         "progressBar\|effectBar\|progress.*bar"
    # From 3c
    check "Sets tracking (3c)"                        "setsP1\|setsP2\|sets.*won\|setScore"
    check "Set-end overlay (3c)"                      "setEnd\|SET_END\|PHASE_SET_END"
    check "Match-end screen (3c)"                     "matchEnd\|MATCH_END\|PHASE_MATCH_END"
    check "Set history (3c)"                          "setHistory\|set.*history"
    # Integration rules
    check "CPU level resets each set"                 "cpuLevel.*0\|cpuLevel = 0\|reset.*cpu.*level\|set.*cpuLevel"
    check "Power-ups clear between sets"              "powerup.*null\|clearPowerup\|reset.*powerup"
    check "Level indicator top-right of court"        "top.*right\|topRight\|corner.*level\|level.*corner"
    ;;

  *)
    echo "ERROR: unknown step '$STEP'. Valid steps: 1 | 2 | 3a | 3b | 3c | 3d"
    exit 1
    ;;
esac

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Result: $PASS passed, $FAIL failed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [[ $FAIL -gt 0 ]]; then
  exit 1
fi
exit 0
