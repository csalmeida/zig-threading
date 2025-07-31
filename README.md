# Zig Single and Multi-Threading Examples

A comprehensive demonstration of single-threaded vs multi-threaded programming in Zig, showcasing performance differences through prime number calculation.

## Overview

This project contains practical examples that compare single-threaded and multi-threaded approaches to CPU-intensive tasks. The examples use prime number calculation across a range of 1 to 7,000,000 to demonstrate the performance benefits of parallel processing.

## Project Structure

```
zig-threading/
├── src/
│   ├── main.zig         # Main entry point that runs both examples
│   ├── single.zig       # Single-threaded prime calculation
│   └── multi.zig        # Multi-threaded prime calculation
├── build.zig            # Build configuration
├── build.zig.zon        # Package manifest
└── README.md
```


## Examples

### Single-Threaded Implementation (`single.zig`)
- Calculates primes sequentially on a single thread
- Simple and predictable execution
- Only utilizes one CPU core regardless of system capabilities
- Serves as a baseline for performance comparison

### Multi-Threaded Implementation (`multi.zig`)
- Divides the work across multiple threads (10 threads by default)
- Each thread processes a subset of the number range
- Uses mutex for thread-safe result aggregation
- Utilizes multiple CPU cores for improved performance

## Key Features

- **CPU Detection**: Automatically detects the number of available CPU cores
- **Performance Timing**: Measures and reports execution time for both approaches
- **Thread Safety**: Demonstrates proper use of mutexes for shared data access
- **Work Distribution**: Shows how to divide computational work across threads
- **Progress Reporting**: Each worker thread reports its completion status

## Requirements

- Zig 0.14.1 or later

## Building and Running

### Build the project:
```bash
zig build
```

### Run the examples:
```bash
zig build run
```

### Run tests:
```bash
zig build test
```

Expected Output

When you run the program, you'll see output similar to:

```bash
System has 10 CPU cores

Found 476648 primes in 1561 milliseconds
Single-threaded execution completed

Worker thread completed range 1-700000: found 56543 primes
Worker thread completed range 700001-1400000: found 50583 primes
Worker thread completed range 1400001-2100000: found 48679 primes
Worker thread completed range 2100001-2800000: found 47557 primes
Worker thread completed range 2800001-3500000: found 46788 primes
Worker thread completed range 3500001-4200000: found 46164 primes
Worker thread completed range 4200001-4900000: found 45678 primes
Worker thread completed range 5600001-6300000: found 44871 primes
Worker thread completed range 4900001-5600000: found 45210 primes
Worker thread completed range 6300001-7000000: found 44575 primes
Multi-threaded result: 476648 primes in 242 milliseconds
All worker threads completed
```

## Performance Analysis

The multi-threaded implementation typically shows significant performance improvements:
- **Speedup**: Often 2-4x faster depending on CPU core count
- **CPU Utilization**: Better utilization of available system resources
- **Scalability**: Performance scales with the number of available cores

## Learning Objectives

This project demonstrates:
- Basic threading concepts in Zig
- Thread synchronization using mutexes
- Work distribution strategies
- Performance measurement and comparison
- Thread lifecycle management (spawn and join)
