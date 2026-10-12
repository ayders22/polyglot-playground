#include "design_pattern_factory.h"

#include <stdexcept>

namespace {

class UartDriver final : public DeviceDriver {
public:
  std::string_view open() const noexcept override
  {
    return "/dev/tty opened";
  }
};

class SpiDriver final : public DeviceDriver {
public:
  std::string_view open() const noexcept override
  {
    return "/dev/spi opened";
  }
};

} // namespace

std::unique_ptr<DeviceDriver> create_driver(std::string_view name)
{
  if (name == "uart") {
    return std::make_unique<UartDriver>();
  }
  if (name == "spi") {
    return std::make_unique<SpiDriver>();
  }

  throw std::invalid_argument("Unsupported device driver");
}
