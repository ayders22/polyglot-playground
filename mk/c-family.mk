bench-c bench-cpp: bench-%:
	$(call VALIDATE_PROJECT,$*)
	$(CMAKE) -S . -B "build/$*/benchmark$(if $(PROJECT_GOAL),/$(PROJECT_PATH))" -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DBUILD_BENCHMARKING=ON -DPROJECT_PATH="$(PROJECT_PATH)"
	$(CMAKE) --build "build/$*/benchmark$(if $(PROJECT_GOAL),/$(PROJECT_PATH))" --config Release
	$(CTEST) --test-dir "build/$*/benchmark$(if $(PROJECT_GOAL),/$(PROJECT_PATH))" --build-config Release --label-regex benchmark --verbose

clean-c clean-cpp: clean-%:
	rm -rf build/$*

format-c format-cpp: format-%:
	$(call REQUIRE_TOOL,$(CLANG_FORMAT))
	$(CLANG_FORMAT) -i $(if $(filter c,$*),$(C_FILES),$(CPP_FILES))

lint-c lint-cpp: lint-%:
	$(call VALIDATE_PROJECT,$*)
	$(call REQUIRE_TOOL,$(CLANG_TIDY))
	$(CMAKE) -S "$(if $(and $(PROJECT_GOAL),$(filter $*,$(PROJECT_LANGUAGE_PARENT)),$(wildcard $(PROJECT_DIR)/CMakeLists.txt)),$(PROJECT_DIR),.)" -B "build/$*/lint$(if $(PROJECT_GOAL),/$(PROJECT_PATH))" -DBUILD_TESTING=ON -DBUILD_BENCHMARKING=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=ON $(if $(filter .,$(if $(and $(PROJECT_GOAL),$(filter $*,$(PROJECT_LANGUAGE_PARENT)),$(wildcard $(PROJECT_DIR)/CMakeLists.txt)),$(PROJECT_DIR),.)),-DC_FAMILY_LANGUAGE=$* $(if $(PROJECT_GOAL),-DPROJECT_PATH="$(PROJECT_PATH)"))
	$(CMAKE) --build "build/$*/lint$(if $(PROJECT_GOAL),/$(PROJECT_PATH))"
	$(CLANG_TIDY) --warnings-as-errors='*' --header-filter='.*tests/.*' -p "build/$*/lint$(if $(PROJECT_GOAL),/$(PROJECT_PATH))" $(if $(filter c,$*),$(if $(PROJECT_GOAL),$(filter $(PROJECT_DIR)/%,$(C_SOURCES)),$(C_SOURCES)),$(if $(PROJECT_GOAL),$(filter $(PROJECT_DIR)/%,$(CPP_SOURCES)),$(CPP_SOURCES))) $$(find "build/$*/lint$(if $(PROJECT_GOAL),/$(PROJECT_PATH))" -type f -name '*_runner.$(if $(filter c,$*),c,cpp)' -print)

test-c test-cpp: test-%:
	$(call VALIDATE_PROJECT,$*)
	$(CMAKE) -S "$(if $(PROJECT_GOAL),$(if $(and $(filter $*,$(PROJECT_LANGUAGE_PARENT)),$(wildcard $(PROJECT_DIR)/CMakeLists.txt)),$(PROJECT_DIR),$(PROJECT_DIR)/$*),.)" -B "build/$*/test$(if $(PROJECT_GOAL),/$(PROJECT_PATH))" -DBUILD_TESTING=ON $(if $(PROJECT_GOAL),,-DC_FAMILY_LANGUAGE=$*)
	$(CMAKE) --build "build/$*/test$(if $(PROJECT_GOAL),/$(PROJECT_PATH))"
	$(CTEST) --test-dir "build/$*/test$(if $(PROJECT_GOAL),/$(PROJECT_PATH))" --output-on-failure
