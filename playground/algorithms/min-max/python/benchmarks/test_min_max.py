from collections.abc import Callable, Iterable

import pytest
from min_max import find_min_max_builtin, find_min_max_manual

MinMaxFunctions = Callable[[Iterable[int]], tuple[int, int]]
FUNCTIONS_TO_TEST: tuple[MinMaxFunctions, MinMaxFunctions] = (
    find_min_max_builtin,
    find_min_max_manual,
)
FUNCTION_IDS = tuple(f.__name__ for f in FUNCTIONS_TO_TEST)
BENCHMARK_VALUES = [(index * 7_919) % 10_000 for index in range(10_000)]


@pytest.mark.parametrize("func", FUNCTIONS_TO_TEST, ids=FUNCTION_IDS)
def test_find_min_max_benchmark(benchmark, func: MinMaxFunctions) -> None:
    result = benchmark(func, BENCHMARK_VALUES)

    assert result == (0, 9_999)
