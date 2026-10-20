; z80dasm 1.1.6
; command line: z80dasm -a -l -g 0x8000 chunk_1c000.bin

	org	08000h

	daa			;8000
	ld b,c			;8001
	ld c,h			;8002
	ld b,l			;8003
	ld d,e			;8004
	ld d,h			;8005
	ld b,l			;8006
	daa			;8007
	jr nz,$+34		;8008
	ld b,d			;800a
	ld h,c			;800b
	ld l,(hl)			;800c
	ld l,e			;800d
	jr nz,l8047h		;800e
	jp l8815h		;8010
	jp l8847h		;8013
	jp l8875h		;8016
	jp l802bh		;8019
	jp 08af0h		;801c
	jp 08af6h		;801f
	jp 08afah		;8022
	jp 08afeh		;8025
	jp 08b03h		;8028
l802bh:
	ld hl,0c102h		;802b
	bit 0,(hl)		;802e
	res 0,(hl)		;8030
	jp z,l804eh		;8032
	push hl			;8035
	ld c,000h		;8036
	ld hl,08cdfh		;8038
	di			;803b
	call sub_8892h		;803c
	ld hl,0c13eh		;803f
	ld de,00026h		;8042
	ld b,008h		;8045
l8047h:
	set 1,(hl)		;8047
	add hl,de			;8049
	djnz l8047h		;804a
	ei			;804c
	pop hl			;804d
l804eh:
	call sub_8652h		;804e
	bit 1,(hl)		;8051
	jr nz,l805bh		;8053
	ld a,(0c23ch)		;8055
	and a			;8058
	jr z,l8063h		;8059
l805bh:
	ld b,001h		;805b
	ld ix,0c23ch		;805d
	jr l8069h		;8061
l8063h:
	ld b,007h		;8063
	ld ix,0c132h		;8065
l8069h:
	ld a,(ix+000h)		;8069
	and a			;806c
	jp z,l8109h		;806d
	ld d,a			;8070
	ld e,(ix+00bh)		;8071
	ld c,(ix+00ch)		;8074
	bit 0,e		;8077
	exx			;8079
	jr z,l8087h		;807a
	ld a,(ix+014h)		;807c
	add a,(ix+015h)		;807f
	ld (ix+015h),a		;8082
	jr nc,l80cah		;8085
l8087h:
	dec (ix+00fh)		;8087
	jr nz,l80cah		;808a
	ld a,(ix+005h)		;808c
	ld (ix+00fh),a		;808f
	exx			;8092
	bit 2,e		;8093
	exx			;8095
	jr z,l80beh		;8096
	ld a,(ix+01dh)		;8098
	and a			;809b
	jr z,l80beh		;809c
	jp m,l80aeh		;809e
	add a,(ix+00dh)		;80a1
	jr c,l80b7h		;80a4
	cp (ix+00eh)		;80a6
	jr c,l80beh		;80a9
	jp l80b7h		;80ab
l80aeh:
	and 07fh		;80ae
	cp (ix+00dh)		;80b0
	jr z,l80b7h		;80b3
	jr nc,l80beh		;80b5
l80b7h:
	exx			;80b7
	res 2,e		;80b8
	ld (ix+00bh),e		;80ba
	exx			;80bd
l80beh:
	inc (ix+00dh)		;80be
	ld a,(ix+00dh)		;80c1
	cp (ix+00eh)		;80c4
	call z,sub_82bfh		;80c7
l80cah:
	call sub_8590h		;80ca
	call sub_8601h		;80cd
	exx			;80d0
	bit 7,e		;80d1
	exx			;80d3
	call nz,sub_822bh		;80d4
	call sub_869ch		;80d7
l80dah:
	ld a,(0c102h)		;80da
	and 03fh		;80dd
	ld (0c102h),a		;80df
	exx			;80e2
	bit 5,e		;80e3
	jp z,l8106h		;80e5
	ld a,(ix+018h)		;80e8
	add a,(ix+019h)		;80eb
	ld (ix+019h),a		;80ee
	jr nc,l8106h		;80f1
	ld a,(ix+001h)		;80f3
	cp (ix+01ah)		;80f6
	jp nz,l8101h		;80f9
	set 1,e		;80fc
	jp l8106h		;80fe
l8101h:
	res 1,e		;8101
	dec (ix+001h)		;8103
l8106h:
	ld (ix+00bh),e		;8106
l8109h:
	ld de,00026h		;8109
	add ix,de		;810c
	dec b			;810e
	jp nz,l8069h		;810f
	ld a,(0c12dh)		;8112
	bit 7,a		;8115
	jp z,l81e2h		;8117
sub_811ah:
	ld bc,0c10eh		;811a
	ld de,0c117h		;811d
	ld hl,0c120h		;8120
	exx			;8123
	ld c,000h		;8124
	ld b,006h		;8126
	bit 6,a		;8128
	jr z,l812eh		;812a
	ld b,009h		;812c
l812eh:
	ld a,c			;812e
	or 030h		;812f
	exx			;8131
	out (0f0h),a		;8132
	ld a,(de)			;8134
	and a			;8135
	jp nz,l813eh		;8136
	ld a,00fh		;8139
	jp l813fh		;813b
l813eh:
	ld a,(hl)			;813e
