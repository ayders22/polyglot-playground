#include "hello_world.h"
#include "unity.h"

#include <cstring>

void setUp(void)
{
}

void tearDown(void)
{
}

static void test_hello_world_impl1_returns_42()
{
  TEST_ASSERT_EQUAL_INT(42, hello_world_impl1());
}

static void test_hello_world_impl2_returns_42()
{
  TEST_ASSERT_EQUAL_INT(42, hello_world_impl2());
}

static bool is_valid_test_name(const char *name)
{
  return std::strcmp(name, "test_hello_world_impl1_returns_42") == 0 ||
         std::strcmp(name, "test_hello_world_impl2_returns_42") == 0;
}

int main(int argc, char *argv[])
{
  if (argc > 2 || (argc == 2 && !is_valid_test_name(argv[1]))) {
    return 1;
  }

  UNITY_BEGIN();
  RUN_TEST(test_hello_world_impl1_returns_42);
  RUN_TEST(test_hello_world_impl2_returns_42);
  return UNITY_END();
}
