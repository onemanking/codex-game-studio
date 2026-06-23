# Security Policy

## Supported Versions

Only the current `main` branch of this template is maintained.

## Reporting a Vulnerability

Report security issues privately through your GitHub repository's security
advisory flow after you publish this template, or contact the maintainer of your
fork directly. Do not disclose exploitable issues in public issues first.

Include:

- What is affected.
- Steps to reproduce.
- Potential impact.
- Suggested mitigation, if known.

## Scope

This template runs locally inside a developer workspace. Relevant security issues
include:

- Skills, agents, or scripts that silently read secrets.
- Undocumented outbound network calls.
- Commands that can modify files outside the workspace without explicit approval.
- Validation or sync logic that follows unsafe paths.
- Prompt-injection-prone skill instructions that bypass documented user approval.

Out of scope:

- Vulnerabilities in Codex itself.
- Bugs in the user's editor or local shell.
- Theoretical issues without a practical attack path.

## Contributor Guidelines

- Keep scripts auditable and path-scoped.
- Do not add hidden telemetry or background services.
- Document any network access clearly.
- Prefer explicit user approval before destructive operations.
- Validate generated skill and agent files before claiming a change is ready.
