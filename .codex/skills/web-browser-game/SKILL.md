---
name: web-browser-game
description: Use when a browser game needs stack selection or routing across Phaser, Three.js, React Three Fiber, UI, assets, playtesting, and hybrid Web Browser architecture.
---

# Web Browser Game Engine Family

Treat **Web Browser** as an engine family, not as a single library. Use this
skill when the project targets playable browser delivery through Canvas, WebGL,
WebGPU, DOM UI, or a hybrid of those surfaces.

## Stack Profiles

- **Phaser 2D**: 2D games with scenes, sprites, cameras, tilemaps, Arcade or
  Matter physics, and fast browser-first iteration.
- **Three.js 3D**: plain WebGL/WebGPU-style runtime ownership, custom render
  loops, GLB/glTF asset loading, shaders, lighting, and postprocessing.
- **React Three Fiber**: React-hosted 3D scenes where UI, app state, and DOM
  workflows are first-class.
- **Hybrid Browser Game**: Phaser plus Three.js or R3F, or DOM UI plus one or
  more canvases. Pick this when the game genuinely needs mixed 2D/3D surfaces.
- **Shared Browser Platform**: routing, input, audio unlock, storage, asset
  budgets, fullscreen, pointer lock, responsive layout, and deployment.

## Routing

Read only the skills needed for the selected profile:

- Shared browser architecture: `../web-game-foundations/SKILL.md`
- Phaser 2D runtime: `../phaser-2d-game/SKILL.md`
- Plain Three.js runtime: `../three-webgl-game/SKILL.md`
- React Three Fiber runtime: `../react-three-fiber-game/SKILL.md`
- Browser game UI/HUD: `../game-ui-frontend/SKILL.md`
- Browser 3D assets: `../web-3d-asset-pipeline/SKILL.md`
- Sprite pipeline: `../sprite-pipeline/SKILL.md`
- Browser playtesting and QA: `../game-playtest/SKILL.md`

For detailed library APIs, route to the mirrored skill families:

- `phaser-*` skills for Phaser scenes, input, physics, tilemaps, cameras,
  animation, loading, audio, scale, and rendering.
- `threejs-*` skills for Three.js fundamentals, loaders, materials, lighting,
  shaders, interaction, animation, postprocessing, profiling, and QA.
- `r3f-*` skills for React Three Fiber scene structure, state boundaries, drei,
  physics, performance, postprocessing, and React integration.

## Hybrid Guardrails

Before implementation, define these boundaries in the architecture decision:

1. **Loop owner**: one system owns the authoritative gameplay tick. Other
   renderers subscribe to state or run visual-only interpolation.
2. **Surface ownership**: document which layer owns Phaser canvas, Three/R3F
   canvas, DOM HUD, modals, overlays, and pointer events.
3. **Input bus**: normalize keyboard, pointer, gamepad, and touch into game
   actions before engine-specific handling.
4. **Asset lifecycle**: keep loaders, cache keys, disposal, and preload screens
   explicit. Do not duplicate large assets across runtimes.
5. **Audio unlock**: plan user-gesture unlock, pause/resume, mute, and mobile
   browser behavior.
6. **Viewport behavior**: handle resize, DPR caps, fullscreen, orientation,
   focus loss, pointer lock, and mobile safe areas.
7. **QA gate**: verify with a browser smoke/playtest pass before claiming the
   game loop, canvas rendering, input, or responsive layout is complete.

## Expected Output

For greenfield work, produce a short stack decision:

- Engine Family: Web Browser
- Stack Profile: Phaser / Three.js / React Three Fiber / Hybrid
- Loop Owner:
- Rendering Surfaces:
- UI/HUD Ownership:
- Asset Pipeline:
- Browser QA Plan:

For existing projects, identify the current stack profile, missing boundaries,
and which specialized skills or agents should review the next change.
