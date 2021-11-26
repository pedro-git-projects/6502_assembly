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
