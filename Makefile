PYTHON ?= python3
CMAKE ?= cmake
CTEST ?= ctest
CLANG_FORMAT ?= clang-format
CLANG_TIDY ?= clang-tidy

LANGUAGES := rs

BENCHMARK_TARGETS := benchmark $(addprefix benchmark-,$(LANGUAGES))
CLEAN_TARGETS := clean $(addprefix clean-,$(LANGUAGES))
FORMAT_TARGETS := $(addprefix format-,$(LANGUAGES))
LINT_TARGETS := $(addprefix lint-,$(LANGUAGES))
TEST_TARGETS := test $(addprefix test-,$(LANGUAGES))

ALL_TARGETS := $(BENCHMARK_TARGETS) $(CLEAN_TARGETS) $(FORMAT_TARGETS) $(LINT_TARGETS) $(TEST_TARGETS)

PYTHON_VENV := .venv
PYTHON_BIN := $(PYTHON_VENV)/bin/python
PYTEST := $(PYTHON_VENV)/bin/pytest
RUFF := $(PYTHON_VENV)/bin/ruff
PYTHON_EXERCISES := $(sort $(shell find playground -type d -name python))

C_BUILD_ROOT := build/c
C_BENCHMARK_BUILD_ROOT := ${C_BUILD_ROOT}/benchmark
C_TEST_BUILD_ROOT := ${C_BUILD_ROOT}/test
C_LINT_BUILD_ROOT := ${C_BUILD_ROOT}/lint
C_EXERCISES := $(sort $(shell find playground -type d -name c))
C_SOURCES := $(sort $(shell find ${C_EXERCISES} -type f -path '*/src/*.c'))
C_FILES := $(sort $(shell find ${C_EXERCISES} -type f \( -name '*.c' -o -name '*.cc' -o -name '*.h' \)))

ifneq ($(filter $(ALL_TARGETS),$(MAKECMDGOALS)),)
EXERCISE_ARGUMENTS := $(filter-out $(ALL_TARGETS),$(MAKECMDGOALS))
ifneq ($(word 2, $(EXERCISE_ARGUMENTS)),)
$(error Only one exercise can be specified at a time)
endif
EXERCISE_GOAL := $(firstword $(EXERCISE_ARGUMENTS))
EXERCISE_PATH := $(patsubst playground/%,%,$(EXERCISE_GOAL))
EXERCISE_DIR := playground/$(EXERCISE_PATH)
ifneq ($(EXERCISE_GOAL),)
.PHONY: $(EXERCISE_GOAL)
$(EXERCISE_GOAL):
	@:

