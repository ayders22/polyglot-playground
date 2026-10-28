from driver import SpiDriverCreator, UartDriverCreator


def test_uart_creator_opens_created_driver() -> None:
    creator = UartDriverCreator()

    assert creator.open_driver()


def test_spi_creator_opens_created_driver() -> None:
    creator = SpiDriverCreator()

    assert not creator.open_driver()
