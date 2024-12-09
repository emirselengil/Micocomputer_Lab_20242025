;@author: 152120211106 @emirselengil A
;@brief: CALCULATOR

jmp start

;data

; Addition Operation

ADD_: mov A, B
add C
out 03h
HLT

start: nop
lxi H, 4200h  

; @brief: The process of receiving values from ports
in 00h        
mov B, A     
in 01h        
mov C, A      

; @brief: The type of operation is reading from the port.
in 02h        
mov D, A  
    
; @brief:
; 00h ==> Subtraction (-)
; 01h ==> Multiplication (*)
; 02h ==> Division (/)
; 03h ==> Addition (+)
 
; @brief: The query I made to proceed to other operations if it's not an addition operation.
CPI 03h
JNZ ops

; @brief: The step to follow if the incoming operation is addition
MOV L, D
PCHL ; @brief: I marked the location where the addition operation 
     ; will take place in the program counter using PCHL.

; @brief: The section where subtraction, multiplication, and division operations will be detected.
ops: nop 

; Subtraction Operation Detection
mvi A, 00h
cmp D
jz SUB_

; Multiplication Operation Detection

mvi A, 01h
cmp D
jz MUL

; Division Operation Detection
mvi A, 02h
cmp D
jz DIV

; @brief: If the operation is not addition and an invalid operation is entered, 
; the program is stopped using HLT.
hlt

; Subtraction Operation
SUB_: mov A, B

sub C
out 03h
hlt

; Multiplication Operation 
; @brief: Since there is no multiplication operation on the 8085, 
; I chose to add the number on the left to itself as many times as the number on the right.

MUL: mov A, B
dcr C

MUL_LOOP: add B      
dcr C         
jnz MUL_LOOP  
out 03h
hlt

; Division Operation
; @brief: Since there is no division operation on the 8085, 
; I subtract from the number on the left until it falls to zero or negative, 
; using the D register to keep track of this as a counter.
; Then, I write the resulting value to the port.

DIV: mov A, B
mvi D, 00h

DIV_LOOP: CMP C 
JC DIV_DONE
SUB C         
INR D          
JMP DIV_LOOP   

DIV_DONE: MOV A, D         
out 03h
hlt
