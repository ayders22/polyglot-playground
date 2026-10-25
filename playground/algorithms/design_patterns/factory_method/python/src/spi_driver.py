from device_driver import DeviceDriver


class SpiDriver(DeviceDriver):
    def open(self) -> bool:
        print("/dev/spi opened")
        return True
