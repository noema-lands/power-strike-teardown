import sys, enc
rom=bytearray(open('powerstrike.sms','rb').read())
def rle_dec(o,limit=40000):
    out=bytearray()
    while True:
        c=rom[o]; o+=1
        if c==0: break
        if c<0x80: out+=rom[o:o+c]; o+=c
        else:
            n=c&0x7f; v=rom[o]; o+=1; out+=bytes([v])*n
        if len(out)>limit: break
    return bytes(out),o
def px(b):
    p=[[0]*8 for _ in range(8)]
    for pl in range(4):
        plb=b[pl*8:pl*8+8]
        for r in range(8):
            for c in range(8):
                if plb[r]>>(7-c)&1: p[r][c]|=1<<pl
    return p
def enc_tile(p):
    b=bytearray(32)
    for pl in range(4):
        for r in range(8):
            byte=0
            for c in range(8):
                if p[r][c]>>pl&1: byte|=1<<(7-c)
            b[pl*8+r]=byte
    return bytes(b)
def build(sheet, kind, arg=None):
    out=bytearray()
    for t in range(len(sheet)//32):
        p=px(sheet[t*32:t*32+32])
        if kind=='sil':
            np=[[ (0 if p[r][c]==0 else (arg or 10)) for c in range(8)] for r in range(8)]
        elif kind=='invert':
            np=[[ (15-p[r][c]) for c in range(8)] for r in range(8)]
        out+=enc_tile(np)
    return bytes(out)
src=int(sys.argv[1],0); kind=sys.argv[2]; outfile=sys.argv[3]
arg=int(sys.argv[4]) if len(sys.argv)>4 else None
sheet,END=rle_dec(src); budget=END-src
comp=build(sheet,kind,arg); comp=enc.rle_opt(comp)
print(f'src {src:05X} sheet {len(sheet)} budget {budget} new {len(comp)}', 'FITS' if len(comp)<=budget else f'OVER+{len(comp)-budget}')
assert len(comp)<=budget, 'does not fit'
p=bytearray(rom); p[src:src+len(comp)]=comp; p[src+len(comp):src+budget]=b'\x00'*(budget-len(comp))
open(outfile,'wb').write(p); print('wrote',outfile)
