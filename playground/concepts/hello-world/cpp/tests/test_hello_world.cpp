#include "hello_world.h"
#include "unity.h"

#include <cstring>

void setUp(void)
{
}

void tearDown(void)
{
}

static void test_hello_world_returns_42()
{
  TEST_ASSERT_EQUAL_INT(42, hello_world());
}

int main(int argc, char *argv[])
{
  if (argc > 2 ||
      (argc == 2 && std::strcmp(argv[1], "test_hello_world_returns_42") != 0)) {
    return 1;
  }

  UNITY_BEGIN();
  RUN_TEST(test_hello_world_returns_42);
  return UNITY_END();
}
