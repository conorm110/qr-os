    global  _main
    extern  _printf

    section .text
_main:
    call    f1
    
    pop     eax
    call    _printf

    add     esp, 4
    ret

f1:
    push    v1
    ret
v1:
    db  'h',0