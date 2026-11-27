PYTHON ?= python3
CMAKE ?= cmake
CTEST ?= ctest
CLANG_FORMAT ?= clang-format
CLANG_TIDY ?= clang-tidy

MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

LANGUAGES := rs py c cpp
PLAYGROUND_DIR ?= playground

BENCHMARK_TARGETS := bench $(addprefix bench-,$(LANGUAGES))
CLEAN_TARGETS := clean $(addprefix clean-,$(LANGUAGES))
FORMAT_TARGETS := $(addprefix format-,$(LANGUAGES))
LINT_TARGETS := $(addprefix lint-,$(LANGUAGES))
TEST_TARGETS := test $(addprefix test-,$(LANGUAGES))

ALL_TARGETS := $(BENCHMARK_TARGETS) $(CLEAN_TARGETS) $(FORMAT_TARGETS) $(LINT_TARGETS) $(TEST_TARGETS)

PROJECT_TASKS := $(filter $(ALL_TARGETS),$(MAKECMDGOALS))
PROJECT_ARGUMENTS := $(if $(PROJECT_TASKS),$(filter-out $(ALL_TARGETS),$(MAKECMDGOALS)))
ifneq ($(word 2, $(PROJECT_ARGUMENTS)),)
  $(error Only one project can be specified at a time)
endif
PROJECT_GOAL := $(firstword $(PROJECT_ARGUMENTS))
PROJECT_PATH := $(patsubst $(PLAYGROUND_DIR)/%,%,$(PROJECT_GOAL))
PROJECT_DIR := $(PLAYGROUND_DIR)/$(PROJECT_PATH)
PROJECT_LANGUAGE_PARENT := $(notdir $(patsubst %/,%,$(dir $(PROJECT_DIR))))

ifneq ($(PROJECT_GOAL),)
  .PHONY: $(PROJECT_GOAL)
  $(PROJECT_GOAL):
	@:

  define VALIDATE_PROJECT
@case "$(PROJECT_PATH)" in \
	""|/*|..|../*|*/..|*/../*) \
		echo "Project '$(PROJECT_PATH)' must be a relative path beneath $(PLAYGROUND_DIR)/" >&2; exit 2 ;; \
	esac
@if [ ! -d "$(PROJECT_DIR)" ]; then \
	echo "Project '$(PROJECT_PATH)' does not exist" >&2; exit 2; \
fi
@if [ ! -d "$(PROJECT_DIR)/$(1)" ] && { \
	[ "$(PROJECT_LANGUAGE_PARENT)" != "$(1)" ] || \
	[ ! -f "$(PROJECT_DIR)/CMakeLists.txt" ]; \
}; then \
	echo "Project '$(PROJECT_PATH)' has no $(1) implementation" >&2; exit 2; \
fi
  endef
endif

define REQUIRE_TOOL
@if ! command -v "$(1)" >/dev/null 2>&1; then \
	echo "Required tool '$(1)' was not found" >&2; \
	exit 2; \
fi
endef

.PHONY: $(ALL_TARGETS)

bench: bench-rs bench-py bench-c bench-cpp

clean: clean-rs clean-py clean-c clean-cpp
	rm -rf target build

test: test-rs test-py test-c test-cpp

include $(MAKEFILE_DIR)mk/rust.mk
include $(MAKEFILE_DIR)mk/python.mk
include $(MAKEFILE_DIR)mk/c.mk
include $(MAKEFILE_DIR)mk/cpp.mk
include $(MAKEFILE_DIR)mk/c-family.mk
