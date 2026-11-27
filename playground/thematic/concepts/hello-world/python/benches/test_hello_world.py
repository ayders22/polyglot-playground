from collections.abc import Callable

import pytest
from hello_world import hello_world_impl1, hello_world_impl2

HelloWorldFunction = Callable[[], int]
FUNCTIONS_TO_BENCHMARK: tuple[HelloWorldFunction, ...] = (
    hello_world_impl1,
    hello_world_impl2,
)
FUNCTION_IDS = tuple(func.__name__ for func in FUNCTIONS_TO_BENCHMARK)


@pytest.mark.parametrize("func", FUNCTIONS_TO_BENCHMARK, ids=FUNCTION_IDS)
def test_hello_world_benchmark(benchmark, func: HelloWorldFunction) -> None:
    assert benchmark(func) == 42
