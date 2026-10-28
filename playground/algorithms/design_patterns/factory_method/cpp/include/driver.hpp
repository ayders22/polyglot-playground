#ifndef DRIVER_HPP
#define DRIVER_HPP

#include "device_driver.hpp"

#include <memory>

class DriverCreator {
public:
  virtual ~DriverCreator() = default;
  virtual std::unique_ptr<DeviceDriver> create_driver() const = 0;
  bool open_driver() const;
};

class UartDriverCreator final : public DriverCreator {
public:
  std::unique_ptr<DeviceDriver> create_driver() const override;
};

class SpiDriverCreator final : public DriverCreator {
public:
  std::unique_ptr<DeviceDriver> create_driver() const override;
};

#endif