define VALIDATE_EXERCISE
@case "$(EXERCISE_PATH)" in \
	""|/*|..|../*|*/..|*/../*) \
		echo "Exercise '$(EXERCISE_PATH)' must be a relative path beneath playground/" >&2; exit 2 ;; \
	esac
@if [ ! -d "$(EXERCISE_DIR)" ]; then \
	echo "Exercise '$(EXERCISE_PATH)' does not exist" >&2; exit 2; \
fi
@if [ ! -d "$(EXERCISE_DIR)/$(1)" ]; then \
	echo "Exercise '$(EXERCISE_PATH)' has no $(1) implementation" >&2; exit 2; \
fi
endef
endif
endif

SELECTED_PYTHON_EXERCISES := $(if $(EXERCISE_GOAL),$(EXERCISE_DIR)/python,$(PYTHON_EXERCISES))
RUST_CARGO_ARGS := $(if $(EXERCISE_GOAL),--manifest-path $(EXERCISE_DIR)/rust/Cargo.toml,--workspace)
C_TEST_SOURCE_DIR := $(if $(EXERCISE_GOAL),$(EXERCISE_DIR)/c,.)
C_TEST_BUILD_DIR := $(if $(EXERCISE_GOAL),$(C_TEST_BUILD_ROOT)/$(EXERCISE_PATH),$(C_TEST_BUILD_ROOT))
C_LINT_BUILD_DIR := $(if $(EXERCISE_GOAL),$(C_LINT_BUILD_ROOT)/$(EXERCISE_PATH),$(C_LINT_BUILD_ROOT))
C_BENCHMARK_BUILD_DIR := $(if $(EXERCISE_GOAL),$(C_BENCHMARK_BUILD_ROOT)/$(EXERCISE_PATH),$(C_BENCHMARK_BUILD_ROOT))

C_BENCHMARK_CMAKE_ARGS := -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DBUILD_BENCHMARKING=ON -DEXERCISE_PATH="$(EXERCISE_PATH)"
C_LINT_CMAKE_ARGS := -DBUILD_TESTING=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

define PREPARE_PYTHON
@if [ ! -x "$(PYTHON_BIN)" ]; then \
	$(PYTHON) -m venv "$(PYTHON_VENV)"; \
fi
@if ! "$(PYTHON_BIN)" -c "import pip" >/dev/null 2>&1; then \
	"$(PYTHON_BIN)" -m ensurepip --upgrade; \
fi
@if [ ! -x "$(PYTEST)" ] || \
	[ ! -x "$(RUFF)" ] || \
	! "$(PYTHON_BIN)" -c "import pytest_benchmark" >/dev/null 2>&1; then \
	"$(PYTHON_BIN)" -m pip install --upgrade pip; \
	"$(PYTHON_BIN)" -m pip install --group dev; \
fi
endef

.PHONY: $(ALL_TARGETS)

bench: bench-rs benhc-py bench-c

bench-rs:
	$(call VALIDATE_EXERCISE,rust)
	CARGO_TARGET_DIR="$(CURDIR)/target" cargo bench $(RUST_CARGO_ARGS)

bench-py:
	$(call VALIDATE_EXERCISE,python)
	$(PREPARE_PYTHON)
	@set -e; for dir in $(SELECTED_PYTHON_EXERCISES); do \
		if [ -d "$$dir/benchmarks" ]; then \
			PYTHONPATH="$$dir/src" $(PYTEST) "$$dir/benchmarks" --benchmark-only; \
		fi; \
	done

bench-c:
	$(call VALIDATE_EXERCISE,c)
	$(CMAKE) -S . -B "$(C_BENCHMARK_BUILD_DIR)" $(C_BENCHMARK_CMAKE_ARGS)
	$(CMAKE) --build "$(C_BENCHMARK_BUILD_DIR)" --config Release
	$(CTEST) --test-dir "$(C_BENCHMARK_BUILD_DIR)" --build-config Release --label-regex benchmark --verbose

clean: clean-rs clean-py clean-c
	rm -rf target

clean-rs:
	cargo clean

clean-py:
	rm -rf $(PYTHON_VENV) .pytest_cache .ruff_cache .benchmarks
	find playground -type d -name __pycache__ -prune -exec rm -rf {} +

clean-c:
	rm -rf $(C_BUILD_ROOT)

format-rs:
	cargo fmt --all

format-py:
	$(PREPARE_PYTHON)
	$(RUFF) format $(PYTHON_EXERCISES)

format-c:
	$(call REQUIRE_TOOL,$(CLANG_FORMAT))
	$(CLANG_FORMAT) -i $(C_FILES)

lint-rs:
	cargo clippy --workspace --all-targets --all-features -- -D warnings

lint-py:
	$(PREPARE_PYTHON)
	$(RUFF) check $(PYTHON_EXERCISES)

lint-c:
	$(call REQUIRE_TOOL,$(CLANG_TIDY))
	$(CMAKE) -S . -B "$(C_LINT_BUILD_DIR)" $(C_LINT_CMAKE_ARGS)
	$(CMAKE) --build "$(C_LINT_BUILD_DIR)"
	$(CLANG_TIDY) --warnings-as-errors='*' -p $(C_LINT_BUILD_DIR) $(C_SOURCES)

test: test-rs test-py test-c

test-rs:
	$(call VALIDATE_EXERCISE,rust)
	CARGO_TARGET_DIR="$(CURDIR)/target" cargo test $(RUST_CARGO_ARGS)

test-py:
	$(call VALIDATE_EXERCISE,python)
	$(PREPARE_PYTHON)
	@set -e; for dir in $(SELECTED_PYTHON_EXERCISES); do \
		PYTHONPATH="$$dir/src" $(PYTEST) "$$dir/tests"; \
	done

test-c:
	$(call VALIDATE_EXERCISE,c)
	$(CMAKE) -S "$(C_TEST_SOURCE_DIR)" -B "$(C_TEST_BUILD_DIR)" -DBUILD_TESTING=ON
	$(CMAKE) --build "$(C_TEST_BUILD_DIR)"
	$(CTEST) --test-dir "$(C_TEST_BUILD_DIR)" --output-on-failure
