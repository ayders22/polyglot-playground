use hello_world::{hello_world_impl1, hello_world_impl2};

#[test]
fn hello_world_impl1_returns_42() {
    assert_eq!(hello_world_impl1(), 42);
}

#[test]
fn hello_world_impl2_returns_42() {
    assert_eq!(hello_world_impl2(), 42);
}
