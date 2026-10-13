#ifndef DESIGN_PATTERN_FACTORY_METHOD_H
#define DESIGN_PATTERN_FACTORY_METHOD_H

#include <memory>
#include <string_view>

class DeviceDriver {
public:
  virtual ~DeviceDriver() = default;
  virtual std::string_view open() const noexcept = 0;
};

std::unique_ptr<DeviceDriver> create_driver(std::string_view name);

#endif
