from iterators import EvenIterator


def test_happy_path() -> None:
    even_numbers = []
    for n in EvenIterator([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]):
        even_numbers.append(n)

    assert even_numbers == [0, 2, 4, 6, 8, 10]


def test_empty_input() -> None:
    even_numbers = []
    for n in EvenIterator([]):
        even_numbers.append(n)

    assert len(even_numbers) == 0
