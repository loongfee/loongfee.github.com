# Repository Guidelines

## Project Structure & Module Organization
- `_posts/` — Blog posts as Markdown (`YYYY-MM-DD-title.md`).
- `pages/` — Static pages (About, Archive), built into `/pages/...`.
- `_layouts/` and `_includes/` — Jekyll templates and partials.
- `_plugins/` — Jekyll plugins (Ruby). Avoid adding dependencies not supported by GitHub Pages.
- `public/` — Assets (CSS/JS/images). Example: `public/css/favorite.css`.
- `favorite/` — Favorites page (`/favorite/index.html`).
- `_config.yml` — Site configuration (title, nav labels, analytics, disqus, permalink).
- `_site/` — Build output. Do not edit or commit changes here.
- `publish.py`, `upload.py`, `run.bat` — Windows-oriented helper scripts for build/deploy.

## Build, Test, and Development Commands
- Local dev: `jekyll serve --livereload` (serves at `http://localhost:4000`).
- Build site: `jekyll build -d _site`.
- Windows helpers: `run.bat` (runs `upload.py` then `publish.py`).
- Publish (Windows): `python publish.py` builds to a temp folder and pushes the generated site; `python upload.py` pushes source changes. Ensure Git remotes and credentials are configured.

## Coding Style & Naming Conventions
- Posts: filename `YYYY-MM-DD-title.md`; front matter includes `layout`, `title`, `date`, `categories`, `tags`.
- Markdown: use fenced code blocks with language hints (e.g., ```python).
- HTML/Liquid: 2-space indentation; reuse partials in `_includes/`; avoid inline styles.
- CSS/JS: place in `public/` and reference via `/public/...`. Keep selectors consistent (e.g., `#favorite`).

## Testing Guidelines
- No unit tests; validate by building locally: `jekyll build` then open pages (home, `/favorite/`, posts, RSS).
- Optional checks: `jekyll doctor`; link checking with `htmlproofer` if available.
- Do not modify `_site/` directly; always rebuild.

## Commit & Pull Request Guidelines
- Commits: concise, imperative. Suggested prefixes: `content:`, `fix:`, `style:`, `build:`, `chore:`.
- PRs: include summary, screenshots for UI changes, linked issues, and confirmation that `jekyll build` passes. Exclude `_site/` diffs.

## Security & Configuration Tips
- Keep tokens/secrets out of the repo. Only edit analytics/disqus/CNAME when explicitly required.
- Navigation labels are localized in `_config.yml` (`locals:`); update consistently with templates.

