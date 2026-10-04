License: MIT. Copyright (c) 2026 Christopher Lasgi.

# motion-mirror

A Claude Code skill to clone a reference motion-design video end to end (timing,
choreography, décor, sound placement), prove the clone with measured gates, lock it
scene by scene, then turn it into a template any app or brand can re-skin, in any
format and locale.

## Install

Copy this folder into a project or into your user skills:

```bash
cp -r motion-mirror <your-repo>/.claude/skills/      # one project
cp -r motion-mirror ~/.claude/skills/                # every project
```

Requirements: ffmpeg 6 or later (with `drawtext`), Node 20 or later, and a deterministic
renderer such as Remotion 4.

## Use

Ask Claude Code for the film, for example: "Mirror this teaser (`~/refs/teaser.mov`) for
our app, scene 1 only, and show me the side-by-side board." The skill makes it map the
shots, inventory décor, motion and sound, clone one scene, prove parity with numbers,
and wait for your validation before the next scene.

Add a `MIRROR.md` next to your film's sources to give it your brand, scene ids, commands
and stricter gates (template in `references/template-model.md`). Each correction you
make is logged and hardened into the skill so it is not repeated.

## Fair use

Mirror the grammar (timing, structure, transitions), never the property: the
reference's logo, copy, music, footage and assets are not reused, and the reference
file is never committed. Disclose AI honestly and credit every music and SFX file.

Sharing: the side-by-side proof carries the reference's picture and sound, so it stays
private (never in Git, a README or a public post). Publish our own cut with our own score.
Check the repository's visibility, the reference's licence and each platform's AI
disclosure first (standing order 10).

