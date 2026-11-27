#include "dynamic_cast.hpp"
#include "unity.h"

void setUp(void)
{
}

void tearDown(void)
{
}

static void test_downcast_to_double()
{
  TEST_ASSERT_EQUAL_FLOAT(3.141593, downcast_to_derived_type());
}
