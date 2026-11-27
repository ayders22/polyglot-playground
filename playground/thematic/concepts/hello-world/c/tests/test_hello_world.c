#include "hello_world.h"
#include "unity.h"

void setUp(void)
{
  // This function is called before each test case
}

void tearDown(void)
{
  // This function is called after each test case
}

static void test_hello_world_impl1_returns_42(void)
{
  TEST_ASSERT_EQUAL_INT(42, hello_world_impl1());
}

static void test_hello_world_impl2_returns_42(void)
{
  TEST_ASSERT_EQUAL_INT(42, hello_world_impl2());
}
