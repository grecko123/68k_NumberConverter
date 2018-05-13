*-----------------------------------------------------------
* Program    : Number Conversion EXTRA CREDIT
* Written by : Brian Grech 
* Date       :
* Description: Converts Decimal and Displays on hardware output sevn seg
*-----------------------------------------------------------
	Include	"YOUR_SEVENSEG_DEF_FILE_LOCATION_HERE\ADDRESSES.X68"
	ORG	$5000
START:				; first instruction of program
	clr.b	svnseg0
	clr.b	svnseg1
	clr.b	svnseg2
	clr.b	svnseg3
	clr.b	svnseg4
	clr.b	svnseg5
	clr.b	svnseg6
	clr.b	svnseg7
	move	#255,d1
	lea	modes,a1
	move	#0,d0
	trap	#15
	lea	modesh,a1
	move	#0,d0
	trap	#15
	lea	digets,a1
	move	#0,d0
	trap	#15
st	move	#255,d1
	lea	intmp,a1
	move	#0,d0
	trap	#15
	clr	d4
	clr	d5
	clr.l	d6	
stog	move	#4,d0
	trap	#15
	move.l 	#99999,d6
	cmp.l	d6,d1
	bgt	nota1
	cmp	#0,d1
	beq	st
	cmp.b	#$00,togsw
	beq	deni
	cmp.b	#$01,togsw
	beq	go
	cmp.b	#$02,togsw
	beq	hexin
	cmp.b	#$04,togsw
	beq	octin
	cmp.b	#$00,togsw
	bgt	deni
	
	MOVE.B	#9,D0
	TRAP	#15		; halt simulator
*messages
intmp	dc.b	'Use toggle switch to select output mode. What is your number value:',0
modes	dc.b	'Toggle switch output: 0 is Decimal, 1 is hex, and 2 is Octal.',0
modesh	dc.b	'Hex letter output; B = 8. and D = ||',0
notm	dc.b	'Number input is too large.',0
denim	dc.b	'Please select a valid output mode! Renter;',0
digets	dc.b	'The largest number supported is 5 digets',0


deni	move	#255,d1
	lea	denim,a1
	move	#0,d0
	trap	#15
	bra	stog	
	
go	lea	numbi,a2
	lea	numbo,a3
	move.l	#10000,d5
	move.l	d1,(a2)
	move.l	(a2),d2
	divu	d5,d2
	move.b	d2,(a3)+
	bsr	shft
	move.l	#1000,d5
	divu	d5,d2
	move.b	d2,(a3)+
	bsr	shft
	move.l	#100,d5
	divu	d5,d2
	move.b	d2,(a3)+
	bsr	shft
	divu	#10,d2
	move.b	d2,(a3)+
	bsr	shft
	move.b	d2,(a3)+
	clr	d7
	move.b	#5,d7
hrenum	clr.b	svnseg2
orenum	clr	d5	
	lea	numbo,a4
renum	nop
	move.b	(a4)+,d4
	sub	#1,d7
	cmp	#1,d5		;check for if there has been an inputed didget allready
	bge	skp		;this skips zero supression detection because number has started
	cmp	#0,d4
	beq	zros
skp	cmp	#6,d7
	beq	vled1
	cmp	#5,d7
	beq	vled2
	cmp	#4,d7
	beq	vled3
	cmp	#3,d7
	beq	vled4
	cmp	#2,d7
	beq	vled5
	cmp	#1,d7
	beq	vled6
	cmp	#0,d7
	beq	vled7	
*
shft	asr.l	#8,d2
	asr.l	#8,d2
	rts
	
zros	clr.b	svnseg0
	clr.b	svnseg1
	clr.b	svnseg2
	clr.b	svnseg3
	clr.b	svnseg4
	clr.b	svnseg5
	clr.b	svnseg6
	clr.b	svnseg7
	bra	renum

