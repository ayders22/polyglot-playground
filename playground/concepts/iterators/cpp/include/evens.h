#ifndef EVENS_H
#define EVENS_H

#include <ranges>
#include <vector>

class Evens {
  using BaseRange = std::ranges::ref_view<const std::vector<int>>;
  using EvenView = std::ranges::filter_view<BaseRange, bool (*)(int)>;

  static bool is_even(int number);

  mutable EvenView even_numbers_;

public:
  explicit Evens(const std::vector<int> &data);

  std::ranges::iterator_t<EvenView> begin() const;
  std::ranges::sentinel_t<EvenView> end() const;
};

#endif
