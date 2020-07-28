.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

//Global memory locations
.global vtable
.global reset_handler

/*
 * Actual vector table
 * Only the size of RAM and reset handler are included for semplicity
 */
.type vtable, %object
vtable:
    .word _estack
    .word reset_handler
.size vtable, .-vtable

.type reset_hanlder, %function
.thumb_func
reset_handler:
    bl main
    b .
.size reset_handler, .-reset_handler
