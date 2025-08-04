ENTRY(kernel_main)

SECTIONS {
    . = 0x8400;

    .text : {
        *(.text)        /* main .text section */
        *(.text.*)      /* any sub-sections like .text.startup or .text.main */
    }

    .rodata : {
        *(.rodata)      /* read-only data, like const strings */
        *(.rodata.*)    /* e.g. .rodata.str1.1 */
    }

    .data : {
        *(.data)
        *(.data.*)
    }

    .bss : {
        *(.bss)
        *(.bss.*)
        *(COMMON)       /* uninitialized globals and static vars */
    }
}
