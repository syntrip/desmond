;
; SYNTRIPSISTEMASSYNTRIPSISTEMASSYNTRIPSISTEMASSYNTRIPSISTEMASSYNTRIPSISTEMASSYN
; YN         MA    TR     T          PS    MASSYNTR          SY    P          NT
; N    SI     S    RI     E    YN     I    ASSYNTRI    TE     N    S    MA     R
; T    IS     S    IP     M    NT     S    SSYNTRIP    EM     T    I    ASS    I
; R    STEMASSY    PS     A    TR     T    SYNTRIPS    MASSYNTR    S    SSY    P
; IP        SYNT          S    RI     E           I    ASSYNTRIPSIST          PS
; PSISTEM     TRIPSIS     S    IP     M    NTRIPSIS    SSYNTRIP    E    YNTRIPSI
; S    MA     R    ST     Y    PS     A    TR     T    SYNTRIPS    M    NTRIPSIS
; I    AS     I    TE     N    SI     S    RI     E    YNTRIPSI    A    TRIPSIST
; S    SS     P    EM     T    IS     S    IP     M    NTRIPSIS    S    RIPSISTE
; T    SY     S    MA     R    ST     Y    PS     A    TRIPSIST    S    IPSISTEM
; E    YN     I    AS     I    TE     N    SI     S    RIPSISTE    Y    PSISTEMA
; MA         IST         IP    EM     TR         SS    IPSISTEM    N    SISTEMAS
; ASSYNTRIPSISTEMASSYNTRIPSISTEMASSYNTRIPSISTEMASSYNTRIPSISTEMASSYNTRIPSISTEMASS
;
;	brother desmond proyect
;	raNdoM brotha signature generator
; by mn@d23.synlabs.com.ar
;	2012/11/13
;
; uc [ pic16F84A ]
;	RB0-RB3 output 
; RB0 <shift>
; RB1 m
; RB2 n
; RB3 <enter>
;

LIST 	p=16F84a
RADIX	hex
__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
#INCLUDE <p16f84a.inc>

;----------------------------------------------------------------------
; constants
;row_size		equ .90
row_size		equ .03
column_size	equ .60

;	cpu equates (memory map)

portB		equ	0x06							; (p. 10 defines port address)

countR	equ	0x0c							; row count
countC	equ	0x0d							; column count
key			equ	0x0e							;

nCount	equ	0x0f							; delay inner count
mCount	equ	0xa0							; delay outter count

;----------------------------------------------------------------------

;----------------------------------------------------------------------
;	main

	org	0x000

start		movlw	0x00						; load W with 0x00 make port B output (p. 45)
	tris	portB									; copy W tristate, port B outputs (p. 58)
	clrf	portB									; clear all lines low
	movlw	0x01
	movwf key										; initialice key
	movlw	row_size
	movwf countR									; initialice countR

	call	pause									; delay by subroutine
	call	pause		
	call	pause
	call	pause
	call	pause									; five pause executions equals ~ 1 second

newRow
	movlw	column_size
	movwf countC									; initialice countC

newColumn
	call press_key
	decfsz countC, f
	goto newColumn
	call press_enter
	decfsz countR, f
	goto newRow
	goto stop

stop	goto	stop

;----------------------------------------------------------------------
;	subroutines

press_key
	movfw key
	xorlw 1
	bz press_m									; btfsc STATUS, Z ; goto LABEL1 ; If SWITCH = CASE1, jump to LABEL1
	movfw key
	xorlw 2
	bz press_n
	movfw key
	xorlw 3
	bz press_shift_m
	movfw key
	xorlw 4
	bz press_shift_n

press_m
	incf key, f
	movlw 0x02									; [m] RB1 1 250ms 0 1000ms
goto press

press_n
	incf key, f
	movlw 0x04									; [n] RB2 1 250ms 0 1000ms
goto press

press_shift_m
	incf key, f
	movlw 0x01
	movwf portB
	call pause50ms
	movlw 0x03									; [M] RB0+RB1 1 250ms 0 1000ms
goto press

press_shift_n
	movlw 0x01
	movwf key
	movlw 0x01
	movwf portB
	call pause50ms
	movlw 0x05									; [N] RB0+RB2 1 250ms 0 1000ms
goto press

press
	movwf portB
	call	pause50ms
	call	pause10ms
	clrf	portB
	call	pause50ms						;
	call	pause50ms						;
return


press_enter
	movlw 0x08									; [enter] RB3 1 250ms 0 1000ms
	movwf portB
	call	pause		
	clrf	portB
	call	pause1000ms
	call	pause1000ms
	call	pause1000ms
	call	pause1000ms
	call	pause1000ms						;
return

pause1000ms
	call	pause
	call	pause
	call	pause
	call	pause									;
return

; pause ~10ms
pause10ms	movlw	.10						; set w = 10 decimal
	movwf		mCount							; mCount = w
loadN10	movlw	0xff						; set w = 255 decimal
	movwf		nCount							; nCount = w
decN10		decfsz	nCount, f		; nCount--
	goto		decN10							; if nCount != 0 then repeat nCount--
	decfsz	mCount, f						; else decrement Count
	goto		loadN10							; if mCount != 0 then 
															;   reload nCount to 255 and decrement
	return											; else exit subroutine

; pause ~50ms
pause50ms	movlw	.50						; set w = 50 decimal
	movwf		mCount							; mCount = w
loadN50	movlw	0xff						; set w = 255 decimal
	movwf		nCount							; nCount = w
decN50		decfsz	nCount, f		; nCount--
	goto		decN50							; if nCount != 0 then repeat nCount--
	decfsz	mCount, f						; else decrement Count
	goto		loadN50							; if mCount != 0 then 
															;   reload nCount to 255 and decrement
	return											; else exit subroutine

; pause ~100ms
pause100ms	movlw	.100					; set w = 100 decimal
	movwf		mCount							; mCount = w
loadN100	movlw	0xff					; set w = 255 decimal
	movwf		nCount							; nCount = w
decN100		decfsz	nCount, f		; nCount--
	goto		decN100							; if nCount != 0 then repeat nCount--
	decfsz	mCount, f						; else decrement Count
	goto		loadN100						; if mCount != 0 then 
															;   reload nCount to 255 and decrement
	return											; else exit subroutine

; pause ~250ms
pause			movlw	0xff					; set w = 255 decimal
	movwf		mCount							; mCount = w
loadN			movlw	0xff					; set w = 255 decimal
	movwf		nCount							; nCount = w
decN			decfsz	nCount, f		; nCount--
	goto		decN								; if nCount != 0 then repeat nCount--
	decfsz	mCount, f						; else decrement Count
	goto		loadN								; if mCount != 0 then 
															;   reload nCount to 255 and decrement
	return											; else exit subroutine

end
