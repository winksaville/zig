const is_test = @import("builtin").is_test;
const std = @import("std");
const math = std.math;
const assert = std.debug.assert;
const warn = std.debug.warn;

const fixint = @import("fixint.zig").fixint;

fn test__fixint(comptime fp_t: type, comptime fixint_t: type, a: fp_t, expected: fixint_t) void {
    const x = fixint(fp_t, fixint_t, a);
    assert(x == expected);
}

test "fixint.u1" {
    test__fixint(f32, i1, -math.inf_f32, -1);
    test__fixint(f32, i1, -math.f32_max, -1);
    test__fixint(f32, i1, -2.0, -1);
    test__fixint(f32, i1, -1.1, -1);
    test__fixint(f32, i1, -1.0, -1);
    test__fixint(f32, i1, -0.9, 0);
    test__fixint(f32, i1, -0.1, 0);
    test__fixint(f32, i1, -math.f32_min, 0);
    test__fixint(f32, i1, -0.0, 0);
    test__fixint(f32, i1, 0.0, 0);
    test__fixint(f32, i1, math.f32_min, 0);
    test__fixint(f32, i1, 0.1, 0);
    test__fixint(f32, i1, 0.9, 0);
    test__fixint(f32, i1, 1.0, 0);
    test__fixint(f32, i1, 2.0, 0);
    test__fixint(f32, i1, math.f32_max, 0);
    test__fixint(f32, i1, math.inf_f32, 0);
}

test "fixint.i2" {
    test__fixint(f32, i2, -math.inf_f32, -2);
    test__fixint(f32, i2, -math.f32_max, -2);
    test__fixint(f32, i2, -2.0, -2);
    test__fixint(f32, i2, -1.9, -1);
    test__fixint(f32, i2, -1.1, -1);
    test__fixint(f32, i2, -1.0, -1);
    test__fixint(f32, i2, -0.9, 0);
    test__fixint(f32, i2, -0.1, 0);
    test__fixint(f32, i2, -math.f32_min, 0);
    test__fixint(f32, i2, -0.0, 0);
    test__fixint(f32, i2, 0.0, 0);
    test__fixint(f32, i2, math.f32_min, 0);
    test__fixint(f32, i2, 0.1, 0);
    test__fixint(f32, i2, 0.9, 0);
    test__fixint(f32, i2, 1.0, 1);
    test__fixint(f32, i2, 2.0, 1);
    test__fixint(f32, i2, math.f32_max, 1);
    test__fixint(f32, i2, math.inf_f32, 1);
}

test "fixint.i3" {
    test__fixint(f32, i3, -math.inf_f32, -4);
    test__fixint(f32, i3, -math.f32_max, -4);
    test__fixint(f32, i3, -4.0, -4);
    test__fixint(f32, i3, -3.0, -3);
    test__fixint(f32, i3, -2.0, -2);
    test__fixint(f32, i3, -1.9, -1);
    test__fixint(f32, i3, -1.1, -1);
    test__fixint(f32, i3, -1.0, -1);
    test__fixint(f32, i3, -0.9, 0);
    test__fixint(f32, i3, -0.1, 0);
    test__fixint(f32, i3, -math.f32_min, 0);
    test__fixint(f32, i3, -0.0, 0);
    test__fixint(f32, i3, 0.0, 0);
    test__fixint(f32, i3, math.f32_min, 0);
    test__fixint(f32, i3, 0.1, 0);
    test__fixint(f32, i3, 0.9, 0);
    test__fixint(f32, i3, 1.0, 1);
    test__fixint(f32, i3, 2.0, 2);
    test__fixint(f32, i3, 3.0, 3);
    test__fixint(f32, i3, 4.0, 3);
    test__fixint(f32, i3, math.f32_max, 3);
    test__fixint(f32, i3, math.inf_f32, 3);
}

test "fixint.i32" {
    test__fixint(f64, i32, -math.inf_f64, math.minInt(i32));
    test__fixint(f64, i32, -math.f64_max, math.minInt(i32));
    test__fixint(f64, i32, @intToFloat(f64, math.minInt(i32)), math.minInt(i32));
    test__fixint(f64, i32, @intToFloat(f64, math.minInt(i32))+1, math.minInt(i32)+1);
    test__fixint(f64, i32, -2.0, -2);
    test__fixint(f64, i32, -1.9, -1);
    test__fixint(f64, i32, -1.1, -1);
    test__fixint(f64, i32, -1.0, -1);
    test__fixint(f64, i32, -0.9, 0);
    test__fixint(f64, i32, -0.1, 0);
    test__fixint(f64, i32, -math.f32_min, 0);
    test__fixint(f64, i32, -0.0, 0);
    test__fixint(f64, i32, 0.0, 0);
    test__fixint(f64, i32, math.f32_min, 0);
    test__fixint(f64, i32, 0.1, 0);
    test__fixint(f64, i32, 0.9, 0);
    test__fixint(f64, i32, 1.0, 1);
    test__fixint(f64, i32, @intToFloat(f64, math.maxInt(i32))-1, math.maxInt(i32)-1);
    test__fixint(f64, i32, @intToFloat(f64, math.maxInt(i32)), math.maxInt(i32));
    test__fixint(f64, i32, math.f64_max, math.maxInt(i32));
    test__fixint(f64, i32, math.inf_f64, math.maxInt(i32));
}

