
[org 0x7c00]                    ; location in memory

mov  [BOOT_DISK],dl              ; allow boot disk to start

mov  bp,0x7c00                   ; init for bios
mov  sp,bp                       ; ...

mov  bx,InitString               ; pass string to print func
call PrintString                 ; print string

call ReadDisk                    ; read disk, enter sector 2+

jmp PROGRAM_SPACE                ; jump to program space

; unreachable inclusions
%include "src/print.asm" 
%include "src/DiskRead.asm"

; variables
InitString:
    db 'Bootloader Started',0

; end bytes
times 510-($-$$) db 0  ; fill with zeros
dw 0xaa55              ; declaire bootloader