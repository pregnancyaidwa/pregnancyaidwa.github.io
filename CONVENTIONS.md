# Repository conventions

## GitHub Actions

When creating or modifying workflows in `.github/workflows/` or composite actions:

- Pin every external action and reusable workflow in `uses:` to a full 40-character
  commit SHA verified against the upstream repository. Branches, version tags, and
  abbreviated hashes are mutable or insufficient pins.
- Add the corresponding release version as a trailing comment (for example,
  `# v4.4.0`) and keep that comment aligned with the pinned commit when updating.
- Local references such as `uses: ./path/to/action` use the checked-out repository
  and do not need a separate SHA. Pin container references (`docker://`) by digest.
- Keep token permissions explicit and limited to what each job needs.
- Keep `.github/dependabot.yml` configured for `github-actions` at `/`, with weekly
  checks on Tuesdays, a seven-day `cooldown.default-days`, and an
  `open-pull-requests-limit` of five. Review Dependabot PRs and upstream changes
  before merging; preserve SHA pins and version comments.

The cooldown delays version updates to allow time for problems in new releases to
be discovered. It does not guarantee a safe dependency and does not delay
Dependabot security updates. See the
[Dependabot options reference](https://docs.github.com/en/code-security/reference/supply-chain-security/dependabot-options-reference).
