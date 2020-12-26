	.begin
BASE	.equ 0x3fffc0		!Starting point of memory mapped region
COUT	.equ 0x0		!0xffff0000 Console Data Port
COSTAT	.equ 0x4		!0xffff0004 Console Status Port
CIN	.equ 0x8		!0xffff0008 Keyboard Data Port
CICTL	.equ 0xc		!0xffff000c Keyboard Control port
	.org 2048		!Stating program address
	add %r0,%r0,%r4	!Clear r4
	sethi BASE, %r4	!Get 22 MSB of 0x3fffc0 into %r4

InWait:	halt
	ldub[%r4+CICTL],%r1
	andcc %r1,0x80,%r1	!And r1 and constant 0x80 store in r1, setting condition 
	be InWait		!Branch to InWait

	ldub [%r4+CIN],%r3	!Reads input
	subcc %r3,27,%r5	!27 is Escape
	be End			!Stop if it is
	
Wait:	ldub [%r4+COSTAT],%r1
	andcc %r1,0x80,%r1	!And r1 and constant 0x80 store in r1, setting condition
	be Wait		!Branch to Wait
	stb %r3,[%r4+COUT]	!Print to console
	ba InWait		!Branch to InWait
	
End:	halt
	.end

! Console output address 0xffff0000
! Keyboard input 0xffff0008 
	
