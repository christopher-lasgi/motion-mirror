---
name: motion-mirror
description: Clones a reference motion-design video end to end (shot timing, choreography, décor, transitions, sound placement), proves the clone with measured gates, locks it scene by scene, then turns it into a template any brand can re-skin and decline in 16:9, 9:16, 1:1 and 4:5. Use when making or fixing a teaser, launch film, trailer, reel or short, when mirroring a reference video, building a video template, re-skinning a film for another brand, or cutting a vertical or localized version. If the repository has a MIRROR.md instance file, read it first.
license: MIT
compatibility: Requires ffmpeg 6 or later (with drawtext) and Node 20 or later. A deterministic renderer such as Remotion 4 is recommended.
metadata:
  author: Christopher Lasgi
  version: "1.0.0"
---

# Motion mirror: clone a reference end to end, then template it

One skill for every motion film made from a reference. Read section 0 before any film
task, work one scene at a time, and log every correction (section 5) in the same commit
as the rule it hardens.

**Instance file first.** If the repository contains a `MIRROR.md` (search the tree for
it), read it before anything else. It names the film, its brand identity, its scene
ids, its exact commands and its own retro log. Its rules add to this skill; where they
are stricter, they win.

| Read | When |
|---|---|
| Sections 0 to 5 | every film task |
| [references/pipeline.md](references/pipeline.md) | starting a mirror, shot map, inventory, workshop, lock, assembly |
| [references/qa-gates.md](references/qa-gates.md) | before showing anything, before delivering |
| [references/ffmpeg-recipes.md](references/ffmpeg-recipes.md) | side-by-side video, boards, pairs, décor check, motion density, onsets, sound layers, re-mux, probe, loudness |
| [references/template-model.md](references/template-model.md) | templating, re-skin for another app or brand, new locale or format |
| [references/retro-log.md](references/retro-log.md) | before showing a scene: the mistakes not to repeat |

## 0. Standing orders

1. **Clone first, identical, then add.** Timing, choreography, décor, transitions and
   sound placement come from the reference, beat for beat. Only the identity changes.
   Never invent your own choreography; improvements come after measured parity, never
   instead of it.
2. **Work from boards, never from memory.** Every claim about the reference ("it holds
   1.5 s", "the line becomes the ring") is read on a timecoded board or a décor pair.
3. **One scene at a time.** The next scene starts only after the current one is
   validated and locked. Never render the whole film to iterate.
4. **Every delivery is side by side with the reference.** Nothing is shown alone: the
   proof bundle is the reference on top and ours under it in one video, same range, a
   timecode on the frame, carrying the reference's sound (ours only on request); plus the
   cut so far, the pair board, décor pairs, a spectrogram pair, the sound report (onsets,
   levels, bands), motion numbers, a gap table and what was not verified. The owner
   annotates on that, never on our video alone. One file per delivery, and a validated
   scene is never delivered again: only what changed. The final film (our cut alone, in
   every format) is the one exception, sent once the owner asks for the finished version.
5. **Never change a validated element** (a locked scene, an approved end card or CTA)
   without asking first.
6. **The owner never repeats a remark.** Each correction becomes a retro line and a
   hardened rule, gate or test in the same commit.
7. **Brand truth.** The target brand's current logo (never a legacy mark), its colours
   and fonts, no em or en dash on screen, shipped capabilities only, every number from
   a cited fact, copy aimed at the brand's audience.
8. **Clone the grammar, never the property.** Choreography, timing and structure are
   mirrored; the reference brand's logo, copy, music, footage, characters and assets
   are never reused. The reference file is never committed.
9. **The fastest render that answers the question.** Render only the scene that changed,
   at preview size, with its margins; a sound-only change re-muxes the new score into
   the existing previews (seconds, no frame rendered); the proof bundle is rebuilt from
   what is already rendered (under a minute); a draft size is allowed for a first look.
   Never render the whole film, never re-render a picture for a sound change, never make
   the owner wait on a render to see a change. Full-size renders are for the validated
   master only.
10. **The side-by-side is a private proof, never a publication.** It carries the
    reference's picture and sound. It never goes in Git, a README, a release or a public
    post, and the reference's audio is never put in our film. What is shared publicly is
    our own cut with our own score. Before any public share, check three things and say
    so: the repository's visibility (a branch of a private repository is private;
    making the repository public publishes every branch and its history), the
    reference's licence, and each platform's AI disclosure. Whether to post a comparison
    anyway is the owner's decision, taken with that risk written down; it is not legal
    advice.
11. **A brand kit wins.** When the owner provides one, use its files and rules as given:
    the supplied path or file for the mark (never redrawn by hand, never a legacy mark),
    its flat colour, no shadow, outline, glow or gradient on the mark, its protection
    zone, no mark on a ground of its own colour. Check the mark on a still at 100 % in
    every format before delivering.
12. **A format is a re-block, watched end to end.** A vertical or square cut is never a
    crop and never a scaled copy with black bands: see "Other formats" in
    [references/pipeline.md](references/pipeline.md). Sound and effects follow the
    picture's events in every format; a decline is checked on a contact sheet (one frame
    every 0.5 s) before it is shown.
13. **A hero object is never still.** A globe, sphere or ring that only rotates reads as
    frozen when its surface is uniform. Give it surface features (land masses, labels,
    tiles), a travelling light or scan, a slow breath of scale, a rocking tilt and a
    push-in, and measure its motion energy against the reference's.
