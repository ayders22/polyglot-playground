use crate::DeviceDriver;

pub struct UartDriver;

impl DeviceDriver for UartDriver {
    fn open(&self) -> bool {
        true
    }
}
