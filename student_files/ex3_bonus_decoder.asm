.global _start

.section .text
_start:
movq $0, %rdx # i
movq $0, %rsi # writing index
lea str(%rip), %rbx # rbx = mem[str]
lea enc(%rip), %r9 # r9 = mem[enc]
movq $0, %rax

loop_HW1:
    movzbq (%r9, %rdx, 1), %rcx # rcx = enc[i]
    cmpq $0, %rcx # rcx != '\0'
    je finished_dec_HW1

    incq %rdx # i++
    movb (%r9, %rdx, 1), %r8b
    incq %rdx
    subq $'0', %rcx
    jmp write_to_str



write_to_str:
    cmpq $0, %rcx
    je loop_HW1
    movb %r8b, (%rbx, %rsi, 1)
    incq %rsi
    decq %rcx
    jmp write_to_str


finished_dec_HW1:
