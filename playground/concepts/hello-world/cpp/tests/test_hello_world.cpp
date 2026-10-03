#include "hello_world.h"

#include <cassert>
#include <cstring>

static void test_hello_world_returns_42()
{
  assert(hello_world() == 42);
}

int main(int argc, char *argv[])
{
  if (argc > 2 ||
      (argc == 2 && std::strcmp(argv[1], "test_hello_world_returns_42") != 0)) {
    return 1;
  }

  test_hello_world_returns_42();
  return 0;
}
