def find_min_max_builtin(arr: list) -> tuple[int, int]:
    if not arr:
        raise ValueError("The input array is empty.")

    min_value = min(arr)
    max_value = max(arr)

    return (min_value, max_value)


def find_min_max_manual(arr: list) -> tuple[int, int]:
    if not arr:
        raise ValueError("The input array is empty.")

    min_value = arr[0]
    max_value = arr[0]

    for num in arr:
        if num < min_value:
            min_value = num
        elif num > max_value:
            max_value = num

    return (min_value, max_value)
