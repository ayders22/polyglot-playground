use hello_world::hello_world;

#[test]
fn hello_world_returns_42() {
    assert_eq!(hello_world(), 42);
}
