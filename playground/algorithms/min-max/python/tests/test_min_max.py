from collections.abc import Callable, Iterable

import pytest
from min_max import find_min_max_builtin, find_min_max_manual

MinMaxFunctions = Callable[[Iterable[int]], tuple[int, int]]
FUNCTIONS_TO_TEST: tuple[MinMaxFunctions, MinMaxFunctions] = (
    find_min_max_builtin,
    find_min_max_manual,
)
FUNCTION_IDS = tuple(f.__name__ for f in FUNCTIONS_TO_TEST)


@pytest.mark.parametrize("func", FUNCTIONS_TO_TEST, ids=FUNCTION_IDS)
def test_find_min_max(func: MinMaxFunctions) -> None:
    assert func([3, 1, 4, 1, 5, 9, 2, 6, 5]) == (1, 9)
