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
        sta temp1       // Store Value in RAM

        cmp #$05        // Compare reg A to 5
        bcc lt          // Branch if reg A is less than 5
        bcs gt          // Branch if reg A is greater than 5

lt:     printc($d6)     // print "*"
        printc($32)     // print "2"
        printc($3d)     // print "="
        lda temp1       // retrieve input value
        asl             // Multiply by 2
        jmp outp        // Show result
        
gt:     printc($2f)     // print "/"
        printc($32)     // print "2"
        printc($3d)     // print "="
        lda temp1       // retrieve input value
        lsr             // Divide by 2

outp:   jsr dispc       // Display Result
        printc($0d)     // print <cr>
        jmp start       // Start from Beginning

end:    rts             // Return to calling address


dispc:  ora #$30        // Convert Numeric Value to ascii using mask
        jsr CHROUT      // Output Result
        rts
