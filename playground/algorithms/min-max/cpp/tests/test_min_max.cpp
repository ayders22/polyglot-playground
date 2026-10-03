#include "min_max.h"

#include <cassert>
#include <cstring>

static void test_find_min_max_builtin()
{
  int values[] = {3, 1, 4, 1, 5, 9, 2, 6, 5};
  int minimum = 0;
  int maximum = 0;
  assert(find_min_max_builtin(values, sizeof(values) / sizeof(values[0]),
                              &minimum, &maximum));
  assert(minimum == 1);
  assert(maximum == 9);
}

static void test_find_min_max_manual()
{
  int values[] = {3, 1, 4, 1, 5, 9, 2, 6, 5};
  int minimum = 0;
  int maximum = 0;

  assert(find_min_max_manual(values, sizeof(values) / sizeof(values[0]),
                             &minimum, &maximum));
  assert(minimum == 1);
  assert(maximum == 9);
}

int main(int argc, char *argv[])
{
  if (argc == 1 || std::strcmp(argv[1], "test_find_min_max_builtin") == 0) {
    test_find_min_max_builtin();
  }
  if (argc == 1 || std::strcmp(argv[1], "test_find_min_max_manual") == 0) {
    test_find_min_max_manual();
  }
  if (argc > 2 ||
      (argc == 2 && std::strcmp(argv[1], "test_find_min_max_builtin") != 0 &&
       std::strcmp(argv[1], "test_find_min_max_manual") != 0)) {
    return 1;
  }
  return 0;
}
