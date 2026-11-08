#!/usr/bin/env python3
"""Cart RLE packer for Sega Master System / Game Gear ROM banks.

Format (per block, ctrl byte first):
  0x00-0x7F : literal run of (n+1) bytes follows
  0x80-0xFF : repeat run, next byte repeated (n & 0x7F) + 2 times... see note
We use: ctrl<0x80 -> literal len = ctrl+1 (1..128)
        ctrl>=0x80 -> repeat len = (ctrl & 0x7F) + 2 (2..129), followed by 1 byte
Decoder is ~20 bytes of Z80 per run class. Verifier ships with the tool so a
mismatch is detectable before anything touches a cartridge.
"""
import sys, struct

def pack(data):
    out = bytearray()
    i, n = 0, len(data)
    while i < n:
        # repeat run?
        j = i
        while j + 1 < n and data[j + 1] == data[i] and (j - i) < 128:
            j += 1
        runlen = j - i + 1
        if runlen >= 3:
            out.append(0x80 | (runlen - 2))
            out.append(data[i])
            i = j + 1
            continue
        # literal run
        start = i
        while i < n and (i - start) < 128:
            # stop if a repeat of >=3 starts here
            if i + 2 < n and data[i] == data[i+1] == data[i+2]:
                break
            i += 1
        out.append(i - start - 1)
        out += data[start:i]
    return bytes(out)

def unpack(packed, size=None):
    out = bytearray()
    i = 0
    while i < len(packed):
        c = packed[i]; i += 1
        if c < 0x80:
            ln = c + 1
            out += packed[i:i+ln]; i += ln
        else:
            ln = (c & 0x7F) + 2
            out += bytes([packed[i]]) * ln; i += 1
        if size is not None and len(out) > size:
            raise ValueError("overrun")
    return bytes(out)

def main():
    p = sys.argv[1]
    data = open(p, 'rb').read()
    out = pack(data)
    back = unpack(out, size=len(data))
    ok = back == data
    print(f"{p}: {len(data)} -> {len(out)} bytes ({len(out)/len(data):.3f}x) roundtrip={'OK' if ok else 'FAIL'}")

if __name__ == '__main__':
    main()
