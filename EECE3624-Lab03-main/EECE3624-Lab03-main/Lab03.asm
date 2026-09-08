/**************************************************************************
 *     File: Lab03.asm
 * Lab Name: Lab 03
 *   Author: Drew Dimino
 *  Created: 09/08/2026
 *
 * This program simulates reading sensor data and doing operations on them.
 * It uses memory locations for sensors and result writes.
 * We hope to learn more about branching in assembly.
 * This is an additional line I added for fun I guess
 *************************************************************************/

/************************************************************************
 * NOTE!  To populate the sensor data to memory, follow these steps!
 * 1) Set breakpoint on 1st instruction RJMP
 * 2) Set the stimulus file
 *    - Debug->Set Stimufile.  Select Lab03.stim
 *    - This only needs to be done ONCE (will save in project file)
 *    - Should be in your Project file from the Repo, but do once to be sure.
 * 3) Execute stimulus file
 *    - Debug->Execute Stimufile
 *    - This needs to be run EVERY TIME you restart a debug session.  :-(
 * 4) single step code
 * 5) Check that data IRAM at 0x0100 has changed "61 97"
 * 
 * Sensor1 Located at 0x0100 (preset to 0x61)
 * Sensor2 Located at 0x0101 (preset to 0x97)
 * 
 * NOTE:  For testing, you can modify these after loading them
 * to make sure all of your branches work properly
 ***********************************************************************/
.equ THRESHOLD	= 0x90	; Constant
.def Sensor1	= R20	; R20 nickname
.def Sensor2	= R21	; R21 nickname


.org 0x0000 ; next instruction will be written to address 0x0000
            ; (the location of the reset vector)
RJMP main	; set reset vector to point to the main code entry point

main:       ; jump here on reset

	; initialize the stack (RAMEND = 0x10FF by default for the ATmega128A)
	LDI R16, HIGH(RAMEND)
	OUT SPH, R16
	LDI R16, low(RAMEND)
	OUT SPL, R16

    ;----------------------------------
    ; student-written code begins here    

	LDI YH, high(0x0100)	; set High Y to the MSBs of address 0x0100
	LDI YL, low(0x0100)		; set Low Y to the LSBs of address 0x0100

	LD Sensor1, Y+	; load byte stored at the address stored in Y (0x0100) to R20. Post-increment.
	LD Sensor2, Y	; load byte stored at the address stored in Y (0x0101) to R21.

	LDI YL, 0x10	; set Y to address 0x0110

	CPI Sensor1, THRESHOLD	; compare value R20, 0x90
	BRSH s1GoE				; branch if R20 >= 0x90

	LDI R17, 0x50	; store 0x50 to address 0x0110 if R20 < 0x90. Post-increment.
	RJMP storeS1	; jump to Sensor1 storage

s1GoE:
	
	LDI R17, 0x46	; store 0x46 to address 0x0110 (branched). Post-increment.	

storeS1:

	ST Y+, R17	; store prior comparison result

	ST Y+, Sensor1	; store Sensor1 data to address 0x0111. Post-increment.

	CPI Sensor2, THRESHOLD	; compare value R21, 0x90
	BRLT s2L

	LDI R17, 's'	; store 's' to address 0x0112 if R21 >= 0x90. Post-increment.	
	RJMP sC			; jump to Sensor comparison

s2L:
	
	LDI R17, 'i'	; store 'i' to address 0x0112 if R21 < 0x90. Post-increment.

sC:
	
	ST Y+, R17	; store prior comparison result

	CP Sensor1, Sensor2		; compare value stored in R20, R21
	BRNE sNE				; branch if values in R20, R21 are not equal.

	LDI R17, 108	; store 108 to address 0x0113 if R20, R21 are equal
	RJMP end		; end program

sNE:

	LDI R17, 115	; store 115 to address 0x0113 if R20, R21 not equal
	RJMP end		; end program

end:
	
	ST Y, R17	; store prior comparison result

	NOP	; It's over, Anakin