.const      RUN_STOP_KEY = $ffe1
.const      CHRIN = $ffe4
.const      CHROUT = $ffd2
.const      PROG_START = $033c
.const      PROG_START2 = $0352

.const      temp1 = $03c0

.macro printc(char) {
    lda #char
    jsr CHROUT

}

        * = PROG_START

getin:  jsr RUN_STOP_KEY // If Stop/Brk key is pressed set Z flag
        beq end          // jump to RTS in Stop/Brk key pressed
        jsr CHRIN        // Load keyboard input in register A
        cmp #$30         // Fill Z flag
        bcc PROG_START   // Invalid ASCII -> Start from beginning
        cmp #$3a
        bcs PROG_START

        jsr CHROUT
        and #$0f
        rts 

        * = PROG_START2

start:	jsr getin       // Call subroutine to get user input
        sta temp1       // Assign reg A to temp1

        printc($20)     // Output <space>
        printc($2d)     // Output "-"
        printc($20)     // Output <space>

        lda temp1       // Load temp1 into reg A 
        clc             // Clear Carry Flag
        lsr             // Shift Right
        bcc even        // Branch Carry Flag Clear
        bcs odd         // Brach Carry Flag Clear


even:   printc($45)     // Output "E"
        printc($56)     // Output "V"
        printc($45)     // Output "E"
        printc($4e)     // Output "N"
        jmp end         // Jump to next Instruction

odd:    printc($4f)     // Output "O"
        printc($44)     // Output "D"
        printc($44)     // Output "D"

end:    printc($0d)     // Output <cr>
        jmp start       // Go Back to Beginning
        rts             // Return to calling address


dispc:  ora #$30        // Convert Numeric Value to ascii using mask
        jsr CHROUT      // Output Result
        rts
