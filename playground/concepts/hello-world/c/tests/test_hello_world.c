#include "hello_world.h"
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

static void test_hello_world_returns_42(void)
{
  TEST_ASSERT_EQUAL_INT(42, hello_world());
}

int main(int argc, char *argv[])
{
  if (argc > 2 ||
      (argc == 2 && strcmp(argv[1], "test_hello_world_returns_42") != 0)) {
    return 1;
  }

  UNITY_BEGIN();
  RUN_TEST(test_hello_world_returns_42);
  return UNITY_END();
}