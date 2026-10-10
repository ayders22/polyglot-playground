pub struct Point {
    pub x: i32,
    pub y: i32,
}

pub struct Actrice {
    pub name: &'static str,
    pub surname: &'static str,
    pub id: i32,
}

pub struct Enterprise<'a> {
    pub name: &'a str,
    pub country: &'static str,
    pub year_founded: &'a u32,
    pub is_active: &'a bool,
}

pub static DEFAULT_ENTERPRISE: Enterprise<'static> = Enterprise {
    name: "Acme",
    country: "US",
    year_founded: &2000,
    is_active: &false,
};
