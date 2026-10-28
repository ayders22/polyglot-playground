from device_driver import DeviceDriver


class SpiDriver(DeviceDriver):
    def open(self) -> bool:
        return False
