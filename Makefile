# Makefile
CC=gcc
CFLAGS=-Wall -Werror -Wextra -Os -fPIE
LD=ld
LDFLAGS=-melf_x86_64 -r --whole-archive
LPATH=-L.
ZIGFLAGS=-Drelease-fast

.PHONY: clean libadd.a

%.o:: %.c
	$(CC) -o $@ -c $(CFLAGS) $^

libadd.a:
	zig build
	touch libadd.a

libi32math.a: libadd.a mul.o
	$(LD) $(LDFLAGS) -o $@ $^

main: main.o libi32math.a
	$(CC) -o main $(CFLAGS) $(LPATH) $< -li32math

clean:
	rm -f *.o *.a main
