.global _start

.section .text
_start:

movq $0, %rax # counter
movq $0, %rdx # i
lea str(%rip), %rbx # rbx = str&

loop_HW1:
    movzbq (%rbx, %rdx, 1), %rcx
    cmpq $0, %rcx
    je finished_str_HW1
    incq %rdx # i++
    subq $'a', %rcx # rcx = str[i] - 'a'
    cmpq $0, %rcx # rcx - 'a'
    jge ge_to_a_HW1
    jmp loop_HW1



ge_to_a_HW1:
    cmpq $25, %rcx # rcx - 'z'
    jle le_to_z_HW1
    jmp loop_HW1


le_to_z_HW1:
    incq %rax # counter++
    jmp loop_HW1

finished_str_HW1:
    movl %eax, count(%rip)
    jmp check_result_HW1