from device_driver import DeviceDriver


class UartDriver(DeviceDriver):
    def open(self) -> bool:
        print("/dev/tty opened")
        return True
