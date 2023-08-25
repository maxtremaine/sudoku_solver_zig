const expect = @import("std").testing.expect;

pub const Sudoku = struct {
    grid: [81]u8,

    fn changeCell(self: Sudoku, index: u8, value: u8) Sudoku {
        var newGrid = self.grid;
        newGrid[index] = value;
        return Sudoku{ .grid = newGrid };
    }

    fn getGroupValues(self: Sudoku, group: [9]u8) [9]u8 {
        var values: [9]u8 = undefined;
        for(group) | groupIndex, i | {
            values[i] = self.grid[groupIndex];
        }
        return values;
    }
};

const groups = [27][9]u8{
    // Rows
	[_]u8{ 0, 1, 2, 3, 4, 5, 6, 7, 8 },
	[_]u8{ 9, 10, 11, 12, 13, 14, 15, 16, 17 },
    [_]u8{ 18, 19, 20, 21, 22, 23, 24, 25, 26 },
	[_]u8{ 27, 28, 29, 30, 31, 32, 33, 34, 35 },
	[_]u8{ 36, 37, 38, 39, 40, 41, 42, 43, 44 },
	[_]u8{ 45, 46, 47, 48, 49, 50, 51, 52, 53 },
	[_]u8{ 54, 55, 56, 57, 58, 59, 60, 61, 62 },
	[_]u8{ 63, 64, 65, 66, 67, 68, 69, 70, 71 },
	[_]u8{ 72, 73, 74, 75, 76, 77, 78, 79, 80 },
	// Columns
	[_]u8{ 0, 9, 18, 27, 36, 45, 54, 63, 72 },
	[_]u8{ 1, 10, 19, 28, 37, 46, 55, 64, 73 },
	[_]u8{ 2, 11, 20, 29, 38, 47, 56, 65, 74 },
	[_]u8{ 3, 12, 21, 30, 39, 48, 57, 66, 75 },
	[_]u8{ 4, 13, 22, 31, 40, 49, 58, 67, 76 },
	[_]u8{ 5, 14, 23, 32, 41, 50, 59, 68, 77 },
	[_]u8{ 6, 15, 24, 33, 42, 51, 60, 69, 78 },
	[_]u8{ 7, 16, 25, 34, 43, 52, 61, 70, 79 },
	[_]u8{ 8, 17, 26, 35, 44, 53, 62, 71, 80 },
	// Boxes
	[_]u8{ 0, 1, 2, 9, 10, 11, 18, 19, 20 },
	[_]u8{ 3, 4, 5, 12, 13, 14, 21, 22, 23 },
	[_]u8{ 6, 7, 8, 15, 16, 17, 24, 25, 26 },
	[_]u8{ 27, 28, 29, 36, 37, 38, 45, 46, 47 },
	[_]u8{ 30, 31, 32, 39, 40, 41, 48, 49, 50 },
	[_]u8{ 33, 34, 35, 42, 43, 44, 51, 52, 53 },
	[_]u8{ 54, 55, 56, 63, 64, 65, 72, 73, 74 },
	[_]u8{ 57, 58, 59, 66, 67, 68, 75, 76, 77 },
	[_]u8{ 60, 61, 62, 69, 70, 71, 78, 79, 80 }
};

test "changes cell values" {
    var zeros = [_]u8{0} ** 81;
    const testPuzzle = Sudoku{ .grid = zeros };
    const newPuzzle = testPuzzle.changeCell(5, 1);
    var answerGrid: [81]u8 = zeros;
    answerGrid[5] = 1;
    for (answerGrid) |answerValue, index| {
        try expect(newPuzzle.grid[index] == answerValue);
    }
    for (zeros) |zero, index| {
        try expect(testPuzzle.grid[index] == zero);
    }
}

test "gets group values" {
    // Initiate underlying variables
    const testGroup = [_]u8{ 0, 1, 2, 3, 4, 5, 6, 7, 8 };
    const emptyList = [_]u8{0} ** 81;
    var testPuzzle = Sudoku{ .grid = emptyList };
    // Set up test
    testPuzzle = testPuzzle.changeCell(0, 5);
    const testValues = testPuzzle.getGroupValues(testGroup);
    const correctAnswer = [_]u8{ 5, 0, 0, 0, 0, 0, 0, 0, 0, };
    
    for(testValues) | value, i | {
        try expect(value == correctAnswer[i]);
    }
}