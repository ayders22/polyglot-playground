PYTHON ?= python3
CMAKE ?= cmake
CTEST ?= ctest
CLANG_FORMAT ?= clang-format
CLANG_TIDY ?= clang-tidy

LANGUAGES := rs py c cpp

BENCHMARK_TARGETS := bench $(addprefix bench-,$(LANGUAGES))
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

C_SOURCES := $(sort $(shell find playground -type f \( -path '*/c/*.c' -o -path '*/c/*.cc' \)))
C_FILES := $(sort $(shell find playground -type f \( -path '*/c/*.c' -o -path '*/c/*.cc' -o -path '*/c/*.h' \)))

CPP_SOURCES := $(sort $(shell find playground -type f \( -path '*/cpp/*.cpp' -o -path '*/cpp/*.cc' -o -path '*/cpp/*.cxx' \)))
CPP_FILES := $(sort $(shell find playground -type f \( -path '*/cpp/*.cpp' -o -path '*/cpp/*.cc' -o -path '*/cpp/*.cxx' -o -path '*/cpp/*.hpp' -o -path '*/cpp/*.h' \)))

EXERCISE_TASKS := $(filter $(ALL_TARGETS),$(MAKECMDGOALS))
EXERCISE_ARGUMENTS := $(if $(EXERCISE_TASKS),$(filter-out $(ALL_TARGETS),$(MAKECMDGOALS)))
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

SELECTED_PYTHON_EXERCISES := $(if $(EXERCISE_GOAL),$(EXERCISE_DIR)/python,$(PYTHON_EXERCISES))
RUST_CARGO_ARGS := $(if $(EXERCISE_GOAL),--manifest-path $(EXERCISE_DIR)/rust/Cargo.toml,--workspace)

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

define REQUIRE_TOOL
@if ! command -v "$(1)" >/dev/null 2>&1; then \
	echo "Required tool '$(1)' was not found" >&2; \
	exit 2; \
fi
endef

.PHONY: $(ALL_TARGETS)

bench: bench-rs bench-py bench-c bench-cpp

bench-rs:
	$(call VALIDATE_EXERCISE,rust)
	CARGO_TARGET_DIR="$(CURDIR)/target" cargo bench $(RUST_CARGO_ARGS)

bench-py:
	$(call VALIDATE_EXERCISE,python)
	$(PREPARE_PYTHON)
	@set -e; for dir in $(SELECTED_PYTHON_EXERCISES); do \
		if [ -d "$$dir/benches" ]; then \
			PYTHONPATH="$$dir/src" $(PYTEST) "$$dir/benches" --benchmark-only; \
		fi; \
	done

bench-c bench-cpp: bench-%:
	$(call VALIDATE_EXERCISE,$*)
	$(CMAKE) -S . -B "build/$*/benchmark$(if $(EXERCISE_GOAL),/$(EXERCISE_PATH))" -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DBUILD_BENCHMARKING=ON -DEXERCISE_PATH="$(EXERCISE_PATH)"
	$(CMAKE) --build "build/$*/benchmark$(if $(EXERCISE_GOAL),/$(EXERCISE_PATH))" --config Release
	$(CTEST) --test-dir "build/$*/benchmark$(if $(EXERCISE_GOAL),/$(EXERCISE_PATH))" --build-config Release --label-regex benchmark --verbose

clean: clean-rs clean-py clean-c clean-cpp
	rm -rf target

clean-rs:
	cargo clean

clean-py:
	rm -rf $(PYTHON_VENV) .pytest_cache .ruff_cache .benchmarks
	find playground -type d -name __pycache__ -prune -exec rm -rf {} +

clean-c clean-cpp: clean-%:
	rm -rf build/$*

format-rs:
	cargo fmt --all

format-py:
	$(PREPARE_PYTHON)
	$(RUFF) format $(PYTHON_EXERCISES)

format-c format-cpp: format-%:
	$(call REQUIRE_TOOL,$(CLANG_FORMAT))
	$(CLANG_FORMAT) -i $(if $(filter c,$*),$(C_FILES),$(CPP_FILES))

lint-rs:
	cargo clippy --workspace --all-targets --all-features -- -D warnings

lint-py:
	$(PREPARE_PYTHON)
	$(RUFF) check $(PYTHON_EXERCISES)

lint-c lint-cpp: lint-%:
	$(call REQUIRE_TOOL,$(CLANG_TIDY))
	$(CMAKE) -S . -B "build/$*/lint$(if $(EXERCISE_GOAL),/$(EXERCISE_PATH))" -DBUILD_TESTING=ON -DBUILD_BENCHMARKING=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
	$(CMAKE) --build "build/$*/lint$(if $(EXERCISE_GOAL),/$(EXERCISE_PATH))"
	$(CLANG_TIDY) --warnings-as-errors='*' -p "build/$*/lint$(if $(EXERCISE_GOAL),/$(EXERCISE_PATH))" $(if $(filter c,$*),$(C_SOURCES),$(CPP_SOURCES))

test: test-rs test-py test-c test-cpp

test-rs:
	$(call VALIDATE_EXERCISE,rust)
	CARGO_TARGET_DIR="$(CURDIR)/target" cargo test $(RUST_CARGO_ARGS)

test-py:
	$(call VALIDATE_EXERCISE,python)
	$(PREPARE_PYTHON)
	@set -e; for dir in $(SELECTED_PYTHON_EXERCISES); do \
		PYTHONPATH="$$dir/src" $(PYTEST) "$$dir/tests"; \
	done

test-c test-cpp: test-%:
	$(call VALIDATE_EXERCISE,$*)
	$(CMAKE) -S "$(if $(EXERCISE_GOAL),$(EXERCISE_DIR)/$*,.)" -B "build/$*/test$(if $(EXERCISE_GOAL),/$(EXERCISE_PATH))" -DBUILD_TESTING=ON $(if $(EXERCISE_GOAL),,-DC_FAMILY_LANGUAGE=$*)
	$(CMAKE) --build "build/$*/test$(if $(EXERCISE_GOAL),/$(EXERCISE_PATH))"
	$(CTEST) --test-dir "build/$*/test$(if $(EXERCISE_GOAL),/$(EXERCISE_PATH))" --output-on-failure
