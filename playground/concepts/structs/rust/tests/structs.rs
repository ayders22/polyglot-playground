use structs::{
    Actrice, Enterprise, Point, Rectangle, RgbColor, Summary, UnitMarker, DEFAULT_ENTERPRISE,
};

#[test]
fn struct_has_scalar_value_members() {
    let point = Point { x: 3, y: 4 };

    assert_eq!(point.x, 3);
    assert_eq!(point.y, 4);
}

#[test]
fn struct_can_be_formatted_with_derived_debug() {
    let point = Point { x: 3, y: 4 };

    assert_eq!(format!("{point:?}"), "Point { x: 3, y: 4 }");
}

#[test]
#[allow(clippy::clone_on_copy)]
fn struct_can_be_cloned_with_derived_clone() {
    let point = Point { x: 3, y: 4 };
    let cloned = point.clone();

    assert_eq!(cloned.x, 3);
    assert_eq!(cloned.y, 4);
}

#[test]
fn struct_can_be_copied_with_derived_copy() {
    let point = Point { x: 3, y: 4 };
    let copied = point;

    assert_eq!(point.x, 3);
    assert_eq!(copied.y, 4);
}

#[test]
fn struct_can_be_compared_with_derived_partial_eq() {
    let point = Point { x: 3, y: 4 };
    let matching_point = Point { x: 3, y: 4 };
    let different_point = Point { x: 4, y: 3 };

    assert_eq!(point, matching_point);
    assert_ne!(point, different_point);
}

#[test]
fn struct_implements_custom_trait() {
    let point = Point { x: 3, y: 4 };

    assert_eq!(point.summary(), "Point at (3, 4)");
}

#[test]
fn tuple_struct_uses_positional_fields() {
    let red = RgbColor(255, 0, 0);

    assert_eq!(red.0, 255);
    assert_eq!(red.1, 0);
    assert_eq!(red.2, 0);
}

#[test]
fn unit_struct_has_no_fields() {
    let marker = UnitMarker;

    assert_eq!(marker, UnitMarker);
}

#[test]
fn struct_has_associated_function() {
    let rectangle = Rectangle::new(3, 4);

    assert_eq!(rectangle.width, 3);
    assert_eq!(rectangle.height, 4);
    assert_eq!(rectangle.area(), 12);
}

#[test]
fn struct_update_syntax_overrides_selected_fields() {
    let original = Point { x: 3, y: 4 };
    let translated = Point { x: 8, ..original };

    assert_eq!(translated.x, 8);
    assert_eq!(translated.y, 4);
}

#[test]
fn struct_has_static_str_members() {
    let actrice = Actrice {
        name: "eva",
        surname: "green",
        id: 1,
    };

    assert_eq!(actrice.name, "eva");
    assert_eq!(actrice.surname, "green");
    assert_eq!(actrice.id, 1);
}

#[test]
fn struct_has_borrowed_and_static_members() {
    let name = String::from("Google");
    let year_founded = 1998;
    let is_active = true;
    let country = "US";

    let enterprise = Enterprise {
        name: &name,
        country,
        year_founded: &year_founded,
        is_active: &is_active,
    };

    assert_eq!(enterprise.name, "Google");
    assert_eq!(enterprise.country, "US");
    assert_eq!(enterprise.year_founded, &1998);
    assert_eq!(enterprise.is_active, &true);
}

#[test]
fn static_item_has_expected_values() {
    assert_eq!(DEFAULT_ENTERPRISE.name, "Acme");
    assert_eq!(DEFAULT_ENTERPRISE.country, "US");
    assert_eq!(DEFAULT_ENTERPRISE.year_founded, &2000);
    assert_eq!(DEFAULT_ENTERPRISE.is_active, &false);
}
