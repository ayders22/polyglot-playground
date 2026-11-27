C_SOURCES := $(sort $(shell find $(PLAYGROUND_DIR) -type f \( -path '*/c/*.c' -o -path '*/c/*.cc' \) ! -path '*/tests/*'))
C_FILES := $(sort $(shell find $(PLAYGROUND_DIR) -type f \( -path '*/c/*.c' -o -path '*/c/*.cc' -o -path '*/c/*.h' \)))
