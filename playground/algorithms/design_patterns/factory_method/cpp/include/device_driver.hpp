#ifndef DEVICE_DRIVER_HPP
#define DEVICE_DRIVER_HPP

class DeviceDriver {
public:
  virtual ~DeviceDriver() = default;
  virtual bool open() = 0;
};

#endif
