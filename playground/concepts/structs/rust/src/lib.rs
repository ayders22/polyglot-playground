pub struct Point {
    pub x: i32,
    pub y: i32,
}

pub struct RgbColor(pub u8, pub u8, pub u8);

#[derive(Debug, PartialEq)]
pub struct UnitMarker;

pub struct Rectangle {
    pub width: u32,
    pub height: u32,
}

impl Rectangle {
    pub fn new(width: u32, height: u32) -> Self {
        Self { width, height }
    }

    pub fn area(&self) -> u32 {
        self.width * self.height
    }
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
