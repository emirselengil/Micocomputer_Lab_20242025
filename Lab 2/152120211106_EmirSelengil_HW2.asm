;@author: 152120211106 @emirselengil A
;@brief: ARITHMETIC INSTRUCTIONS

jmp Question1

;data

; @brief: The order array to be used for sorting
Order: db 03h, 02h, 01h, 04h, 06h, 05h

; @brief: The values array containing the values to be sorted
Values: db 15h, 21h, 20h, 21h, 11h, 06h

;code
Question1: nop

	; @brief: Address accesses and counter definition.

	LXI h, Order      ; Assign the address of the order array to the HL register. 
	LXI d, Values     ; Assign the address of the values array to the DE register.
	LXI b, 1000h      ; Assign the address where the sorted array will begin to be written to the BC register.	
	MVI c, 06h        ; Determining the value of count, which represents the number of elements to be sorted.

SORT_LOOP:   MOV a, m     ; Copy the value in the HL register to the Accumulator.
	call STORE_VALUE  ; Calling the STORE_VALUE subroutine.

	; @brief: Incrementing the addresses in the registers.

	INX h             
	INX d 		  
	DCR c             
	JNZ SORT_LOOP     ; If the counter is not zero, return to the beginning.
	call Question2 	  ; Calling the STORE_VALUE part.

	HLT  		  

STORE_VALUE: PUSH b

	; @brief: To prevent the loss of our address values, I am storing the main values on the stack.
      
	PUSH d		  
	PUSH h		  
    
	MOV l, a	  ; Copy the value in the accumulator to the L register.
	MOV h, b   	  ; Copy the value in the B register to the H register.
	MOV a, m	  ; Copy the data from the memory address to the accumulator.
	LDAX d     	  ; Read the value indirectly from the D register and transfer it to the accumulator.
	DCR l

	; @brief: The section for writing the accumulated values to memory.
	  	  
	MOV m, a    	  ; Copy the value in the accumulator to the memory address.

	; @brief: Since the addresses will change during the above operations, 
	; we load the values that were previously pushed onto the stack 
	; back into the appropriate registers to access the old addresses.

	POP h       	  
	POP d		
	POP b	

	RET		  

Question2: LXI h, 1000h   ; Assign the address where the sorted array will begin to be written to the HL register.  
	MVI c, 03h 	  ; Determining the value of count.

	; @brief: I performed a reset operation since I will be using these registers in the subsequent code.
	; Clearing the register.

	MVI d, 00h	  
	MVI e, 00h	  
	MVI a, 00h 	  
	MVI b, 00h	  

START_ADD: CALL ADD_BCD   ; Calling the ADD_BCD subroutine.
    
	DCR c 		  
	INX h		  
	JNZ START_ADD	  ; If the counter is not zero, return to the beginning.
			  ;It checks whether the result of the last operation performed above is zero or not.
	
	; @brief: The section for writing the accumulated values to memory.

	MOV m, e      	  ; Copy the value in the E register to the memory address.
	INX h         	  
	MOV m, d       	  ; Copy the value in the D register to the memory address.
	INX h		  
	MOV m, b          ; Copy the value in the B register to the memory address. 

	RET		  

ADD_BCD: MOV a, m ; Copy the data from the memory address to the accumulator.

	; @brief: The values at the even addresses are collected and summed, and the result is placed in the D register.  
      
	ADD d		  ; Add the value in the accumulator to the D register.             
	DAA    		  ; Convert the generated value to BCD format.          
	MOV d, a  	  ; Copy the value in the accumulator to the D register.
        
	; @brief: The section for handling overflow issues.

	MVI a, 00h
	ADC b		  ; A + B + Carry
	MOV b, a  	  ; If there is a carry value, write it to the B register.
	INX h 

        ; @brief: The values at the odd addresses are collected and summed, and the result is placed in the E register.

	MOV a, m  	  ; Copy the data from the memory address to the accumulator.        
	ADD e             ; Add the value in the accumulator to the E register.
	DAA		  ; Convert the generated value to BCD format.
	MOV e, a  	  ; Copy the value in the accumulator to the E register.
	
	; @brief: The section for handling overflow issues.

	MVI a, 00h
	ADC b		  ; A + B + Carry
	MOV b, b          ; If there is a carry value, write it to the B register.     
             
	RET


