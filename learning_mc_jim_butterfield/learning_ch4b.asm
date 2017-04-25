.const      RUN_STOP_KEY = $ffe1
.const      CHRIN = $ffe4
.const      CHROUT = $ffd2
.const      PROG_START = $033c
.const      PROG_START2 = $0352

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
end:    rts 

        * = PROG_START2

start:	jsr getin       // Call subroutine to get user input
        sta $03c0       // Store Value in RAM
        lda #$2d        // Prepare "-" ascii code
        jsr CHROUT      // Output "-"
        jsr getin       // Call subroutine to get user input
        sta $03c1       // Store Value in RAM
        lda #$3d        // Prepare "=" ascii code
        jsr CHROUT      // Output "="
        lda $03c0       // Retrieve value from memory
        sec             // Clear C flag
        sbc $03c1       // Perform subtraction
        jsr dispc       // Display Result

        lda #$0d        // Prepare <cr> ascii code
        jsr CHROUT      // Output <cr>
        rts


dispc:  ora #$30        // Convert Numeric Value to ascii using mask
        jsr CHROUT      // Output Result
        rts             // Return to calling address