vled0	cmp	#1,d4
	beq	ledv01
	cmp	#2,d4
	beq	ledv02
	cmp	#3,d4
	beq	ledv03
	cmp	#4,d4
	beq	ledv04
	cmp	#5,d4
	beq	ledv05
	cmp	#6,d4
	beq	ledv06
	cmp	#7,d4
	beq	ledv07
	cmp	#8,d4
	beq	ledv08
	cmp	#9,d4
	beq	ledv09
	cmp	#$a,d4
	beq	ledv0a
	cmp	#$b,d4
	beq	ledv0b
	cmp	#$c,d4
	beq	ledv0c
	cmp	#$d,d4
	beq	ledv0d
	cmp	#$e,d4
	beq	ledv0e
	cmp	#$f,d4
	beq	ledv0f
*	
vled1	cmp	#0,d4
	beq	ledv10
	cmp	#1,d4
	beq	ledv11
	cmp	#2,d4
	beq	ledv12
	cmp	#3,d4
	beq	ledv13
	cmp	#4,d4
	beq	ledv14
	cmp	#5,d4
	beq	ledv15
	cmp	#6,d4
	beq	ledv16
	cmp	#7,d4
	beq	ledv17
	cmp	#8,d4
	beq	ledv18
	cmp	#9,d4
	beq	ledv19
	cmp	#$a,d4
	beq	ledv1a
	cmp	#$b,d4
	beq	ledv1b
	cmp	#$c,d4
	beq	ledv1c
	cmp	#$d,d4
	beq	ledv1d
	cmp	#$e,d4
	beq	ledv1e
	cmp	#$f,d4
	beq	ledv1f
*	
vled2	cmp	#0,d4
	beq	ledv20
	cmp	#1,d4
	beq	ledv21
	cmp	#2,d4
	beq	ledv22
	cmp	#3,d4
	beq	ledv23
	cmp	#4,d4
	beq	ledv24
	cmp	#5,d4
	beq	ledv25
	cmp	#6,d4
	beq	ledv26
	cmp	#7,d4
	beq	ledv27
	cmp	#8,d4
	beq	ledv28
	cmp	#9,d4
	beq	ledv29
	cmp	#$a,d4
	beq	ledv2a
	cmp	#$b,d4
	beq	ledv2b
	cmp	#$c,d4
	beq	ledv2c
	cmp	#$d,d4
	beq	ledv2d
	cmp	#$e,d4
	beq	ledv2e
	cmp	#$f,d4
	beq	ledv2f
*	
vled3	cmp	#0,d4
	beq	ledv30
	cmp	#1,d4
	beq	ledv31
	cmp	#2,d4
	beq	ledv32
	cmp	#3,d4
	beq	ledv33
	cmp	#4,d4
	beq	ledv34
	cmp	#5,d4
	beq	ledv35
	cmp	#6,d4
	beq	ledv36
	cmp	#7,d4
	beq	ledv37
	cmp	#8,d4
	beq	ledv38
	cmp	#9,d4
	beq	ledv39
	cmp	#$a,d4
	beq	ledv3a
	cmp	#$b,d4
	beq	ledv3b
	cmp	#$c,d4
	beq	ledv3c
	cmp	#$d,d4
	beq	ledv3d
	cmp	#$e,d4
	beq	ledv3e
	cmp	#$f,d4
	beq	ledv3f
*	
vled4	cmp	#0,d4
	beq	ledv40
	cmp	#1,d4
	beq	ledv41
	cmp	#2,d4
	beq	ledv42
	cmp	#3,d4
	beq	ledv43
	cmp	#4,d4
	beq	ledv44
	cmp	#5,d4
	beq	ledv45
	cmp	#6,d4
	beq	ledv46
	cmp	#7,d4
	beq	ledv47
	cmp	#8,d4
	beq	ledv48
	cmp	#9,d4
	beq	ledv49
	cmp	#$a,d4
	beq	ledv4a
	cmp	#$b,d4
	beq	ledv4b
	cmp	#$c,d4
	beq	ledv4c
	cmp	#$d,d4
	beq	ledv4d
	cmp	#$e,d4
	beq	ledv4e
	cmp	#$f,d4
	beq	ledv4f
