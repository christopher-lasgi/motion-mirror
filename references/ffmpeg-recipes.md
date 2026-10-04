# ffmpeg recipes

Self-contained snippets (ffmpeg 6 or later). `REF` is the reference, `OURS` our scene
preview, `A`/`B` a range in seconds. Fonts: any monospace TTF for `drawtext`.

## 1. Timecoded board (one image every 0.25 s)

```bash
FONT=/usr/share/fonts/truetype/dejavu/DejaVuSansMono-Bold.ttf
ffmpeg -v error -y -ss $A -to $B -i "$REF" \
  -vf "fps=4,scale=480:-1,drawtext=fontfile=$FONT:text='%{pts\:hms}':x=8:y=8:fontsize=22:fontcolor=white:box=1:boxcolor=0x000000aa,tile=5x8" \
  -frames:v 1 ref-board.png
```

`fps=4` is one image per 0.25 s; size the tile grid to `(B-A)*4` images.

## 2. Side-by-side REF | OURS at the same timecodes

```bash
ffmpeg -v error -y -ss $A -to $B -i "$REF" -ss $OA -to $OB -i "$OURS" -filter_complex \
 "[0:v]fps=4,scale=480:-1,setpts=N/(4*TB),drawtext=fontfile=$FONT:text='REF %{pts\:hms}':x=8:y=8:fontsize=22:fontcolor=white:box=1:boxcolor=0x7c3aedcc,pad=iw+6:ih[a];\
  [1:v]fps=4,scale=480:-1,setpts=N/(4*TB),drawtext=fontfile=$FONT:text='OURS %{pts\:hms}':x=8:y=8:fontsize=22:fontcolor=white:box=1:boxcolor=0x2563ebcc[b];\
  [a][b]hstack=2,tile=2x8:padding=6" -frames:v 1 pair-board.png
```

`OA..OB` is the same duration as `A..B` in our file.

## 3. Décor check: full-size pairs, shadows lifted

```bash
T=1.5
ffmpeg -v error -y -ss $T -i "$REF" -ss $T -i "$OURS" -filter_complex \
 "[0:v]scale=960:-1,trim=end_frame=1[r];[1:v]scale=960:-1,trim=end_frame=1[o];[r][o]hstack,eq=gamma=1.8" \
 -frames:v 1 decor-$T.png
```

Use `eq=gamma=1.8`. Never `eq=contrast`: contrast crushes dark grounds to black and hides
outlines, dot grids and gradients. Do at least three instants per scene.

## 4. Motion density

```bash
density() { ffmpeg -v error -ss $2 -t $3 -i "$1" \
  -vf "scale=960:540,format=gray,tblend=all_mode=difference,signalstats,metadata=mode=print:key=lavfi.signalstats.YAVG:file=-" \
  -f null - | grep -o 'YAVG=[0-9.]*' | cut -d= -f2 | \
  awk '{s+=$1; n++; if($1>0.25)m++; if($1<0.05)z++} END{printf "mean %.2f moving %d/%d still %d\n", s/n, m, n, z}'; }
density "$REF" $A $(echo "$B-$A" | bc); density "$OURS" $OA $(echo "$B-$A" | bc)
```

Pass: ours mean ≥ 0.85 × reference mean, ours still ≤ 1.2 × reference still.

## 5. Audio onsets

Quick list with ffmpeg only: 10 ms RMS windows at 48 kHz, a rise of more than 6 dB, 0.12 s apart (good enough for hits):

```bash
ffmpeg -v error -ss $A -to $B -i "$REF" -vn -ac 1 -ar 48000 -af "highpass=f=80,lowpass=f=12000,asetnsamples=n=480,astats=metadata=1:reset=1,ametadata=print:key=lavfi.astats.Overall.RMS_level:file=-" -f null - \
 | awk -F'[ =:]' '/pts_time/{t=$NF} /RMS_level/{v=$NF; if(v!="-inf" && p!="" && v-p>6 && t-l>0.12){print t; l=t} p=v}'
```

