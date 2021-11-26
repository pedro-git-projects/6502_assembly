	processor 6502
	
	seg code
	org $F000    ; Define the code origin at $F000

; Labels are indented to the left  
; The label start is at $F000
Start:
	sei        ; Disable interrupts
	cld        ; Disable the BCD decimal math mode
	ldx #$FF   ; Loads the X register with #$FF 
	txs 	   ; Transfer the X register to the (S)tack pointer  
	; this forces the stack pointer to point to the end of the memory 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the Page zero region ($00 to $FF) 									   ;
; That is, the entrire RAM and the whole TIA registers     					   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	lda #0    ; A = 0
	ldx #$FF  ; X = #$FF
	sta $FF   ; Making sure $FF is zeroed before the loop starts
MemLoop: 
	dex 		; X--
	sta $0,X    ; Store the value of A inside memory address $0 + X
	bne MemLoop ; X starts with #$FF while X is not loaded with 0, we branch back to MemLoop
				; Another way to see this is: Loop until the z-flag is set

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
; Fill the ROM size util it reaches 4KB 													;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	org $FFFC
	.word Start 		; Atari 2600 expect four bytes at the end of the cartridge
	.word Start			; We can generate two of those bytes with the instruction .word
						; The value of the two bytes should be that of the beggining of the cartrige
						; We pass that value using our defined label: Start this resets the vector at $FFFC
						; The other word is the interrupt vector, that will bel at $FFFE (unused int he VCS)
	