*	
vled5	cmp	#0,d4
	beq	ledv50
	cmp	#1,d4
	beq	ledv51
	cmp	#2,d4
	beq	ledv52
	cmp	#3,d4
	beq	ledv53
	cmp	#4,d4
	beq	ledv54
	cmp	#5,d4
	beq	ledv55
	cmp	#6,d4
	beq	ledv56
	cmp	#7,d4
	beq	ledv57
	cmp	#8,d4
	beq	ledv58
	cmp	#9,d4
	beq	ledv59
	cmp	#$a,d4
	beq	ledv5a
	cmp	#$b,d4
	beq	ledv5b
	cmp	#$c,d4
	beq	ledv5c
	cmp	#$d,d4
	beq	ledv5d
	cmp	#$e,d4
	beq	ledv5e
	cmp	#$f,d4
	beq	ledv5f
*	
vled6	cmp	#0,d4
	beq	ledv60
	cmp	#1,d4
	beq	ledv61
	cmp	#2,d4
	beq	ledv62
	cmp	#3,d4
	beq	ledv63
	cmp	#4,d4
	beq	ledv64
	cmp	#5,d4
	beq	ledv65
	cmp	#6,d4
	beq	ledv66
	cmp	#7,d4
	beq	ledv67
	cmp	#8,d4
	beq	ledv68
	cmp	#9,d4
	beq	ledv69
	cmp	#$a,d4
	beq	ledv6a
	cmp	#$b,d4
	beq	ledv6b
	cmp	#$c,d4
	beq	ledv6c
	cmp	#$d,d4
	beq	ledv6d
	cmp	#$e,d4
	beq	ledv6e
	cmp	#$f,d4
	beq	ledv6f
*
vled7	cmp	#0,d4
	beq	ledv70
	cmp	#1,d4
	beq	ledv71
	cmp	#2,d4
	beq	ledv72
	cmp	#3,d4
	beq	ledv73
	cmp	#4,d4
	beq	ledv74
	cmp	#5,d4
	beq	ledv75
	cmp	#6,d4
	beq	ledv76
	cmp	#7,d4
	beq	ledv77
	cmp	#8,d4
	beq	ledv78
	cmp	#9,d4
	beq	ledv79
	cmp	#$a,d4
	beq	ledv7a
	cmp	#$b,d4
	beq	ledv7b
	cmp	#$c,d4
	beq	ledv7c
	cmp	#$d,d4
	beq	ledv7d
	cmp	#$e,d4
	beq	ledv7e
	cmp	#$f,d4
	beq	ledv7f
*		

* Variables and Strings
nota1	move	#255,d1
	lea	notm,a1
	move	#0,d0
	trap 	#15
	bra	st

ledv00	move.b	#%00111111,svnseg0
	add	#1,d5
	bra	renum
ledv01	move.b	#%00000110,svnseg0
	add	#1,d5
	bra	renum
ledv02	move.b	#%01011011,svnseg0
	add	#1,d5
	bra	renum
ledv03	move.b	#%01001111,svnseg0
	add	#1,d5
	bra	renum
ledv04	move.b	#%01100110,svnseg0
	add	#1,d5
	bra	renum
ledv05	move.b	#%01101101,svnseg0
	add	#1,d5
	bra	renum
ledv06	move.b	#%01111100,svnseg0
	add	#1,d5
	bra	renum
ledv07	move.b	#%00000111,svnseg0
	add	#1,d5
	bra	renum
ledv08	move.b	#%01111111,svnseg0
	add	#1,d5
	bra	renum
ledv09	move.b	#%01100111,svnseg0
	add	#1,d5
	bra	renum
ledv0A	move.b	#%01110111,svnseg0
	add	#1,d5
	bra	renum
ledv0B	move.b	#%11111111,svnseg0
	add	#1,d5
	bra	renum
ledv0C	move.b	#%00111001,svnseg0
	add	#1,d5
	bra	renum
