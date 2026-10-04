# Mirror pipeline

## 1. Ingest

- Keep the reference outside the repository (a local folder the repo ignores). Note
  where it came from and under which terms you may study it.
- Probe it: `ffprobe -v error -show_entries stream=codec_name,width,height,r_frame_rate,sample_rate:format=duration -of compact <ref>`.
- Pick the project fps from the reference (60 fps reference, 60 fps film); if the film
  uses a musical grid, derive frames per beat from it (60 fps at 120 BPM = 30 frames).

## 2. Shot map

- Board the whole reference at 0.25 s (recipe 1), then board every transition at
  0.05 to 0.1 s. Read onsets for the same ranges (recipe 5).
- One row per shot: `in`, `out`, picture, what it turns into at the hand-over, transition
  type (shape match, zoom through, flash, wipe, whip), sound (hit, riser, silence).
- Number the shots. The owner validates the map before any code.

## 3. Inventory per shot

- Décor: ground and gradient, grids and dot grids, giant numerals and outlines, rules
  and ticks, playheads, corner brackets, labels and their lit word, rings, glows, grain,
  vignettes, lines, particles.
- Motion: what moves, path, easing, duration, overshoot, camera drift, per-frame grain.
- Sound: every onset, its character, its level relative to the bed, calm passages.
- Read décor on gamma-lifted full-size pairs (recipe 3), never on small tiles.

## 4. Events table

- One JSON file shared by picture and sound: `fps`, optional `bpm`, `marks` (scene
  starts, in frames) and `events` (frames on which the picture does something).
- Scenes land their animation on events; the score places its cues on the same frames.
- A test fails when a major event has no audible onset (gate S).

## 5. Clone one scene

- Edit that scene's file only (one owner per file when several agents work).
- Preview the scene alone, half size, with its own sound and 12 frames of margin on each
  side to judge the hand-overs. About one minute, never a whole-film render. A first look
  may use a third of the size. A change to the score alone is re-muxed into the existing
  previews (seconds), never re-rendered.
- Iterate on boards and numbers until gates T, S, M, D and C pass.

## 6. Prove parity and show

Send the proof bundle, built from what is already rendered in under a minute:

- the side-by-side video, reference on top, ours under it, same range from 0 to the end
  of the current scene, a timecode on the frame, twice (our sound, the reference's sound);
- the cut so far (the scene previews joined, margins trimmed);
- the REF/OURS pair board and the décor pairs of the scene;
- the spectrogram pair and the sound report (onsets, levels, bands);
- motion numbers for both, a table `shot | reference | ours | gap | fixed?`, and what was
  not verified (motion seen on stills only, sound measured but not heard, a format not
  rendered).

## 7. Lock

Record a hash of the scene's sources (and of the previous scene's, since its tail
overlaps). The assembly refuses a locked scene whose hash changed; unlocking needs a new
validation.

## 8. Assemble

Render each scene at full size, cache by source hash, concatenate without re-encoding,
mux the full score once. Render picture silent and mux the audio separately so the AAC
priming delay never shifts hits. If only the sound changed, re-mux; do not re-render.

## 9. Templatize and decline

See `template-model.md`. Other locales and formats start only after the first locale is
validated and locked. Each format is re-blocked for its canvas; each locale re-passes
gates T and S (longer words change timing).

## Process rules

- Storyboard first: time, picture, copy, sound, hand-over in and out, validated before code.
- An agent's report is a claim to verify with stills and numbers, not a result.
- No review panels or QC rounds nobody asked for; correct scene by scene with the owner.
- Check CPU load and kill obsolete background renders before a render; leave no waiter.
- Deliver a small web copy (under 30 MiB) as soon as a scene or film is ready; do not
  make the owner wait for a format or locale they did not ask for yet.
- Determinism: a frame depends only on time, props and assets; randomness is seeded.
- Paid providers (voice, music, generation) only with the owner's go and a spend cap.

## Other formats (9:16, 1:1, 4:5)

A format starts after the first one is locked, and is built as a re-block of the same
frames, never a crop:

- **Windows.** Show the master stage through one to three windows (source rectangle,
  scaled to the canvas width, destination y), animated between keyframes: a hard cut where
  the picture cuts, a glide on the shot's own transition. One window for a single subject
  (hook, chat, reveal, each kinetic beat framed on its own); stacked windows for wide
  shots (columns, a counter over its object, lines over a globe), with "text" and
  "visual" modes so nothing shows twice.
- **No black.** Behind the windows a blurred, dimmed cover of the stage fills the canvas;
  grounds of full-bleed scenes extend past the stage; window edges fade on all four sides;
  a vignette or frame rail made for the wide stage is dropped.
- **Redraw where the content is wide.** A chat or table is redrawn in portrait proportions
  (width and height scaled, text wrapped) instead of shrunk to a strip.
- **Fit, centre, then check.** Words are fitted to the window with the safe-area margins
  of gate A; a giant crop is allowed only where the reference crops on purpose.
- **Sound and events.** The score and the events table are the master's, frame for frame;
  the format never gets its own timing.
- **Watch it.** Render stills at every cut and glide, then a contact sheet of the whole
  decline (one frame every 0.5 s) and read it for black voids, cut words, hard edges,
  duplicated text and tiny content, before delivering.
