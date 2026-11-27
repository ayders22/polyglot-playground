#include "dynamic_cast.hpp"

namespace {
class Base {
public:
  virtual ~Base() = default;
};

class FloatValue : public Base {
public:
  explicit FloatValue(float value) : value(value)
  {
  }

  float value;
};
} // namespace

float downcast_to_derived_type(void)
{
  FloatValue pi(3.141593);
  Base *base = &pi;
  FloatValue *pi_float = dynamic_cast<FloatValue *>(base);

  return pi_float->value;
}
