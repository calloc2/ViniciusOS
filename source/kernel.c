void kernel_main() {
    volatile char *video = (volatile char*)0xb8000;
    video[0] = 'H';
    video[1] = 0x0F;  // white on black
    video[2] = 'i';
    video[3] = 0x0F;
    while (1) {}
}