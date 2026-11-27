#ifndef UART_DRIVER_HPP
#define UART_DRIVER_HPP

#include "device_driver.hpp"

class UartDriver final : public DeviceDriver {
public:
  bool open() override;
};

#endif
