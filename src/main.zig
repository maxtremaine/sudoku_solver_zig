const std = @import("std");
const print = std.debug.print;

const Sudoku = @import("./Sudoku.zig").Sudoku;

pub fn main() !void {
    const emptyGrid = [_]u8{0} ** 81;
    const testPuzzle = (Sudoku{ .grid = emptyGrid })
        .changeCell(5, 2)
        .changeCell(6, 4);
    for (testPuzzle.grid) |item| {
        print("number: {}\n", .{item});
    }

    var reallyEmptyGrid: [9]u32 = undefined;
    for(reallyEmptyGrid) |emptyItem| {
        print("{}", .{emptyItem});
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
