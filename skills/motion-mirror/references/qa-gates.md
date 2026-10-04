# QA gates

All gates pass before a scene is shown. Numbers are minimums; an instance `MIRROR.md`
may raise them.

| Gate | Check | Pass when |
|---|---|---|
| T timing | REF/OURS pair board, one pair every 0.25 s; boundaries at 0.05 s | every reference beat has its twin within ±0.1 s (±6 frames at 60 fps); marks sit on the reference timecodes; do not trigger the post-hook section early |
| S sound | onset lists of both (recipe 5); band energy per 0.25 s and a spectrogram pair of both (recipe 5b); the reference's key and chord per half second; sync test on the events table | each reference onset has ours within 0.15 s; no extra hit where the reference is calm; every band within 8 dB of the reference at every 0.25 s; a bed stops where the reference's bed stops (a scene never replays the previous scene's bed); silences of the reference (gaps before a hit) are cloned; each major event has its peak spectral flux in [t-45 ms, t+25 ms] at or above the 95th percentile of the flux over ±1.2 s around it; hit cues lead the picture by at most 2 frames; music ducks 60 to 90 ms under each cue; the bed never goes empty where the reference has rhythm |
| M motion density | recipe 4 on the same range of both | our mean frame change ≥ 85 % of the reference mean; our still frames (YAVG < 0.05) ≤ reference still frames × 1.2; moving frames (YAVG > 0.25) comparable; per-frame grain and transition energy count |
| D décor | gamma-lifted full-size pairs (recipe 3) at 3 or more instants per scene; a fine pair board (0.1 s) over each hold | every inventoried element is present, each effect (sweep, glint, sparkle, flash) appears as many times as in the reference and on its timecodes: ground and gradient, grids, giant numerals and outlines, rules and ticks, playheads, brackets, labels and lit words, rings, glows, grain, vignettes, lines |
| C continuity | stills at -12, -6, 0, +6, +12 frames around every boundary | no hard cut, no pop, no black flash; the outgoing scene keeps rendering under the incoming one (tail overlap) through a shared element |
| H hook and pacing | first frame, event gaps | text or subject readable on frame 0 with no fade-in; a meaningful visual change every 2 to 4 s; no end card holding seconds without information or motion |
| B brand and copy | copy files per locale | current logo, brand colours and fonts, no em or en dash, shipped capabilities only, numbers from cited facts, each idea said once, every locale complete |
| L loudness | integrated loudness and peak of the master (recipe 7) | integrated about -14 LUFS (window -15 to -14 for a procedural master), sample peak at or below -4.45 dBFS before AAC (about -1.5 dBTP after) |
| A safe areas | overlay the safe box per canvas shape | tall (ratio < 0.87): 13 % top, 30 % bottom, 7 % sides; wide (ratio > 1.15): 10 %, 12 %, 8 %; square: 10 %, 10 %, 9 %; formats recomposed per canvas, never letterboxed or cropped from a master |
| E export | ffprobe (recipe 6) | H.264, yuv420p, bt709 primaries, transfer and matrix tagged in the bitstream at the final stitch, AAC (192k for catalogue renders, up to 256k 48 kHz for a master), `+faststart`; catalogue lock CRF 18 x264 slow; a delivered master may use CRF 14 with `-tune grain` and a web copy CRF 21 under 30 MiB; never yuv444 or a trailing moov atom |
| X disclosure | container tags, captions | no synthetic voice: IPTC DigitalSourceType `algorithmicMedia`, no AI badge on a scripted render; synthetic voice: `compositeWithTrainedAlgorithmicMedia`, a spoken disclosure at the start, the same line first in captions, the platform's AI toggle on; a comment tag is not a C2PA manifest and is never presented as one; credit the author and licence of every music and SFX file |

QC is evidence (boards, numbers, contact sheets), never a second verdict system: the
owner validates.
