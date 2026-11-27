#include "hello_world.hpp"
#include "unity.h"

void setUp(void)
{
}

void tearDown(void)
{
}

static void test_hello_world_returns_greeting()
{
  TEST_ASSERT_EQUAL_STRING("Hello, world!", hello_world().c_str());
}
