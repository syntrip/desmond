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
; MonoCharacter ASCII TeleType
; by mn@d23.synlabs.com.ar
;	2012/11/15
;
; uc [ pic16F84A ]
;	RB0-RB2 output 
; RB0 <space>
; RB1 <:>
; RB2 <enter>
;

LIST 	p=16F84a
RADIX	hex
__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
#INCLUDE <p16f84a.inc>

;----------------------------------------------------------------------
;	cpu equates (memory map)

pcl				equ 0x02						; program counter low
portB			equ	0x06						; (p. 10 defines port address)

code_ptr	equ	0x0c						; ascii art table pointer
key				equ	0x0d						;
key_code	equ	0x0e						; XXX not used
key_count	equ	0x0f						;

nCount		equ	0x0f						; delay inner count
mCount		equ	0xa0						; delay outter count

;----------------------------------------------------------------------

;----------------------------------------------------------------------
;	main

	org	0x000

start		movlw	0x00						; load W with 0x00 make port B output (p. 45)
	tris	portB									; copy W tristate, port B outputs (p. 58)
	clrf	portB									; clear all lines low
	movlw	0x00
	movwf key										; initialice key

	call	pause									; delay by subroutine
	call	pause		
	call	pause
	call	pause
	call	pause									; five pause executions equals ~ 1 second

	movlw	0x00
	movwf code_ptr							; initialice code_ptr

newCode
	movfw	code_ptr
	call ascii_art
	movwf key
	incf code_ptr, f
	movfw key	
	xorlw 0x00
	bz stop
	movfw key	
	xorlw 0x01
	bz press_enter

	bcf STATUS, C								; clear carry flag!
	rrf key, w
	movwf key_count
repeat
	btfss key, 0
	goto pspace
	goto pchar
pspace
	call press_space
	goto check
pchar
	call press_character
check
;	decfsz key_count, f
;	goto repeat
;	goto newCode
	decf key_count, f
	movfw key_count
	xorlw 0x00
	bz newCode
	goto repeat
	goto stop

press_enter
	movlw 0x04									; [enter] RB2 1
	movwf portB
	call	pause100ms	
	clrf	portB
	call	pause1000ms
	call	pause1000ms
	call	pause1000ms
	call	pause1000ms						;
goto newCode

stop	goto	stop

;----------------------------------------------------------------------
;	subroutines

press_space
	movlw 0x01									; [ ] RB0 1
	movwf portB
	call	pause100ms
	clrf	portB
	call	pause100ms						;
return

press_character
	movlw 0x02									; [:] RB1 1
	movwf portB
	call	pause100ms
	clrf	portB
	call	pause100ms						;
return

pause1000ms
	call	pause
	call	pause
	call	pause
	call	pause									;
return

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

ascii_art	addwf PCL, f
	RETLW 0x77
	RETLW 0x01
	RETLW 0x05
	RETLW 0x0c
	RETLW 0x05
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x0e
	RETLW 0x05
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x0e
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x0e
	RETLW 0x05
	RETLW 0x01
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x01
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x01
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x01
	RETLW 0x05
	RETLW 0x0c
	RETLW 0x07
	RETLW 0x0e
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x10
	RETLW 0x03
	RETLW 0x06
	RETLW 0x15
	RETLW 0x0e
	RETLW 0x05
	RETLW 0x01
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x01
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x01
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x01
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x01
	RETLW 0x05
	RETLW 0x0c
	RETLW 0x07
	RETLW 0x0c
	RETLW 0x05
	RETLW 0x06
	RETLW 0x05
	RETLW 0x06
	RETLW 0x05
	RETLW 0x0c
	RETLW 0x05
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x06
	RETLW 0x03
	RETLW 0x06
	RETLW 0x0d
	RETLW 0x01
	RETLW 0x77
	RETLW 0x01
	RETLW 0x00
goto stop

end

