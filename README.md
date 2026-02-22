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

## Install Skill Locally

Copy or clone this repository, then place the skill folder in one of:

- Workspace skill path: `<workspace>/skills/socialclaw-cli/`
- Global local path: `~/.openclaw/skills/socialclaw-cli/`

Then restart OpenClaw so it reloads skills.

## Validate Skill

```powershell
& 'C:\Users\visha\AppData\Local\Python\bin\python.exe' `
  'C:\Users\visha\.codex\skills\.system\skill-creator\scripts\quick_validate.py' `
  'C:\Users\visha\SocialClaw-CLI\skills\socialclaw-cli'
```
