#include P16F84A.INC
    __config _XT_OSC  &  _WDT_OFF & _PWRTE_ON
;File Registers used by delay subroutine
DELAY_COUNT1        	EQU 	H'21'
DELAY_COUNT2        	EQU 	H'22'
DELAY_COUNT3        	EQU 	H'23'
ORG   h'0'
    bsf 	STATUS,5  	;select bank 1
    movlw	B'00000001'   ;set up port B0 as input
    movwf	TRISB
    movlw	B'00010000'   ;set up port A4 as an input
    movwf	TRISA
    bcf 	STATUS,5  	;select bank 0
    	
loop
    movlw       B'00001111'
    movwf	PORTA
    movlw	~B'10111110'
    movwf	PORTB
;    call	conversion

;    BTFSC	PORTA,4
;    goto	loopcount	
    goto	loop
	    
;loop0    
;    movlw ~B'00001100'
;    movwf PORTB
;    call delay2
;    BTFSC PORTA,4
;    return 
;    goto loop0
;    
;loop1    
;    movlw ~B'00001100'
;    movwf PORTB
;    call delay2
;    BTFSC PORTA,4
;    return 
;    goto loop1
;
;loop2
;    movlw  ~B'11011010'
;    movwf PORTB
;    call delay2
;    BTFSC PORTA,4
;    return
;    goto loop2
;
;loop3
;    movlw   ~B'11110010' 
;    movwf PORTB
;    call delay2
;    BTFSC PORTA,4
;    return
;    goto loop3
;
;loop4
;    movlw   ~B'11100100' 
;    movwf PORTB
;    call delay2
;    BTFSC PORTA,4
;    return
;    goto loop4
;
;loop5
;    movlw	~B'01110110' 
;    movwf	PORTB
;    call	delay2
;    BTFSC	PORTA,4
;    return
;    goto	loop5
;
;loop6
;    movlw	~B'01111110'  
;    movwf	PORTB
;    call	delay2
;    BTFSC	PORTA,4
;    return
;    goto	loop6
;
;loop7
;    movlw   ~B'10100010' 
;    movwf PORTB
;    call delay2
;    BTFSC PORTA,4
;    return
;    goto loop7
;
;loop8
;    movlw   ~B'11111110'
;    movwf PORTB
;    call delay2
;    BTFSC PORTA,4
;    return
;    goto loop8
;
;loop9
;    movlw   ~B'11100111'
;    movwf PORTB
;    call delay2
;    BTFSC PORTA,4
;    return
;    goto loop9
;
;
;    
;loopcount
;    movlw B'00000001'
;    movwf	PORTA
;    call delayseconds
;    movlw   ~B'01000000'   ;0
;    movwf   PORTB
;    movlw B'00000010'
;    movwf   PORTA
;    call delay01seconds
;    movlw B'01000000'
;    movlw   PORTB
;    movlw B'00000100'
;    movwf   PORTA
;        
;;	BTFSC PORTA,4
;;	call loop0
;;	BTFSC PORTB,0
;;	call loopcount
;    call delayseconds
;;	BTFSC PORTA,4
;;	call loop0
;;	BTFSC PORTB,0
;;	call loopcount
;	
;    call delayseconds
;    movlw   ~B'00001100'   ;1
;    movwf   PORTB
;;	BTFSC PORTA,4
;;	call loop1
;;	BTFSC PORTB,0
;;	call loopcount
;    call delayseconds
;;	BTFSC PORTA,4
;;	call loop1
;;	BTFSC PORTB,0
;;	call loopcount
;	
;    call delayseconds
;    movlw   ~B'11011010'   ;2
;    movwf   PORTB
;;	BTFSC PORTA,4
;;	call loop2
;;	BTFSC PORTB,0
;;	call loopcount
;    call delayseconds
;;	BTFSC PORTA,4
;;	call loop2
;;	BTFSC PORTB,0
;;	call loopcount
;	
;    call delayseconds
;    movlw   ~B'11110010'  ;3
;    movwf   PORTB
;;	BTFSC PORTA,4
;;	call loop3
;;	BTFSC PORTB,0
;;	call loopcount
;    call delayseconds
;;	BTFSC PORTA,4
;;	call loop3
;;	BTFSC PORTB,0
;;	call loopcount
;	
;    call delayseconds
;    movlw   ~B'11100100'   ;4
;    movwf   PORTB
;;	BTFSC PORTA,4
;;	call loop4
;;	BTFSC PORTB,0
;;	call loopcount
;    call delayseconds
;;	BTFSC PORTA,4
;;	call loop4
;;	BTFSC PORTB,0
;;	call loopcount
;	
;    call delayseconds
;    movlw   ~B'01110110'  ;5
;    movwf   PORTB
;;	BTFSC PORTA,4
;;	call loop5
;;	BTFSC PORTB,0
;;	call loopcount
;    call delayseconds
;;	BTFSC PORTA,4
;;	call loop5
;;	BTFSC PORTB,0
;;	call loopcount
;	
;    call delayseconds
;    movlw   ~B'01111110'   ;6
;    movwf   PORTB
;;	BTFSC PORTA,4
;;	call loop6
;;	BTFSC PORTB,0
;;	call loopcount
;    call delayseconds
;;	BTFSC PORTA,4
;;	call loop6
;;	BTFSC PORTB,0
;;	call loopcount
;	
;    call delayseconds
;    movlw   ~B'10100010'  ;7
;    movwf   PORTB
;;	BTFSC PORTA,4
;;	call loop7
;;	BTFSC PORTB,0
;;	call loopcount
;    call delayseconds
;;	BTFSC PORTA,4
;;	call loop7
;;	BTFSC PORTB,0
;;	call loopcount
;	
;    call delayseconds
;    movlw   ~B'11111110' ;8
;    movwf   PORTB
;;	BTFSC PORTA,4
;;	call loop8
;;	BTFSC PORTB,0
;;	call loopcount
;    call delayseconds
;;	BTFSC PORTA,4
;;	call loop8
;;	BTFSC PORTB,0
;;	call loopcount
;	
;    call delayseconds
;    movlw   ~B'11100111'  ;9
;    movwf   PORTB
;;	BTFSC PORTA,4
;;	call loop9
;;	BTFSC PORTB,0
;;	call loopcount
;    call delayseconds
;;	BTFSC PORTA,4
;;	call loop9
;;	BTFSC PORTB,0
;;	call loopcount
;	
;    goto loopcount
;    
;    
;; program delay
;delayseconds
;    movlw       	H'AA'
;  	;initialise delay counters
;    movwf       	DELAY_COUNT1
;    movlw       	H'18'
;    movwf       	DELAY_COUNT2
;    movlw       	H'03'
;    movwf       	DELAY_COUNT3
;delay_loop1
;    decfsz      	DELAY_COUNT1,F  ; innermost loop
;    goto        	delay_loop1  	; decrements and loops until delay_count1=0
;    decfsz      	DELAY_COUNT2,F  ; middle loop
;    goto        	delay_loop1
;    decfsz      	DELAY_COUNT3,F  ; outer loop
;    goto        	delay_loop1
;    return
;
;delay01seconds
;    movlw       	H'AA'
;  	;initialise delay counters
;    movwf       	DELAY_COUNT1
;    movlw       	H'18'
;    movwf       	DELAY_COUNT2
;    movlw       	H'03'
;    movwf       	DELAY_COUNT3
;delay_loop01
;    decfsz      	DELAY_COUNT1,F  ; innermost loop
;    goto        	delay_loop01  	; decrements and loops until delay_count1=0
;    decfsz      	DELAY_COUNT2,F  ; middle loop
;    goto        	delay_loop01
;    decfsz      	DELAY_COUNT3,F  ; outer loop
;    goto        	delay_loop01
;    return
;
;delay001seconds
;    movlw       	H'AA'
;  	;initialise delay counters
;    movwf       	DELAY_COUNT1
;    movlw       	H'18'
;    movwf       	DELAY_COUNT2
;    movlw       	H'03'
;    movwf       	DELAY_COUNT3
;delay_loop001
;    decfsz      	DELAY_COUNT1,F  ; innermost loop
;    goto        	delay_loop001  	; decrements and loops until delay_count1=0
;    decfsz      	DELAY_COUNT2,F  ; middle loop
;    goto        	delay_loop001
;    decfsz      	DELAY_COUNT3,F  ; outer loop
;    goto        	delay_loop001
;    return
;
;
;delay0001seconds
;    movlw       	H'AA'
;  	;initialise delay counters
;    movwf       	DELAY_COUNT1
;    movlw       	H'18'
;    movwf       	DELAY_COUNT2
;    movlw       	H'03'
;    movwf       	DELAY_COUNT3
;delay_loop0001
;    decfsz      	DELAY_COUNT1,F  ; innermost loop
;    goto        	delay_loop0001  	; decrements and loops until delay_count1=0
;    decfsz      	DELAY_COUNT2,F  ; middle loop
;    goto        	delay_loop0001
;    decfsz      	DELAY_COUNT3,F  ; outer loop
;    goto        	delay_loop0001
;    return
;
;delay2
;    movlw       	H'08'
;  	;initialise delay counters
;    movwf       	DELAY_COUNT1
;    movlw       	H'18'
;    movwf       	DELAY_COUNT2
;    movlw       	H'03'
;    movwf       	DELAY_COUNT3
;delay_loop2
;    decfsz      	DELAY_COUNT1,F  ; innermost loop
;    goto        	delay_loop2  	; decrements and loops until delay_count1=0
;    decfsz      	DELAY_COUNT2,F  ; middle loop
;    goto        	delay_loop2
;    decfsz      	DELAY_COUNT3,F  ; outer loop
;    goto        	delay_loop2
;    return
    
conversion
    addwf   PCL
    retlw   ~B'10111110'    ;0
    retlw   ~B'00110000'    ;1
    retlw   ~B'11011010'    ;2
    retlw   ~B'11110010'    ;3
    retlw   ~B'11100100'    ;4
    retlw   ~B'01110110'    ;5
    retlw   ~B'01111110'    ;6
    retlw   ~B'10100010'    ;7
    retlw   ~B'11111110'    ;8
    retlw   ~B'11100111'    ;9
    retlw   ~B'11101110'    ;A
end
