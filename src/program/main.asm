main:

    mov bx, Char       ; pass char to print
    call PrintString   ; print char
    inc dh             ; since letter was printed, inc dh
    ; end main
    jmp keyboardLoop

nlint:
    inc dh
    ret

maintype:
    db 0x02