#include "driver.hpp"
#include "spi_driver.hpp"
#include "uart_driver.hpp"

bool DriverCreator::open_driver() const
{
  return create_driver()->open();
}

std::unique_ptr<DeviceDriver> UartDriverCreator::create_driver() const
{
  return std::make_unique<UartDriver>();
}

std::unique_ptr<DeviceDriver> SpiDriverCreator::create_driver() const
{
  return std::make_unique<SpiDriver>();
}