14. **Nothing lives only in the container.** Renders are ephemeral. Every validated final
    (our cut only, never the pair) is pushed to the film's `Assets` branch with a manifest
    (commit, locale, format, duration, size), and the instance's hand-off file says how
    to resume and how to start a new film.

## Before you start

Ask for, or confirm, these inputs once:

- The reference video path (kept outside the repository) and where it comes from.
- The target brand's identity data: logo files, colour tokens, fonts, copy per locale.
- The formats and locales wanted, and the renderer already in use.

Copy this checklist and tick it as you go:

```
Mirror progress
- [ ] Reference ingested and probed (outside the repo)
- [ ] Shot map validated by the owner
- [ ] Inventory per shot (décor, motion, sound)
- [ ] Events table shared by picture and sound
- [ ] Scene cloned, gates T S M D C passed, proof bundle shown
- [ ] Scene validated and locked (repeat per scene)
- [ ] Assembly, gates L E X passed
- [ ] Declines (formats, locales) re-blocked and watched
```

## Working with the model

The skill removes repeated explanations and makes results checkable; it does not replace a capable model. Use the strongest model available, with extended reasoning for the shot map, the sound analysis and the gap table. Cheap steps (a re-mux, a board, a probe) need no extra reasoning. Judge every claim by its board or its number, never by the model's own report.

## 1. Pipeline at a glance

| Step | Output | Gate |
|---|---|---|
| 1 Ingest | reference stored outside the repo, source and licence noted, probed | fps, size, duration, audio known |
| 2 Shot map | one row per shot: in, out, picture, transition in and out, sound | every cut and hard onset timecoded; owner validates |
| 3 Inventory | per shot: décor list, motion list, sound list | décor checklist covered |
| 4 Events table | marks (scene starts) and events (frames where the picture acts), shared by picture and sound | every meaningful reference onset is an event |
| 5 Clone one scene | that scene only, previewed in about a minute with margins | gates T, S, M, D, C |
| 6 Prove parity | pair board, décor pairs, numbers, gap table | owner validates |
| 7 Lock | scene hash recorded; assembly refuses a changed locked scene | |
| 8 Assemble | master and web copy, only changed scenes re-rendered | gates L, E, X |
| 9 Templatize | identity split from choreography | a second brand renders with zero choreography edits |
| 10 Declines | other formats and locales, each re-blocked | gate A per format, T and S per locale |

Detail and process rules: [references/pipeline.md](references/pipeline.md).

## 2. Template model

Two layers that never mix. **Choreography** (shot map, marks, events, overlaps, easings,
camera moves, score cue grammar) is the template and stays fixed. **Identity** is data:
brand tokens, logo files, fonts, copy per locale, app slots (real captures or UI drawn
from the app's own components), facts, score parameters. A re-skin changes identity
data only; a re-skin that needs choreography edits is a new template, cloned and gated
again. Detail: [references/template-model.md](references/template-model.md).

## 3. Tools

Everything a mirror needs is ffmpeg, ffprobe, Node and a deterministic renderer
(Remotion or equivalent): recipes in [references/ffmpeg-recipes.md](references/ffmpeg-recipes.md).
A repository may wrap them in scripts (board, scene workshop with lock and cached
assembly, sync check, procedural score); its `MIRROR.md` lists the exact commands.

## 4. QA gates (summary; numbers in [references/qa-gates.md](references/qa-gates.md))

| Gate | Pass when |
|---|---|
| T timing | every reference beat has its twin within ±0.1 s; marks sit on the reference timecodes |
| S sound | each reference onset has ours within 0.15 s, no extra hit where the reference is calm; every major event audible |
| M motion density | our mean frame change ≥ 85 % of the reference, still frames ≤ reference × 1.2 |
| D décor | every inventoried element present on gamma-lifted pairs (never contrast) |
| C continuity | no hard cut, pop or black flash at -12, -6, 0, +6, +12 frames around each boundary |
| B brand and copy | standing order 7 holds in every locale |
| L loudness | about -14 LUFS integrated, true peak headroom kept |
| A safe areas | tall 13/30/7 %, wide 10/12/8 %, square 10/10/9 % (top/bottom/sides); formats recomposed, never cropped |
| E export | H.264 yuv420p, bt709 tags, AAC, faststart, verified with ffprobe |
| X disclosure | AI disclosure honest, no faked C2PA, music and SFX credited |

QC produces evidence, not a verdict: the owner validates.

## 5. Self-correction loop

1. The owner corrects something: restate the mistake in one line.
2. Add a row to the retro log: the generic lesson in [references/retro-log.md](references/retro-log.md),
   the film-specific one in the instance `MIRROR.md`.
3. Harden the rule where it belongs: standing order, pipeline rule, gate number, recipe.
4. If a script or test can hold it, add it in the same commit; otherwise the row says why.
5. Same class of mistake twice: the gate was too weak; raise it instead of adding a row.

## 6. Interop

This skill owns the film's form. A brand's facts, voice and publishing rules stay in that
brand's own content skill; render-lock numbers and disclosure sentences live in one
source file per repository, never forked. A repository adopts the skill by copying this
folder unchanged and adding its own `MIRROR.md` (template in
[references/template-model.md](references/template-model.md)).
