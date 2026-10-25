import pytest
from device_driver import DeviceDriver
from driver import DriverCreator, SpiDriverCreator, UartDriverCreator
from spi_driver import SpiDriver
from uart_driver import UartDriver


def test_device_driver_class_is_abstract() -> None:
    with pytest.raises(TypeError, match="abstract class DeviceDriver"):
        DeviceDriver()


def test_driver_creator_class_is_abstract() -> None:
    with pytest.raises(TypeError, match="abstract class DriverCreator"):
        DriverCreator()


def test_uart_driver_class_can_be_instantiated(capsys) -> None:
    uart_driver = UartDriver()
    uart_driver.open()

    assert capsys.readouterr().out == "/dev/tty opened\n"


def test_spi_driver_class_can_be_instantiated(capsys) -> None:
    spi_driver = SpiDriver()
    spi_driver.open()

    assert capsys.readouterr().out == "/dev/spi opened\n"


def test_uart_creator_creates_driver_through_creator_abstraction(capsys) -> None:
    concrete_creator = UartDriverCreator()
    creator: DriverCreator = concrete_creator
    driver = creator.create_driver()
    driver.open()

    assert capsys.readouterr().out == "/dev/tty opened\n"


def test_spi_creator_creates_driver_through_creator_abstraction(capsys) -> None:
    concrete_creator = SpiDriverCreator()
    creator: DriverCreator = concrete_creator
    driver = creator.create_driver()
    driver.open()

    assert capsys.readouterr().out == "/dev/spi opened\n"


def test_uart_creator_opens_created_driver(capsys) -> None:
    creator = UartDriverCreator()

    assert creator.open_driver()
    assert capsys.readouterr().out == "/dev/tty opened\n"


def test_spi_creator_opens_created_driver(capsys) -> None:
    creator = SpiDriverCreator()

    assert creator.open_driver()
    assert capsys.readouterr().out == "/dev/spi opened\n"
