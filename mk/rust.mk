RUST_CARGO_ARGS := $(if $(PROJECT_GOAL),--manifest-path $(PROJECT_DIR)/rust/Cargo.toml,--workspace)
RUST_FMT_ARGS := $(if $(PROJECT_GOAL),--manifest-path $(PROJECT_DIR)/rust/Cargo.toml,--all)

bench-rs:
	$(call VALIDATE_PROJECT,rust)
	CARGO_TARGET_DIR="$(CURDIR)/target" cargo bench $(RUST_CARGO_ARGS)

clean-rs:
	cargo clean

format-rs:
	$(call VALIDATE_PROJECT,rust)
	cargo fmt $(RUST_FMT_ARGS)

lint-rs:
	$(call VALIDATE_PROJECT,rust)
	cargo clippy $(RUST_CARGO_ARGS) --all-targets --all-features -- -D warnings

test-rs:
	$(call VALIDATE_PROJECT,rust)
	CARGO_TARGET_DIR="$(CURDIR)/target" cargo test $(RUST_CARGO_ARGS)
