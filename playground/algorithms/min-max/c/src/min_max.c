#include "min_max.h"

bool find_min_max_builtin(const int *values, size_t count, int *minimum,
                          int *maximum) {
  if (count == 0) {
    return false;
  }

  *minimum = values[0];
  *maximum = values[0];

  for (size_t i = 1; i < count; ++i) {
    if (values[i] < *minimum) {
      *minimum = values[i];
    } else if (values[i] > *maximum) {
      *maximum = values[i];
    }
  }

  return true;
}

bool find_min_max_manual(const int *values, size_t count, int *minimum,
                         int *maximum) {
  if (count == 0) {
    return false;
  }

  *minimum = values[0];
  *maximum = values[0];

  for (size_t i = 1; i < count; ++i) {
    if (values[i] < *minimum) {
      *minimum = values[i];
    } else if (values[i] > *maximum) {
      *maximum = values[i];
    }
  }

  return true;
}
