[org 0x7e00]
call cls
mov dh, 0x00

loop:
    mov ah, 0x00       ; tell bios to get current key
    int 0x16           ; activate interupt

    mov bh,ah          ; put keyboard value into upper bh
    call mapChar       ; map keyboard
    mov [Char],bh      ; put bh into char

    mov bx, Char       ; pass char to print
    call PrintString   ; print char
    jmp loop



jmp  $


; unreachable includes
%include "src/print.asm"
%include "src/keyboard.asm"
; vars
Char:
    db "f",0

; end bytes
times 1536-($-$$) db 0 