# Makefile
CC=gcc
CFLAGS=-Wall -Werror -Wextra -Os -fPIE
LD=ld
LDFLAGS=-melf_x86_64 -r --whole-archive
ZIGOUT=zig-out/lib
LPATH=-L.
ZIG_SRCS=$(wildcard src/*.zig)

.PHONY: clean libadd.a test default

default: main

%.o:: %.c
	$(CC) -o $@ -c $(CFLAGS) $^

$(ZIGOUT)/libadd.a: $(ZIG_SRCS)
	zig fmt build.zig src/*.zig
	zig build

libi32math.a: $(ZIGOUT)/libadd.a mul.o
	$(LD) $(LDFLAGS) $(LPATH) -o $@ $^

main: main.o libi32math.a
	$(CC) -o main $(CFLAGS) $(LPATH) $< -li32math

test: $(ZIG_SRCS)
	zig build test

clean:
	rm -f *.o *.a main
	rm -rf zig-out zig-cache
