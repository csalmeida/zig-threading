//! By convention, root.zig is the root source file when making a library. If
//! you are making an executable, the convention is to delete this file and
//! start with main.zig instead.
const std = @import("std");

const WorkerData = struct {
    start: u64,
    end: u64,
    result: *u64,
    mutex: *std.Thread.Mutex,
};

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

fn workerThread(data: WorkerData) void {
    var local_count: u64 = 0;
    var i = data.start;

    // Each thread processes its assigned range
    while (i <= data.end) : (i += 1) {
        if (isPrime(i)) {
            local_count += 1;
        }
    }

    // Thread-safe update of shared result
    data.mutex.lock();
    defer data.mutex.unlock();
    data.result.* += local_count;

    std.debug.print("Worker thread completed range {}-{}: found {} primes\n",
                   .{ data.start, data.end, local_count });
}

pub fn runRoutine() !void {
    // In the case for this M1 Max running macOS, it shows 10 CPU cores, so assigning 1 thread per each core.
    const num_threads = 10;
    const total_range = 7_000_000;
    const range_per_thread = total_range / num_threads;

    var total_primes: u64 = 0;
    var mutex = std.Thread.Mutex{};
    var threads: [num_threads]std.Thread = undefined;

    const start_time = std.time.milliTimestamp();

    // Create and start worker threads
    for (&threads, 0..) |*thread, i| {
        const worker_data = WorkerData{
            .start = i * range_per_thread + 1,
            .end = (i + 1) * range_per_thread,
            .result = &total_primes,
            .mutex = &mutex,
        };

        thread.* = try std.Thread.spawn(.{}, workerThread, .{worker_data});
    }

    // Wait for all threads to complete
    for (&threads) |*thread| {
        thread.join();
    }

    const end_time = std.time.milliTimestamp();
    const duration = end_time - start_time;

    std.debug.print("Multi-threaded result: {} primes in {} milliseconds\n",
                   .{ total_primes, duration });
    std.debug.print("All worker threads completed\n", .{});
}
