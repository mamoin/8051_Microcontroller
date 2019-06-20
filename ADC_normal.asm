		ORG	00H
		MOV	SP,#70H
		MOV   	PSW,#00H
		RS  	BIT	P2.0
		RW   	BIT 	P2.1
		ENBL  	BIT 	P2.2
		RED	BIT	P2.5
		WRT	BIT	P2.6
		INTR	BIT	P2.7
		
		
		
		
		MOV  	A,#38H		;init. LCD 2 lines, 5x7 matrix
		LCALL  	COMMAND    	;call command subroutine
		LCALL   DELAY      	;give LCD some time
		MOV   	A,#0CH      	;dispplay on, cursor on
		LCALL  	COMMAND    	;call command subroutine
		LCALL   DELAY      	;give LCD some time
		MOV  	A, #01 		;clear LCD
		LCALL  	COMMAND  	;call command subroutine
		LCALL   DELAY      	;give LCD some time
		MOV  	A, #06H      	;shift cursor right
		LCALL  	COMMAND    	;call command subroutine
		LCALL   DELAY	      	;give LCD some time
		MOV  	A, #80H      	;cursor at line 1 postion 1
		LCALL  	COMMAND    	;call command subroutine
		LCALL   DELAY      	;give LCD some time
		
		
		
		MOV	P3,#0FFH
		SETB	INTR
BACK:		CLR	WRT
		SETB	WRT
HERE:		JB	INTR,HERE
		CLR	RED
		LCALL	CONVERSION
		MOV	R0,#52H
		MOV	R2,#3
CONTINUE:	MOV	A,@R0
		LCALL	DISPLAY
		LCALL	DELAY
		DEC	R0
		DJNZ	R2,CONTINUE
		SETB	RED
		MOV  	A, #80H      	;cursor at line 1 postion 1
		LCALL  	COMMAND    	;call command subroutine
		LCALL   DELAY      	;give LCD some time
		SJMP	BACK
		
		
CONVERSION:	MOV	A,P3
		MOV	R0,#40H
		MOV	B,#10
		DIV	AB
		MOV	@R0,B
		INC	R0
		MOV	B,#10
		DIV	AB
		MOV	@R0,B
		INC	R0
		MOV	@R0,A
		
		MOV	R0,#40H
		MOV	R1,#50H
		MOV	R2,#3
	BACK1:	MOV	A,@R0
		ORL	A,#30H
		MOV	@R1,A
		INC	R0
		INC	R1
		DJNZ	R2,BACK1
		RET


COMMAND:   	LCALL   READY
		MOV	P1, A
		CLR   	RS
		CLR	RW
		SETB   	ENBL
		LCALL   DELAY
		CLR   	ENBL
		RET
		
DISPLAY:	LCALL   READY
		MOV   	P1, A
		SETB   	RS
		CLR   	RW
		SETB   	ENBL
		LCALL   DELAY
		CLR   	ENBL
		RET


READY:     	SETB   	P1.7
		CLR	RS
		SETB   	RW
	WAIT:   CLR 	ENBL
		ACALL   DELAY
		SETB   	ENBL
		JB   	P1.7,WAIT
		RET
				
DELAY:     		MOV   	R3, #50
	AGAIN_2:   	MOV   	R4, #255
	AGAIN:     	DJNZ   	R4, AGAIN
			DJNZ   	R3, AGAIN_2
			RET



		END