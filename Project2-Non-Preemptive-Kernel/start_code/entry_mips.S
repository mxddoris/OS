#include "regs.h"
	.text
	.align	2
	.globl  get_timer	
	.ent	get_timer
	.type	get_timer, @function
get_timer:
	mfc0 $2,$9
        nop
        j       ra
        nop
	.align	2
	.globl  kernel_entry	
	.ent	kernel_entry
	.type	kernel_entry, @function
kernel_entry:
	addiu sp, sp, -24
	sw ra, 0(sp)
	bnez $4, 1f
	nop

	jal do_yield
	nop
	beqz $0,2f
	nop

1:
	jal do_exit
	nop
2:
	lw ra, 0(sp)
	addiu sp, sp, 24
	jr ra
	nop

	.align	2
	.globl  scheduler_entry	
	.ent	scheduler_entry
	.type	scheduler_entry, @function
scheduler_entry:
	# call scheduler, which will set new current process
	# need student add
	jal scheduler #call
	
	la t0, current_running
	lw t0, (t0)
	#lw t0, 0(t0)

	lw s0, 8(t0)
	lw s1, 12(t0)
	lw s2, 16(t0)
	lw s3, 20(t0)
	lw s4, 24(t0)
	lw s5, 28(t0)
	lw s6, 32(t0)
	lw s7, 36(t0)
	lw fp, 40(t0)
	lw sp, 44(t0)
	lw ra, 48(t0)
	
	

	.align	2
	.globl  save_pcb	
	.ent	save_pcb
	.type	save_pcb, @function
save_pcb:
	# save the pcb of the currently running process
	# need student add
	la t0, current_running
	lw t0, (t0)
	#lw t0, 0(t0)
	


	sw s0, 8(t0)
	sw s1, 12(t0)
	sw s2, 16(t0)
	sw s3, 20(t0)
	sw s4, 24(t0)
	sw s5, 28(t0)
	sw s6, 32(t0)
	sw s7, 36(t0)
	sw fp, 40(t0)
	
	addiu sp, sp, 24
	sw sp, 44(t0)
	addiu sp, sp, -24

	lw t1, 16(sp) #ra
	sw t1, 48(t0) #ra

	jr ra