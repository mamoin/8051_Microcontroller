ORG 0H
MOV A,#38H
LCALL COMNWRT
MOV A,#0EH
LCALL COMNWRT
MOV A,#01H
LCALL COMNWRT
MOV P3,#0FFH
K1:  MOV P0,#0
     MOV A,P3
     ANL A,#00001111B
     CJNE A,#00001111B,K1
K2:  LCALL DELAY
     MOV A,P3
     ANL A,#00001111B
     CJNE A,#00001111B,OVER
     SJMP K2
OVER:LCALL DELAY
     MOV A,P3
     ANL A,#00001111B
     CJNE A,#00001111B,OVER1
     SJMP K2
OVER1: MOV P0,#11111110B
     MOV A,P3
     ANL A,#00001111B
     CJNE A,#00001111B,ROW_0
     MOV P0,#11111101B
     MOV A,P3
     ANL A,#00001111B
     CJNE A,#00001111B,ROW_1 
     MOV P0,#11111011B
     MOV A,P3
     ANL A,#00001111B
     CJNE A,#00001111B,ROW_2
     MOV P0,#11110111B
     MOV A,P3
     ANL A,#00001111B
     CJNE A,#00001111B,ROW_3
     LJMP K2
ROW_0:MOV DPTR,#KCODE0
     SJMP FIND
ROW_1:MOV DPTR,#KCODE1
     SJMP FIND
ROW_2:MOV DPTR,#KCODE2
     SJMP FIND     
ROW_3:MOV DPTR,#KCODE3
     SJMP FIND
FIND:RRC A
     JNC MATCH
     INC DPTR
     SJMP FIND
MATCH:CLR A
     MOVC A,@A+DPTR
     LCALL DATAWRT
     LJMP K1
COMNWRT:MOV P1,A
        CLR P2.0
        CLR P2.1
        SETB P2.2
        LCALL DELAY2
        CLR P2.2
        RET     
DATAWRT:MOV P1,A
        SETB P2.0
        CLR P2.1
        SETB P2.2
        LCALL DELAY2
        CLR P2.2
        RET
DELAY:MOV R0,#25
      L3:MOV R1,#4
      L2:MOV R2,#98
      L1:DJNZ R2,L1
         DJNZ R1,L2
         DJNZ R0,L3
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         NOP
         RET
DELAY2:MOV R3,#50
       A1:MOV R4,#255
       A2:DJNZ R4,A2
          DJNZ R3,A1   
          RET
 
KCODE0: DB 'D','F','0','E'
KCODE1: DB 'C','9','8','7'
KCODE2: DB 'B','6','5','4'
KCODE3: DB 'A','3','2','1'
	 END	   