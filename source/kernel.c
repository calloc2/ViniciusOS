void kernel_main() {
    const char* msg = "Hello from C kernel!\n";
    char* vga = (char*)0xB8000;

    for (int i = 0; msg[i]; i++) {
        vga[i * 2] = msg[i];       // ASCII char
        vga[i * 2 + 1] = 0x07;     // White on black
    }

    while (1){

    }
}