l813fh:
	out (0f1h),a		;813f
	inc hl			;8141
	ld a,(de)			;8142
	inc de			;8143
	bit 6,a		;8144
	ex af,af'			;8146
	exx			;8147
	ld a,c			;8148
	or 020h		;8149
	call sub_822ah		;814b
	exx			;814e
	nop			;814f
	nop			;8150
	out (0f0h),a		;8151
	ex af,af'			;8153
	jr z,l8161h		;8154
	res 4,a		;8156
	out (0f1h),a		;8158
	set 4,a		;815a
	nop			;815c
	nop			;815d
	call sub_8226h		;815e
l8161h:
	out (0f1h),a		;8161
	and a			;8163
	jr nz,l816dh		;8164
	call sub_822ah		;8166
	inc bc			;8169
	jp l817fh		;816a
l816dh:
	exx			;816d
	ld a,c			;816e
	or 010h		;816f
	call sub_8228h		;8171
	exx			;8174
	nop			;8175
	out (0f0h),a		;8176
	ld a,(bc)			;8178
	inc bc			;8179
	out (0f1h),a		;817a
	call sub_8228h		;817c
l817fh:
	exx			;817f
	inc c			;8180
	dec b			;8181
	jp nz,l812eh		;8182
	ld a,00eh		;8185
	ld a,00eh		;8187
	out (0f0h),a		;8189
	ld a,(0c12ah)		;818b
	out (0f1h),a		;818e
	ld c,a			;8190
	ld a,(0c129h)		;8191
	cp c			;8194
	jr z,l81a0h		;8195
	call sub_8226h		;8197
	out (0f1h),a		;819a
	nop			;819c
	call sub_822ah		;819d
l81a0h:
	and a			;81a0
	jp z,l81b9h		;81a1
	push hl			;81a4
	pop hl			;81a5
	ld bc,00336h		;81a6
	ld hl,0c126h		;81a9
l81ach:
	ld a,c			;81ac
	out (0f0h),a		;81ad
	ld a,(hl)			;81af
	inc hl			;81b0
	out (0f1h),a		;81b1
	inc c			;81b3
	call sub_8226h		;81b4
	djnz l81ach		;81b7
l81b9h:
	ld hl,0c12bh		;81b9
	bit 7,(hl)		;81bc
	jr z,l81e1h		;81be
	res 7,(hl)		;81c0
	ld a,(hl)			;81c2
	ld l,a			;81c3
	ld h,000h		;81c4
	add hl,hl			;81c6
	add hl,hl			;81c7
	add hl,hl			;81c8
	ld bc,08a58h		;81c9
	add hl,bc			;81cc
	ld bc,00800h		;81cd
l81d0h:
	ld a,c			;81d0
	out (0f0h),a		;81d1
	inc c			;81d3
	ld a,(hl)			;81d4
	nop			;81d5
	out (0f1h),a		;81d6
	push hl			;81d8
	pop hl			;81d9
	push hl			;81da
	pop hl			;81db
	push hl			;81dc
	pop hl			;81dd
	inc hl			;81de
	djnz l81d0h		;81df
l81e1h:
	ret			;81e1
l81e2h:
	ld hl,0c103h		;81e2
	ld b,080h		;81e5
l81e7h:
	ld a,(hl)			;81e7
	and 00fh		;81e8
	or b			;81ea
	out (07fh),a		;81eb
	inc hl			;81ed
	ld a,(hl)			;81ee
	and 03fh		;81ef
	out (07fh),a		;81f1
	inc hl			;81f3
	ld a,b			;81f4
	add a,010h		;81f5
	ld b,a			;81f7
	ld a,(hl)			;81f8
	cpl			;81f9
	and 00fh		;81fa
	or b			;81fc
	out (07fh),a		;81fd
	inc hl			;81ff
	ld a,b			;8200
	add a,010h		;8201
	ld b,a			;8203
	cp 0e0h		;8204
	jp nz,l81e7h		;8206
	ld a,(0c131h)		;8209
	cp (hl)			;820c
	res 3,a		;820d
	ld (hl),a			;820f
	ld (0c131h),a		;8210
	jp z,l821ch		;8213
	and 007h		;8216
	or 0e0h		;8218
	out (07fh),a		;821a
l821ch:
	inc hl			;821c
	ld a,(hl)			;821d
	cpl			;821e
	and 00fh		;821f
	or 0f0h		;8221
	out (07fh),a		;8223
	ret			;8225
sub_8226h:
	push hl			;8226
	pop hl			;8227
sub_8228h:
	push hl			;8228
	pop hl			;8229
sub_822ah:
	ret			;822a
sub_822bh:
	ld a,(ix+01fh)		;822b
	cp 040h		;822e
	jp c,l8291h		;8230
	and 03fh		;8233
	ld c,a			;8235
	ld a,(0c102h)		;8236
	bit 7,a		;8239
	jr z,l824ah		;823b
	ld a,(ix+013h)		;823d
	and a			;8240
	jr z,l8246h		;8241
	add a,(ix+004h)		;8243
l8246h:
	ld (ix+01bh),a		;8246
	ret			;8249
l824ah:
	ld a,(ix+01bh)		;824a
	and a			;824d
	ret z			;824e
	exx			;824f
	bit 6,e		;8250
	exx			;8252
	jr nz,l8258h		;8253
	sub c			;8255
	jr l8259h		;8256
