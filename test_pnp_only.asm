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
;	test pnp bjt
; by mn@d23.synlabs.com.ar
;	2012/11/12
;
; uc [ pic16F84A ]
;	RB0 output 9/10s ON 1/10 OFF cycle
;

LIST 	p=16F84a
RADIX	hex
__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
#INCLUDE <p16f84a.inc>

;----------------------------------------------------------------------
;	cpu equates (memory map)

portB		equ	0x06							; (p. 10 defines port address)
nCount	equ	0x0d
mCount	equ	0x0e

;----------------------------------------------------------------------

;----------------------------------------------------------------------
;	main

	org	0x000

start		movlw	0x00						; load W with 0x00 make port B output (p. 45)
	tris	portB									; copy W tristate, port B outputs (p. 58)
	movlw 0x00									;
	movwf portB									; set all lines high
	call	pause									; delay by subroutine
	call	pause		
	call	pause
	call	pause
	call	pause									; five pause executions equals ~ 1 second

blink
	movlw 0x01									; RB1 1 1800ms 0 200ms
	movwf portB
	call	pause		
	call	pause
	call	pause
	call	pause
	call	pause
	call	pause		
	call	pause
	call	pause
	call	pause
	clrf	portB
	call	pause									; inf cycle
goto blink

;----------------------------------------------------------------------
;	subroutines

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
