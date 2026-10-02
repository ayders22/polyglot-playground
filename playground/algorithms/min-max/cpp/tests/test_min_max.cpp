#include "min_max.h"

#include <cassert>

int main(void)
{
  int values[] = {3, 1, 4, 1, 5, 9, 2, 6, 5};

  int minimum = 0;
  int maximum = 0;

  assert(find_min_max_builtin(values, sizeof(values) / sizeof(values[0]),
                              &minimum, &maximum));
  assert(minimum == 1);
  assert(maximum == 9);

  minimum = 0;
  maximum = 0;

  assert(find_min_max_manual(values, sizeof(values) / sizeof(values[0]),
                             &minimum, &maximum));
  assert(minimum == 1);
  assert(maximum == 9);

  return 0;
}
