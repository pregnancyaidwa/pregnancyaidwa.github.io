# Agent instructions

These instructions apply throughout this repository. Read [CONVENTIONS.md](CONVENTIONS.md)
and [CONTRIBUTING.md](CONTRIBUTING.md) before making changes. Preserve the licensing
terms in [LICENSE.md](LICENSE.md) and existing file notices.

## Project and source of truth

This is the Pregnancy Aid of Washington State website. It uses Bootstrap 3,
jQuery 1.12.4, Font Awesome, and HTML templates with Server Side Includes (SSI).

- Edit website content and assets in `src/`.
- Shared partials are `src/_*.html`; location-specific pages live under
  `src/desmoines/`. Preserve the existing SSI include patterns and relative paths.
- `scripts/gen-site.sh` expands includes, rewrites `.shtml` links to `.html`,
  generates legacy `.shtml` redirects, and copies assets into `gen/`.
- `gen/` is ignored build output. Regenerate it rather than editing it directly.
- GitHub Actions builds and deploys the generated static site to GitHub Pages.
  The deployed site does not require an SSI-capable server.

## Build and preview

Run commands from the repository root. The build requires Bash and standard Unix
utilities; on Windows use Git Bash or WSL.

```bash
bash -n scripts/gen-site.sh
bash scripts/gen-site.sh
```

The build deletes and recreates `./gen/`. Keep source files out of that directory.
To preview the generated site when Python is available:

```bash
python -m http.server 8000 --directory gen
```

Open `http://localhost:8000/`. Stop the server when finished.

## Editing conventions

- Follow existing page and shared-partial structure. Prefer changes in shared
  partials when the change should affect every page.
- When changing `src/css/site.css`, increment its `version` query parameter in
  `src/_Head2.html` so visitors receive the updated stylesheet.
- Preserve responsive Bootstrap patterns, descriptive image alternative text,
  keyboard navigation, and readable contrast. Check mobile and desktop layouts
  for visual changes.
- Keep assistance messaging Free, Confidential, and Compassionate. Do not invent
  service availability, contact details, medical claims, or organizational policy.
- Keep changes focused. Treat bundled third-party CSS, JavaScript, and fonts as
  vendor assets; update them only when the task calls for it.
- For workflows and composite actions, follow the SHA pinning, release comment,
  permission, and Dependabot requirements in `CONVENTIONS.md`.

## Validation and handoff

There is no automated test suite currently. For website or build-script changes,
run the syntax check and build above, then inspect the affected generated pages.
Check that SSI includes are expanded, `.html` links and assets resolve, and legacy
`.shtml` redirects still point to the expected pages. For shared changes, include
a root page and `desmoines/index.html` in the checks.

Run `git diff --check` for every change. In the handoff, summarize the changes,
report the checks actually performed, and state any checks that could not run.
Documentation-only changes do not require rebuilding the website.
