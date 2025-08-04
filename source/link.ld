ENTRY(kernel_main)

SECTIONS {
    . = 0x12000;

    .text : { *(.text) }
    .data : { *(.data) }
    .bss  : { *(.bss)  }
}
. = ALIGN(512);