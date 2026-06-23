# Available Skills (Slash Commands)

131 workspace-local skills are available in this template:

- 73 studio workflow skills organized by phase.
- 58 mirrored browser-library skills for Phaser, Three.js, and React Three Fiber.

Type `/` in Codex to access workflow-style skills when slash routing is available,
or reference the skill name directly. Browser-game umbrella skills such as
`game-studio`, `web-game-foundations`, `phaser-2d-game`, `three-webgl-game`,
`react-three-fiber-game`, `game-ui-frontend`, `web-3d-asset-pipeline`,
`sprite-pipeline`, and `game-playtest` are supplied by the installed Codex Game
Studio plugin and are intentionally not duplicated in this repository.

## Onboarding & Navigation

| Command | Purpose |
|---------|---------|
| `/start` | First-time onboarding — asks where you are, then guides you to the right workflow |
| `/help` | Context-aware "what do I do next?" — reads current stage and surfaces the required next step |
| `/project-stage-detect` | Full project audit — detect phase, identify existence gaps, recommend next steps |
| `/setup-engine` | Configure engine + version, detect knowledge gaps, populate version-aware reference docs |
| `/adopt` | Brownfield format audit — checks internal structure of existing GDDs/ADRs/stories, produces migration plan |

## Web Browser Engine Family

| Command | Purpose |
|---------|---------|
| `/game-studio` | Plugin browser-game router across Phaser, Three.js, React Three Fiber, hybrid architecture, UI, assets, and QA |
| `/web-game-foundations` | Plugin browser runtime architecture skill for loop ownership, input, audio, storage, responsive behavior, and deployment constraints |
| `/phaser-2d-game` | Plugin Phaser browser-game implementation skill |
| `/three-webgl-game` | Plugin plain Three.js browser-game runtime skill |
| `/react-three-fiber-game` | Plugin React-hosted 3D browser-game skill |
| `/game-ui-frontend` | Plugin browser-game HUD, overlay, menu, and responsive UI skill |
| `/web-3d-asset-pipeline` | Plugin GLB/glTF, texture, material, and browser 3D asset budget skill |
| `/sprite-pipeline` | Plugin 2D sprite sheet and animation asset workflow skill |
| `/game-playtest` | Plugin browser-game smoke/playtest skill |

## Game Design

| Command | Purpose |
|---------|---------|
| `/brainstorm` | Guided ideation using professional studio methods (MDA, SDT, Bartle, verb-first) |
| `/map-systems` | Decompose game concept into systems, map dependencies, prioritize design order |
| `/design-system` | Guided, section-by-section GDD authoring for a single game system |
| `/quick-design` | Lightweight design spec for small changes — tuning, tweaks, minor additions |
| `/review-all-gdds` | Cross-GDD consistency and game design holism review across all design docs |
| `/propagate-design-change` | When a GDD is revised, find affected ADRs and produce an impact report |

## Art & Assets

| Command | Purpose |
|---------|---------|
| `/art-bible` | Guided, section-by-section Art Bible authoring — creates visual identity spec before asset production begins |
| `/asset-spec` | Generate per-asset visual specifications and AI generation prompts from GDDs, level docs, or character profiles |
| `/asset-audit` | Audit assets for naming conventions, file size budgets, and pipeline compliance |

## UX & Interface Design

| Command | Purpose |
|---------|---------|
| `/ux-design` | Guided section-by-section UX spec authoring (screen/flow, HUD, or pattern library) |
| `/ux-review` | Validate UX specs for GDD alignment, accessibility, and pattern compliance |

## Architecture

| Command | Purpose |
|---------|---------|
| `/create-architecture` | Guided authoring of the master architecture document |
| `/architecture-decision` | Create an Architecture Decision Record (ADR) |
| `/architecture-review` | Validate all ADRs for completeness, dependency ordering, and GDD coverage |
| `/create-control-manifest` | Generate flat programmer rules sheet from accepted ADRs |

## Stories & Sprints

| Command | Purpose |
|---------|---------|
| `/create-epics` | Translate GDDs + ADRs into epics — one per architectural module |
| `/create-stories` | Break a single epic into implementable story files |
| `/dev-story` | Read a story and implement it — routes to the correct programmer agent |
| `/sprint-plan` | Generate or update a sprint plan; initializes sprint-status.yaml |
| `/sprint-status` | Fast 30-line sprint snapshot (reads sprint-status.yaml) |
| `/story-readiness` | Validate a story is implementation-ready before pickup (READY/NEEDS WORK/BLOCKED) |
| `/story-done` | 8-phase completion review after implementation; updates story file, surfaces next story |
| `/estimate` | Structured effort estimate with complexity, dependencies, and risk breakdown |

