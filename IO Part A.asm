.begin
BASE	.equ 0x3fffc0			!Starting point of the memory mapped region
COUT	.equ 0x0			!0xffff0000 Console Data Port
COSTAT	.equ 0x4			!0xffff0004 Console Status Port
	
	.org 2048			!Start adressing at 2048
	add %r0,%r0,%r2		!Adding %r0 and %r0 into %r2
	add %r0,%r0,%r4		!Adding %r0 and %r0 into %r4
	sethi BASE,%r4		!Taking the first 22 MSB from 0x3fffc0 and store in r4
Loop:	ld [%r2+String], %r3	!Load next char into r3
	addcc %r3,%r0,%r3		!Adding and setting condition, r3 and r0 into r3
	be End				!Stop if null
Wait:	ldub [%r4+COSTAT],%r1
	andcc %r1,0x80,%r1		!Add 0x80 constant to r1 and store in r1
	be Wait			!Branch to Wait
	stb %r3,[%r4+COUT]		!Print to console
	add %r2,4,%r2			!Increment String offset (r2)
	ba Loop			!Branch to loop
End:	halt				!A non-standard instruction to stop the simulator

	.org 3000			!Starting address 
!The "Hellow, World!" string
String:	0x48,0x65,0x6c,0x6f
		0x2c,0x20,0x77,0x6f,0x72
		0x6c,0x64,0x21,0x0a,0
	.end



! stb %r3,[%r4+COUT]		!Print to console
! Does not take in keystrokes
! ffff0000 output address


