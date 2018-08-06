const std = @import("std");
const assert = std.debug.assert;
const builtin = @import("builtin");
const AtomicOrder = builtin.AtomicOrder;


test "atomicstore" {
    var value: u8 = 123;
    testAtomicStore(&value, 21);
    assert(value == 21);
}

fn testAtomicStore(ptr: *u8, value: u8) void {
    @atomicStore(u8, ptr, value, AtomicOrder.Release);
}
