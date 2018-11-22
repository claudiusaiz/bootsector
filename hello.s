
[BITS 16]           ; compile instructions for 16-bit
[ORG 0x7C00]        ; Specifies at which location will the output code be eventually loaded

START:
MOV SI, Hello       ; Store string pointer to SI
CALL PRINTSTR       ; Call PRINTSTR procedure
JMP $               ; Infinite loop

PRINTCHAR:
    MOV AH, 0x0E    ; Teletype output mode
    MOV BH, 0x00    ; Page number
    MOV BL, 0x08    ; Grey font
    INT 0x10        ; Call video interrupt
    RET             ; Return to the calling procedure

PRINTSTR:
    LODSB           ; Load a byte from SI to AL and increment SI
    CMP AL, 0       ; Compare accumulator to 0
    JE EXIT         ; If AL == 0, call the EXIT procedure
    CALL PRINTCHAR  ; Else, print the current character on the screen
    JMP PRINTSTR    ; Jump to PRINTSTR - print the rest of the string

EXIT:
    RET             ; Just return


Hello DB 'Hello World!', 13, 10, 0 ; the null-terminated string "Hello World!\r\n"


TIMES 510 - ($ - $$) DB 0   ; fill with zereos until the 510th byte
DW 0XAA55                   ; fill with 0xAA55