l8258h:
	add a,c			;8258
l8259h:
	jr z,l8287h		;8259
	ld b,(ix+009h)		;825b
	rlc b		;825e
	jr z,l8269h		;8260
	ld hl,08926h		;8262
	cp 061h		;8265
	jr l8272h		;8267
l8269h:
	ld hl,089e6h		;8269
	cp 019h		;826c
	jr c,l8286h		;826e
	cp 079h		;8270
l8272h:
	jr nc,l8286h		;8272
	ld (ix+01bh),a		;8274
	add a,a			;8277
	ld e,a			;8278
	ld d,000h		;8279
	add hl,de			;827b
	ld e,(hl)			;827c
	inc hl			;827d
	ld d,(hl)			;827e
	ld (ix+016h),e		;827f
	ld (ix+017h),d		;8282
	ret			;8285
l8286h:
	sub a			;8286
l8287h:
	ld (ix+01bh),a		;8287
	ld (ix+016h),a		;828a
	ld (ix+017h),a		;828d
	ret			;8290
l8291h:
	ld l,(ix+016h)		;8291
	ld h,(ix+017h)		;8294
	ld b,h			;8297
	ld c,l			;8298
l8299h:
	srl b		;8299
	rr c		;829b
l829dh:
	dec a			;829d
	jp nz,l8299h		;829e
	exx			;82a1
	bit 6,e		;82a2
	exx			;82a4
	jr nz,l82b0h		;82a5
	add hl,bc			;82a7
	ld a,h			;82a8
	cp 004h		;82a9
	jr c,l82b8h		;82ab
	jp l82b5h		;82ad
l82b0h:
	and a			;82b0
	sbc hl,bc		;82b1
	jr nc,l82b8h		;82b3
l82b5h:
	ld hl,00000h		;82b5
l82b8h:
	ld (ix+016h),l		;82b8
	ld (ix+017h),h		;82bb
	ret			;82be
sub_82bfh:
	ld e,(ix+007h)		;82bf
	ld d,(ix+008h)		;82c2
	dec de			;82c5
l82c6h:
	inc de			;82c6
	ld a,(de)			;82c7
	bit 7,a		;82c8
	jp z,l8472h		;82ca
	cp 0b0h		;82cd
	jp nc,l846dh		;82cf
	inc de			;82d2
	ld hl,l82c6h		;82d3
	push hl			;82d6
	ld hl,l82e5h		;82d7
	ld b,000h		;82da
	add a,a			;82dc
	ld c,a			;82dd
	add hl,bc			;82de
	ld a,(hl)			;82df
	inc hl			;82e0
	ld h,(hl)			;82e1
	ld l,a			;82e2
	ld a,(de)			;82e3
	jp (hl)			;82e4
l82e5h:
	cpl			;82e5
	add a,e			;82e6
	ld (hl),083h		;82e7
	ld d,e			;82e9
	add a,e			;82ea
	ld e,h			;82eb
	add a,e			;82ec
	ld h,h			;82ed
	add a,e			;82ee
	ld d,a			;82ef
	add a,e			;82f0
	ld c,l			;82f1
	add a,e			;82f2
	and b			;82f3
	add a,e			;82f4
	ld h,b			;82f5
	add a,e			;82f6
	ld h,h			;82f7
	add a,e			;82f8
	adc a,h			;82f9
	add a,e			;82fa
	ld (hl),l			;82fb
	adc a,b			;82fc
	inc (hl)			;82fd
	add a,e			;82fe
	ld l,a			;82ff
	add a,e			;8300
	add a,h			;8301
	add a,e			;8302
	add a,h			;8303
	add a,e			;8304
	adc a,b			;8305
	add a,e			;8306
	and h			;8307
	add a,e			;8308
	xor d			;8309
	add a,e			;830a
	jp nz,0e083h		;830b
	add a,e			;830e
	call m,01083h		;830f
	add a,h			;8312
	ld (04284h),hl		;8313
	add a,h			;8316
	jr c,l829dh		;8317
	ld b,d			;8319
	add a,h			;831a
	ld b,d			;831b
	add a,h			;831c
	ld a,(hl)			;831d
	add a,e			;831e
	ld b,b			;831f
	add a,e			;8320
	or b			;8321
	add a,e			;8322
	ld b,(hl)			;8323
	add a,h			;8324
	dec b			;8325
	add a,h			;8326
	ld c,d			;8327
	add a,h			;8328
	ld d,l			;8329
	add a,h			;832a
	ld e,c			;832b
	add a,h			;832c
	ld h,h			;832d
	add a,h			;832e
l832fh:
	ld l,a			;832f
	inc de			;8330
	ld a,(de)			;8331
	ld h,a			;8332
	ex de,hl			;8333
	dec de			;8334
	ret			;8335
	call sub_8376h		;8336
	inc de			;8339
	dec (hl)			;833a
	ld a,(de)			;833b
	jr nz,l832fh		;833c
	inc de			;833e
	ret			;833f
	call sub_8376h		;8340
	inc (hl)			;8343
	inc de			;8344
	ld a,(de)			;8345
	inc de			;8346
	cp (hl)			;8347
	ld a,(de)			;8348
	jr nz,l832fh		;8349
	inc de			;834b
	ret			;834c
	ld a,(ix+01ch)		;834d
	ld (0c100h),a		;8350
	ld (ix+000h),000h		;8353
	pop hl			;8357
	pop hl			;8358
	jp l80dah		;8359
	ld (ix+003h),a		;835c
	ret			;835f
	ld (ix+002h),a		;8360
	ret			;8363
	and a			;8364
	jp z,l836bh		;8365
	add a,(ix+004h)		;8368
