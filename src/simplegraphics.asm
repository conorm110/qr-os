cls:
    mov ebx, 0xb8000
    cmp ebx, 0xb87D0
    jle clearpixel

    clearpixel:
        mov [ebx], byte ' '
        add ebx, 2
        cmp ebx, 0xb87D0
        jle clearpixel

    ret