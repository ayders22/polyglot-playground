from abc import ABC, abstractmethod

from device_driver import DeviceDriver
from spi_driver import SpiDriver
from uart_driver import UartDriver


class DriverCreator(ABC):
    @abstractmethod
    def create_driver(self) -> DeviceDriver:
        pass

    def open_driver(self) -> bool:
        return self.create_driver().open()


class UartDriverCreator(DriverCreator):
    def create_driver(self) -> DeviceDriver:
        return UartDriver()


class SpiDriverCreator(DriverCreator):
    def create_driver(self) -> DeviceDriver:
        return SpiDriver()
