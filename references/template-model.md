# Template model

A mirrored film becomes a template once its identity is data. Choreography is fixed;
identity is swapped.

## Layers

| Layer | Holds | Changes per brand? |
|---|---|---|
| Timeline | `fps`, `bpm`, `marks`, `events`, tail overlaps per boundary | no |
| Choreography | scene components, easings, camera rails, springs, décor layers | no |
| Score grammar | event kind to cue (hit, blip, riser, duck), lead frames, arc | no |
| Score parameters | seed, key, levels, optional licensed track re-timed to the events | yes |
| Brand tokens | colours (ground, text, one accent, highlights), radius, glow | yes |
| Logo | official files of the brand, never redrawn, never a legacy mark | yes |
| Fonts | display, sans, mono, bundled locally with their licence | yes |
| Copy | one file per locale, every string in every locale, length limits per slot | yes |
| App slots | real captures (frame-exact, seeked per frame, supersampled) or UI drawn from the app's own components | yes |
| Facts | every number or claim on screen points to a cited fact | yes |

## Rules

- Tokens are derived from the brand's own code or design file, never typed as hex in a
  scene. An unknown brand id is an error, never a fallback to another brand.
- Copy slots carry a maximum length measured on the widest locale; a string that
  overflows is rewritten, not shrunk.
- A slot that expects a capture refuses an invented UI or another vendor's chrome.
- Formats are separate layouts on the same timeline (tall, wide, square, 4:5), each with
  its own safe area; never a crop of the master.
- A re-skin passes gates B, A, E, X; it passes T, S, M, D, C again only if a slot
  changed duration or motion.
- A re-skin that needs choreography edits is a new template: clone and gate again.

## Adding a brand or app

1. Add its identity data (tokens, logo files, fonts, copy per locale, facts, captures).
2. Render every scene preview with the new identity; read the pair board against the
   first brand's locked scenes (same choreography, new identity).
3. Run the gates, then assemble each requested format and locale.

## Instance file (`MIRROR.md`) template

Put it next to the film's sources in the adopting repository:

```markdown
# <Film name>: mirror instance

- Reference: <title>, stored at <local path outside the repo>, studied for timing only
- Brand: colours <tokens>, logo <file>, fonts <families and weights>, audience <one line>
- Shot map: <table or link to the validated map>
- Scenes: <ids and frame ranges>, events table <path>
- Commands: <board, scene preview, lock, assemble, score, tests>
- Extra gates: <stricter numbers, banned words, shipped-claims list>
- Retro log: | Mistake the owner caught | Rule now |
```
