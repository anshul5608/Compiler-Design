CC      = gcc
CFLAGS  = -Wall -Wno-unused-function
FLEX    = flex

SRC_DIR = src
LEX_SRC = $(SRC_DIR)/lexer.l
GEN_C   = lex.yy.c
TARGET  = lexer

.PHONY: all clean run

all: $(TARGET)

$(GEN_C): $(LEX_SRC)
	$(FLEX) -o $(GEN_C) $(LEX_SRC)

$(TARGET): $(GEN_C)
	$(CC) $(CFLAGS) -o $(TARGET) $(GEN_C)

clean:
	rm -f $(TARGET) $(GEN_C)
run: all
	./run.sh
