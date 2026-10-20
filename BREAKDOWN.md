# Power Strike / Aleste (SMS) — real breakdown

ROM: Power-Strike-USA-Europe.sms · 131,072 bytes (1 Mbit) · md5 8d9f02dcfea8f9728a3665ca12b044d1
Header @ $7FF0: "TMR SEGA", product 09 51, region 4F, checksum $2229.
Everything below is from the binary itself (z80dasm + a script I wrote). Where I'm
inferring, I say so.

## 1. Cart layout

Each 16 KB bank from bank 2 up is stamped with Compile's own signature in ASCII:
`'ALESTE'  Bank 2` … `'ALESTE'  Bank 7` at the very first byte of the bank. That's
the developer signing the ROM, not Sega.

- Bank 0  — resident kernel, fixed at $0000. Boot, VDP init, IRQ vectors, mapper
            detect, decompressors. The vblank IRQ sits at $0038: it reads port $BF,
            tests bit 7, and jumps into the real vblank body at $0EF2. The frame
            counter it bumps is $C006, deep inside that body.
- Bank 1  — fixed at $4000 (holds the Sega header at $7FF0).
- Banks 2–7 — switched into slot $8000–$BFFF.
- Bank 7 — sound driver + music.
- Bank 3 — level/stage data.
- Banks 2, 4, 5, 6 — tile graphics.
- Bank switching: the boot writes the mapper registers at $FFFC–$FFFF; the code also
  probes port $3F / reads $DD (a Codemasters-style detect) and later writes a bank
  number straight to $FFFF before loading. (I did not fully resolve which mapper
  variant the retail cart actually ships; the header is the Sega standard.)

## 2. Sound  (bank 7, ROM $1C000)

This is the richest subsystem, and it's a proper hybrid engine.

- Entry jump table at $8010 (bank-relative): init, start, stop, and effect calls —
  `jp $8815 / $8847 / $8875 / $802B / $8AF0 / $8AF6 / $8AFA / $8AFE / $8B03`.
- Two chips driven together:
    * YM2413 FM  — register select on port $F0, data on port $F1, I/O on $F2.
    * SN76489 PSG — data on port $7F.
  So Power Strike uses the FM sound unit; the PSG handles the rest.
- 7 channels of state, a $26-byte block each, starting at RAM $0C132 (the block at
  $0C23C is the 8th/echo the code walks). Each block carries note, period, volume
  envelope, instrument, and per-channel flags.
- Two note/period lookup tables at $8926 and $89E6 (one for FM F-numbers, one for PSG
  dividers). FM instrument (patch) table at $8A58, 8 bytes per patch, written to FM
  registers 0–7.
- Music data: song pointer table at $8CF8. 15 songs.

The game ships an in-game SOUND TEST menu, and its own list is the cleanest track
index you'll get (ROM $2340 and on):

```
 0 EXIT
 1 ALESTE              8 EASYGOING
 2 THE CHALLENGER      9 RAPID TURNING
 3 TENSION OF DARK SIDE 10 STREET FIGHTER
 4 THE DEVASTATION     11 DOGODAGA-DOGODEGE
 5 THE SOLITUDE        12 GO AHEAD
 6 DON'T CRY HI-YAH    13 AGAIN
 7 BLOODY JEWEL        14 TRIUMPH
```

Credits from the STAFF screen ($278E): V.G.M. & S.E. — MYARMO / SHANT / SHIN-KUN;
SOUND PROGRAM — JEMINI. (These names survived in the ROM data, so they're readable
straight out of the binary.)

## 3. Levels  (bank 3)

Stage table at $1F6F in bank 0. Seven 8-byte entries (stages 0–6):

| stage | bank | level source | aux ptr A | aux ptr B |
|-------|------|--------------|-----------|-----------|
| 0 | 3 | $AC77 | $9908 | $8010 |
| 1 | 3 | $AE65 | $9908 | $8010 |
| 2 | 3 | $B0B0 | $9908 | $8010 |
| 3 | 3 | $B326 | $9908 | $8010 |
| 4 | 3 | $B5C8 | $9F87 | $8800 |
| 5 | 3 | $B87E | $A181 | $8C90 |
| 6 | 3 | $BA9D | $A6F2 | $93B0 |

