#ifndef SPI_DRIVER_HPP
#define SPI_DRIVER_HPP

#include "device_driver.hpp"

class SpiDriver final : public DeviceDriver {
public:
  bool open() override;
};

#endif
