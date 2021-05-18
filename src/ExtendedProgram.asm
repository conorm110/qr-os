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

    mov [0xb8000], byte '3'
    mov [0xb8002], byte '2'
    mov [0xb8004], byte ' '
    mov [0xb8006], byte 'B'
    mov [0xb8008], byte 'I'
    mov [0xb800a], byte 'T'
    mov [0xb800c], byte ' '
    mov [0xb800e], byte 'M'
    mov [0xb8010], byte 'O'
    mov [0xb8012], byte 'D'
    mov [0xb8014], byte 'E'

    call DetectCPUID
    call DetectLongMode
    call SetUpIdentityPaging
    call EditGDT
    jmp codeseg:Start64Bit

[bits 64]

Start64Bit:
    mov edi, 0xb8000
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    rep stosq
    jmp $

times 1024-($-$$) db 0
