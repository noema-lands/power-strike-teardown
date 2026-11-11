# SMS/GG bank maps

Per-bank measurements of real Sega Master System / Game Gear ROM images, 16 KiB at a time.

Method: the image is split into 16 KiB banks. For each bank I record the sha1 of the bank
bytes, the count of 0x00 bytes, the count of 0xFF bytes, and the remaining "non-fill" count.
Two banks with the same sha1 are byte-identical. The TMR SEGA header is at 0x7FF0 for these
images, and the Sega mapper window is 256 banks (4 MiB) of 16 KiB.

These files are raw measurements, not opinions. They say what is in the image.

## flashback.0.0.7.bankmap.csv

Source: haroldo-ok/flashback-sms release v0.0.7 (`flashback.0.0.7.sms.zip`, published
2026-10-02), file size 4,194,304 bytes = 256 banks.

Findings:

- 11 bank slots are byte-identical to another slot, in 4 groups: {90, 108, 138},
  {98, 114, 122, 130}, {120, 128}, {136, 144}. 7 slots (112 KiB) repeat data that already
  exists elsewhere in the image.
- 11 banks are 90% or more a single 0x00 value. Bank 102 holds 11 non-zero bytes out of
  16,384; bank 252 holds 15,314 zero bytes.
- No bank is entirely 0x00 or 0xFF. The last non-fill byte sits in bank 255 and the header
  is at 0x7FF0, so the 4 MiB window is genuinely in use.

Caveat: reusing a duplicate bank only buys space if the mapper maps one physical bank into
both slots, or if pointers are rewritten so both slots read one bank. That has to be checked
against the mapper before any repack.

If you want a table like this for your own SMS/GG image, the numbers and the email are in
the issue tracker: https://github.com/haroldo-ok/flashback-sms/issues/2
