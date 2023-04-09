PORTB = $6000
PORTA = $6001
DDRB  = $6002			; data direction A
DDRA  = $6003			; data direction B
E  = %10000000
RW = %01000000
RS = %00100000
	
	.org $8000

reset:	
  	lda #%11111111  	; enable for output
	sta DDRB

	lda #%11100000 		; set top 3 pints on port a to output
	sta DDRA

	
	lda #%00111000		; set 8 bit mode; 2-line display; 5x8 font
	sta PORTB
	lda #0                  ; clear RS/RW/E bits
	sta PORTA		
	lda #E 			; set enable bit
	sta PORTA
	lda #0                  ; clear RS/RW/E bits	
	sta PORTA		

	
	lda #%00001111		; display on, cursor on, blink on
	sta PORTB
	lda #0                  ; clear RS/RW/E bits
	sta PORTA		
	lda #E 			; set enable bit
	sta PORTA
	lda #0 			; clear RS/RW/E bits
	sta PORTA		

	lda #%00000110		; incremet and shift cursor, dont shift display
	sta PORTB
	lda #0                  ; clear RS/RW/E bits
	sta PORTA		
	lda #E 			; set enable bit
	sta PORTA
	lda #0 			; clear RS/RW/E bits
	sta PORTA		

	lda #"H" 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		

	lda #"e" 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		

	lda #"l" 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		

	lda #"l" 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		

	lda #"o" 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		
	
	lda #"," 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		
	
	lda #" " 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		

	lda #"w" 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		
	
	lda #"o" 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		

	lda #"r" 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		

	lda #"l" 		
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		

	lda #"d" 
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		

	lda #"!" 
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		

	
loop:
	jmp loop
	
	.org $fffc
	.word reset
	.word $0000
	
