# Social Flow Skill Pack

OpenClaw skill package for operating the `social` CLI with safe, plan-first workflows.

This repository is skill-only and packages one orchestrator skill:

- `skills/social-flow`

## What It Covers

- Auth and token workflows
- Query and data discovery
- Facebook posting workflows
- Instagram workflows
- WhatsApp workflows
- Marketing API workflows
- Ops, agent, gateway, and studio workflows

## Requirement

Install `social` CLI first:

```bash
npm install -g @vishalgojha/social-flow
```

Verify source before installing:

- npm: `https://www.npmjs.com/package/@vishalgojha/social-flow`
- repository: `https://github.com/vishalgojha/social-flow`

## Install Skill Locally

Copy or clone this repository, then place the skill folder in one of:

- Workspace skill path: `<workspace>/skills/social-flow/`
- Global local path: `~/.openclaw/skills/social-flow/`

Then restart OpenClaw so it reloads skills.

## Validate Skill

```powershell
./skills/social-flow/scripts/ci_validate_skill.ps1 -SkillRoot ./skills/social-flow
./skills/social-flow/scripts/validate_examples.ps1 -SkillRoot ./skills/social-flow
./skills/social-flow/scripts/verify_upstream_contract.ps1 -SkillRoot ./skills/social-flow -Repo vishalgojha/social-flow -Ref main
```

## Publish to ClawHub

```bash
clawhub login --no-browser --token YOUR_TOKEN
clawhub publish ./skills/social-flow --slug socialclaw-cli --name "Social Flow" --version 0.1.3 --tags latest --changelog "Update Social Flow naming and risk-gated workflow guidance"
```

## CI Gate

This repository includes `.github/workflows/quality.yml`.

It blocks regressions by validating:

- required skill structure and frontmatter
- local command examples used in references
- upstream `social-flow` command contract for key command signatures
