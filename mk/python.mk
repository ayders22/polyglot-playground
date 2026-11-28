PYTHON_VENV := .venv
PYTHON_BIN := $(PYTHON_VENV)/bin/python
PYTEST := $(PYTHON_VENV)/bin/pytest
RUFF := $(PYTHON_VENV)/bin/ruff
PYTHON_PROJECTS := $(sort $(shell find $(PLAYGROUND_DIR) -type d -name python))
SELECTED_PYTHON_PROJECTS := $(if $(PROJECT_GOAL),$(filter $(PROJECT_DIR)/%,$(PYTHON_PROJECTS)),$(PYTHON_PROJECTS))

ifneq ($(PROJECT_GOAL),)
  define VALIDATE_PYTHON_PROJECTS
@case "$(PROJECT_PATH)" in \
	""|/*|..|../*|*/..|*/../*) \
		echo "Project '$(PROJECT_PATH)' must be a relative path beneath $(PLAYGROUND_DIR)/" >&2; exit 2 ;; \
	esac
@if [ ! -d "$(PROJECT_DIR)" ]; then \
	echo "Project '$(PROJECT_PATH)' does not exist" >&2; exit 2; \
fi
@if [ -z "$(SELECTED_PYTHON_PROJECTS)" ]; then \
	echo "Project '$(PROJECT_PATH)' has no python implementation" >&2; exit 2; \
fi
  endef
endif

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

bench-py:
	$(call VALIDATE_PYTHON_PROJECTS)
	$(PREPARE_PYTHON)
	@set -e; for dir in $(SELECTED_PYTHON_PROJECTS); do \
		if [ -d "$$dir/benches" ]; then \
			PYTHONPATH="$$dir/src" $(PYTEST) "$$dir/benches" --benchmark-only; \
		fi; \
	done

clean-py:
	rm -rf $(PYTHON_VENV) .pytest_cache .ruff_cache .benchmarks
	find $(PLAYGROUND_DIR) -type d -name .benchmarks -prune -exec rm -rf {} +
	find $(PLAYGROUND_DIR) -type d -name __pycache__ -prune -exec rm -rf {} +

format-py:
	$(call VALIDATE_PYTHON_PROJECTS)
	$(PREPARE_PYTHON)
	$(RUFF) format $(SELECTED_PYTHON_PROJECTS)

lint-py:
	$(call VALIDATE_PYTHON_PROJECTS)
	$(PREPARE_PYTHON)
	$(RUFF) check $(SELECTED_PYTHON_PROJECTS)

test-py:
	$(call VALIDATE_PYTHON_PROJECTS)
	$(PREPARE_PYTHON)
	@set -e; for dir in $(SELECTED_PYTHON_PROJECTS); do \
		PYTHONPATH="$$dir/src" $(PYTEST) "$$dir/tests" -v; \
	done
