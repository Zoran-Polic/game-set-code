# Tutorial Testing Scripts

Automated end-to-end tests for the [GAME, SET, CODE tutorial](../TUTORIAL.md).

Each tutorial step has a defined prompt. These scripts run that prompt through
`bob run` (headless mode), capture the HTML output, and validate it against
behavioural criteria — checking that the output actually does what the step
promises, not just that it compiles.

---

## Scripts

| Script | Purpose |
|---|---|
| `test-tutorial.sh` | Orchestrator — runs all steps end-to-end, chains outputs |
| `check-step.sh` | Validator — checks one HTML file against a step's criteria |

---

## Requirements

- `bob` CLI in PATH (`bob --help` should work)
- bash 4+

---

## Usage

### Run all steps

```bash
cd volunteer/game-set-code/testing
chmod +x test-tutorial.sh check-step.sh
./test-tutorial.sh
```

Output HTML files land in `/tmp/tennis-test/step-1/tennis.html`, `step-2/`, etc.

### Run specific steps

```bash
./test-tutorial.sh --steps 1,2
./test-tutorial.sh --steps 3a,3b,3c,3d
./test-tutorial.sh --steps 3d
```

### Custom output directory

```bash
./test-tutorial.sh --out-dir ~/Desktop/tennis-test
```

### Validate a file you already have

```bash
./check-step.sh 1 ~/Desktop/tennis.html
./check-step.sh 3a ~/.bob/playground/tennis.html
```

---

## How branching works

Steps 3a, 3b, and 3c all branch from the Step 2 output — they are independent
feature additions, not a sequence. The orchestrator tracks the Step 2 output
and feeds it as input to each of 3a, 3b, and 3c separately.

Step 3d combines all three and also uses the Step 2 output as its base
(not a 3a/3b/3c output).

```
Step 1 → Step 2 ──┬── Step 3a
                  ├── Step 3b
                  ├── Step 3c
                  └── Step 3d
```

---

## What the checks cover

Each step's validator checks for the presence of key implementation patterns
in the generated HTML. The checks are **behavioural** — they look for variable
names, API calls, and values that indicate a feature is implemented, not just
that the file is non-empty.

| Step | Key checks |
|---|---|
| 1 | Canvas, ball physics, CPU accuracy, touch controls, Web Audio, start/end screens |
| 2 | Name entry, setup screen, 3 themes, 6 ball styles, 2P mode, localStorage, confetti, 4 sounds |
| 3a | `cpuLevel`, level badge, 8-position trail ring buffer, opacity/size taper, trail reset |
| 3b | 3 power-up types, `Math.hypot` collision, progress bar, flash message, clear between points |
| 3c | Sets tracking, set-end overlay, 3s countdown, match-end screen, set history, set dots |
| 3d | All of 3a+3b+3c, CPU level resets each set, power-ups clear between sets |

---

## Interpreting results

A **PASS** means all grep-based checks found their expected patterns.
A **FAIL** shows which specific checks failed and the pattern that was missing.

Note: a PASS means the code structure is correct, not that the game is
bug-free. Manual play-testing after automated checks is still recommended,
especially for 3d where feature interactions matter.
