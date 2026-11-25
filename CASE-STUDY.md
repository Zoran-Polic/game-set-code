# Teaching by Building: Designing a Zero-Install Browser Game Tutorial

Developer enablement is strongest when learners can make something real, see it work quickly, and then understand how each new capability changes the system.

For an IBM volunteer event, I built **Game, Set, Code**, a small browser-based tennis game and step-by-step tutorial. The goal was not to build a production game. It was to create a practical learning artifact: a project that people could open immediately, modify in small steps, and use to connect prompting, implementation choices, and visible results.

## Start with constraints that reduce friction

The project uses a deliberately simple delivery model:

- each version is a single self-contained HTML file;
- it runs in a modern browser without installation or login;
- it has no CDN or runtime network dependency;
- it supports keyboard, mouse, and touch interaction; and
- it can be opened locally as well as played in the browser.

Those constraints matter for learning. They remove setup problems and make the project easy to share, inspect, and adapt.

## Make progress visible through versions

The tutorial is organized as a sequence of working versions rather than one large final code drop.

- **v1** establishes the smallest playable loop: paddles, ball, and score.
- **v2** adds setup choices, difficulty, themes, two-player support, local win/loss tracking, sound, and touch controls.
- **v3** variants add progressive difficulty, visual ball trails, power-ups, and tournament mode.
- **v3d** combines those features into the full edition.

That structure lets a learner see the result of each change and makes it easier to discuss tradeoffs: what belongs in the core loop, what state has to persist, what should reset between sets, and how the controls should work on different devices.

## Use prompting as an iterative engineering activity

The public repository includes example prompts used to evolve the game. They are intentionally concrete: ask for a setup screen, a difficulty selector tied to CPU behavior, a second-player control scheme, local statistics, or a tournament-state overlay.

The useful lesson is not that a prompt replaces engineering judgment. It is that a clear prompt can define a small, testable increment. Each increment still needs an acceptance check:

- Does the feature work in the existing game loop?
- Does it work with keyboard and touch controls?
- Does it preserve the zero-install, offline model?
- Does it make the tutorial easier to understand rather than adding complexity without explanation?

This turns AI-assisted development into a sequence of observable design and verification decisions.

## Build for adaptation

The project keeps event-level customization in a visible configuration block. A facilitator can adjust the displayed organization name, game title, scoring, and related presentation details without changing the game’s underlying mechanics.

That is a small example of a broader enablement principle: expose the parts learners or facilitators are expected to change, and keep the rest of the system stable until they are ready to explore it.

## What I would reuse

For future developer-enablement work, I would reuse four practices from this project:

1. **Choose a small, runnable artifact.** Learners should see a result quickly.
2. **Teach through working increments.** A versioned path makes design decisions visible.
3. **Keep the environment lightweight.** Zero-install and offline-friendly materials lower the barrier to participation.
4. **Document the reasoning, not just the code.** A tutorial should explain what changed, why it changed, and how to verify it.

The public project and tutorial are available through the `game-set-code` repository and its project site.
