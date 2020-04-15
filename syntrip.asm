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
;	hello world
; by mn@d23.synlabs.com.ar
;	2012/11/12
;
; uc [ pic16F84A ]
;	RB0-RB7 output 1/5s ON 4/5 OFF sequential sweep/cycle
;

LIST 	p=16F84a
RADIX	hex
__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
#INCLUDE <p16f84a.inc>

;----------------------------------------------------------------------
;	cpu equates (memory map)

portB		equ	0x06							; (p. 10 defines port address)
count		equ	0x0c
nCount	equ	0x0d
mCount	equ	0x0e

;----------------------------------------------------------------------

;----------------------------------------------------------------------
;	main

	org	0x000

start		movlw	0x00						; load W with 0x00 make port B output (p. 45)
	tris	portB									; copy W tristate, port B outputs (p. 58)
	clrf	portB									; clear all lines low
	clrf	count									; initialize counter to 0
get_cnt	movf	count, w				; move count to W
	movwf	portB									; move W to port B
	call	pause									; delay by subroutine
	call	pause		
	call	pause
	call	pause
	call	pause									; five pause executions equals ~ 1 second

	movlw 0x01									; [s] RB0 1 200ms 0 800ms
	movwf portB
	call	pause		
	clrf	portB
	call	pause
	call	pause
	call	pause
	call	pause									; end first character

	movlw 0x02									; [y] RB1 1 200ms 0 800ms
	movwf portB
	call	pause		
	clrf	portB
	call	pause
	call	pause
	call	pause
	call	pause									; end 2nd character

	movlw 0x04									; [n] RB2 1 200ms 0 800ms
	movwf portB
	call	pause		
	clrf	portB
	call	pause
	call	pause
	call	pause
	call	pause									; end 3rd character

	movlw 0x08									; [t] RB3 1 200ms 0 800ms
	movwf portB
	call	pause		
	clrf	portB
	call	pause
	call	pause
	call	pause
	call	pause									; end 4th character

	goto	break									; XXX test break jump

	movlw 0x10									; [r] RB4 1 200ms 0 800ms
	movwf portB
	call	pause		
	clrf	portB
	call	pause
	call	pause
	call	pause
	call	pause									; end 5th character

	movlw 0x20									; [i] RB5 1 200ms 0 800ms
	movwf portB
	call	pause		
	clrf	portB
	call	pause
	call	pause
	call	pause
	call	pause									; end 6th character

	movlw 0x40									; [p] RB6 1 200ms 0 800ms
	movwf portB
	call	pause		
	clrf	portB
	call	pause
	call	pause
	call	pause
	call	pause									; end 7th character

	movlw 0x80									; [.] RB7 1 200ms 0 800ms
	movwf portB
	call	pause		
	clrf	portB
	call	pause
	call	pause
	call	pause
	call	pause									; end last character

stop	goto	stop

break
blink
	movlw 0x0F									; RB0-RB3 1 200ms 0 800ms
	movwf portB
	call	pause		
	clrf	portB
	call	pause
	call	pause
	call	pause
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
