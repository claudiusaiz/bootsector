
all: boot

boot: hello.s
	nasm -f bin -o $@.img $?

clean:
	rm -f boot.img
