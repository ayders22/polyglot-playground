#include "min_max.h"
#include "unity.h"

void setUp(void) {
  // This function is called before each test case
}

void tearDown(void) {
  // This function is called after each test case
}

static void test_find_min_max_builtin(void) {
  int values[] = {3, 1, 4, 1, 5, 9, 2, 6, 5};
  int minimum, maximum;
  bool result = find_min_max_builtin(values, sizeof(values) / sizeof(values[0]),
                                     &minimum, &maximum);
  TEST_ASSERT_TRUE(result);
  TEST_ASSERT_EQUAL_INT(1, minimum);
  TEST_ASSERT_EQUAL_INT(9, maximum);
}

static void test_find_min_max_manual(void) {
  int values[] = {3, 1, 4, 1, 5, 9, 2, 6, 5};
  int minimum, maximum;
  bool result = find_min_max_manual(values, sizeof(values) / sizeof(values[0]),
                                    &minimum, &maximum);
  TEST_ASSERT_TRUE(result);
  TEST_ASSERT_EQUAL_INT(1, minimum);
  TEST_ASSERT_EQUAL_INT(9, maximum);
}

int main(void) {
  UNITY_BEGIN();
  RUN_TEST(test_find_min_max_builtin);
  RUN_TEST(test_find_min_max_manual);
  return UNITY_END();
}