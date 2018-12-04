const is_test = @import("builtin").is_test;
const std = @import("std");
const math = std.math;
const Log2Int = std.math.Log2Int;
const maxInt = std.math.maxInt;
const minInt = std.math.minInt;
const warn = std.debug.warn;

const DBG = false;

pub fn fixint(comptime fp_t: type, comptime fixint_t: type, a: fp_t) fixint_t {
    @setRuntimeSafety(is_test);

    const Di1 = switch (fixint_t) {
        i1 => false, // We can't print i1
        else => DBG,
    };

    const fixuint_t = @IntType(false, fixint_t.bit_count);

    const rep_t = switch (fp_t) {
        f32 => u32,
        f64 => u64,
        f128 => u128,
        else => unreachable,
    };
    const srep_t = @IntType(true, rep_t.bit_count);
    const significandBits = switch (fp_t) {
        f32 => 23,
        f64 => 52,
        f128 => 112,
        else => unreachable,
    };

    const typeWidth = rep_t.bit_count;
    const exponentBits = (typeWidth - significandBits - 1);
    const signBit = (rep_t(1) << (significandBits + exponentBits));
    const maxExponent = ((1 << exponentBits) - 1);
    const exponentBias = (maxExponent >> 1);

    const implicitBit = (rep_t(1) << significandBits);
    const significandMask = (implicitBit - 1);

    // Break a into negative, exponent, significand
    const aRep: rep_t = @bitCast(rep_t, a);
    const absMask = signBit - 1;
    const aAbs: rep_t = aRep & absMask;

    const negative = (aRep & signBit) != 0;
    const exponent = @intCast(i32, aAbs >> significandBits) - exponentBias;
    const significand: rep_t = (aAbs & significandMask) | implicitBit;

    if (DBG) warn("negative={x} exponent={}:{x} significand={}:{x}\n", negative, exponent, exponent, significand, significand);

    // If exponent is negative, the result is zero.
    if (exponent < 0) {
        if (DBG) warn("neg exponent result=0:0\n");
        return 0;
    }

    var result: fixint_t = undefined;

    const ShiftedResultType = if (fixint_t.bit_count > rep_t.bit_count) fixuint_t else rep_t;
    var shifted_result: ShiftedResultType = undefined;

    // If the value is too large for the integer type, saturate.
    if (@intCast(usize, exponent) >= fixint_t.bit_count) {
        result = if (negative) fixint_t(minInt(fixint_t)) else fixint_t(maxInt(fixint_t));
        if (Di1) warn("too large result={}:{x}\n", result, result);
        return result;
    }

    // If 0 <= exponent < significandBits, right shift to get the result.
    // Otherwise, shift left.
    if (exponent < significandBits) {
        if (DBG) warn("exponent:{} < significandBits:{})\n", exponent, usize(significandBits));
        var diff = @intCast(ShiftedResultType, significandBits - exponent);
        if (DBG) warn("diff={}:{x}\n", diff, diff);
        var shift = @intCast(Log2Int(ShiftedResultType), diff);
        if (DBG) warn("significand={}:{x} right shift={}:{x}\n", significand, significand, shift, shift);
        shifted_result = @intCast(ShiftedResultType, significand) >> shift;
    } else {
        if (DBG) warn("exponent:{} >= significandBits:{})\n", exponent, usize(significandBits));
        var diff = @intCast(ShiftedResultType, exponent - significandBits);
        if (DBG) warn("diff={}:{x}\n", diff, diff);
        var shift = @intCast(Log2Int(ShiftedResultType), diff);
        if (Di1) warn("significand={}:{x} left shift={}:{x}\n", significand, significand, shift, shift);
        shifted_result = @intCast(ShiftedResultType, significand) << shift;
    }
    if (DBG) warn("shifted_result={}\n", shifted_result);
    if (negative) {
        // The result will be negative, but shifted_result is unsigned so compare >= -maxInt
        if (shifted_result >= -math.minInt(fixint_t)) {
            // Saturate
            result = math.minInt(fixint_t);
        } else {
            // Cast shifted_result to result
            result = -1 * @intCast(fixint_t, shifted_result);
        }
    } else {
        // The result will be positive
        if (shifted_result >= math.maxInt(fixint_t)) {
            // Saturate
            result = math.maxInt(fixint_t);
        } else {
            // Cast shifted_result to result
            result = @intCast(fixint_t, shifted_result);
        }
    }
    if (Di1) warn("result={}:{x}\n", result, result);
    return result;
}
