from hello_world import hello_world_impl1, hello_world_impl2


def test_hello_world_impl1() -> None:
    assert hello_world_impl1() == 42


def test_hello_world_impl2() -> None:
    assert hello_world_impl2() == 42