l836bh:
	ld (ix+004h),a		;836b
	ret			;836e
	call sub_8376h		;836f
	inc de			;8372
	ld a,(de)			;8373
	ld (hl),a			;8374
	ret			;8375
sub_8376h:
	ld c,a			;8376
	ld b,000h		;8377
	push ix		;8379
	pop hl			;837b
	add hl,bc			;837c
	ret			;837d
	call sub_8376h		;837e
	ld (hl),000h		;8381
	ret			;8383
	ld (ix+01eh),a		;8384
	ret			;8387
	ld (ix+000h),a		;8388
	ret			;838b
	ld b,(ix+001h)		;838c
	bit 7,a		;838f
	jr z,l8399h		;8391
	add a,b			;8393
	jr c,l83a0h		;8394
	sub a			;8396
	jr l83a0h		;8397
l8399h:
	add a,b			;8399
	cp 010h		;839a
	jr c,l83a0h		;839c
	ld a,00fh		;839e
l83a0h:
	ld (ix+001h),a		;83a0
	ret			;83a3
	ld hl,0c100h		;83a4
	or (hl)			;83a7
	ld (hl),a			;83a8
	ret			;83a9
	ld l,(ix+010h)		;83aa
	dec l			;83ad
	jr l83b3h		;83ae
	ld l,(ix+010h)		;83b0
l83b3h:
	ld h,000h		;83b3
	ld c,a			;83b5
	inc de			;83b6
	ld a,(de)			;83b7
	ld b,a			;83b8
	add hl,bc			;83b9
	ld a,(hl)			;83ba
	add a,(ix+004h)		;83bb
	ld (ix+004h),a		;83be
	ret			;83c1
	ld b,(ix+00bh)		;83c2
	res 1,b		;83c5
	and 00fh		;83c7
	ld (ix+01ah),a		;83c9
	inc de			;83cc
	ld a,(de)			;83cd
	ld (ix+018h),a		;83ce
	ld (ix+019h),000h		;83d1
	set 5,b		;83d5
	and a			;83d7
	jr nz,l83dch		;83d8
	res 5,b		;83da
l83dch:
	ld (ix+00bh),b		;83dc
	ret			;83df
	ld b,(ix+00bh)		;83e0
	res 6,b		;83e3
	bit 7,a		;83e5
	jr z,l83ebh		;83e7
	set 6,b		;83e9
l83ebh:
	set 7,b		;83eb
	and 07fh		;83ed
	jr z,l83f6h		;83ef
	ld (ix+01fh),a		;83f1
	jr l83f8h		;83f4
l83f6h:
	res 7,b		;83f6
l83f8h:
	ld (ix+00bh),b		;83f8
	ret			;83fb
	bit 1,(ix+00bh)		;83fc
	jp z,l832fh		;8400
	inc de			;8403
	ret			;8404
	ld a,(0c12dh)		;8405
	bit 7,a		;8408
	ld a,(de)			;840a
	jp z,l832fh		;840b
	inc de			;840e
	ret			;840f
	res 0,(ix+00bh)		;8410
	and a			;8414
	ret z			;8415
	set 0,(ix+00bh)		;8416
	ld (ix+014h),a		;841a
	ld (ix+015h),080h		;841d
	ret			;8421
	ld (ix+022h),a		;8422
	ld l,a			;8425
	inc de			;8426
	ld a,(de)			;8427
	ld (ix+023h),a		;8428
	and a			;842b
	jr z,l8433h		;842c
	set 2,(ix+000h)		;842e
	ret			;8432
l8433h:
	res 2,(ix+000h)		;8433
	ret			;8437
	ld a,(ix+000h)		;8438
	xor 010h		;843b
	ld (ix+000h),a		;843d
	dec de			;8440
	ret			;8441
	ld (ix+006h),a		;8442
	ret			;8445
	ld (ix+01dh),a		;8446
	ret			;8449
	ld hl,0c12dh		;844a
	bit 7,(hl)		;844d
	jr z,l8454h		;844f
	ld (ix+009h),a		;8451
l8454h:
	ret			;8454
	ld (ix+00ah),a		;8455
	ret			;8458
	ld a,(0c12dh)		;8459
	bit 7,a		;845c
	jr z,l8462h		;845e
l8460h:
	inc de			;8460
	ret			;8461
l8462h:
	dec de			;8462
	ret			;8463
	ld a,(0c12dh)		;8464
	bit 7,a		;8467
	jr z,l8460h		;8469
	jr l8462h		;846b
l846dh:
	ld a,(ix+013h)		;846d
	jr l8473h		;8470
l8472h:
	inc de			;8472
l8473h:
	ex af,af'			;8473
	ld a,(ix+013h)		;8474
	and a			;8477
	ex af,af'			;8478
	ld (ix+013h),a		;8479
	call sub_8560h		;847c
	jr z,l84a4h		;847f
	bit 0,(ix+00ch)		;8481
	jr z,l84a4h		;8485
	ld a,(ix+017h)		;8487
	ld l,(ix+016h)		;848a
	cp l			;848d
	jr nz,l8496h		;848e
	cp 0ffh		;8490
	jr nz,l8496h		;8492
	ld a,b			;8494
	ld l,c			;8495
