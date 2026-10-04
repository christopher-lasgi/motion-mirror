# Contributing

Thanks for helping. This repository is a single Claude Code skill, so contributions are small and precise.

## Good contributions

- A mistake you hit while cloning a reference video, with the rule that would have prevented it (a row in `references/retro-log.md` plus the hardened rule).
- A better ffmpeg recipe, a measured gate threshold, a clearer step in the pipeline.
- A fix for anything unclear, wrong or outdated.

## Before you open a pull request

1. Branch from `main`: `feat/...`, `fix/...` or `docs/...`.
2. Keep the skill brand-neutral and free of media (see `AGENTS.md`).
3. Run `scripts/check.sh`. It must pass.
4. Open the pull request with the template: what, why, how you checked it. One concern per pull request.

Commits follow Conventional Commits (`type(scope): imperative summary`). Open an issue first for anything larger than a fix.

## Releases

Maintainers tag `vMAJOR.MINOR.PATCH` and publish notes grouped as Added, Changed, Fixed. Changes to the standing orders or QA gates are a minor version at least.

## License

By contributing you agree that your work is released under the MIT License.
