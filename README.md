# SocialClaw-CLI

OpenClaw skill package for operating the `social` CLI with safe, plan-first workflows.

This repository is skill-only and packages one orchestrator skill:

- `skills/socialclaw-cli`

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
npm install -g @vishalgojha/social-cli
```

Verify source before installing:

- npm: `https://www.npmjs.com/package/@vishalgojha/social-cli`
- repository: `https://github.com/vishalgojha/social-CLI`

## Install Skill Locally

Copy or clone this repository, then place the skill folder in one of:

- Workspace skill path: `<workspace>/skills/socialclaw-cli/`
- Global local path: `~/.openclaw/skills/socialclaw-cli/`

Then restart OpenClaw so it reloads skills.

## Validate Skill

```powershell
./skills/socialclaw-cli/scripts/ci_validate_skill.ps1 -SkillRoot ./skills/socialclaw-cli
./skills/socialclaw-cli/scripts/validate_examples.ps1 -SkillRoot ./skills/socialclaw-cli
./skills/socialclaw-cli/scripts/verify_upstream_contract.ps1 -SkillRoot ./skills/socialclaw-cli -Repo vishalgojha/social-CLI -Ref main
```

## Publish to ClawHub

```bash
clawhub login --no-browser --token YOUR_TOKEN
clawhub publish ./skills/socialclaw-cli --slug socialclaw-cli --name "SocialClaw CLI" --version 0.1.2 --tags latest --changelog "Update summary and validation guards"
```

## CI Gate

This repository includes `.github/workflows/quality.yml`.

It blocks regressions by validating:

- required skill structure and frontmatter
- local command examples used in references
- upstream `social-CLI` command contract for key command signatures
```
