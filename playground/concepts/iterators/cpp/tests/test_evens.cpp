#include "evens.h"
#include "unity.h"

#include <cstring>
#include <vector>

void setUp(void)
{
}

void tearDown(void)
{
}

static void test_iterator_happy_path()
{
  const std::vector<int> data{1, 2, 3, 4, 5, 6};
  std::vector<int> even_numbers;
  for (const int number : Evens(data)) {
    even_numbers.push_back(number);
  }

  TEST_ASSERT_EQUAL_INT(3, static_cast<int>(even_numbers.size()));
  TEST_ASSERT_EQUAL_INT(2, even_numbers[0]);
  TEST_ASSERT_EQUAL_INT(4, even_numbers[1]);
  TEST_ASSERT_EQUAL_INT(6, even_numbers[2]);
}

static void test_iterator_empty_input()
{
  const std::vector<int> data;
  std::vector<int> even_numbers;
  for (const int number : Evens(data)) {
    even_numbers.push_back(number);
  }

  TEST_ASSERT_EQUAL_INT(0, static_cast<int>(even_numbers.size()));
}

static void test_lazy_evaluation()
{
  std::vector<int> data{1};
  const Evens evens(data);
  data[0] = 2;

  TEST_ASSERT_EQUAL_INT(2, *evens.begin());
}

int main(int argc, char *argv[])
{
  if (argc > 2 ||
      (argc == 2 && std::strcmp(argv[1], "test_iterator_happy_path") != 0 &&
       std::strcmp(argv[1], "test_iterator_empty_input") != 0 &&
       std::strcmp(argv[1], "test_lazy_evaluation") != 0)) {
    return 1;
  }

  UNITY_BEGIN();
  RUN_TEST(test_iterator_happy_path);
  RUN_TEST(test_iterator_empty_input);
  RUN_TEST(test_lazy_evaluation);
  return UNITY_END();
}
