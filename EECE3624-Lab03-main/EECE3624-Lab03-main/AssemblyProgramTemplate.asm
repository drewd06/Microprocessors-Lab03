/**************************************************************************
 *     File: Labxx.asm
 * Lab Name: 
 *   Author: 
 *  Created: 
 *
 * This program...
 *************************************************************************/ 

.org 0x0000 ; next instruction will be written to address 0x0000
            ; (the location of the reset vector)
rjmp main	; set reset vector to point to the main code entry point

main:       ; jump here on reset

; initialize the stack (RAMEND = 0x10FF by default for the ATmega128A)
ldi R16, HIGH(RAMEND)
out SPH, R16
ldi R16, low(RAMEND)
out SPL, R16

; your code starts here...
