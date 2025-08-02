const std = @import("std");
const single = @import("single.zig");
const multi = @import("multi.zig");

pub fn main() !void {
  const cpu_count = try std.Thread.getCpuCount();
  std.debug.print("System has {} CPU cores\n", .{cpu_count});

  single.runRoutine(); // Single threaded code.
  try multi.runRoutine(); // Multi threaded code.
}
