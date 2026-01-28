# Commit Message Skill

Generate consistent commit messages following Conventional Commits.

## Trigger

Activate when user says: "commit", "write commit message", "prepare commit"

## Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

## Types

| Type | Use for |
|------|---------|
| `feat` | New features |
| `fix` | Bug fixes |
| `docs` | Documentation only |
| `style` | Formatting (no code change) |
| `refactor` | Code restructuring |
| `perf` | Performance improvements |
| `test` | Adding/fixing tests |
| `build` | Build system changes |
| `ci` | CI configuration |
| `chore` | Maintenance tasks |

## Rules

- Imperative mood: "add" not "added"
- No capital after colon
- No trailing period
- Max 72 characters for subject
- Wrap body at 72 characters

## Scope

Use area affected: `auth`, `api`, `db`, `ui`, or feature name. Omit for broad changes.

## Footer

- Reference issues: `Fixes #123` or `Refs #456`
- Breaking changes: `BREAKING CHANGE: description`

## Process

1. Run `git status` and `git diff --staged`
2. Analyze changes
3. Propose commit message
4. Explain type/scope choice if unclear
5. Ask for confirmation before committing
