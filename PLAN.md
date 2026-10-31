# Deferred improvements

These items are a backlog for future work, not instructions to implement them
as part of unrelated changes. None have been implemented by adding this plan.

## Pull request validation

- [ ] Run the site build on pull requests targeting `main` so failures are
  visible before merging.
- [ ] Keep deployment restricted to pushes to `main`; pull request validation
  should not receive deployment permissions or deploy the site.
- [ ] Verify both a successful PR build and a deliberately failing build, and
  confirm that a PR cannot trigger deployment.

## Automated build checks

- [ ] Check generated pages for unresolved SSI includes, broken local links,
  and missing local assets. Account for fragments, query strings, and legacy
  `.shtml` redirects without treating external URLs as local paths.
- [ ] Include root pages and `desmoines/index.html` in coverage.
- [ ] Run these checks during PR validation and demonstrate that representative
  broken includes, links, and assets cause a failed check.

## Enforce action SHA pins in GitHub settings

- [ ] With repository admin access, open **Settings > Actions > General**.
  Under **Actions permissions**, enable **Require actions to be pinned to a
  full-length commit SHA**, then click **Save**.
- [ ] Check for organization or enterprise policies if the setting is unavailable
  or cannot be changed. Organization-wide configuration is also available under
  the organization's **Settings > Actions > General**.
- [ ] Confirm the pinned workflow still runs after enabling the policy.

This setting applies to actions, including GitHub-authored actions. GitHub still
allows reusable workflows to be referenced by tag under this policy, so retain
the stricter reusable-workflow pinning convention in `CONVENTIONS.md`.

Reference: [Managing GitHub Actions settings for a repository](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository).