l8496h:
	ld (ix+01fh),b		;8496
	ld (ix+01eh),c		;8499
	ld (ix+017h),a		;849c
	ld (ix+016h),l		;849f
	jr l84aah		;84a2
l84a4h:
	ld (ix+017h),b		;84a4
	ld (ix+016h),c		;84a7
l84aah:
	ld a,(de)			;84aa
	cp 0e0h		;84ab
	jp nc,l84b6h		;84ad
	ld a,(ix+012h)		;84b0
	jp l84c9h		;84b3
l84b6h:
	sub 0e0h		;84b6
	jr nz,l84bfh		;84b8
	inc de			;84ba
	ld a,(de)			;84bb
	jp l84c8h		;84bc
l84bfh:
	dec a			;84bf
	ld hl,08b29h		;84c0
	ld c,a			;84c3
	ld b,000h		;84c4
	add hl,bc			;84c6
	ld a,(hl)			;84c7
l84c8h:
	inc de			;84c8
l84c9h:
	ld (ix+00eh),a		;84c9
	ld (ix+012h),a		;84cc
	ld hl,0c102h		;84cf
	ld a,(ix+005h)		;84d2
	ld (ix+00fh),a		;84d5
	sub a			;84d8
	ld (ix+00dh),a		;84d9
	ld (ix+021h),a		;84dc
	ex af,af'			;84df
	jr z,l84e8h		;84e0
	bit 4,(ix+000h)		;84e2
	jr nz,l84f2h		;84e6
l84e8h:
	ld (ix+020h),000h		;84e8
	set 2,(ix+00bh)		;84ec
	set 6,(hl)		;84f0
l84f2h:
	res 1,(ix+00ch)		;84f2
	set 7,(hl)		;84f6
	bit 2,(ix+000h)		;84f8
	jr z,l8545h		;84fc
	ld h,(ix+023h)		;84fe
	ld l,(ix+022h)		;8501
l8504h:
	ld a,(hl)			;8504
	and a			;8505
	jr nz,l850fh		;8506
	inc hl			;8508
	ld a,(hl)			;8509
	inc hl			;850a
	ld h,(hl)			;850b
	ld l,a			;850c
	jr l8504h		;850d
l850fh:
	inc hl			;850f
	jp p,l852dh		;8510
	ld c,a			;8513
	ld a,(ix+009h)		;8514
	and a			;8517
	jr z,l8528h		;8518
	ld a,(ix+00ah)		;851a
	and 0f8h		;851d
	ld b,a			;851f
	ld a,(hl)			;8520
	or b			;8521
	ld (ix+00ah),a		;8522
	ld a,c			;8525
	jr l852ch		;8526
l8528h:
	ld b,(hl)			;8528
	ld (ix+002h),b		;8529
l852ch:
	inc hl			;852c
l852dh:
	ld (ix+023h),h		;852d
	ld (ix+022h),l		;8530
	ld (ix+01eh),a		;8533
	rlca			;8536
	rlca			;8537
	rlca			;8538
	and 003h		;8539
	ld b,a			;853b
	ld a,(ix+000h)		;853c
	and 0fch		;853f
	or b			;8541
	ld (ix+000h),a		;8542
l8545h:
	ld (ix+008h),d		;8545
	ld (ix+007h),e		;8548
	exx			;854b
	ld d,(ix+000h)		;854c
	ld e,(ix+00bh)		;854f
	ld c,(ix+00ch)		;8552
	bit 1,d		;8555
	exx			;8557
	ret z			;8558
	ld a,(ix+01eh)		;8559
	ld (0c131h),a		;855c
	ret			;855f
sub_8560h:
	ld bc,00000h		;8560
	and a			;8563
	ret z			;8564
	ld c,a			;8565
	ld a,(ix+000h)		;8566
	and 00bh		;8569
	cp 00ah		;856b
	ld a,c			;856d
	jr z,l858ch		;856e
	add a,(ix+004h)		;8570
	dec a			;8573
	add a,a			;8574
	ld c,a			;8575
	ld a,(ix+009h)		;8576
	and a			;8579
	jr z,l8584h		;857a
	ld hl,08928h		;857c
	add hl,bc			;857f
	ld c,(hl)			;8580
	inc hl			;8581
	ld b,(hl)			;8582
	ret			;8583
l8584h:
	ld hl,089e8h		;8584
	add hl,bc			;8587
	ld c,(hl)			;8588
	inc hl			;8589
	ld b,(hl)			;858a
	ret			;858b
l858ch:
	ld (ix+01eh),a		;858c
	ret			;858f
sub_8590h:
	ld a,(ix+002h)		;8590
	add a,a			;8593
	jp z,l85b7h		;8594
	ld hl,08b84h		;8597
	ld c,a			;859a
	ld b,000h		;859b
	add hl,bc			;859d
	ld c,(hl)			;859e
	inc hl			;859f
	ld b,(hl)			;85a0
	ld d,(ix+020h)		;85a1
	call sub_85bch		;85a4
	inc d			;85a7
	ld (ix+020h),d		;85a8
	add a,(ix+001h)		;85ab
	sub 00fh		;85ae
	jr nc,l85b3h		;85b0
	sub a			;85b2
