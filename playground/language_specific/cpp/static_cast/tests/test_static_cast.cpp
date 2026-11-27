#include "static_cast.hpp"
#include "unity.h"

void setUp(void)
{
}

void tearDown(void)
{
}

static void test_from_double_to_uint8_t()
{
  TEST_ASSERT_EQUAL_INT(3, from_double_to_uint8_t());
}

static void test_from_uint8_t_to_float()
{
  TEST_ASSERT_EQUAL_FLOAT(3.141593, from_double_to_float());
}
