.global _start

.section .text
_start:

lea board(%rip), %rbx # rbx = &board
lea valid(%rip), %r9 # r9 = &valid
lea lazer(%rip), %r10 # r10 = &lazer
movq $0, %rax # # lazer x-pos
movq $0, %rsi # lazer y-pos
movq $0, %rcx # lazer direction (0...3)

init_lazer_HW1:
    movq $0, %rdx
    movl (%r10, %rdx, 1), %eax
    addq $4, %rdx
    movl (%r10, %rdx, 1), %esi
    addq $4, %rdx
    movl (%r10, %rdx, 1), %ecx

loop_HW1:
    jmp move_lazer_HW1
direction_lazer_HW1:
    cmpq $8, %rax
    jge lazer_lost_HW1
    cmpq $0, %rax
    jl lazer_lost_HW1
    cmpq $8, %rsi
    jge lazer_lost_HW1
    cmpq $0, %rsi
    jl lazer_lost_HW1
    jmp infinite_loop_check_HW1
not_infinite_HW1:
    jmp check_lazer_hit_HW1
after_check_hit_HW1:
    jmp loop_HW1


infinite_loop_check_HW1:
    movq $0, %r12
    cmpl (%r10, %r12, 1), %eax
    jne not_infinite_HW1
    addq $4, %r12
    cmpl (%r10, %r12, 1), %esi
    jne not_infinite_HW1
    addq $4, %r12
    cmpl (%r10, %r12, 1), %ecx
    jne not_infinite_HW1
    jmp lazer_lost_HW1 # we reaches an infinite loop, because we've reaches the starting position with the same direction
    
check_lazer_hit_HW1:
    movq %rax, %r11
    shlq $3, %r11
    addq %rsi, %r11
    movzbq (%rbx, %r11, 1), %rdx # rdx = board[rax][rsi]
    cmpq $'.', %rdx
    je after_check_hit_HW1
    cmpq $'#', %rdx
    je lazer_lost_HW1
    cmpq $'T', %rdx
    je lazer_won_HW1
    cmpq $'\', %rdx
    je mirror_type_a_HW1
    cmpq $'/', %rdx
    je mirror_type_b_HW1
    jmp after_check_hit_HW1


mirror_type_a_HW1:
    cmpq $0, %rcx
    je change_dir_left_HW1
    cmpq $3, %rcx
    je change_dir_up_HW1
    cmpq $2, %rcx
    je change_dir_right_HW1
    
    movq $2, %rcx # this means that the direction is right, meaning we need to go down now
    jmp after_check_hit_HW1


mirror_type_b_HW1:
    cmpq $0, %rcx
    je change_dir_right_HW1
    cmpq $1, %rcx
    je change_dir_up_HW1
    cmpq $2, %rcx
    je change_dir_left_HW1
    
    movq $2, %rcx # this means that the direction is left, meaning we need to go down now
    jmp after_check_hit_HW1


change_dir_right_HW1:
    movq $1, %rcx
    jmp after_check_hit_HW1

change_dir_up_HW1:
    movq $0, %rcx
    jmp after_check_hit_HW1

change_dir_left_HW1:
    movq $3, %rcx
    jmp after_check_hit_HW1
    

move_lazer_HW1: # moves the lazer in its direction
    
    decq %rax
    cmpq $0, %rcx # direction = 0
    je direction_lazer_HW1
    incq %rax # direction isn't 0, so we revert our changes
    incq %rsi
    cmpq $1, %rcx
    je direction_lazer_HW1
    decq %rsi # direction isn't 1, so we revert our changes
    incq %rax
    cmpq $2, %rcx
    je direction_lazer_HW1
    decq %rax
    decq %rsi
    jmp direction_lazer_HW1


lazer_won_HW1:
    movq $0, %rdx
    movb $1, (%r9, %rdx, 1)
    jmp skip_HW1


lazer_lost_HW1:
    movq $0, %rdx
    movb $0, (%r9, %rdx, 1)

skip_HW1:
