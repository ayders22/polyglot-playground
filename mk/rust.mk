RUST_CARGO_ARGS := $(if $(PROJECT_GOAL),--manifest-path $(PROJECT_DIR)/rust/Cargo.toml,--workspace)

bench-rs:
	$(call VALIDATE_PROJECT,rust)
	CARGO_TARGET_DIR="$(CURDIR)/target" cargo bench $(RUST_CARGO_ARGS)

clean-rs:
	cargo clean

format-rs:
	cargo fmt --all

lint-rs:
	$(call VALIDATE_PROJECT,rust)
	cargo clippy $(RUST_CARGO_ARGS) --all-targets --all-features -- -D warnings

test-rs:
	$(call VALIDATE_PROJECT,rust)
	CARGO_TARGET_DIR="$(CURDIR)/target" cargo test $(RUST_CARGO_ARGS)
