#include "min_max.h"
#include "unity.h"

#include <string.h>

void setUp(void)
{
  // This function is called before each test case
}

void tearDown(void)
{
  // This function is called after each test case
}

static void test_find_min_max_builtin(void)
{
  int values[] = {3, 1, 4, 1, 5, 9, 2, 6, 5};
  int minimum, maximum;
  bool result = find_min_max_builtin(values, sizeof(values) / sizeof(values[0]),
                                     &minimum, &maximum);
  TEST_ASSERT_TRUE(result);
  TEST_ASSERT_EQUAL_INT(1, minimum);
  TEST_ASSERT_EQUAL_INT(9, maximum);
}

static void test_find_min_max_manual(void)
{
  int values[] = {3, 1, 4, 1, 5, 9, 2, 6, 5};
  int minimum, maximum;
  bool result = find_min_max_manual(values, sizeof(values) / sizeof(values[0]),
                                    &minimum, &maximum);
  TEST_ASSERT_TRUE(result);
  TEST_ASSERT_EQUAL_INT(1, minimum);
  TEST_ASSERT_EQUAL_INT(9, maximum);
}

int main(int argc, char *argv[])
{
  if (argc > 2) {
    return 1;
  }

  UNITY_BEGIN();
  if (argc == 1 || strcmp(argv[1], "test_find_min_max_builtin") == 0) {
    RUN_TEST(test_find_min_max_builtin);
  }
  if (argc == 1 || strcmp(argv[1], "test_find_min_max_manual") == 0) {
    RUN_TEST(test_find_min_max_manual);
  }
  if (argc == 2 && strcmp(argv[1], "test_find_min_max_builtin") != 0 &&
      strcmp(argv[1], "test_find_min_max_manual") != 0) {
    return 1;
  }
  return UNITY_END();
}