## Reviews & Analysis

| Command | Purpose |
|---------|---------|
| `/design-review` | Review a game design document for completeness and consistency |
| `/code-review` | Architectural code review for a file or changeset |
| `/balance-check` | Analyze game balance data, formulas, and config — flag outliers |
| `/content-audit` | Audit GDD-specified content counts against implemented content |
| `/scope-check` | Analyze feature or sprint scope against original plan, flag scope creep |
| `/perf-profile` | Structured performance profiling with bottleneck identification |
| `/tech-debt` | Scan, track, prioritize, and report on technical debt |
| `/gate-check` | Validate readiness to advance between development phases (PASS/CONCERNS/FAIL) |
| `/consistency-check` | Scan all GDDs against the entity registry to detect cross-document inconsistencies (stats, names, rules that contradict each other) |
| `/security-audit` | Audit the game for security vulnerabilities: save tampering, cheat vectors, network exploits, data exposure, and input validation gaps |

## QA & Testing

| Command | Purpose |
|---------|---------|
| `/qa-plan` | Generate a QA test plan for a sprint or feature |
| `/smoke-check` | Run critical path smoke test gate before QA hand-off |
| `/soak-test` | Generate a soak test protocol for extended play sessions |
| `/regression-suite` | Map test coverage to GDD critical paths, identify fixed bugs without regression tests |
| `/test-setup` | Scaffold the test framework and CI/CD pipeline for the project's engine |
| `/test-helpers` | Generate engine-specific test helper libraries for the test suite |
| `/test-evidence-review` | Quality review of test files and manual evidence documents |
| `/test-flakiness` | Detect non-deterministic (flaky) tests from CI run logs |
| `/skill-test` | Validate skill files for structural compliance and behavioral correctness |
| `/skill-improve` | Improve a skill using a test-fix-retest loop — diagnose, propose fix, rewrite, verify |

## Production

| Command | Purpose |
|---------|---------|
| `/milestone-review` | Review milestone progress and generate status report |
| `/retrospective` | Run a structured sprint or milestone retrospective |
| `/bug-report` | Create a structured bug report |
| `/bug-triage` | Read all open bugs, re-evaluate priority vs. severity, assign owner and label |
| `/reverse-document` | Generate design or architecture docs from existing implementation |
| `/playtest-report` | Generate a structured playtest report or analyze existing playtest notes |

## Release

| Command | Purpose |
|---------|---------|
| `/release-checklist` | Generate and validate a pre-release checklist for the current build |
| `/launch-checklist` | Complete launch readiness validation across all departments |
| `/changelog` | Auto-generate changelog from git commits and sprint data |
| `/patch-notes` | Generate player-facing patch notes from git history and internal data |
| `/hotfix` | Emergency fix workflow with audit trail, bypassing normal sprint process |
| `/day-one-patch` | Prepare a focused day-one patch for known issues discovered after gold master but before or at public launch |

## Creative & Content

| Command | Purpose |
|---------|---------|
| `/prototype` | Concept prototype — throwaway build right after brainstorm to validate core idea (Phase 1) |
| `/vertical-slice` | Pre-Production validation — production-quality end-to-end build before committing to Production (Phase 4) |
| `/onboard` | Generate contextual onboarding document for a new contributor or agent |
| `/localize` | Localization workflow: string extraction, validation, translation readiness |

## Team Orchestration

Coordinate multiple agents on a single feature area:

| Command | Coordinates |
|---------|-------------|
| `/team-combat` | game-designer + gameplay-programmer + ai-programmer + technical-artist + sound-designer + qa-tester |
| `/team-narrative` | narrative-director + writer + world-builder + level-designer |
| `/team-ui` | ux-designer + ui-programmer + art-director + accessibility-specialist |
| `/team-release` | release-manager + qa-lead + devops-engineer + producer |
| `/team-polish` | performance-analyst + technical-artist + sound-designer + qa-tester |
| `/team-audio` | audio-director + sound-designer + technical-artist + gameplay-programmer |
| `/team-level` | level-designer + narrative-director + world-builder + art-director + systems-designer + qa-tester |
| `/team-live-ops` | live-ops-designer + economy-designer + community-manager + analytics-engineer |
| `/team-qa` | qa-lead + qa-tester + gameplay-programmer + producer |
