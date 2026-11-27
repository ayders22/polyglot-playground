use crate::DeviceDriver;

pub struct SpiDriver;

impl DeviceDriver for SpiDriver {
    fn open(&self) -> bool {
        false
    }
}