l85b3h:
	ld (0c12fh),a		;85b3
	ret			;85b6
l85b7h:
	ld a,(ix+001h)		;85b7
	jr l85b3h		;85ba
sub_85bch:
	ld l,d			;85bc
	ld h,000h		;85bd
	add hl,bc			;85bf
	ld a,(hl)			;85c0
	bit 7,a		;85c1
	ret z			;85c3
	cp 080h		;85c4
	jp nz,l85cdh		;85c6
l85c9h:
	dec d			;85c9
	dec hl			;85ca
	ld a,(hl)			;85cb
	ret			;85cc
l85cdh:
	cp 081h		;85cd
	jp nz,l85dch		;85cf
l85d2h:
	inc hl			;85d2
	ld a,d			;85d3
	sub (hl)			;85d4
	ld d,a			;85d5
	ld l,d			;85d6
	ld h,000h		;85d7
	add hl,bc			;85d9
	ld a,(hl)			;85da
	ret			;85db
l85dch:
	cp 082h		;85dc
	jp nz,l85e5h		;85de
	ld d,000h		;85e1
	ld a,(bc)			;85e3
	ret			;85e4
l85e5h:
	cp 083h		;85e5
	jp nz,l85f4h		;85e7
	exx			;85ea
	bit 2,e		;85eb
	exx			;85ed
	jr nz,l85c9h		;85ee
l85f0h:
	inc d			;85f0
	inc hl			;85f1
	ld a,(hl)			;85f2
	ret			;85f3
l85f4h:
	cp 084h		;85f4
	ret nz			;85f6
	exx			;85f7
	bit 2,e		;85f8
	exx			;85fa
	jr nz,l85d2h		;85fb
	inc d			;85fd
	inc hl			;85fe
	jr l85f0h		;85ff
sub_8601h:
	ld a,(ix+003h)		;8601
	ld e,a			;8604
	and 03fh		;8605
	add a,a			;8607
	ret z			;8608
	ld hl,08b46h		;8609
	ld c,a			;860c
	ld b,000h		;860d
	add hl,bc			;860f
	ld c,(hl)			;8610
	inc hl			;8611
	ld b,(hl)			;8612
	ld d,(ix+021h)		;8613
	call sub_85bch		;8616
	inc d			;8619
	ld (ix+021h),d		;861a
	bit 7,e		;861d
	jp z,l8624h		;861f
	cpl			;8622
	inc a			;8623
l8624h:
	cp 080h		;8624
	ld b,000h		;8626
	ld c,a			;8628
	jr c,l862ch		;8629
	dec b			;862b
l862ch:
	ld l,(ix+016h)		;862c
	ld h,(ix+017h)		;862f
	ld a,h			;8632
	or l			;8633
	ret z			;8634
	ld a,h			;8635
	sbc hl,bc		;8636
	bit 6,e		;8638
	jr z,l864bh		;863a
	cp h			;863c
	jr z,l864bh		;863d
	bit 7,b		;863f
	jr z,l8648h		;8641
	dec h			;8643
	ld l,0ffh		;8644
	jr l864bh		;8646
l8648h:
	inc h			;8648
	ld l,000h		;8649
l864bh:
	ld (ix+016h),l		;864b
	ld (ix+017h),h		;864e
	ret			;8651
sub_8652h:
	sub a			;8652
	ld (0c105h),a		;8653
	ld (0c108h),a		;8656
	ld (0c10bh),a		;8659
	ld (0c10dh),a		;865c
	dec a			;865f
	ld (0c130h),a		;8660
	ld a,(0c12dh)		;8663
	bit 7,a		;8666
	ret z			;8668
	and 040h		;8669
	xor 040h		;866b
	srl a		;866d
	ld (0c129h),a		;866f
	ld (0c12ah),a		;8672
	sub a			;8675
	ld (0c117h),a		;8676
	ld (0c118h),a		;8679
	ld (0c119h),a		;867c
	ld (0c11ah),a		;867f
	ld (0c11bh),a		;8682
	ld (0c11ch),a		;8685
	ld (0c11dh),a		;8688
	ld (0c11eh),a		;868b
	ld (0c11fh),a		;868e
	dec a			;8691
	ld (0c126h),a		;8692
	ld (0c127h),a		;8695
	ld (0c128h),a		;8698
	ret			;869b
sub_869ch:
	exx			;869c
	ld a,d			;869d
	exx			;869e
	ld b,a			;869f
	bit 5,a		;86a0
	call nz,sub_8652h		;86a2
	ld a,b			;86a5
	and 003h		;86a6
	ret z			;86a8
	exx			;86a9
	ld a,e			;86aa
	bit 1,c		;86ab
	exx			;86ad
	ret nz			;86ae
	ld a,(ix+009h)		;86af
	and a			;86b2
	jp z,l879ch		;86b3
	ld e,(ix+016h)		;86b6
	ld d,(ix+017h)		;86b9
	bit 0,b		;86bc
	jp z,l871bh		;86be
	ld hl,0c10eh		;86c1
	ld b,000h		;86c4
	ld c,(ix+006h)		;86c6
	add hl,bc			;86c9
	ld (hl),e			;86ca
	ld c,009h		;86cb
	add hl,bc			;86cd
	ld a,d			;86ce
	or e			;86cf
	jr nz,l86d9h		;86d0
	ld (hl),080h		;86d2
	add hl,bc			;86d4
	ld (hl),00fh		;86d5
	jr l871bh		;86d7
