const expect = @import("std").testing.expect;

pub const Sudoku = struct {
    grid: [81]u8,

    pub fn changeCell(self: Sudoku, index: u8, value: u8) Sudoku {
        var newGrid = self.grid;
        newGrid[index] = value;
        return Sudoku{ .grid = newGrid };
    }
};

test "changes cell values" {
    const emptyList = [_]u8{0} ** 81;
    const testPuzzle = Sudoku{ .grid = emptyList };
    const newPuzzle = testPuzzle.changeCell(5, 1);
    var answerGrid: [81]u8 = emptyList;
    answerGrid[5] = 1;
    for (answerGrid) |answerValue, index| {
        try expect(newPuzzle.grid[index] == answerValue);
    }
}
