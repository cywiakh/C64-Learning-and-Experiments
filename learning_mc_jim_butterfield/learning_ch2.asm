.macro newLine() {
    lda #$0D
    jsr CHROUT
}

.macro boxTextBorder(myLength, myLeftCorner, myRightCorner) {
        lda #myLeftCorner
        jsr CHROUT
        ldx #$00

loopa:  lda #$C3
        jsr CHROUT
        inx
        cpx #myLength
        bne loopa


        lda #myRightCorner
        jsr CHROUT
}

.macro boxTextContent(myText, myLength) {

        lda #$7D
        jsr CHROUT
        ldx #$00

loopa:  lda myText, x
        jsr CHROUT
        inx
        cpx #myLength
        bne loopa


        lda #$7D
        jsr CHROUT
}



.const CHROUT=$ffd2
.const MY_TEXT=$0410

        * = $033C

start:  lda #$48
        jsr CHROUT
        lda #$49
        jsr CHROUT
        newLine()

        ldx #$00
loop:   lda MY_TEXT,x
        jsr CHROUT
        inx
        cpx #$0B
        bne loop
        newLine()


        ldx #$0A
loop5:   lda MY_TEXT,x
        jsr CHROUT
        dex
        cpx #$00
        bne loop5
        lda MY_TEXT, x
        jsr CHROUT
        newLine()

        ldx #$21
loop2:  txa
        jsr CHROUT
        inx
        cpx #$5E
        bne loop2
        ldx #$A1
loop3:  txa
        jsr CHROUT
        inx
        cpx #$FF
        bne loop3
        newLine()

        boxTextBorder($0B, $B0, $AE)
        newLine()
        boxTextContent(MY_TEXT, $0B)
        newLine()
        boxTextBorder($0B, $ED, $BD)
        newLine()

        
        rts

        * = MY_TEXT

        .text "HELLO WORLD"

