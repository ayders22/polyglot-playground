#include "hello_world.hpp"

#include <benchmark/benchmark.h>

namespace {

void benchmark_hello_world(benchmark::State &state)
{
  for ([[maybe_unused]] auto iteration : state) {
    auto message = hello_world();
    benchmark::DoNotOptimize(message);
  }
}

BENCHMARK(benchmark_hello_world);

} // namespace