ledv0D	move.b	#%00110110,svnseg0
	add	#1,d5
	bra	renum
ledv0E	move.b	#%01111001,svnseg0
	add	#1,d5
	bra	renum
ledv0F	move.b	#%01110001,svnseg0
	add	#1,d5
	bra	renum

ledv10	move.b	#%00111111,svnseg1
	add	#1,d5
	bra	renum
ledv11	move.b	#%00000110,svnseg1
	add	#1,d5
	bra	renum
ledv12	move.b	#%01011011,svnseg1
	add	#1,d5
	bra	renum
ledv13	move.b	#%01001111,svnseg1
	add	#1,d5
	bra	renum
ledv14	move.b	#%01100110,svnseg1
	add	#1,d5
	bra	renum
ledv15	move.b	#%01101101,svnseg1
	add	#1,d5
	bra	renum
ledv16	move.b	#%01111100,svnseg1
	add	#1,d5
	bra	renum
ledv17	move.b	#%00000111,svnseg1
	add	#1,d5
	bra	renum
ledv18	move.b	#%01111111,svnseg1
	add	#1,d5
	bra	renum
ledv19	move.b	#%01100111,svnseg1
	add	#1,d5
	bra	renum
ledv1A	move.b	#%01110111,svnseg1
	add	#1,d5
	bra	renum
ledv1B	move.b	#%11111111,svnseg1
	add	#1,d5
	bra	renum
ledv1C	move.b	#%00111001,svnseg1
	add	#1,d5
	bra	renum
ledv1D	move.b	#%00110110,svnseg1
	add	#1,d5
	bra	renum
ledv1E	move.b	#%01111001,svnseg1
	add	#1,d5
	bra	renum
ledv1F	move.b	#%01110001,svnseg1
	add	#1,d5
	bra	renum


ledv20	move.b	#%00111111,svnseg2
	add	#1,d5
	bra	renum
ledv21	move.b	#%00000110,svnseg2
	add	#1,d5
	bra	renum
ledv22	move.b	#%01011011,svnseg2
	add	#1,d5
	bra	renum
ledv23	move.b	#%01001111,svnseg2
	add	#1,d5
	bra	renum
ledv24	move.b	#%01100110,svnseg2
	add	#1,d5
	bra	renum
ledv25	move.b	#%01101101,svnseg2
	add	#1,d5
	bra	renum
ledv26	move.b	#%01111100,svnseg2
	add	#1,d5
	bra	renum
ledv27	move.b	#%00000111,svnseg2
	add	#1,d5
	bra	renum
ledv28	move.b	#%01111111,svnseg2
	add	#1,d5
	bra	renum
ledv29	move.b	#%01100111,svnseg2
	add	#1,d5
	bra	renum
ledv2A	move.b	#%01110111,svnseg2
	add	#1,d5
	bra	renum
ledv2B	move.b	#%11111111,svnseg2
	add	#1,d5
	bra	renum
ledv2C	move.b	#%00111001,svnseg2
	add	#1,d5
	bra	renum
ledv2D	move.b	#%00110110,svnseg2
	add	#1,d5
	bra	renum
ledv2E	move.b	#%01111001,svnseg2
	add	#1,d5
	bra	renum
ledv2F	move.b	#%01110001,svnseg2
	add	#1,d5
	bra	renum

	
ledv30	move.b	#%00111111,svnseg3
	add	#1,d5
	bra	renum	
ledv31	move.b	#%00000110,svnseg3
	add	#1,d5
	bra	renum	
ledv32	move.b	#%01011011,svnseg3
	add	#1,d5
	bra	renum	
ledv33	move.b	#%01001111,svnseg3
	add	#1,d5
	bra	renum	
ledv34	move.b	#%01100110,svnseg3
	add	#1,d5
	bra	renum	
ledv35	move.b	#%01101101,svnseg3
	add	#1,d5
	bra	renum	
ledv36	move.b	#%01111100,svnseg3
	add	#1,d5
	bra	renum	
