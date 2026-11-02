pub trait DeviceDriver {
    fn open(&self) -> bool;
}
