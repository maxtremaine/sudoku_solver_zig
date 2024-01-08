const expect = @import("std").testing.expect;
const expectEqual = @import("std").testing.expectEqual;

const SudokuModule = @import("./Sudoku.zig");
const Sudoku = SudokuModule.Sudoku;
const groups = SudokuModule.groups;

pub const BlankCell = struct {
    index: u8,
    possibleValues: [10]bool, // True means the index is a possible value.
    df: u8,

    pub fn fromPuzzle(puzzle: Sudoku, index: u8) BlankCell {
        const grid = puzzle.grid;
        var df: u8 = 9;
        var possibleValues = [_]bool{true} ** 10;

        for (groups) |group| {
            for (group) |groupIndex| {
                if (groupIndex == index) {
                    for (group) |addIndex| {
                        const relatedValue = grid[addIndex];

                        if (relatedValue != 0 and possibleValues[relatedValue] == true) {
                            df -= 1;
                            possibleValues[relatedValue] = false;
                        }
                    }
                    break;
                }
            }
        }

        if (df == 1) {
            possibleValues[0] = false;
        }

        return BlankCell{ .index = index, .possibleValues = possibleValues, .df = df };
    }
};

test "starts with a puzzle" {
    const zeros = [_]u8{0} ** 81;
    const testPuzzle = (Sudoku{ .grid = zeros, .blanks = 0 })
        .changeCell(9, 3)
        .changeCell(4, 5);
    const testBlank = BlankCell.fromPuzzle(testPuzzle, 0);
    const correctPV = [_]bool{ true, true, true, false, true, false, true, true, true, true };
    try expect(testBlank.df == 7);
    try expectEqual(testBlank.possibleValues, correctPV);
}
