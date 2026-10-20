import sys
rom=bytearray(open('powerstrike.sms','rb').read())

def rle_dec(o,limit=20000):
    out=bytearray()
    while True:
        c=rom[o]; o+=1
        if c==0: break
        if c<0x80: out+=rom[o:o+c]; o+=c
        else:
            n=c&0x7f; v=rom[o]; o+=1; out+=bytes([v])*n
        if len(out)>limit: break
    return bytes(out),o

def rle_enc(data):
    # greedy: find runs>=3 -> repeat token; else literal run up to 127
    out=bytearray(); n=len(data); i=0
    lit=bytearray()
    def flush():
        nonlocal lit
        while lit:
            chunk=lit[:127]; del lit[:127]
            out.append(len(chunk)); out.extend(chunk)
    while i<n:
        # run length
        j=i
        while j<n and data[j]==data[i]: j+=1
        run=j-i
        if run>=3:
            flush()
            while run>0:
                c=min(run,127); out.append(0x80|c); out.append(data[i]); run-=c
            i=j
        else:
            lit.append(data[i]); i+=1
    flush()
    out.append(0)  # terminator
    return bytes(out)

SRC=0x10010
sheet,END=rle_dec(SRC)
print('orig sheet bytes',len(sheet),'compressed',END-SRC)

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

def transform(sheet):
    out=bytearray()
    NT=len(sheet)//32
    for t in range(NT):
        p=px(sheet[t*32:t*32+32])
        np=[[0]*8 for _ in range(8)]
        for r in range(8):
            for c in range(8):
                i=p[r][c]
                if i==0: np[r][c]=0
                else:
                    # posterize: dark half vs bright half -> two material indices
                    np[r][c]=10 if i<=7 else 15
        out+=enc_tile(np)
    return bytes(out)

if __name__=='__main__':
    ns=transform(sheet)
    comp=rle_enc(ns)
    print('new sheet bytes',len(ns),'new compressed',len(comp),'budget',END-SRC)
    print('FITS' if len(comp)<=END-SRC else 'TOO BIG')
    # write patched rom if fits
    if len(comp)<=END-SRC:
        patched=bytearray(rom)
        patched[SRC:SRC+len(comp)]=comp
        patched[SRC+len(comp):SRC+ (END-SRC)]=bytes(END-SRC-len(comp))  # zero pad remainder? NO - must keep stream terminator; padding after terminator is fine
        open('powerstrike_reskin.sms','wb').write(patched)
        print('wrote powerstrike_reskin.sms')
