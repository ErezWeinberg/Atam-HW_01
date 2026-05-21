.section .data
board:
    .byte '.','.','.','.','.','.','.','.' # row 0
    .byte '.','.','.','T','.','.','.','.'
    .byte '.','.','.','/','.','.','.','.'
    .byte '.','.','.','.','.','.','.','.'
    .byte '.','.','.','.','.','.','.','.'
    .byte '.','.','.','.','.','.','.','.'
    .byte '.','.','.','.','.','.','.','.'
    .byte '.','.','.','.','.','.','.','.'
lazer:
    .int 2, 0, 1
valid:
    .byte 9

.section .text
    cmpb $1, valid(%rip)
    jne fail_test_HW1
pass_test_HW1:
    movq $60, %rax
    xorq %rdi, %rdi
    syscall
fail_test_HW1:
    movq $60, %rax
    movq $1, %rdi
    syscall
