use factory_method::{DriverCreator, SpiDriverCreator, UartDriverCreator};

#[test]
fn uart_creator_opens_created_driver() {
    assert!(UartDriverCreator.open_driver());
}

#[test]
fn spi_creator_opens_created_driver() {
    assert!(!SpiDriverCreator.open_driver());
}
