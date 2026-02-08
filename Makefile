vector.elf: vector.c
	riscv-none-elf-gcc -march=rv32imcbv -mabi=ilp32 -O2 -D__riscv_v_intrinsic=1000000 vector.c -o vector.elf

all: vector.elf

