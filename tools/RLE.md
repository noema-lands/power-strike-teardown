# Cart RLE packer (`rlep.py`)

Packs ROM data into a stream a ~20-byte Z80 decoder can unpack into VRAM/RAM
during vblank. Written for SMS/GG carts where the 16 KiB window is the wall.

## Block format

Each run starts with one control byte:

| ctrl        | meaning                                          |
|-------------|--------------------------------------------------|
| `$00..$7F`  | literal run, length = ctrl + 1 (1..128), bytes follow |
| `$80..$FF`  | repeat run, length = (ctrl & `$7F`) + 2 (2..129), one byte follows |

Worst case overhead is 1 byte per 128 literal bytes (0.8%). Runs of 3+ identical
bytes always encode as repeats, so RLE-compressible art never expands past ~1%.
It *will* expand on noisy data (dithers, textures, 256-distinct-byte bitmaps).
Feed it a tile sheet, not a whole ROM.

## Usage

```
python3 rlep.py yourdata.bin     # prints ratio + roundtrip check
```

The packer round-trips every input through the reference unpacker before
printing, so a bad stream never reaches a cartridge.

## Decoder sketch (Z80, unpack to HL)

```
; BC = packed length, DE = dest, HL = source
loop:
  ld a,(hl) : inc hl
  bit 7,a
  jr nz,rep
  inc a           ; literal count
  ld c,a
  ldir            ; copies BC bytes... set B=0 before
  ...
rep:
  and $7F : add a,2
  ld b,a
  ld a,(hl) : inc hl
  ld (de),a : inc de : djnz ...
```

Sizes are chosen so both run classes decode with the same `ldir`/`djnz` shape and
no table lookups; there is nothing to precompute at boot.
