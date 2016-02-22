;Michael Otty and Laurabelle Kakulu
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
        
loop                        ;Displays all 0's until the start button is pressed
    movlw   H'A'            ;Move 'A' to the working register
    call    conversion      ;Call the conversion chart using 'A' and return the correct binary number. 'A' corresponds to 0(on the display)
    movwf   PORTB
    movlw   B'00000001'     ;Power the 1st segment.
    movwf   PORTA
    call    delay2          ;Leaves the number displayed on the segment on for longer so numbers are brighter & clearer to see
    clrf    PORTA           ;Stops the next number displaying on the current display
    
    movlw   H'A'
    call    conversion
    movwf   PORTB
    movlw   B'00000010'     ;Power the 2nd segment.
    movwf   PORTA
    call    delay2
    clrf    PORTA

    movlw   H'A'
    call    conversion
    movwf   PORTB
    movlw   B'00000100'     ;Power the 3rd segment.
    movwf   PORTA
    call    delay2
    clrf    PORTA
    
    movlw   H'A'
    call    conversion
    movwf   PORTB
    movlw   B'00001000'     ;Power the 4th segment.
    movwf   PORTA
    call    delay2
    clrf    PORTA

    btfsc   PORTA,4         ;Checks for voltage at A4, if the button is unpressed, the voltage is 0. The next instruction is skipped.
    goto    loopcount       ;Start the stopwatch.
    goto    loop
        

loopcount ;Main loop
    btfsc   PORTA,4         ;Debounce - Makes sure that the use has removed their finger from the button before continuing.
    goto    loopcount

;Moves 'A' to the registers
    movlw   H'A'
    movwf   Segment4
    movlw   H'A'
    movwf   Segment3
    movlw   H'A'
    movwf   Segment2
    movlw   H'A'
    movwf   Segment1
milliloop
    btfsc   PORTA,4         ;Checks for voltage at A4
    goto    Stopped         ;Stops the stopwatch
    
continue ;Label for continuing the stopwatch after it has been stopped
    btfsc   PORTA, 4        ;Debounce
    goto    continue
    
    ;call    delay
    call    display         ;Call the function which displays the number on the segments depending on the value of ‘Segment'
    decfsz  Segment4
    goto    milliloop       ;inner loop for the milliseconds.
    call    display
    movlw   H'A'            ;reset milliseconds
    movwf   Segment4
    
;After 10 loops(10 milliseconds), The value of sement 3 decrements by 1.
    
    decfsz  Segment3        ;loop for centiseconds
    goto    milliloop 
    call    display
    movlw   H'A'            ;reset centiseconds
    movwf   Segment3
    
;After 100 loops(100 milliseconds), The value of sement 2 decrements by 1.
    
    decfsz  Segment2        ;loop for deciseconds
    goto    milliloop
    call    display
    movlw   H'A'            ;reset deciseconds
    movwf   Segment2
    
;After 1000 loops(1 second), The value of sement 1 decrements by 1.    
    
    decfsz  Segment1        ;loop for seconds
    goto    milliloop
    movlw   H'A'            ;reset seconds
    movwf   Segment1 
    
    goto    loopcount
    
    

delay2 ;delay inbetween powering segments
    movlw   H'34'           ;initialise delay counters
    movwf   DELAY_COUNT1
delay_loop2
    nop 
    decfsz  DELAY_COUNT1,F 
    goto    delay_loop2  
    return
    
    
conversion ;Conversion chart which converts the hexadecimal number in 'Segment' to a binary value corresponding to the 7-segment number.
    addwf   PCL
    nop ;nop because 'milliloop' skips 0
    retlw   ~B'11100111'	;9
    retlw   ~B'11111110'	;8
    retlw   ~B'10100010'	;7
    retlw   ~B'01111110'	;6
    retlw   ~B'01110110'	;5
    retlw   ~B'11100100'	;4
    retlw   ~B'11110010'	;3
    retlw   ~B'11011010'	;2-
    retlw   ~B'10100000'	;1
    retlw   ~B'10111110'	;0

display ;For displaying the correct numbers depending on the value of 'Segment'
    movfw   Segment1        ;Get value 
    call    conversion      ;Convert to correct binary number 
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
    
Stopped                     ;Loop for freezing the display. The same as 'Display' but it waits for the user to press the button again before returning.
    btfsc   PORTA,4
    goto    Stopped         ;Button debounce
    
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
    goto    continue
    
    btfsc   PORTB,0         ;Checks for voltage at A0 
    goto    loop            ;Restarts the stopwatch
    goto    Stopped
    
end
