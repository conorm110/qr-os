cls:
    mov edi, 0xb8000
    mov rax, 0x0000000000000000
    mov ecx, 500
    rep stosq
    ret