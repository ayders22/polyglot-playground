use structs::{Actrice, Enterprise, Point, DEFAULT_ENTERPRISE};

#[test]
fn struct_has_scalar_value_members() {
    let point = Point { x: 3, y: 4 };

    assert_eq!(point.x, 3);
    assert_eq!(point.y, 4);
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
