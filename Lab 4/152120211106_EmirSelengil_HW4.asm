;@author: 152120211106 @emirselengil A
;@brief: POWER and SQUARE ROOT


START: In 00H 

    ; @brief: Operation Control Part           
    Cpi 00H           
    Jz POWER_OP  ;Jump for first question high power     
    Cpi 01H           
    Jz SQUARE_OP ;Jump for second question       
    hlt         

;------------
;QUESTİON 1
;------------
POWER_OP: In 01H ; Input the number from port 01h
                
    Mov B, A
    Mvi C, 1     ; Count      
    Mvi D, 1     ; Control Number     

POWER_LOOP: Mov A, D              
    Call MULTIPLY     
    Mov D, A         
    Cpi 255h        
    Jc CONTINUE_POWER ; If result < 256, continue increasing power
    Jmp STORE_POWER   ; If result >= 256, exit loop and store answer in port 02h

CONTINUE_POWER: Inr C                 
    Jmp POWER_LOOP  
  
; @brief: Store answer in port 02h
STORE_POWER: Mov A, C          
    Out 02H           
    hlt     

; @brief: If there is overflow, store answer in port 02h      
STORE_OVERFLOW: Dcr C 
    Mov A, C          
    Out 02H          
    hlt     
      
; @brief: Multiplication section for high power
MULTIPLY: Mvi H, 00H            
    Mov L, A          
    Mvi A, 00H        
    Mov D, B          

MULTIPLY_LOOP: Add D
    Cmp B
    Jc STORE_OVERFLOW ; If the value resulting from the operation is smaller than the value we received as input, 
                      ; it means that it is overflow because you cannot obtain a value smaller than a number
                      ; by adding it to itself.           
    Dcr L             
    Jnz MULTIPLY_LOOP 
    Ret               


;------------
;QUESTİON 2
;------------
SQUARE_OP: In 01H ; Input the number from port 01h
Mov B, A
Mvi D, 01h        ; Control Number 
Mvi E, 00h        ; Result
Mov C, D
call Multiply_sqrt_start

; @brief: Multiplication section for second question
Multiply_sqrt_start: Mov E, A 
Mov A, D
Cpi 10H ; If the number is greater than 15 in decimal, the result of the operation will exceed 
        ; 256 and there will be an overflow. A control has been created to prevent this.
Jz store_owerflow  ; if there is a owerflow, store answer in port 02h
Mvi A, 00h
Mov C, D

Multiply_sqrt: Add D
dcr C
Jnz Multiply_sqrt
Inr D
Cmp B
jc Multiply_sqrt_start
Mov L, A
call Calculate_Distance

; @brief: Distance calculation
Calculate_Distance: Mov A, B
Sub E     ; Calculate distance for lower part
Mov E, A
Mov A, L
Sub B     ; Calculate distance for upper part
Mov L, A
call Comp

; @brief: Distance comparison section
Comp: Mov A, E
cmp L
jc store_smaller
jz store_equal
jmp store_bigger

; @brief: If the closest value is the larger number, save it to port 02h.
store_bigger: Mov A, D
dcr A
out 02h
hlt

; @brief: If both values ​​are equidistant, save section to port 02h
; There is no such example because the sum of the numbers between 
; any two square numbers will never be an odd number.

store_equal: Mov A, D
dcr A
out 03h
dcr A
out 02h
hlt

; @brief: If the closest value is the smaller number, save it to port 02h.
store_smaller: Mov A, D
sui 02h
out 02h
hlt

; @brief: If there is a owerflow, store answer in port 02h
store_owerflow: Mov A, D
dcr A
out 02h
hlt
