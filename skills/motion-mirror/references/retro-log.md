# Retro log (generic lessons, newest last)

Every line is a correction an owner had to make on a real film. Film-specific lines live
in that film's `MIRROR.md`.

| Mistake the owner caught | Rule now |
|---|---|
| A legacy wordmark was used instead of the current logo | Standing order 7; gate B |
| Several chapters repeated the same idea | One idea per scene, said once; gate B |
| SFX were inaudible and the music did not follow the picture | One events table shared by picture and sound, a sync test, ducking, a bed that never empties; gate S |
| A frame froze mid-film and a passage had no rhythm | No element or sound sits still; gates M and C |
| An approved end card was replaced without asking, and the old one was better | Standing order 5: validated elements are locked |
| Scenes ended in hard cuts | Shape match cuts and tail overlaps checked at ±12 frames; gate C |
| We worked from memory and whole-film stills, so opening length, dwell time and the calm before a flash went unseen | Standing order 2: timecoded boards, side by side, every scene |
| We invented our own choreography instead of copying the reference | Standing order 1: identical first, then add |
| Background lines, corner brackets, a ruler and its playhead, a lit caption word were missing | Décor inventory on full-size pairs before showing; gate D |
| The owner repeated the same kind of remark | Standing order 6 and section 5: a retro line plus a hardened rule or check in the same commit |
| Whole-film renders (20 to 35 min) to judge one scene | Scene previews of about one minute and a cached assembly |
| The film never said what the product is | A plain definition sentence and a capabilities beat; gate B |
| The décor check used `eq=contrast`, which crushed dark grounds: a giant outline numeral, a dot grid and a gradient ground were missed | Décor pairs use `eq=gamma=1.8`, never contrast; the inventory lists grounds, grids, giant numerals; recipe 3 |
| Our scene had far less motion than the reference ("they have many more images per second") | Motion density measured against the reference: mean ≥ 85 %, still frames ≤ 1.2 ×; grain per frame and transition energy count; gate M |
| The section after the hook started too early | Marks sit on the reference timecodes, read on the pair board; gate T |
| Work moved to the next scene before the current one was validated | Standing order 3 |
| A scene was shown without a side-by-side board | Standing order 4: no preview without its proof bundle |
| Two overlapping skills covered one job | One generic skill plus one instance file per film |
| The opening bed ran on into the next scene and the owner heard "the start replaying" at 4 s; levels matched but the layers did not | Sound is cloned layer by layer: band energy per 0.25 s and a spectrogram pair (recipe 5b), the reference's key and chords measured, each scene's bed starts and stops where the reference's does; gate S |
| Renders took minutes for a change that only touched the sound, and deliveries showed our video alone, so the owner repeated the same remarks | Standing orders 4 and 9: every delivery is the side-by-side video (both soundtracks) plus the proof bundle, built in under a minute from existing previews; a sound change is re-muxed, never re-rendered |
| A decorative effect (a light sweep over the logo) played three times where the reference plays it once | Count every effect of the reference per shot (sweeps, glints, sparkles, flashes) in the inventory and clone the count and the timecodes; never multiply an effect to fill a hold; gate D |
| The vertical cut was a camera zoom on the wide stage: cropped words, black bands | A format is a re-block through animated windows with an ambient cover; standing order 12 and "Other formats" |
| The vertical chat was a tiny strip, the reveal logo touched the edge, headline words were cut at the frame edge, a hard stage edge showed as a square flash | Redraw wide content in portrait, fit every word to its window, fade window edges, drop wide-stage vignettes; contact sheet and stills at every cut before delivering |
| The same text showed twice in stacked windows | "text" and "visual" modes per window |
| The end logo was off the brand (wrong blue, extrusion, glow, clipped by a rectangle) | Standing order 11: the brand kit's path and flat colour, nothing added, checked at 100 % |
| The two globes read as frozen next to the reference | Standing order 13: surface features, travelling light or scan, breath, tilt, push-in |
| The owner asked whether the branch and the side-by-side could be shared publicly; the repository was private and the pair carries the reference's picture and sound | Standing order 10: the pair is a private proof; check visibility, licence and disclosure before any public share |

