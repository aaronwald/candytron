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
	jsr lcd_instruction
	lda #%00001111		; display on, cursor on, blink on
	jsr lcd_instruction
	lda #%00000110		; incremet and shift cursor, dont shift display
	jsr lcd_instruction
	lda #%000000001		; clear
	jsr lcd_instruction

	
	lda #"T"
	jsr print_char
	lda #"e"
	jsr print_char
	lda #"a" 		
	jsr print_char
	lda #"m" 		
	jsr print_char
	lda #" " 		
	jsr print_char
	lda #"W" 		
	jsr print_char
	lda #"a"
	jsr print_char
	lda #"l" 		
	jsr print_char
	lda #"d" 		
	jsr print_char
	lda #"!" 
	jsr print_char
	
loop:
	jmp loop

lcd_instruction:
	sta PORTB
	lda #0                  ; clear RS/RW/E bits
	sta PORTA		
	lda #E 			; set enable bit
	sta PORTA
	lda #0 			; clear RS/RW/E bits
	sta PORTA		
	rts

print_char:
	sta PORTB
	lda #RS 		; RS
	sta PORTA		
	lda #(RS | E)		; set enable bit & RS
	sta PORTA
	lda #RS			; RS 
	sta PORTA		
	rts
	
	.org $fffc
	.word reset
	.word $0000
	
