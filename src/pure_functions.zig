const expect = @import("std").testing.expect;

pub fn hasDuplicates(list: [9]u8) bool {
    var pastValues = [_]u8{0} ** 9;
    for(list) |value, i| {
        if(i == 0) {
            pastValues[0] = value;
            continue;
        }
        if(value == 0) {
            continue;
        }
        for(pastValues) |pastValue| {
            if(value == pastValue) {
                return true;
            }
        }
        pastValues[i] = value;
    }
    return false;
}

test "identifies lists with duplicates" {
    const noDupes = [_]u8{ 1, 170, 3, 0, 5, 6, 7, 8, 9 };
    const hasDupes = [_]u8{1, 2, 3, 3, 3, 3, 3, 3, 3 };
    try expect(hasDuplicates(noDupes) == false);
    try expect(hasDuplicates(hasDupes) == true);
}