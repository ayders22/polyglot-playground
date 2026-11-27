#include <benchmark/benchmark.h>

extern "C" {
#include "hello_world.h"
}

namespace {

void benchmark_hello_world_impl1(benchmark::State &state)
{
  for ([[maybe_unused]] auto iteration : state) {
    int result = hello_world_impl1();
    benchmark::DoNotOptimize(result);
  }
}

void benchmark_hello_world_impl2(benchmark::State &state)
{
  for ([[maybe_unused]] auto iteration : state) {
    int result = hello_world_impl2();
    benchmark::DoNotOptimize(result);
  }
}

BENCHMARK(benchmark_hello_world_impl1);
BENCHMARK(benchmark_hello_world_impl2);

} // namespace