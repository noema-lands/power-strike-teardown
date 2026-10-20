import sys
rom=bytearray(open('desert5.sms','rb').read())
def rle_dec(o,limit=60000):
    out=bytearray()
    while True:
        c=rom[o]; o+=1
        if c==0: break
        if c<0x80: out+=rom[o:o+c]; o+=c
        else:
            n=c&0x7f; v=rom[o]; o+=1; out+=bytes([v])*n
        if len(out)>limit: break
    return bytes(out),o
SRC=0x10010
sheet,END=rle_dec(SRC)
print('sheet bytes',len(sheet),'tiles',len(sheet)//32,'comp',END-SRC)
# render sheet as 16-wide montage, palette grayscale index
from PIL import Image
NT=len(sheet)//32
W=16
H=(NT+W-1)//W
SC=4
img=Image.new('RGB',(W*8*SC,H*8*SC),(20,20,20))
# palette approximation for 0..15
pal=[(0,0,0),(20,20,40),(40,40,90),(70,70,140),(110,110,180),(150,150,200),(200,200,220),(255,255,255),
     (40,20,10),(90,50,20),(150,90,40),(200,140,70),(240,200,120),(255,240,180),(40,40,40),(120,120,120)]
for t in range(NT):
    b=sheet[t*32:t*32+32]
    px=[[0]*8 for _ in range(8)]
    for pl in range(4):
        for r in range(8):
            for c in range(8):
                if (b[pl*8+r]>>(7-c))&1: px[r][c]|=1<<pl
    for r in range(8):
        for c in range(8):
            col=pal[px[r][c]]
            for dy in range(SC):
                for dx in range(SC):
                    X=(t%W)*8*SC+c*SC+dx; Y=(t//W)*8*SC+r*SC+dy
                    img.putpixel((X,Y),col)
img.save('sheet_montage.png')
print('wrote sheet_montage.png', img.size)
