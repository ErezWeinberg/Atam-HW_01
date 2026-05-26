.global _start

.section .text
_start:
movq $0, %rdx # i
movq $0, %rsi # writing index
lea str(%rip), %rbx # rbx = mem[str]
lea enc(%rip), %r9 # r9 = mem[enc]
movzbq (%rbx, %rdx, 1), %rcx # rcx = str[0]
cmp $0, %rcx
je skip_HW1
movq $1, %rax # repeating chars counter


loop_HW1:
    incq %rdx # i++
    movq %rcx, %r8 # r8 = rcx
    movzbq (%rbx, %rdx, 1), %rcx # rcx = str[i + 1]
    cmpq %r8, %rcx
    je repeating_HW1
    jne not_repeating_HW1
    jmp loop_HW1

repeating_HW1:
    incq %rax
    jmp loop_HW1

not_repeating_HW1:
    cmpq $0, %rcx
    je finished_enc_HW1
    cmpq $1, %rax
    je loop_HW1

    movq %rax, %r10
    addq $'0', %r10
    movb %r10b, (%r9, %rsi, 1)
    movq $1, %rax
    incq %rsi
    movb %r8b, (%r9, %rsi, 1)
    incq %rsi
    jmp loop_HW1




finished_enc_HW1:
    cmpq $1, %rax
    je skip_HW1
    movq %rax, %r10
    addq $'0', %r10
    movb %r10b, (%r9, %rsi, 1)
    incq %rsi
    movb %r8b, (%r9, %rsi, 1)
    incq %rsi
skip_HW1:
    movb $0, (%r9, %rsi, 1)

