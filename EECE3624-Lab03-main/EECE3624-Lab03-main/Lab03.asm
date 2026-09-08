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
