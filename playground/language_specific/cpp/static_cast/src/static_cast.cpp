#include "static_cast.hpp"

std::uint8_t from_double_to_uint8_t(void)
{
  double pi_double = 3.1415926535;
  std::uint8_t pi_uint8_t = static_cast<std::uint8_t>(pi_double);

  return pi_uint8_t;
}

float from_double_to_float(void)
{
  double pi_double = 3.1415926535;
  float pi_float = static_cast<float>(pi_double);

  return pi_float;
}
