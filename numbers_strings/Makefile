CC = fasm
build_dir = ../bin
once: main.asm
	$(CC) main.asm
	ld main.o -o $(build_dir)/main
run: $(build_dir)/main
	$(build_dir)/main
