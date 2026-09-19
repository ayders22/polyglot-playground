#include "min_max.h"

#include <benchmark/benchmark.h>

#include <array>
#include <cstddef>
#include <cstdint>

namespace {

constexpr std::size_t value_count = 10'000;

std::array<int, value_count> make_values() {
  std::array<int, value_count> values{};

  for (std::size_t i = 0; i < values.size(); ++i) {
    values[i] = static_cast<int>((i * 7'919) % value_count);
  }

  return values;
}

template <auto implm> void benchmark_min_max(benchmark::State &state) {
  const auto values = make_values();

  for ([[maybe_unused]] auto iteration : state) {
    int minimum = 0;
    int maximum = 0;
    bool succeeded = implm(values.data(), values.size(), &minimum, &maximum);

    benchmark::DoNotOptimize(succeeded);
    benchmark::DoNotOptimize(minimum);
    benchmark::DoNotOptimize(maximum);
  }

  state.SetItemsProcessed(static_cast<int64_t>(state.iterations()) *
                          static_cast<int64_t>(values.size()));
}

BENCHMARK_TEMPLATE(benchmark_min_max, find_min_max_builtin);
BENCHMARK_TEMPLATE(benchmark_min_max, find_min_max_manual);

} // namespace