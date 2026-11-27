use crate::{DeviceDriver, SpiDriver, UartDriver};

pub trait DriverCreator {
    fn create_driver(&self) -> Box<dyn DeviceDriver>;

    fn open_driver(&self) -> bool {
        self.create_driver().open()
    }
}

pub struct UartDriverCreator;

impl DriverCreator for UartDriverCreator {
    fn create_driver(&self) -> Box<dyn DeviceDriver> {
        Box::new(UartDriver)
    }
}

pub struct SpiDriverCreator;

impl DriverCreator for SpiDriverCreator {
    fn create_driver(&self) -> Box<dyn DeviceDriver> {
        Box::new(SpiDriver)
    }
}
