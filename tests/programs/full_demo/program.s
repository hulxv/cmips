# full_demo written by hand in plain MIPS, for comparison.
# Expected output: 14, 5, 13, 7, 9, 120, 5, hello (one per line)

        .data
arr:    .word 3, 1, 4, 1, 5
sum:    .word 0
biggest: .word 0
count:  .word 0
msg:    .asciiz "hello"
buf:    .space 16
nl:     .asciiz "\n"

        .text
main:
        # 1) sum the array
        la      $s0, arr
        li      $t1, 5
        li      $t3, 0
sum_lp: lw      $t6, 0($s0)
        addu    $t3, $t3, $t6
        addiu   $s0, $s0, 4
        addiu   $t1, $t1, -1
        bnez    $t1, sum_lp
        sw      $t3, sum
        move    $a0, $t3
        li      $v0, 1
        syscall
        la      $a0, nl
        li      $v0, 4
        syscall

        # 2) largest element
        la      $s0, arr
        li      $t0, 0
        li      $t4, 0
max_lp: lw      $t2, 0($s0)
        ble     $t2, $t4, skip
        move    $t4, $t2
skip:   addiu   $s0, $s0, 4
        addiu   $t0, $t0, 1
        blt     $t0, 5, max_lp
        sw      $t4, biggest
        move    $a0, $t4
        li      $v0, 1
        syscall
        la      $a0, nl
        li      $v0, 4
        syscall

        # 3) arithmetic: 10 + 5 - 3 + 1 = 13
        li      $t5, 10
        addiu   $t5, $t5, 5
        addiu   $t5, $t5, -3
        addiu   $t5, $t5, 1
        sw      $t5, count
        move    $a0, $t5
        li      $v0, 1
        syscall
        la      $a0, nl
        li      $v0, 4
        syscall

        # 4) larger of two values, then a swap
        li      $t0, 3
        li      $t1, 7
        bge     $t0, $t1, max_ok
        move    $t0, $t1
max_ok: move    $a0, $t0
        li      $v0, 1
        syscall
        la      $a0, nl
        li      $v0, 4
        syscall
        li      $t2, 4
        li      $t3, 9
        move    $t6, $t2
        move    $t2, $t3
        move    $t3, $t6
        move    $a0, $t2
        li      $v0, 1
        syscall
        la      $a0, nl
        li      $v0, 4
        syscall

        # 5) recursive factorial of 5
        li      $a0, 5
        jal     fact
        move    $a0, $v0
        li      $v0, 1
        syscall
        la      $a0, nl
        li      $v0, 4
        syscall

        # 6) string length, then copy with the 0 byte
        la      $t0, msg
        li      $s2, 0
len_lp: lb      $t1, 0($t0)
        beqz    $t1, len_done
        addiu   $t0, $t0, 1
        addiu   $s2, $s2, 1
        j       len_lp
len_done:
        move    $a0, $s2
        li      $v0, 1
        syscall
        la      $a0, nl
        li      $v0, 4
        syscall
        la      $t0, msg
        la      $t1, buf
        addiu   $t2, $s2, 1
cpy_lp: lb      $t3, 0($t0)
        sb      $t3, 0($t1)
        addiu   $t0, $t0, 1
        addiu   $t1, $t1, 1
        addiu   $t2, $t2, -1
        bnez    $t2, cpy_lp
        la      $a0, buf
        li      $v0, 4
        syscall
        la      $a0, nl
        li      $v0, 4
        syscall
        li      $v0, 10
        syscall

# fact: $a0 = n, returns n! in $v0
fact:   li      $v0, 1
        ble     $a0, 1, fact_ret
        addiu   $sp, $sp, -8
        sw      $ra, 4($sp)
        sw      $a0, 0($sp)
        addiu   $a0, $a0, -1
        jal     fact
        lw      $a0, 0($sp)
        lw      $ra, 4($sp)
        addiu   $sp, $sp, 8
        mul     $v0, $v0, $a0
fact_ret:
        jr      $ra
