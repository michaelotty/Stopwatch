#include P16F84A.INC
__config _XT_OSC  &  _WDT_OFF & _PWRTE_ON

;File Registers used by delay subroutine and the counter
Segment1        EQU     H'0D'
Segment2        EQU     H'0E'
Segment3        EQU     H'0F'
Segment4        EQU     H'10'
DELAY_COUNT1    EQU     H'21'
DELAY_COUNT2    EQU     H'22'
DELAY_COUNT3    EQU     H'23'

ORG h'0'
    bsf     STATUS,5        ;select bank 1
    movlw   B'00000001'     ;set up port B0 as input
    movwf   TRISB
    movlw   B'00010000'     ;set up port A4 as an input
    movwf   TRISA
    bcf     STATUS,5        ;select bank 0
        
loop
    movlw   H'A'
    call    conversion
    movwf   PORTB
    movlw   B'00000001'
    movwf   PORTA
    call    delay2
    clrf    PORTA
    
    movlw   H'A'
    call    conversion
    movwf   PORTB
    movlw   B'00000010'
    movwf   PORTA
    call    delay2
    clrf    PORTA

    movlw   H'A'
    call    conversion
    movwf   PORTB
    movlw   B'00000100'
    movwf   PORTA
    call    delay2
    clrf    PORTA
    
    movlw   H'A'
    call    conversion
    movwf   PORTB
    movlw   B'00001000'
    movwf   PORTA
    call    delay2
    clrf    PORTA

    btfsc   PORTA,4
    goto    loopcount    
    goto    loop
        

loopcount
    btfsc PORTA,4
    goto  loopcount
    ;call    delay2
    movlw   H'A'
    movwf   Segment4
    movlw   H'A'
    movwf   Segment3
    movlw   H'A'
    movwf   Segment2
    movlw   H'A'
    movwf   Segment1
milliloop
    btfsc   PORTA,4
    goto    Stopped
    
test
    btfsc   PORTA, 4
    goto    test
    
    ;call    delay
    call    display         ;Call the function which displays the number on the segments depending on the value of ‘Segment'
    decfsz  Segment4
    goto    milliloop       ;inner loop for the milliseconds
    call    display
    movlw   H'A'            ;reset milliseconds
    movwf   Segment4
    

    
    decfsz  Segment3        ;loop for centiseconds
    goto    milliloop 
    call    display
    movlw   H'A'            ;reset centiseconds
    movwf   Segment3
    

    
    decfsz  Segment2        ;loop for deciseconds
    goto    milliloop
    call    display
    movlw   H'A'            ;reset deciseconds
    movwf   Segment2
    
    
    
    decfsz  Segment1        ;loop for seconds
    goto    milliloop
    movlw   H'A'            ;reset seconds
    movwf   Segment1 
    

    goto    loopcount
    
    

delay2
    movlw   H'34'  ;initialise delay counters
    movwf   DELAY_COUNT1
delay_loop2
    nop
    decfsz  DELAY_COUNT1,F 
    goto    delay_loop2  
    return
    
    
conversion
    addwf   PCL
    nop
    retlw   ~B'11100111'	;9
    retlw   ~B'11111110'	;8
    retlw   ~B'10100010'	;7
    retlw   ~B'01111110'	;6
    retlw   ~B'01110110'	;5
    retlw   ~B'11100100'	;4
    retlw   ~B'11110010'	;3
    retlw   ~B'11011010'	;2
    retlw   ~B'10100000'	;1
    retlw   ~B'10111110'	;0

display
    movfw   Segment1
    call    conversion
    movwf   PORTB
    movlw   B'00000001'
    movwf   PORTA
    call    delay2
    clrf    PORTA

    movfw   Segment2
    call    conversion
    movwf   PORTB
    movlw   B'00000010'
    movwf   PORTA
    call    delay2
    clrf    PORTA
    

    movfw   Segment3
    call    conversion
    movwf   PORTB
    movlw   B'00000100'
    movwf   PORTA
    call    delay2
    clrf    PORTA
    
    movfw   Segment4
    call    conversion
    movwf   PORTB
    movlw   B'00001000'
    movwf   PORTA
    call    delay2
    return
    
Stopped
    btfsc PORTA,4
    goto Stopped
    
    movfw   Segment1
    call    conversion
    movwf   PORTB
    movlw   B'00000001'
    movwf   PORTA
    call    delay2
    clrf    PORTA

    movfw   Segment2
    call    conversion
    movwf   PORTB
    movlw   B'00000010'
    movwf   PORTA
    call    delay2
    clrf    PORTA

    movfw   Segment3
    call    conversion
    movwf   PORTB
    movlw   B'00000100'
    movwf   PORTA
    call    delay2
    clrf    PORTA
    
    movfw   Segment4
    call    conversion
    movwf   PORTB
    movlw   B'00001000'
    movwf   PORTA
    call    delay2
    clrf    PORTA
    btfsc   PORTA,4
    goto test
    
    btfsc   PORTB,0
    goto    loop
    goto    Stopped
    
end
