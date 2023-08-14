# Makefile
CC=gcc
CFLAGS=-Wall -Werror -Wextra -Os -fPIE
LD=ld
LDFLAGS=-melf_x86_64 -r --whole-archive
ZIGOUT=zig-out/lib
LPATH=-L$(ZIGOUT) -L.

.PHONY: clean libadd.a

%.o:: %.c
	$(CC) -o $@ -c $(CFLAGS) $^

$(ZIGOUT)/libadd.a:
	zig fmt build.zig src/*.zig
	zig build

libi32math.a: $(ZIGOUT)/libadd.a mul.o
	$(LD) $(LDFLAGS) $(LPATH) -o $@ $^

main: main.o libi32math.a
	$(CC) -o main $(CFLAGS) $(LPATH) $< -li32math

clean:
	rm -f *.o *.a main
	rm -rf zig-out zig-cache
