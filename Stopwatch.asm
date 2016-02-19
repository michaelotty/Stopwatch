#include P16F84A.INC
    __config _XT_OSC  &  _WDT_OFF & _PWRTE_ON
;File Registers used by delay subroutine
Segment1  EQU H'0D'
Segment2  EQU H'0E'
Segment3  EQU H'0F'
Segment4  EQU H'10'
DELAY_COUNT1            EQU     H'21'
DELAY_COUNT2            EQU     H'22'
DELAY_COUNT3            EQU     H'23'
ORG   h'0'
    bsf     STATUS,5      ;select bank 1
    movlw    B'00000001'   ;set up port B0 as input
    movwf    TRISB
    movlw    B'00010000'   ;set up port A4 as an input
    movwf    TRISA
    bcf     STATUS,5      ;select bank 0
        
loop

    movlw       H'01'
    call conversion
    movwf    PORTB
    movlw       B'00000001'
    movwf    PORTA
    call delay2
    movlw       B'00000000'
    movwf    PORTA
    

    movlw       H'02'
    call conversion
    movwf    PORTB
    movlw       B'00000010'
    movwf    PORTA
    call delay2
    movlw       B'00000000'
    movwf    PORTA
    

    movlw       H'03'
    call conversion
    movwf    PORTB
    movlw       B'00000100'
    movwf    PORTA
    call delay2
    movlw       B'00000000'
    movwf    PORTA
    

    movlw       H'04'
    call conversion
    movwf    PORTB
    movlw       B'00001000'
    movwf    PORTA
    call delay2
    movlw       B'00000000'
    movwf    PORTA

;    BTFSC    PORTA,4
;    goto    loopcount    
    goto    loop
        

loopcount
    movlw H'10'
    movwf Segment4
    movlw H'10'
    movwf Segment3
    movlw H'10'
    movwf Segment2
    movlw H'10'
    movwf Segment1
milliloop
    call Display ;Call the function which displays the number on the segments depending on the value of ‘Segment'
    decfsz Segment4
    call delay
    goto milliloop ;inner loop for the milliseconds
    call Display
    decfsz Segment3
    goto milliloop 
    call Display
    decfsz Segment2
    goto milliloop
    call Display
    decfsz Segment1
    goto milliloop
    goto loopcount
    
    
; program delay
delay
    movlw           H'AA'
      ;initialise delay counters
    movwf           DELAY_COUNT1
    movlw           H'18'
    movwf           DELAY_COUNT2
    movlw           H'03'
    movwf           DELAY_COUNT3
delay_loop1
    decfsz          DELAY_COUNT1,F  ; innermost loop
    goto            delay_loop1      ; decrements and loops until delay_count1=0
    decfsz          DELAY_COUNT2,F  ; middle loop
    goto            delay_loop1
    decfsz          DELAY_COUNT3,F  ; outer loop
    goto            delay_loop1
    return




delay2
    movlw           H'FF'
      ;initialise delay counters
    movwf           DELAY_COUNT1
    movlw	    H'06'
    movwf	    DELAY_COUNT2
delay_loop2
    decfsz          DELAY_COUNT1,F  ; innermost loop
    goto            delay_loop2      ; decrements and loops until delay_count1=0
    decfsz	    DELAY_COUNT2,F
    goto	    delay_loop2
    return
    
conversion
    addwf   PCL
    retlw   ~B'10111110'    ;0
    retlw   ~B'10100000'    ;1
    retlw   ~B'11011010'    ;2
    retlw   ~B'11110010'    ;3
    retlw   ~B'11100100'    ;4
    retlw   ~B'01110110'    ;5
    retlw   ~B'01111110'    ;6
    retlw   ~B'10100010'    ;7
    retlw   ~B'11111110'    ;8
    retlw   ~B'11100111'    ;9

Display
    movf B'00001111',PORTA
    movlw Segment1
    call conversion
    movwf PORTB

    ;movf B'00000010',PORTA
    movlw Segment2
    call conversion
    movwf PORTB

   ; movf B'00000100',PORTA
    movlw Segment3
    call conversion
    movwf PORTB

   ; movf B'00001000',PORTA
    movlw Segment4
    call conversion
    movwf PORTB
    Return
end
