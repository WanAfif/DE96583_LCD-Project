			#include<p18F4550.inc>

innerloop	set	0x00
outerloop	set	0x01

LCD			set	PORTC
			
			org 0x00
			goto start
			org 0x08
			retfie
			org 0x18
			retfie

;***************************************
;Subroutine for LCD
;***************************************
regCMD		BCF		LCD, 4, A		;RS=0
			BCF		LCD, 5, A		;RW=0
			BSF		LCD, 6, A		;EN=1
			CALL	DELAY
			BCF		LCD, 6, A		;EN=0
			RETURN

regDATA		BSF		LCD, 4, A		;RS=1
			BCF		LCD, 5, A		;RW=0
			BSF		LCD, 6, A		;EN=1
			CALL	DELAY
			BCF		LCD, 6, A		;EN=0
			RETURN

;***************************************
;Subroutine for 0.4sec delay
;***************************************
dup_nop		macro num
			variable i
i = 0
			while i < num
			nop
i += 1
			endw
			endm


DELAY		MOVLW	D'32'			;0.4sec delay subroutine for
			MOVWF	outerloop, A	;20MHz crystal frequency
AGAIN1		MOVLW	D'250'
			MOVWF	innerloop, A
AGAIN2		dup_nop	D'247'
			DECFSZ	innerloop, F, A
			BRA		AGAIN2
			DECFSZ	outerloop, F, A
			BRA		AGAIN1
			NOP
			RETURN

;***************************************
;Display My NAME
;***************************************
AFIF		MOVLW	0x01			;clear screen
			MOVWF	PORTD, A
			CALL	regCMD

			MOVLW	D'32'			;make space
			MOVWF	PORTD, A
			CALL	regDATA

			MOVLW	D'87'			;show "W"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'97'			;show "a"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'110'			;show "n"
			MOVWF	PORTD, A
			CALL	regDATA

			MOVLW	D'32'			;make space
			MOVWF	PORTD, A
			CALL	regDATA

			MOVLW	D'65'			;show "A"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'102'			;show "f"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'105'			;show "i"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'102'			;show "f"
			MOVWF	PORTD, A
			CALL	regDATA

			MOVLW	D'32'			;make space
			MOVWF	PORTD, A
			CALL	regDATA

			MOVLW	D'72'			;show "H"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'105'			;show "i"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'108'			;show "l"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'109'			;show "m"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'105'			;show "i"
			MOVWF	PORTD, A
			CALL	regDATA

			BRA		checkNAME

;***************************************
;Display ID
;***************************************
ID			MOVLW	0x01			;clear screen
			MOVWF	PORTD, A
			CALL	regCMD

			MOVLW	D'32'			;make space
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'32'
			MOVWF	PORTD, A
			CALL	regDATA

			MOVLW	D'68'			;show "D"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'69'			;show "E"
			MOVWF	PORTD, A
			CALL	regDATA

			MOVLW	D'57'			;show "9"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'54'			;show "6"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'53'			;show "5"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'56'			;show "8"
			MOVWF	PORTD, A
			CALL	regDATA
			MOVLW	D'51'			;show "3"
			MOVWF	PORTD, A
			CALL	regDATA

			BRA		checkID

;***************************************
;Display number on KEYPAD
;***************************************
disp0		MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'48'			;show "0"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkZERO

disp1		MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'49'			;show "1"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkONE

disp2		MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'50'			;show "2"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkTWO

disp3		MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'51'			;show "3"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkTHREE

disp4		MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'52'			;show "4"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkFOUR

disp5		MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'53'			;show "5"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkFIVE

disp6		MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'54'			;show "6"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkSIX

disp7		MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'55'			;show "7"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkSEVEN

disp8		MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'56'			;show "8"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkEIGHT

disp9		MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'57'			;show "9"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkNINE

dispSTAR	MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'42'			;show "*"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkSTAR

dispHASH	MOVLW	0xC0			;2nd line
			MOVWF	PORTD, A
			CALL	regCMD
			MOVLW	D'35'			;show "#"
			MOVWF	PORTD, A
			CALL	regDATA
			BRA		checkTAG


;***************************************
;clear LCD Display
;***************************************
Blank		MOVLW	0x01
			MOVWF	PORTD, A
			CALL	regCMD
			RETURN

;***************************************
;KEYPAD setting
;***************************************
outA		BSF		PORTB, 4, A
			BCF		PORTB, 5, A
			BCF		PORTB, 6, A
			BCF		PORTB, 7, A
			RETURN
outB		BCF		PORTB, 4, A
			BSF		PORTB, 5, A
			BCF		PORTB, 6, A
			BCF		PORTB, 7, A
			RETURN
outC		BCF		PORTB, 4, A
			BCF		PORTB, 5, A
			BSF		PORTB, 6, A
			BCF		PORTB, 7, A
			RETURN
outD		BCF		PORTB, 4, A
			BCF		PORTB, 5, A
			BCF		PORTB, 6, A
			BSF		PORTB, 7, A
			RETURN

;***************************************
;My Main Program
;***************************************
start		SETF	TRISA, A
			MOVLW	B'00001111'
			MOVWF	TRISB, A
			CLRF	TRISC, A
			CLRF	TRISD, A

;Configure 2 line and 5*7 matrix*******
			MOVLW	0x38
			MOVWF	PORTD, A
			CALL	regCMD

;Display on with cursor blinking*******
			MOVLW	0x0E
			MOVWF	PORTD, A
			CALL	regCMD

;Clear display*************************
			MOVLW	0x01
			MOVWF	PORTD, A
			CALL	regCMD

;1st line******************************
			MOVLW	0x80
			MOVWF	PORTD, A
			CALL	regCMD

;polling push button*******************
checkNAME	BTFSC	PORTA, 4, A
			BRA		AFIF
			CALL	Blank
checkID		BTFSC	PORTB, 0, A
			BRA		ID
			CALL	Blank

;polling keypad*************************
checkONE	CALL	outA
			BTFSS	PORTB, 1, A
			BRA		checkTWO
			BRA		disp1
checkTWO	CALL	outA
			BTFSS	PORTB, 2, A
			BRA		checkTHREE
			BRA		disp2
checkTHREE	CALL	outA
			BTFSS	PORTB, 3, A
			BRA		checkFOUR
			BRA		disp3
checkFOUR	CALL	outB
			BTFSS	PORTB, 1, A
			BRA		checkFIVE
			BRA		disp4
checkFIVE	CALL	outB
			BTFSS	PORTB, 2, A
			BRA		checkSIX
			BRA		disp5
checkSIX	CALL	outB
			BTFSS	PORTB, 3, A
			BRA		checkSEVEN
			BRA		disp6
checkSEVEN	CALL	outC
			BTFSS	PORTB, 1, A
			BRA		checkEIGHT
			BRA		disp7
checkEIGHT	CALL	outC
			BTFSS	PORTB, 2, A
			BRA		checkNINE
			BRA		disp8
checkNINE	CALL	outC
			BTFSS	PORTB, 3, A
			BRA		checkSTAR
			BRA		disp9
checkSTAR	CALL	outD
			BTFSS	PORTB, 1, A
			BRA		checkZERO
			BRA		dispSTAR
checkZERO	CALL	outD
			BTFSS	PORTB, 2, A
			BRA		checkTAG
			BRA		disp0
checkTAG	CALL	outD
			BTFSS	PORTB, 3, A
			BRA		checkNAME
			BRA		dispHASH
			BRA		checkNAME

			END