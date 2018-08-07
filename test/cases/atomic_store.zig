const std = @import("std");
const assert = std.debug.assert;
const builtin = @import("builtin");
const AtomicOrder = builtin.AtomicOrder;
const AtomicRmwOp = builtin.AtomicRmwOp;


test "test.atomicrmw.xchg" {
    var data: u8 = 123;
    var prev_value = @atomicRmw(u8, &data, AtomicRmwOp.Xchg, 42, AtomicOrder.SeqCst);
    assert(prev_value == 123);
    assert(data == 42);
}

test "test.atomicload" {
    var data: u8 = 123;
    assert(@atomicLoad(u8, &data, AtomicOrder.Acquire) == 123);
}

//test "test.atomicstore" {
//    var data: u8 = 123;
//    @atomicStore(u8, &data, 5, AtomicOrder.Release);
//    assert(data == 5);
//}
