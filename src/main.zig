const std = @import("std");
const testing = std.testing;

export fn add_i32(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try testing.expect(add_i32(3, 7) == 10);
}
