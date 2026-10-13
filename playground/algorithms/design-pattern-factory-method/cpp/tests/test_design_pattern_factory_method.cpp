#include "design_pattern_factory_method.h"
#include "unity.h"

#include <cstring>
#include <stdexcept>

void setUp(void)
{
}

void tearDown(void)
{
}

static void test_factory_method_creates_uart_driver()
{
  const auto driver = create_driver("uart");
  TEST_ASSERT_NOT_NULL(driver.get());
  TEST_ASSERT_EQUAL_STRING("/dev/tty opened", driver->open().data());
}

static void test_factory_method_creates_spi_driver()
{
  const auto driver = create_driver("spi");
  TEST_ASSERT_NOT_NULL(driver.get());
  TEST_ASSERT_EQUAL_STRING("/dev/spi opened", driver->open().data());
}

static void test_factory_method_rejects_unsupported_driver_name()
{
  bool rejected = false;
  try {
    (void)create_driver("i2c");
  } catch (const std::invalid_argument &) {
    rejected = true;
  }
  TEST_ASSERT_TRUE(rejected);
}

static bool is_valid_test_name(const char *name)
{
  return std::strcmp(name, "test_factory_method_creates_uart_driver") == 0 ||
         std::strcmp(name, "test_factory_method_creates_spi_driver") == 0 ||
         std::strcmp(
             name, "test_factory_method_rejects_unsupported_driver_name") == 0;
}

int main(int argc, char *argv[])
{
  if (argc > 2 || (argc == 2 && !is_valid_test_name(argv[1]))) {
    return 1;
  }

  UNITY_BEGIN();
  if (argc == 1 ||
      std::strcmp(argv[1], "test_factory_method_creates_uart_driver") == 0) {
    RUN_TEST(test_factory_method_creates_uart_driver);
  }
  if (argc == 1 ||
      std::strcmp(argv[1], "test_factory_method_creates_spi_driver") == 0) {
    RUN_TEST(test_factory_method_creates_spi_driver);
  }
  if (argc == 1 ||
      std::strcmp(argv[1],
                  "test_factory_method_rejects_unsupported_driver_name") == 0) {
    RUN_TEST(test_factory_method_rejects_unsupported_driver_name);
  }
  return UNITY_END();
}