For the gate, use spectral flux: log magnitude, 2048-sample window, 256 hop, 80 Hz to
12 kHz, positive differences summed; an onset is a local maximum above the 97th
percentile, at least 0.12 s after the previous one. Compare lists: each reference onset
needs ours within 0.15 s.

## 6. Probe the delivery

```bash
ffprobe -v error -select_streams v:0 -show_entries stream=codec_name,profile,pix_fmt,color_primaries,color_transfer,color_space,r_frame_rate,nb_frames -of compact "$OUT"
ffprobe -v error -show_entries format_tags -of compact "$OUT"
```

## 7. Loudness

```bash
ffmpeg -nostats -i "$OUT" -af ebur128=peak=true -f null - 2>&1 | tail -n 12
```

## 8. Silent render plus separate mux (no AAC priming shift)

```bash
ffmpeg -v error -y -i silent.mp4 -i score.wav -map 0:v -map 1:a \
  -c:v libx264 -preset slow -crf 18 -pix_fmt yuv420p -profile:v high \
  -color_primaries bt709 -color_trc bt709 -colorspace bt709 \
  -c:a aac -b:a 192k -ar 48000 -movflags +faststart -shortest master.mp4
```

## 9. Boundary stills (continuity)

```bash
for d in -12 -6 0 6 12; do f=$((MARK+d)); ffmpeg -v error -y -i "$OURS" -vf "select=eq(n\,$f)" -frames:v 1 cut-$MARK-$d.png; done
```

## 5b. Sound layers: spectrogram pair and band energy

Onsets alone miss a bed that runs on, a missing tone or a wrong key. Compare the layers.

```bash
# Spectrogram pair, same range, same scale (read: which bands sit where, which stop, where the silences are)
ffmpeg -t 15 -i ref.mov  -lavfi "showspectrumpic=s=1800x420:legend=1:scale=log:fscale=log:color=intensity:start=40:stop=16000" spec-ref.png
ffmpeg -t 15 -i ours.mp4 -lavfi "showspectrumpic=s=1800x420:legend=1:scale=log:fscale=log:color=intensity:start=40:stop=16000" spec-ours.png
ffmpeg -i spec-ref.png -i spec-ours.png -filter_complex vstack spec-pair.png
```

Then measure energy per band every 0.25 s for both (40-150, 150-300, 300-500, 500-1200,
1200-2500, 2500-6000, 6000-14000 Hz) and flag any band more than 8 dB away; measure the
reference's dominant notes per 0.25 s (Goertzel on the semitone grid) to read its key and its
chord changes, and write the score in that key.

## 2b. Side-by-side video, the delivery format

The reference on top, ours under it, one timecode, same range; render it twice, once
with each soundtrack, so the owner can watch, listen and annotate in one place.

```bash
T=15
ffmpeg -t $T -i ref.mov -i ours-cut.mp4 -filter_complex \
 "[0:v]scale=960:540,fps=60,drawtext=text='REFERENCE':x=16:y=12:fontsize=26:fontcolor=white:box=1:boxcolor=black@0.6[a];\
  [1:v]scale=960:540,drawtext=text='OURS':x=16:y=12:fontsize=26:fontcolor=white:box=1:boxcolor=black@0.6[b];\
  [a][b]vstack,drawtext=text='%{pts\:hms}':x=w-220:y=12:fontsize=26:fontcolor=white:box=1:boxcolor=black@0.6[v]" \
 -map "[v]" -map 1:a -t $T -c:v libx264 -crf 23 -preset veryfast -pix_fmt yuv420p -c:a aac pair-ours-sound.mp4
# same command with -map 0:a for pair-ref-sound.mp4
```

## 10. Re-mux a new score into existing previews (no frame rendered)

```bash
# the preview starts `margin` frames before its scene: seek the score to the same instant
ffmpeg -i scene.mp4 -ss <(sceneStart - margin) / fps> -t <preview duration> -i score.wav \
  -map 0:v -map 1:a -c:v copy -c:a aac -b:a 192k -shortest -movflags +faststart scene-new.mp4
```
