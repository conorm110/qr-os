PrintString:
    push ax
    push bx

    mov ah, 0x0e
    .Loop:
    cmp [bx], byte 0
    je .Exit
        mov al, [bx]
        int 0x10
        inc bx
        jmp .Loop
    .Exit:

    pop ax
    pop bx
    ret

cls:
  pusha
  mov ah, 0x00
  mov al, 0x03  ; text mode 80x25 16 colours
  int 0x10
  popa
  ret

newline:
    mov bh, [linesize]
    cmp bh, 0x50
    jne space
    mov bh, 0 ; we dont want the normal char handler using this
    ret

space:
    mov ah, 0x0e
    mov al, ' '
    int 0x10
    inc bh
    cmp bh, 0x50
    jne space

linesize:
    db 0x00