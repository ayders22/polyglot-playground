#include "hello_world.h"
#include "unity.h"

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
