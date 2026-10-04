# Evals

Five scenarios that describe how an agent should behave with the skill installed. They are the way to check, on your own model and your own material, that the skill helps and does not deform the result.

## Run them

1. Pick the model and reasoning setting you use for real work.
2. For each entry in `evals.json`, run `query` twice in a clean session: once without the skill, once with it installed.
3. Compare each run with `expected_behavior`. Count a behaviour as met only if you can point to it in the transcript or the files produced.
4. Keep the two scores per scenario. The skill helps when the second run meets more behaviours than the first, on the scenarios that matter to you.

There is no built-in runner: use a script of your own or do it by hand. Results depend on the model, so repeat the run when you change model.

## Add one

When a correction teaches something new, add a scenario here in the same pull request as the rule and the row in `skills/motion-mirror/references/retro-log.md`. Format: `skills`, `query`, `files`, `expected_behavior` (a list of observable behaviours).
