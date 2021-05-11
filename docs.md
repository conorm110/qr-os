# Docs - Bash
## Bash mode restrictions
You cannot prevent use text input or the main kernel loop. To allow full access to the program, skip ahead to assthon docs.

## Program structure by default
The programmers entry point is the main function. However, it is important to know how main is called. main is triggered my the kernels operation loop after each line is entered. using ```ret``` will terminate the main function. Try to use ```jmp location``` instead.
You must also declair file type. This is done through a system variable.

```
; main.asm
main:

    call keyboardLoop

maintype:
    db 0x01
```

Must call keyboardLoop to continue back to kernel


## Printing Text
__Keyboard Simulation__
```
mov cx, [charScanCode]
mov ah, 0x05 
int 0x16
```
This way will put the text into a line buffer, however it allows access to the built in newline function. 

For example, to print 'a' then a new line:
```
main:
    cmp osc, 0x00
    je simA
    cmp osc, 0x01
    je nl

    mov dh, 0x00

simA:
    mov cx, 0x1E
    mov ah, 0x05 
    int 0x16
    mov [osc], 0x01

nl:
    mov [osc], 0x00
    call newline

osc:
    db, 0x00
call newline
```

__BIOS Printing__
This allows you to use a build in print function but not a newline function. Here is an example of printing a char

```
main:
    cmp runonce, 0x00
    je pchar

    mov dh, 0x00

pchar:
    mov [runonce], 0x01
    mov bx, Char        ; pass char to print
    call PrintString    ; print char
Char:
    db, 'a',0

runonce:
    db, 0x00
```
To print with newline, you can space 80-n times where n is a given lines char count. The easiest way to do this is edit dh (char counter)
```
main:
    cmp runonce, 0x00
    je pchar
    
    mov dh, 0x00

pchar:
    mov [runonce], 0x01
    mov al, [Char]
    int 0x10

    sub dh, 0x01
    call newline

Char:
    db, 'a',0

runonce:
    db, 0x00
```

Notice that the printstring function is not called. This is due to issues with returning. This may be fixed in a future version if I remember.

# Docs - Assthon