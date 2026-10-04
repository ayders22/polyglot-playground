# polyglot-playground

C, C++, Rust, Python and more

## Commands

### Clean

```sh
make clean
make clean-rs
make clean-py
make clean-c
make clean-cpp
```

### Test

Run the complete suite across all languages:

```sh
make test
```

Run a specific language suite:

```sh
make test-rs        # cargo test --workspace
make test-py        # pytest for all Python exercise tests
make test-c         # cmake + ctest for all C exercise tests
make test-cpp       # cmake + ctest for all C++ exercise tests
```

Run tests for a single exercise (for example, the min-max exercise):

```sh
make test-rs playground/algorithms/min-max
make test-py playground/algorithms/min-max
make test-c playground/algorithms/min-max
make test-cpp playground/algorithms/min-max
```

### Format

```sh
make format-rs
make format-py
make format-c
make format-cpp
```

### Lint

```sh
make lint-rs
make lint-py
make lint-c
make lint-cpp
```
