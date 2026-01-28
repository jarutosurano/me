# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Nextra documentation site using the `nextra-theme-docs` theme. Nextra is a Next.js-based static site generator for documentation.

**Live site**: https://me-kappa-six.vercel.app/

Commits to `main` automatically deploy to Vercel.

## Commands

```bash
pnpm i          # Install dependencies
pnpm dev        # Start development server (localhost:3000)
pnpm build      # Build for production
pnpm start      # Start production server
```

## Architecture

- **Content**: Documentation pages live in `pages/` as `.mdx` files (Markdown with JSX support)
- **Navigation**: Controlled by `_meta.json` files in each directory - defines page order, titles, and external links
- **Theme config**: `theme.config.tsx` contains site-wide settings (logo, links, footer)
- **Next.js config**: `next.config.js` wraps Next.js with Nextra using `nextra-theme-docs`
- **Components**: React components in `components/` can be imported directly into MDX files

## Adding Pages

Create `.mdx` files in `pages/` and add entries to `pages/_meta.json` to control navigation order and titles.

## Skills

Available slash commands for Claude Code:

| Command | Purpose |
|---------|---------|
| `/nextra-dev` | Nextra-specific patterns, MDX pages, navigation, theme config |
| `/docs-engineer` | Documentation writing, information architecture, content patterns |
| `/commit` | Git commit workflow |
| `/code-review` | Code review |
| `/security-review` | Security review |
