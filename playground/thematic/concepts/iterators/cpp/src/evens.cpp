#include "evens.h"

Evens::Evens(const std::vector<int> &data)
    : even_numbers_(std::views::all(data) | std::views::filter(&Evens::is_even))
{
}

bool Evens::is_even(int number)
{
  return number % 2 == 0;
}

std::ranges::iterator_t<Evens::EvenView> Evens::begin() const
{
  return even_numbers_.begin();
}

std::ranges::sentinel_t<Evens::EvenView> Evens::end() const
{
  return even_numbers_.end();
}
