
.const      RUN_STOP_KEY = $ffe1
.const      CHRIN = $ffe4
.const      CHROUT = $ffd2
.const      PROG_START = $033c
.const      PROG_START2 = $037c
.const      PROG_START3 = $039c

        * = PROG_START

        jsr RUN_STOP_KEY // If Stop/Brk key is pressed set Z flag
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

        jsr RUN_STOP_KEY // If Stop/Brk key is pressed set Z flag
        beq end2          // jump to RTS in Stop/Brk key pressed
        jsr CHRIN        // Load keyboard input in register A
        cmp #$41         // Fill Z flag
        bcc PROG_START2   // Invalid ASCII -> Start from beginning
        cmp #$5a
        bcs PROG_START2

        jsr CHROUT
        and #$0f
end2:   rts

        
        * = PROG_START3

        jsr RUN_STOP_KEY // If Stop/Brk key is pressed set Z flag
        beq end3         // jump to RTS in Stop/Brk key pressed
        jsr CHRIN        // Load keyboard input in register A
        cmp #$30         // Fill Z flag
        bcc PROG_START3  // Invalid ASCII -> Start from beginning
        cmp #$3a
        bcs PROG_START3

        and #$fe
        jsr CHROUT
end3:   rts
        