ledv37	move.b	#%00000111,svnseg3
	add	#1,d5
	bra	renum	
ledv38	move.b	#%01111111,svnseg3
	add	#1,d5
	bra	renum	
ledv39	move.b	#%01100111,svnseg3
	add	#1,d5
	bra	renum
ledv3A	move.b	#%01110111,svnseg3
	add	#1,d5
	bra	renum
ledv3B	move.b	#%11111111,svnseg3
	add	#1,d5
	bra	renum
ledv3C	move.b	#%00111001,svnseg3
	add	#1,d5
	bra	renum
ledv3D	move.b	#%00110110,svnseg3
	add	#1,d5
	bra	renum
ledv3E	move.b	#%01111001,svnseg3
	add	#1,d5
	bra	renum
ledv3F	move.b	#%01110001,svnseg3
	add	#1,d5
	bra	renum

	
	
ledv40	move.b	#%00111111,svnseg4
	add	#1,d5
	bra	renum
ledv41	move.b	#%00000110,svnseg4
	add	#1,d5
	bra	renum
ledv42	move.b	#%01011011,svnseg4
	add	#1,d5
	bra	renum
ledv43	move.b	#%01001111,svnseg4
	add	#1,d5
	bra	renum
ledv44	move.b	#%01100110,svnseg4
	add	#1,d5
	bra	renum
ledv45	move.b	#%01101101,svnseg4
	add	#1,d5
	bra	renum
ledv46	move.b	#%01111100,svnseg4
	add	#1,d5
	bra	renum
ledv47	move.b	#%00000111,svnseg4
	add	#1,d5
	bra	renum
ledv48	move.b	#%01111111,svnseg4
	add	#1,d5
	bra	renum
ledv49	move.b	#%01100111,svnseg4
	add	#1,d5
	bra	renum
ledv4A	move.b	#%01110111,svnseg4
	add	#1,d5
	bra	renum
ledv4B	move.b	#%11111111,svnseg4
	add	#1,d5
	bra	renum
ledv4C	move.b	#%00111001,svnseg4
	add	#1,d5
	bra	renum
ledv4D	move.b	#%00110110,svnseg4
	add	#1,d5
	bra	renum
ledv4E	move.b	#%01111001,svnseg4
	add	#1,d5
	bra	renum
ledv4F	move.b	#%01110001,svnseg4
	add	#1,d5
	bra	renum


ledv51	move.b	#%00000110,svnseg5
	add	#1,d5
	bra	renum	
ledv52	move.b	#%01011011,svnseg5
	add	#1,d5
	bra	renum
ledv50	move.b	#%00111111,svnseg5
	add	#1,d5
	bra	renum
ledv53	move.b	#%01001111,svnseg5
	add	#1,d5
	bra	renum
ledv54	move.b	#%01100110,svnseg5
	add	#1,d5
	bra	renum
ledv55	move.b	#%01101101,svnseg5
	add	#1,d5
	bra	renum
ledv56	move.b	#%01111100,svnseg5
	add	#1,d5
	bra	renum
ledv57	move.b	#%00000111,svnseg5
	add	#1,d5
	bra	renum
ledv58	move.b	#%01111111,svnseg5
	add	#1,d5
	bra	renum
ledv59	move.b	#%01100111,svnseg5
	add	#1,d5
	bra	renum
ledv5A	move.b	#%01110111,svnseg5
	add	#1,d5
	bra	renum
ledv5B	move.b	#%11111111,svnseg5
	add	#1,d5
	bra	renum
ledv5C	move.b	#%00111001,svnseg5
	add	#1,d5
	bra	renum
ledv5D	move.b	#%00110110,svnseg5
	add	#1,d5
	bra	renum
ledv5E	move.b	#%01111001,svnseg5
	add	#1,d5
	bra	renum
ledv5F	move.b	#%01110001,svnseg5
	add	#1,d5
	bra	renum


ledv60	move.b	#%00111111,svnseg6
	add	#1,d5
	bra	renum
