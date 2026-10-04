# motion-mirror: rules for any agent and any contributor

This repository holds one thing: the `motion-mirror` skill (`SKILL.md` and `references/`). It is public, brand-neutral and meant to be copied into other projects as is. Keep `main` clean at all times: every change goes through a pull request.

## Neutral by construction

- No brand, product, client or company name, no logo, no copy, no media. Examples stay generic ("the reference", "the target brand").
- No secret, local path, private repository name or private link. No session link, no model name, no "generated with" footer in any commit, pull request, issue or release.
- No reference media of any kind. The skill describes how to work with one; it never ships one.

## Writing rules (commits, pull requests, issues, releases, files)

Everything we write is read by strangers who know nothing about how it was made.

- English, plain and specific. Say what changed and why. No hype, no emoji, no filler, no em or en dashes, no "it is not just X, it is Y" constructions.
- Commits: Conventional Commits, `type(scope): imperative summary` under 72 characters (`feat`, `fix`, `docs`, `chore`). The body explains why, not what the diff already shows. One logical change per commit. No trailers.
- Pull requests: the title follows the commit format. The body follows `.github/pull_request_template.md`: what, why, how it was checked. One concern per pull request, no unrelated edits. Draft until `scripts/check.sh` passes.
- Issues: use the templates, one problem per issue, with a way to reproduce or a concrete example.
- Releases: SemVer tags `vMAJOR.MINOR.PATCH`. Notes are written for someone who uses the skill, grouped as Added, Changed, Fixed, with no internal chatter. A release is published only on the owner's explicit go.
- Files: kebab-case names, one topic per file, no duplicate of what another file already says (link instead). No placeholder text, no leftover notes, no empty sections.

## Working on the skill itself

- A correction becomes a row in `references/retro-log.md` and a hardened rule, gate or recipe in the same pull request (the skill's own self-correction loop).
- Keep `SKILL.md` short and move detail to `references/`. Every `references/...` link in `SKILL.md` must resolve.
- Run `scripts/check.sh` before opening a pull request.

## Never

An agent never merges, approves, closes issues or publishes releases. It never force-pushes `main` or rewrites shared history. It never adds a file nobody asked for.
