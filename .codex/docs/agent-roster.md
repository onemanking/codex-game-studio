# Agent Roster

The following agents are available. Each has a dedicated definition file in
`.codex/agents/`. Use the agent best suited to the task at hand. When a task
spans multiple domains, the coordinating agent (usually `producer` or the
domain lead) should delegate to specialists.

## Tier 1 -- Leadership Agents (Deep)
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `creative-director` | High-level vision | Major creative decisions, pillar conflicts, tone/direction |
| `technical-director` | Technical vision | Architecture decisions, tech stack choices, performance strategy |
| `producer` | Production management | Sprint planning, milestone tracking, risk management, coordination |

## Tier 2 -- Department Lead Agents (Standard)
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `game-designer` | Game design | Mechanics, systems, progression, economy, balancing |
| `lead-programmer` | Code architecture | System design, code review, API design, refactoring |
| `art-director` | Visual direction | Style guides, art bible, asset standards, UI/UX direction |
| `audio-director` | Audio direction | Music direction, sound palette, audio implementation strategy |
| `narrative-director` | Story and writing | Story arcs, world-building, character design, dialogue strategy |
| `qa-lead` | Quality assurance | Test strategy, bug triage, release readiness, regression planning |
| `release-manager` | Release pipeline | Build management, versioning, changelogs, deployment, rollbacks |
| `localization-lead` | Internationalization | String externalization, translation pipeline, locale testing |

## Tier 3 -- Specialist Agents (Standard or Fast)
| Agent | Domain | Model | When to Use |
|-------|--------|-------|-------------|
| `systems-designer` | Systems design | Standard | Specific mechanic implementation, formula design, loops |
| `level-designer` | Level design | Standard | Level layouts, pacing, encounter design, flow |
| `economy-designer` | Economy/balance | Standard | Resource economies, loot tables, progression curves |
| `gameplay-programmer` | Gameplay code | gpt-5.3-codex-spark | Feature implementation, gameplay systems code |
| `engine-programmer` | Engine systems | gpt-5.3-codex-spark | Core engine, rendering, physics, memory management |
| `ai-programmer` | AI systems | gpt-5.3-codex-spark | Behavior trees, pathfinding, NPC logic, state machines |
| `network-programmer` | Networking | gpt-5.3-codex-spark | Netcode, replication, lag compensation, matchmaking |
| `tools-programmer` | Dev tools | gpt-5.3-codex-spark | Editor extensions, pipeline tools, debug utilities |
| `ui-programmer` | UI implementation | gpt-5.3-codex-spark | UI framework, screens, widgets, data binding |
| `technical-artist` | Tech art | Default | Shaders, VFX, optimization, art pipeline tools |
| `sound-designer` | Sound design | Standard | SFX design docs, audio event lists, mixing notes |
| `writer` | Dialogue/lore | Standard | Dialogue writing, lore entries, item descriptions |
| `world-builder` | World/lore design | Standard | World rules, faction design, history, geography |
| `qa-tester` | Test execution | Fast | Writing test cases, bug reports, test checklists |
| `performance-analyst` | Performance | Standard | Profiling, optimization recs, memory analysis |
| `devops-engineer` | Build/deploy | gpt-5.3-codex-spark | CI/CD, build scripts, version control workflow |
| `analytics-engineer` | Telemetry | Standard | Event tracking, dashboards, A/B test design |
| `ux-designer` | UX flows | Standard | User flows, wireframes, accessibility, input handling |
| `prototyper` | Rapid prototyping | gpt-5.3-codex-spark | Throwaway prototypes, mechanic testing, feasibility validation |
| `security-engineer` | Security | Default | Anti-cheat, exploit prevention, save encryption, network security |
| `accessibility-specialist` | Accessibility | Default | WCAG compliance, colorblind modes, remapping, text scaling |
| `live-ops-designer` | Live operations | Standard | Seasons, events, battle passes, retention, live economy |
| `community-manager` | Community | Fast | Patch notes, player feedback, crisis comms, community health |
| `browser-qa-specialist` | Browser QA | Default | Browser smoke checks, console review, canvas rendering, mobile viewport, input/audio validation |

## Engine-Specific Agents (use the set matching your engine)

### Engine Leads

| Agent | Engine | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `unreal-specialist` | Unreal Engine 5 | Default | Blueprint vs C++, GAS overview, UE subsystems, Unreal optimization |
| `unity-specialist` | Unity | Default | MonoBehaviour vs DOTS, Addressables, URP/HDRP, Unity optimization |
| `godot-specialist` | Godot 4 | Default | GDScript patterns, node/scene architecture, signals, Godot optimization |
| `web-game-specialist` | Web Browser | Default | Browser runtime architecture, stack profiles, hybrid Phaser/Three/R3F boundaries |

### Unreal Engine Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `ue-gas-specialist` | Gameplay Ability System | Default | Abilities, gameplay effects, attribute sets, tags, prediction |
| `ue-blueprint-specialist` | Blueprint Architecture | Default | BP/C++ boundary, graph standards, naming, BP optimization |
| `ue-replication-specialist` | Networking/Replication | Default | Property replication, RPCs, prediction, relevancy, bandwidth |
| `ue-umg-specialist` | UMG/CommonUI | Default | Widget hierarchy, data binding, CommonUI input, UI performance |

### Unity Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `unity-dots-specialist` | DOTS/ECS | Default | Entity Component System, Jobs, Burst compiler, hybrid renderer |
| `unity-shader-specialist` | Shaders/VFX | Default | Shader Graph, VFX Graph, URP/HDRP customization, post-processing |
| `unity-addressables-specialist` | Asset Management | Default | Addressable groups, async loading, memory, content delivery |
| `unity-ui-specialist` | UI Toolkit/UGUI | Default | UI Toolkit, UXML/USS, UGUI Canvas, data binding, cross-platform input |

### Godot Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `godot-gdscript-specialist` | GDScript | Default | Static typing, design patterns, signals, coroutines, GDScript performance |
| `godot-csharp-specialist` | C# / .NET | Default | .NET patterns, [Signal] delegates, async, nullable types, type-safe node access |
| `godot-shader-specialist` | Shaders/Rendering | Default | Godot shading language, visual shaders, particles, post-processing |
| `godot-gdextension-specialist` | GDExtension | Default | C++/Rust bindings, native performance, custom nodes, build systems |

### Web Browser Sub-Specialists

| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `phaser-specialist` | Phaser 2D | Default | Scenes, cameras, sprites, tilemaps, Arcade/Matter physics, browser scale/input |
| `threejs-specialist` | Three.js/WebGL | Default | Render loop, scene graph, loaders, materials, shaders, post-processing, performance |
| `r3f-specialist` | React Three Fiber | Default | React-hosted 3D, Canvas ownership, state boundaries, drei/physics, DOM HUD integration |
| `browser-qa-specialist` | Browser QA | Default | Dev server/build checks, console errors, screenshots, canvas nonblank, desktop/mobile input/audio |