ledv61	move.b	#%00000110,svnseg6
	add	#1,d5
	bra	renum
ledv62	move.b	#%01011011,svnseg6
	add	#1,d5
	bra	renum
ledv63	move.b	#%01001111,svnseg6
	add	#1,d5
	bra	renum
ledv64	move.b	#%01100110,svnseg6
	add	#1,d5
	bra	renum
ledv65	move.b	#%01101101,svnseg6
	add	#1,d5
	bra	renum
ledv66	move.b	#%01111100,svnseg6
	add	#1,d5
	bra	renum
ledv67	move.b	#%00000111,svnseg6
	add	#1,d5
	bra	renum
ledv68	move.b	#%01111111,svnseg6
	add	#1,d5
	bra	renum
ledv69	move.b	#%01100111,svnseg6
	add	#1,d5
	bra	renum
ledv6A	move.b	#%01110111,svnseg6
	add	#1,d5
	bra	renum
ledv6B	move.b	#%11111111,svnseg6
	add	#1,d5
	bra	renum
ledv6C	move.b	#%00111001,svnseg6
	add	#1,d5
	bra	renum
ledv6D	move.b	#%00110110,svnseg6
	add	#1,d5
	bra	renum
ledv6E	move.b	#%01111001,svnseg6
	add	#1,d5
	bra	renum
ledv6F	move.b	#%01110001,svnseg6
	add	#1,d5
	bra	renum

	
ledv70	move.b	#%00111111,svnseg7
	add	#1,d5
	bra	st
ledv71	move.b	#%00000110,svnseg7
	add	#1,d5
	bra	st
ledv72	move.b	#%01011011,svnseg7
	add	#1,d5
	bra	st
ledv73	move.b	#%01001111,svnseg7
	add	#1,d5
	bra	st
ledv74	move.b	#%01100110,svnseg7
	add	#1,d5
	bra	st
ledv75	move.b	#%01101101,svnseg7
	add	#1,d5
	bra	st
ledv76	move.b	#%01111100,svnseg7
	add	#1,d5
	bra	st
ledv77	move.b	#%00000111,svnseg7
	add	#1,d5
	bra	st
ledv78	move.b	#%01111111,svnseg7
	add	#1,d5
	bra	st
ledv79	move.b	#%01100111,svnseg7
	add	#1,d5
	bra	st
ledv7A	move.b	#%01110111,svnseg7
	add	#1,d5
	bra	st
ledv7B	move.b	#%11111111,svnseg7
	add	#1,d5
	bra	st
ledv7C	move.b	#%00111001,svnseg7
	add	#1,d5
	bra	st
ledv7D	move.b	#%00110110,svnseg7
	add	#1,d5
	bra	st
ledv7E	move.b	#%01111001,svnseg7
	add	#1,d5
	bra	st
ledv7F	move.b	#%01110001,svnseg7
	add	#1,d5
	bra	st


	org	$6000
numbi	ds.l	64
	org	$6050
numbo	ds.b	64
	org	$6500
hexin	
	clr	d4
	move	#6,d4		;counter
	lea	$6055,a2
hexlp	clr	d5
	lsl.l	#$4,d1
	move.b	d1,d5
	lsr.b	#$4,d5
	clr.b	d1
	move.b	d5,-(a2)
	lsr.l	#$8,d1
	sub	#1,d4
	cmp	#0,d4
	bne	hexlp
	clr	d7
	move.b	#5,d7
	bra 	hrenum
	
octin	cmp	#8,d1
	blt	octex
	clr.l	d6
	clr.l	d5
	lea	$6056,a2
	add	#5,d6
octlp	divu	#8,d1
	move.w	d1,d5
	clr.w	d1
	lsr.l	#8,d1
	lsr.l	#8,d1
	move.b	d1,-(a2)
	move	d5,d1
	dbra	d6,octlp
	clr	d7
	move.b	#6,d7
	bra	orenum
octex	move.b	d1,d4
	move	#0,d7
	bra	skp
	
	END	START		; last line of source