l86d9h:
	ld a,(ix+00ah)		;86d9
	and 020h		;86dc
	or d			;86de
	or 080h		;86df
	exx			;86e1
	bit 2,e		;86e2
	exx			;86e4
	jr z,l86e9h		;86e5
	set 4,a		;86e7
l86e9h:
	ld (hl),a			;86e9
	ld a,(0c102h)		;86ea
	bit 7,a		;86ed
	jr z,l86f7h		;86ef
	bit 6,a		;86f1
	jr z,l86f7h		;86f3
	set 6,(hl)		;86f5
l86f7h:
	add hl,bc			;86f7
	ld a,(ix+009h)		;86f8
	ld b,a			;86fb
	cp 010h		;86fc
	jr c,l8701h		;86fe
	sub a			;8700
l8701h:
	rlca			;8701
	rlca			;8702
	rlca			;8703
	rlca			;8704
	ld c,a			;8705
	jr nz,l8714h		;8706
	ld a,(0c12bh)		;8708
	cp b			;870b
	jr z,l8714h		;870c
	ld a,b			;870e
	set 7,a		;870f
	ld (0c12bh),a		;8711
l8714h:
	ld a,(0c12fh)		;8714
	xor 00fh		;8717
	or c			;8719
	ld (hl),a			;871a
l871bh:
	exx			;871b
	bit 1,d		;871c
	exx			;871e
	ret z			;871f
	ld a,(ix+00ah)		;8720
	and 007h		;8723
	ld c,a			;8725
	ld b,000h		;8726
	ld hl,l8797h		;8728
	add hl,bc			;872b
	ld a,e			;872c
	or d			;872d
	jr nz,l874ch		;872e
	exx			;8730
	bit 2,d		;8731
	exx			;8733
	jr nz,l874ch		;8734
	call sub_873dh		;8736
	ld e,00fh		;8739
	jr l8770h		;873b
sub_873dh:
	ld a,(hl)			;873d
	xor 0ffh		;873e
	ld b,a			;8740
	ld a,(0c129h)		;8741
	and b			;8744
	ld (0c129h),a		;8745
	ld (0c12ah),a		;8748
	ret			;874b
l874ch:
	exx			;874c
	bit 2,e		;874d
	exx			;874f
	jr nz,l8757h		;8750
	call sub_873dh		;8752
	jr l876ah		;8755
l8757h:
	ld a,(0c129h)		;8757
	or (hl)			;875a
	ld (0c129h),a		;875b
	ex af,af'			;875e
	ld a,(0c102h)		;875f
	bit 7,a		;8762
	jr nz,l876ah		;8764
	ex af,af'			;8766
	ld (0c12ah),a		;8767
l876ah:
	ld a,(0c12fh)		;876a
	xor 00fh		;876d
	ld e,a			;876f
l8770h:
	ld hl,0c126h		;8770
	ld a,c			;8773
	cp 003h		;8774
	jr c,l8779h		;8776
	inc hl			;8778
l8779h:
	cp 001h		;8779
	jr c,l877fh		;877b
	inc hl			;877d
	inc a			;877e
l877fh:
	and 001h		;877f
	jr nz,l8789h		;8781
	ld a,(hl)			;8783
	and 0f0h		;8784
	or e			;8786
	ld (hl),a			;8787
	ret			;8788
l8789h:
	ld a,(hl)			;8789
	and 00fh		;878a
	rlc e		;878c
	rlc e		;878e
	rlc e		;8790
	rlc e		;8792
	or e			;8794
	ld (hl),a			;8795
	ret			;8796
l8797h:
	djnz $+10		;8797
	ld bc,00402h		;8799
l879ch:
	ld e,(ix+016h)		;879c
	ld d,(ix+017h)		;879f
	ld c,(ix+006h)		;87a2
	bit 1,b		Warning: Code might not be 8080 compatible!
;87a5
	jp z,l87b7h		;87a7
	ld a,(0c12fh)		;87aa
	ld (0c10dh),a		;87ad
	ld a,c			;87b0
	ld (0c130h),a		;87b1
	jp l87c5h		;87b4
l87b7h:
	ld a,(0c130h)		;87b7
	cp c			;87ba
	jr nz,l87c5h		;87bb
	sub a			;87bd
	ld (0c10dh),a		;87be
	dec a			;87c1
	ld (0c130h),a		;87c2
l87c5h:
	ld a,e			;87c5
	or d			;87c6
	jr nz,l87dah		;87c7
	ld (0c12fh),a		;87c9
	bit 1,b		;87cc
	jp z,l87dah		;87ce
	exx			;87d1
	bit 2,d		;87d2
	exx			;87d4
	jr nz,l87dah		;87d5
	ld (0c10dh),a		;87d7
l87dah:
	bit 0,b		;87da
	jr nz,l87e2h		;87dc
	sub a			;87de
	ld (0c12fh),a		;87df
