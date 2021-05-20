[org 0x7e00]

jmp EnterProtectedMode

%include "gdt.asm"
%include "print.asm"


EnterProtectedMode:
    call EnableA20
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp codeseg:StartProtectedMode

EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

%include "CPUID.asm"
%include "SimplePaging.asm"

StartProtectedMode:

    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebx, 0xb8000
    cmp ebx, 0xb87D0
    jle clearpixel

    clearpixel:
        mov [ebx], byte ' '
        add ebx, 2
        cmp ebx, 0xb87D0
        jle clearpixel

    jmp $
    call DetectCPUID
    call DetectLongMode
    call SetUpIdentityPaging
    call EditGDT
    jmp codeseg:Start64Bit

[bits 64]

Start64Bit:
    ;mov rax, 0x1f201f201f201f20
    call cls
    mov edi, 0xb8000
    mov rax, 0x1f201f2000000000
    mov ecx, 1
    rep stosq
    mov edi, 0xb8008
    mov rax, 0x1f201f2000000000
    mov ecx, 1
    rep stosq
    mov edi, 0xb8010
    mov rax, 0xffffffffffffffff
    mov ecx, 1
    rep stosq
    jmp $
    %include "graphics.asm"

times 1024-($-$$) db 0
