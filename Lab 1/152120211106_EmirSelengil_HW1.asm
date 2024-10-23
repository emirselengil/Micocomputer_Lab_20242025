
;<Program title>

jmp start

;data

;152120211106 Emir Selengil - A

;Question1

;Address

;Dec   ==> Hex
;1521h ==> 5409
;2021h ==> 8225
;1106h ==> 4358

;Question7
;In this section, I create the ports and specify the addresses of the ports.

portB:      EQU 00H  ; I/O Port addres 00h
portD:      EQU 01H  ; I/O Port addres 01h
portH:      EQU 02H  ; I/O Port addres 02h

;Question2

;Using the Memory tool on the left side, 
;I assigned the value 0Bh to the address 1521H, which is 5409 in decimal.

;code
start: nop

;Question3

;To write the value 0Dh to the address 2021H, 
;I first used the MVI command and then the STA command. 
;First, I loaded the value 0Dh into a A register using MVI, 
;and then I wrote it to the address 2021H using STA.

MVI A, 0Dh   ; Loading 0Dh into the A register.
STA 2021h    ; Saving the value in the A register to the address 2024H.

;MVI => Move immediate 8-bit 
;STA => Store accumulator direct 

;Question4

;In 8085 assembly language, indirect addressing is a mode of addressing
;where a register is used to determine the memory address of a data or instruction.

;LXI => Setting the address 1106H in the H and L registers. Here, 
;the H register will take the value 11H, and the L register will take the value 06H. 

;MOV => Copy from source to destination

MVI A, 0FH       ; Loading the value 0FH into the A register.
LXI H, 1106H    ; Loading the address 1106H into the H and L registers.
MOV M, A         ; Writing the value 0FH from the A register to the address 1106H.

;Question5

;First, we access specific addresses using MVI with the help of the H and L registers,
;and then we use MOV to transfer the values at these addresses to the desired registers.

LXI H, 1521H  ; Loading the address 1521H into the H and L registers
MOV B, M      ; Transferring the value at address 1521H to the B register.

LXI H, 2021H  ; Loading the address 2021H into the H and L registers
MOV D, M      ; Transferring the value at address 2021H to the D register.

LXI H, 1106H  ; Loading the address 1106H into the H and L registers
MOV H, M      ; Transferring the value at address 1106H to the H register.


;Question6

; B=>D D=>H H=>B

;The push and pop system operates entirely on the stack principle, 
;using LIFO (Last In, First Out). According to this order, 
;the registers B, D, and H are pushed in sequence, 
;and then to achieve the desired transfers, B, H, and D are popped.

PUSH B ;Push B onto the stack (0BH)
PUSH D ;Push D onto the stack (0DH)
PUSH H ;Push H onto the stack (0FH)

POP B  ;Pop the top of the stack into B (0FH)
POP H  ;Pop the top of the stack into H (0DH)
POP D  ;Pop the top of the stack into D (0BH)

;Question7 cont.

;The OUT command sends the data in the accumulator (A) register to the specified I/O port.

;Therefore, I first transferred the value from the desired register to the A register and 
;then sent it to the address on the I/O port.

;I gained insight into how I can solve this problem using the tutorial of GNUsim8085.

MOV A, B   ; Transfer the value from register B to register A.
OUT portB  ; Write the value in A to port 00H.

MOV A, D   ; Transfer the value from register D to register A.
OUT portD  ; Write the value in A to port 01H.

MOV A, H   ; Transfer the value from register H to register A.
OUT portH  ; Write the value in A to port 02H.


;Question8

;To start my program by loading it into a different memory address, 
;I first wrote 0011 in the "Load me at" section at the top and then 
;examined the memory section on the right.

;In my observations, I noticed that the addresses where the instructions 
;are loaded have changed. However, access to fixed memory addresses remained 
;the same. For example, the value I assigned to 2021H remained unchanged even 
;though the starting point of the program changed. There was no change in the 
;logic or functionality of the code.


;end

hlt