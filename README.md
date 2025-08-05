# ViniciusOS

Um sistema operacional simples desenvolvido em Assembly e C.

## Pré-requisitos

Para compilar e executar o ViniciusOS, você precisa dos seguintes programas instalados:

### 1. NASM (Netwide Assembler)
- **Download**: https://www.nasm.us/
- **Instalação**: Execute o instalador e certifique-se de que o NASM está no PATH do sistema

### 2. GCC Cross-Compiler (i686-elf-gcc)
Para compilar o kernel em C, você precisa de um cross-compiler para arquitetura i686.

**No Windows (usando MSYS2):**
```bash
# Instalar MSYS2 primeiro: https://www.msys2.org/
pacman -S mingw-w64-x86_64-gcc
pacman -S mingw-w64-x86_64-binutils
```

**Alternativa - Usando WSL (Windows Subsystem for Linux):**
```bash
sudo apt update
sudo apt install build-essential
sudo apt install gcc-multilib
```

### 3. QEMU
- **Download**: https://www.qemu.org/download/
- **Windows**: Baixe o instalador do site oficial
- **Linux**: `sudo apt install qemu-system-x86`

### 4. Python
- **Download**: https://www.python.org/downloads/
- Necessário para o script `pad.py`

## Estrutura do Projeto

```
ViniciusOS/
├── source/
│   ├── boot.asm      # Bootloader
│   ├── main.asm      # Código Assembly principal
│   ├── kernel.c      # Kernel em C
│   └── link.ld       # Script de linkagem
├── output/           # Arquivos compilados
├── autorun.bat       # Script básico (apenas Assembly)
├── autorun2.bat      # Script com kernel C + padding
├── autorun3.bat      # Script com debug
├── autorun4.bat      # Script simplificado
└── pad.py           # Script Python para padding
```

## Como Executar

### Opção 1: Execução Básica (apenas Assembly)
```bash
autorun.bat
```
Este script compila apenas os arquivos Assembly e cria uma imagem de disquete simples.

### Opção 2: Execução com Kernel C
```bash
autorun2.bat
```
Este script compila o kernel em C junto com o Assembly e aplica padding.

### Opção 3: Execução com Debug
```bash
autorun3.bat
```
Este script inclui flags de debug para desenvolvimento.

### Opção 4: Execução Simplificada
```bash
autorun4.bat
```
Este script usa uma abordagem mais simples para compilação.

## Compilação Manual

Se preferir compilar manualmente:

### 1. Limpar arquivos de saída
```bash
del /f /q "output\*"
```

### 2. Compilar bootloader
```bash
nasm -f bin source/boot.asm -o output/boot.bin
```

### 3. Compilar kernel C (se necessário)
```bash
i686-elf-gcc -m32 -ffreestanding -c source/kernel.c -o output/kernel.o
i686-elf-ld -T source/link.ld -m elf_i386 output/kernel.o -o output/kernel.elf
i686-elf-objcopy -O binary output/kernel.elf output/kernel.bin
```

### 4. Aplicar padding (se necessário)
```bash
python pad.py output\kernel.bin
```

### 5. Combinar arquivos
```bash
copy /b output\boot.bin + output\kernel.bin output\os.img
```

### 6. Executar no QEMU
```bash
qemu-system-x86_64.exe output/os.img
```

## Solução de Problemas

### Erro: "nasm não é reconhecido"
- Certifique-se de que o NASM está instalado e no PATH do sistema
- Reinicie o terminal após a instalação

### Erro: "i686-elf-gcc não é reconhecido"
- Instale o cross-compiler conforme as instruções acima
- No Windows, considere usar WSL para facilitar a instalação

### Erro: "qemu-system-x86_64.exe não é reconhecido"
- Certifique-se de que o QEMU está instalado e no PATH
- Verifique se o caminho do QEMU está correto no script

### Erro de compilação do kernel
- Verifique se o cross-compiler está instalado corretamente
- Certifique-se de que o arquivo `link.ld` existe e está correto

## Desenvolvimento

Para adicionar novas funcionalidades:

1. **Modificar o bootloader**: Edite `source/boot.asm`
2. **Adicionar código Assembly**: Edite `source/main.asm`
3. **Modificar o kernel C**: Edite `source/kernel.c`
4. **Ajustar linkagem**: Edite `source/link.ld`

## Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## Licença

Este projeto é de código aberto. Sinta-se livre para usar e modificar conforme necessário. 