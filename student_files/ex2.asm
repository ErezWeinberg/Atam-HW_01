.global _start

.section .text
_start:

lea exp(%rip), %rbx # rbx = &exp
lea valid(%rip), %r9 # r9 = &valid
movq $0, %rax # rax = i = 0
movq $0, %rdx # the "stack"

loop_HW1:
    movzbq (%rbx, %rax, 1), %rcx # rcx = exp[i]
    incq %rax
    cmpq $0, %rcx
    je end_of_str_HW1
    cmpq $'(', %rcx
    je add_bracket_HW1
    cmpq $'{', %rcx
    je add_bracket_HW1
    cmpq $'[', %rcx
    je add_bracket_HW1
    cmpq $')', %rcx
    je remove_normal_HW1
    cmpq $'}', %rcx
    je remove_curly_HW1
    jmp remove_square_HW1


add_bracket_HW1:
    shlq $8, %rdx
    addb %cl, %dl
    jmp loop_HW1

remove_normal_HW1:
    cmpb $'(', %dl
    jne not_valid_HW1
    shrq $8, %rdx
    jmp loop_HW1

remove_curly_HW1:
    cmpb $'{', %dl
    jne not_valid_HW1
    shrq $8, %rdx
    jmp loop_HW1

remove_square_HW1:
    cmpb $'[', %dl
    jne not_valid_HW1
    shrq $8, %rdx
    jmp loop_HW1


end_of_str_HW1:
    cmpq $0, %rdx
    jne not_valid_HW1
    movq $0, %rsi
    movl $1, (%r9, %rsi, 1)
    jmp skip_HW1

not_valid_HW1:
    movq $0, %rsi
    movl $0, (%r9, %rsi, 1)

skip_HW1:
