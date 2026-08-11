CC = gcc

CFLAGS = -Wall -g -std=c99 -Iinclude -MMD -MP

SRC_DIR = src
BUILD_DIR = build
BINARY_DIR = bin

TARGET = $(BINARY_DIR)/clox

SOURCES = $(wildcard $(SRC_DIR)/*.c)

OBJECTS = $(SOURCES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

DEPENDS = $(OBJECTS:.o=.d)

$(TARGET): $(OBJECTS) | $(BINARY_DIR)
	$(CC) $(OBJECTS) -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR) $(BINARY_DIR):
	mkdir -p $@

-include $(DEPENDS)

clean:
	rm -rf $(BUILD_DIR) $(BINARY_DIR)

run: $(TARGET)
	./$(TARGET)


.PHONY: clean run