test "fixint.i64" {
    test__fixint(f64, i64, -math.inf_f64, math.minInt(i64));
    test__fixint(f64, i64, -math.f64_max, math.minInt(i64));
    test__fixint(f64, i64, @intToFloat(f64, math.minInt(i64)), math.minInt(i64));
    test__fixint(f64, i64, @intToFloat(f64, math.minInt(i64))+1, math.minInt(i64));
    test__fixint(f64, i64, -2.0, -2);
    test__fixint(f64, i64, -1.9, -1);
    test__fixint(f64, i64, -1.1, -1);
    test__fixint(f64, i64, -1.0, -1);
    test__fixint(f64, i64, -0.9, 0);
    test__fixint(f64, i64, -0.1, 0);
    test__fixint(f64, i64, -math.f32_min, 0);
    test__fixint(f64, i64, -0.0, 0);
    test__fixint(f64, i64, 0.0, 0);
    test__fixint(f64, i64, math.f32_min, 0);
    test__fixint(f64, i64, 0.1, 0);
    test__fixint(f64, i64, 0.9, 0);
    test__fixint(f64, i64, 1.0, 1);
    test__fixint(f64, i64, @intToFloat(f64, math.maxInt(i64))-1, math.maxInt(i64));
    test__fixint(f64, i64, @intToFloat(f64, math.maxInt(i64)), math.maxInt(i64));
    test__fixint(f64, i64, math.f64_max, math.maxInt(i64));
    test__fixint(f64, i64, math.inf_f64, math.maxInt(i64));
}

test "fixint.i128" {
    test__fixint(f64, i128, -math.inf_f64, math.minInt(i128));
    test__fixint(f64, i128, -math.f64_max, math.minInt(i128));
    test__fixint(f64, i128, @intToFloat(f64, math.minInt(i128)), math.minInt(i128));
    test__fixint(f64, i128, @intToFloat(f64, math.minInt(i128))+1, math.minInt(i128));
    test__fixint(f64, i128, -2.0, -2);
    test__fixint(f64, i128, -1.9, -1);
    test__fixint(f64, i128, -1.1, -1);
    test__fixint(f64, i128, -1.0, -1);
    test__fixint(f64, i128, -0.9, 0);
    test__fixint(f64, i128, -0.1, 0);
    test__fixint(f64, i128, -math.f32_min, 0);
    test__fixint(f64, i128, -0.0, 0);
    test__fixint(f64, i128, 0.0, 0);
    test__fixint(f64, i128, math.f32_min, 0);
    test__fixint(f64, i128, 0.1, 0);
    test__fixint(f64, i128, 0.9, 0);
    test__fixint(f64, i128, 1.0, 1);
    test__fixint(f64, i128, @intToFloat(f64, math.maxInt(i128))-1, math.maxInt(i128));
    test__fixint(f64, i128, @intToFloat(f64, math.maxInt(i128)), math.maxInt(i128));
    test__fixint(f64, i128, math.f64_max, math.maxInt(i128));
    test__fixint(f64, i128, math.inf_f64, math.maxInt(i128));

    test__fixint(f64, i128, 0x1.0p+0, i128(1) << 0);
    test__fixint(f64, i128, 0x1.0p+1, i128(1) << 1);
    test__fixint(f64, i128, 0x1.0p+2, i128(1) << 2);
    test__fixint(f64, i128, 0x1.0p+50, i128(1) << 50);
    test__fixint(f64, i128, 0x1.0p+51, i128(1) << 51);
    test__fixint(f64, i128, 0x1.0p+52, i128(1) << 52);
    test__fixint(f64, i128, 0x1.0p+53, i128(1) << 53);

    test__fixint(f64, i128, 0x1.0p+125, i128(0x1) << 125-0);
    test__fixint(f64, i128, 0x1.8p+125, i128(0x3) << 125-1);
    test__fixint(f64, i128, 0x1.Cp+125, i128(0x7) << 125-2);
    test__fixint(f64, i128, 0x1.Ep+125, i128(0xF) << 125-3);
    test__fixint(f64, i128, 0x1.Fp+125, i128(0x1F) << 125-4);
    test__fixint(f64, i128, 0x1.F8p+125, i128(0x3F) << 125-5);
    test__fixint(f64, i128, 0x1.FCp+125, i128(0x7F) << 125-6);
    test__fixint(f64, i128, 0x1.FEp+125, i128(0xFF) << 125-7);
    test__fixint(f64, i128, 0x1.FFp+125, i128(0x1FF) << 125-8);
    test__fixint(f64, i128, 0x1.FF8p+125, i128(0x3FF) << 125-9);
    test__fixint(f64, i128, 0x1.FFFp+125, i128(0x1FFF) << 125-12);
    test__fixint(f64, i128, 0x1.FFFFp+125, i128(0x1FFFF) << 125-16);
    test__fixint(f64, i128, 0x1.FFFFFp+125, i128(0x1FFFFF) << 125-20);
    test__fixint(f64, i128, 0x1.FFFFFFFFFp+125, i128(0x1FFFFFFFFF) << 125-36);
    test__fixint(f64, i128, 0x1.FFFFFFFFFFFFEp+125, i128(0xFFFFFFFFFFFFF) << 125-51);
    test__fixint(f64, i128, 0x1.FFFFFFFFFFFFFp+125, i128(0x1FFFFFFFFFFFFF) << 125-52);
}