l87e2h:
	bit 3,b		;87e2
	jr nz,l8808h		;87e4
	ld a,c			;87e6
	add a,a			;87e7
	add a,c			;87e8
	ld c,a			;87e9
	ld b,000h		;87ea
	ld hl,0c103h		;87ec
	add hl,bc			;87ef
	ld (hl),e			;87f0
	inc hl			;87f1
	sla e		;87f2
	rl d		;87f4
	sla e		;87f6
	rl d		;87f8
	sla e		;87fa
	rl d		;87fc
	sla e		;87fe
	rl d		;8800
	ld (hl),d			;8802
	inc hl			;8803
	ld a,(0c12fh)		;8804
	ld (hl),a			;8807
l8808h:
	ret			;8808
l8809h:
	ld d,020h		;8809
	rla			;880b
	ld d,b			;880c
	jr $-62		;880d
	ld h,005h		;880f
	daa			;8811
	dec b			;8812
	jr z,l8816h		;8813
l8815h:
	ld c,a			;8815
l8816h:
	ld (0c12dh),a		;8816
	and a			;8819
	jp z,l8834h		;881a
	bit 6,a		;881d
	jp nz,l8834h		;881f
	ld b,006h		;8822
	ld hl,l8809h		;8824
l8827h:
	ld a,(hl)			;8827
	out (0f0h),a		;8828
	inc hl			;882a
	ld a,(hl)			;882b
	out (0f1h),a		;882c
	inc hl			;882e
	call sub_8226h		;882f
	djnz l8827h		;8832
l8834h:
	sub a			;8834
	ld (0c12bh),a		;8835
	bit 7,c		;8838
	jr z,l883dh		;883a
	inc a			;883c
l883dh:
	out (0f2h),a		;883d
	sub a			;883f
	ld (0c102h),a		;8840
	dec a			;8843
	ld (0c10ch),a		;8844
l8847h:
	push ix		;8847
	ld ix,0c132h		;8849
	ld de,00026h		;884d
	ld b,008h		;8850
	sub a			;8852
l8853h:
	ld (ix+000h),a		;8853
	add ix,de		;8856
	djnz l8853h		;8858
	pop ix		;885a
	di			;885c
	ld a,(0c12dh)		;885d
	push af			;8860
	ld a,080h		;8861
	ld (0c12dh),a		;8863
	call sub_8652h		;8866
	call sub_811ah		;8869
	call l81e2h		;886c
	pop af			;886f
	ld (0c12dh),a		;8870
	ei			;8873
	ret			;8874
l8875h:
	push bc			;8875
	push de			;8876
	push hl			;8877
	push ix		;8878
	di			;887a
	call sub_8885h		;887b
	ei			;887e
	pop ix		;887f
	pop hl			;8881
	pop de			;8882
	pop bc			;8883
	ret			;8884
sub_8885h:
	ld c,a			;8885
	add a,a			;8886
	ld e,a			;8887
	ld d,000h		;8888
	ld hl,08cf8h		;888a
	add hl,de			;888d
	ld e,(hl)			;888e
	inc hl			;888f
	ld d,(hl)			;8890
	ex de,hl			;8891
sub_8892h:
	ld a,(hl)			;8892
	inc hl			;8893
	and a			;8894
	jr nz,l8898h		;8895
	jp (hl)			;8897
l8898h:
	ld b,a			;8898
	jp p,l88b3h		;8899
	ld a,(0c12dh)		;889c
	bit 7,a		;889f
	jr nz,l88a6h		;88a1
	inc hl			;88a3
	jr l88abh		;88a4
l88a6h:
	ld a,(hl)			;88a6
	inc hl			;88a7
	ld h,(hl)			;88a8
	ld l,a			;88a9
	ld b,(hl)			;88aa
l88abh:
	inc hl			;88ab
	ld a,b			;88ac
	and 07fh		;88ad
	jp nz,l88b3h		;88af
	jp (hl)			;88b2
l88b3h:
	ld a,(hl)			;88b3
	inc hl			;88b4
	push hl			;88b5
	add a,a			;88b6
	ld e,a			;88b7
	ld d,000h		;88b8
	ld hl,08918h		;88ba
	add hl,de			;88bd
	ld e,(hl)			;88be
	inc hl			;88bf
	ld d,(hl)			;88c0
	pop hl			;88c1
	ld a,(hl)			;88c2
	and a			;88c3
	jr z,$+75		;88c4
	ld a,(de)			;88c6
	bit 6,a		;88c7
	ret nz			;88c9
	push de			;88ca
	pop ix		;88cb
	ld (ix+01ch),c		;88cd
	ld a,(0c12dh)		;88d0
	bit 7,a		;88d3
	jr nz,l88e3h		;88d5
l88d7h:
	ld (ix+009h),000h		;88d7
	ld (ix+00ah),000h		;88db
	ld c,009h		;88df
	jr l88e9h		;88e1
l88e3h:
	bit 7,b		;88e3
	jr z,l88d7h		;88e5
	ld c,00bh		;88e7
l88e9h:
	ld a,b			;88e9
	ld b,000h		;88ea
	ldir		;88ec
	ld b,a			;88ee
	ld c,(ix+01ch)		;88ef
	sub a			;88f2
	ld (ix+00bh),a		;88f3
	ld (ix+00ch),a		;88f6
	ld (ix+00dh),a		;88f9
	ld (ix+01dh),a		;88fc
	defb 0ddh		;88ff
