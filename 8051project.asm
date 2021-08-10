org 0000h
	jmp inicio

org 0023h
	clr RI
	call handle_int
	call handle_led
reti

org 0033h
handle_int:
	mov A, sbuf
	clr ACC.7
	mov @R0,A
	ret

handle_led:
	clr C
	mov A, @R0
	subb A,#37h
	jz next
	jc next
	mov R1,#40h
	call send_msg
	jmp fim
	next:
		call verifica_led
	fim:
		ret

find_switch:
	mov R2,#00h
	mov a,p2
	inc a
	jz no_switch
	mov a,p2
	search:
	inc R2
	rrc a
	jc search
	no_switch:
ret


verifica_led:
	call find_switch
	clr A
	xchd A, @R0	
	inc A
	subb A,R2
	jz turn
	mov R1,#49h
	call send_msg
	jmp back
	turn:
		call liga_led
	back:
		ret

liga_led:	
	mov p1,#0FFh
	mov A,#30h
	add A,R2
	dec A
	mov 3Eh,A
	mov A,p1
	clr c
	setpos:
		rlc a
	djnz R2,setpos
	mov p1,a
	mov R1,#3Ah
	call send_msg
ret
			
send_msg:
	loop:
	mov A,@R1 
	jz finish
	mov C,P
	mov ACC.7,C
	mov sbuf,A
	inc R1
	jnb TI,$
	clr TI
	jmp loop
	finish:
		ret
	
inicio:
	mov sp,#4Fh
	mov ie,#10010000b

	setb SM1
	setb REN
	
	mov A, PCON
	setb ACC.7
	mov PCON,A

	mov tmod,#00100000b
	mov th1,#0F3h
	mov tl1,#0F3h
	setb tr1

	mov R0,#20h
	mov R2,#00h
	
	mov 3Ah,#'L'
	mov 3Bh,#'E'
	mov 3Ch,#'D'
	mov 3Dh,#'_'
	mov 3Fh,#00h


	mov 40h,#'S'
	mov 41h,#'o'
	mov 42h,#' '
	mov 43h,#'0'
	mov 44h,#' '
	mov 45h,#'a'
	mov 46h,#' '
	mov 47h,#'7'
	mov 48h,#00h

	mov 49h,#'S'
	mov 4Ah,#'W'
	mov 4Bh,#' '
 	mov 4Ch,#'O'
	mov 4Dh,#'F'
	mov 4Eh,#'F'	
	mov 4Fh,#00h
	
	
	jmp $
