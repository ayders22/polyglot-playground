#ifndef MIN_MAX_H
#define MIN_MAX_H

#include <cstddef>

#ifdef __cplusplus
extern "C" {
#endif

bool find_min_max_builtin(const int *values, std::size_t count, int *minimum,
                          int *maximum);
bool find_min_max_manual(const int *values, std::size_t count, int *minimum,
                         int *maximum);

#ifdef __cplusplus
}
#endif

#endif
