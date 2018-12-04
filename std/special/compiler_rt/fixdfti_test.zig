const __fixdfti = @import("fixdfti.zig").__fixdfti;
const std = @import("std");
const assert = std.debug.assert;

fn test__fixdfti(a: f64, expected: i128) void {
    const x = __fixdfti(a);
    assert(x == expected);
}

test "fixdfti" {
    test__fixdfti(0.0, 0);

    test__fixdfti(0.5, 0);
    test__fixdfti(0.99, 0);
    test__fixdfti(1.0, 1);
    test__fixdfti(1.5, 1);
    test__fixdfti(1.99, 1);
    test__fixdfti(2.0, 2);
    test__fixdfti(2.01, 2);
    test__fixdfti(-0.5, 0);
    test__fixdfti(-0.99, 0);
    test__fixdfti(-1.0, -1);
    test__fixdfti(-1.5, -1);
    test__fixdfti(-1.99, -1);
    test__fixdfti(-2.0, -2);
    test__fixdfti(-2.01, -2);

    test__fixdfti(0x1.FFFFFEp+62, 0x7FFFFF8000000000);
    test__fixdfti(0x1.FFFFFCp+62, 0x7FFFFF0000000000);

    test__fixdfti(-0x1.FFFFFEp+62, -0x7fffff8000000000);
    test__fixdfti(-0x1.FFFFFCp+62, -0x7fffff0000000000);

    test__fixdfti(0x1.FFFFFFFFFFFFFp+63, 0xFFFFFFFFFFFFF800);
    test__fixdfti(0x1.0000000000000p+63, 0x8000000000000000);
    test__fixdfti(0x1.FFFFFFFFFFFFFp+62, 0x7FFFFFFFFFFFFC00);
    test__fixdfti(0x1.FFFFFFFFFFFFEp+62, 0x7FFFFFFFFFFFF800);

    test__fixdfti(0x1.FFFFFFFFFFFFEp+127,   0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
    test__fixdfti(-0x1.FFFFFFFFFFFFEp+127, -0x80000000000000000000000000000000);

    test__fixdfti(0x1.FFFFFFFFFFFFFp+126, 0x7FFFFFFFFFFFFC000000000000000000);
    test__fixdfti(0x1.FFFFFFFFFFFFEp+126, 0x7FFFFFFFFFFFF8000000000000000000);
    test__fixdfti(-0x1.0000000000000p+128, -0x80000000000000000000000000000000);
}
