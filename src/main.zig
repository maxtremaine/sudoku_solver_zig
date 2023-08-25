const std = @import("std");
const print = std.debug.print;

const Sudoku = @import("./Sudoku.zig").Sudoku;

pub fn main() !void {
    const data = @embedFile("io/start_puzzle.sudoku");
    for(data) |line| {
        print("{c}", .{line});
    } 
}

test {
    std.testing.refAllDeclsRecursive(@This());
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