Source addresses are slot-2 addresses; to get a ROM offset, ROM = bank*$4000 +
(addr − $8000). So stage 0's level source $AC77 is ROM $EC77.

The stage loader is at $0E35: it takes the current stage number from $C881, indexes
this table, writes the bank register, and returns the level pointer. Then $15E1 /
$1306 / $162A initialise the scroll state.

The level itself is built from segments. Aux ptr A ($9908 → ROM $D908 for stage 0) is a
directory of 3-byte entries: [pointer,$16][type,$8]. Stage 0 has six:

```
 ptr=$9A76 type=7     ptr=$9D52 type=4
 ptr=$9995 type=2     ptr=$9D92 type=5
 ptr=$9CFC type=4     ptr=$9ED1 type=1
 then $00 terminator
```

Each segment is RLE-compressed (format in §4) and decompresses to background tile
indices. Verified on stage 0: segment $9A76 → 2,234 bytes of a single repeated tile
(a flat fill, type 7 = fill), segment $9995 → 337 bytes of mixed tiles
(0x45/0x46/0x64–0x67). The types 1–7 look like segment roles (fill, gradient, column
strip, detail …); I did not reverse every type.

Aux ptr B ($8010 → ROM $C010) is uncompressed name-table material: raw 16-bit
tile+attribute words, e.g. `$0100 $0100 $0138 $0139 $013A $013B $0339 $0338 …`.

## 4. Graphics  (banks 2, 4, 5, 6)

SMS VRAM is split: $0000–$1FFF background patterns, $2000–$37FF sprite patterns. Tiles
are 32 bytes each, 4 bitplanes interleaved per row.

Loading is table-driven. Descriptor lists live at $1E52 in bank 0 (12 entries, one per
stage/screen). Each list is a run of 5-byte records terminated by $00:

```
   [bank] [vram dest lo hi] [source lo hi]
```

The loader ($1E33) sets the bank, then decompresses from the source to the VDP address
via port $BE. What each asset actually is, verified by decompressing it:

| list used by | loads |
|--------------|-------|
| stages 0–3 | bank5 → VRAM $2000, 40 tiles (sprites); bank4 → VRAM $0000, 64 tiles (background) |
| stage 4 | same, + bank5 → $2600, 25 extra tiles |
| stage 5 | same, + bank5 → $2C80, 22 extra tiles |
| stage 6 | bank5 → $2000, 41 tiles; bank4 → $0000, 64 tiles; bank4 → $1C00, 3 tiles |
| late stages | bank2 / bank6 tile sets (e.g. bank6 → 34/46/41 tiles, bank2 → 24 tiles at $2000) |
| title/ending screens | additional lists at $1EA7 … $1ECD |

So: **bank 4 = background tile sheet, bank 5 = sprite tile sheet** (per-stage variants
tacked on), **banks 2 and 6 = extra sheets for the later levels**. Roughly 40–64 tiles
per sheet, which is small and clean — the art is hand-drawn 8×8, not photographic.

The RLE format used everywhere in this ROM (I implemented it and it round-trips):

```
  [n]            n in 1..127  -> copy next n bytes literally
  [0x80 | n] [v] n in 1..127  -> repeat byte v, n times
  [0x00]         end of stream
```

There are stride-1, stride-2 and stride-4 variants (the stride-4 one handles the
4-plane interleave) plus a direct-to-VDP version that writes port $BE. The VDP address
is set by the small routine at $01C9 (writes E then D|$40 to port $BF).

## 5. What's solid vs inferred

SOLID (read from bytes / command output): the ROM header; the per-bank signature; the
$0038 vblank path and $C006 frame counter; the sound engine ports, channel block,
song table and the full SOUND TEST track list; the stage table and the segment
directory; the tile descriptor lists and their decompressed tile counts; the RLE
format.

INFERRED (structure clear, details not fully reversed): the exact mapper variant; the
meaning of each level-segment type; the exact FM-vs-PSG channel assignment; whether
the 5-byte render lists are per-stage or per-screen (some are clearly for the title/
ending, e.g. the list loaded with index 8 at $1FD2).
