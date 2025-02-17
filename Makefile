COPT = $(if $(OPT),-O3 -flto,)
CC = gcc
CFLAGS = -g -Wall $(COPT)
LDFLAGS =

SRC_DIR = src
BUILD_DIR = build

SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

.DEFAULT_GOAL = clean

.PHONY: clean
clean:
	find . -type f -name *.o   -delete
	find . -type f -executable -delete

.PHONY: fmt-check
fmt-check:
	clang-format --Werror --dry-run -i **/*.c

.PHONY: fmt
fmt:
	clang-format -i **/*.c

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p ${BUILD_DIR}
	$(CC) $(CFLAGS) -c $< -o $@ $(LDFLAGS)

.PHONY: build
build: $(OBJS)
	$(CC) $(CFLAGS) $< -o a.out $(LDFLAGS)
