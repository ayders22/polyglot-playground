CPP_SOURCES := $(sort $(shell find $(PLAYGROUND_DIR) -type f \( -path '*/cpp/*.cpp' -o -path '*/cpp/*.cc' -o -path '*/cpp/*.cxx' \) ! -path '*/tests/*'))
CPP_FILES := $(sort $(shell find $(PLAYGROUND_DIR) -type f \( -path '*/cpp/*.cpp' -o -path '*/cpp/*.cc' -o -path '*/cpp/*.cxx' -o -path '*/cpp/*.hpp' -o -path '*/cpp/*.h' \)))
