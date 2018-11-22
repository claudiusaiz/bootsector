
[BITS 16]           ; compile instructions for 16-bit
[ORG 0x7C00]        ; Specifies at which location will the output code be eventually loaded

START:
XOR EAX, EAX        ; clear registers
XOR EDX, EDX        ; before calling RDTSC
RDTSC               ; return cycles in EDX:EAX
PUSH EAX            ; push EAX on the stack
MUL EDX             ; multiply EDX with EAX, and store the product in EAX
XCHG EAX, EDX       ; switch values
POP EAX             ; pop a value from the stack and store it in EAX
CALL SetPosition    
;MOV BL, AL         ; set colorful mode
MOV BL, 0x0A        ; set 'matrix' mode
CALL WriteChar
JMP START           ; repeat

; sets position to row DH and column DL
SetPosition:
MOV AH, 0x02        ; set cursor position
MOV BH, 0           ; page 0
INT 0x10
RET

; write character AL of color BL on current cursor position 
WriteChar:
MOV AH, 0x09        ; write characters
MOV BH, 0           ; page 0
MOV CX, 1           ; write character one time
INT 0x10
RET

TIMES 510 - ($ - $$) DB 0   ; fill with zereos until the 510th byte
DW 0XAA55                   ; fill with 0xAA55

