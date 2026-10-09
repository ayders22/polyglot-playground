use structs::Point;

#[test]
fn point_stores_its_coordinates() {
    let point = Point { x: 3, y: 4 };

    assert_eq!(point.x, 3);
    assert_eq!(point.y, 4);
}
