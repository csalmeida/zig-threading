const std = @import("std");

/// Iterates from the start number to the end number, for each number it determines is it is a prime number.
fn calculatePrimes(start: u64, end: u64) u64 {
    var count: u64 = 0;
    var i = start;

    while (i <= end) : (i += 1) {
        if (isPrime(i)) {
            count += 1;
        }
    }

    return count;
}

/// Determines if number passed to it is a prime number.
fn isPrime(n: u64) bool {
    if (n < 2) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;

    var i: u64 = 3;
    while (i * i <= n) : (i += 2) {
        if (n % i == 0) return false;
    }
    return true;
}

/// Runs single threaded routine.
/// This program runs entirely on a single thread, executing each prime number check sequentially. /// While simple and predictable, it only utilizes one CPU core regardless of how many cores your system has available.
pub fn runRoutine() void {
  const start_time = std.time.milliTimestamp();

  // Calculates primes sequencially from 1 to 7_000_000:
  const prime_count = calculatePrimes(1, 7_000_000);

  const end_time = std.time.milliTimestamp();
  const duration = end_time - start_time;

  std.debug.print("Found {} primes in {} milliseconds\n", .{ prime_count, duration });
  std.debug.print("Single-threaded execution completed\n", .{});
}
