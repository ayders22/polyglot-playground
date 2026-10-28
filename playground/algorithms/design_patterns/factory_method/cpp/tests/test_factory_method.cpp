#include "driver.hpp"
#include "unity.h"

#include <memory>

void setUp(void)
{
}

void tearDown(void)
{
}

static void test_uart_creator_opens_created_driver()
{
  const std::unique_ptr<DriverCreator> creator =
      std::make_unique<UartDriverCreator>();
  TEST_ASSERT_TRUE(creator->open_driver());
}

static void test_spi_creator_opens_created_driver()
{
  const std::unique_ptr<DriverCreator> creator =
      std::make_unique<SpiDriverCreator>();
  TEST_ASSERT_FALSE(creator->open_driver());
}
