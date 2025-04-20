CC = gcc
LEX = lex
YACC = yacc -d -v

# Source files
LEX_SRC = CS315_S25_Team16.lex
YACC_SRC = CS315_S25_Team16.yacc

# Generated files
YACC_C = y.tab.c
YACC_H = y.tab.h
LEX_C = lex.yy.c

# Object files
OBJ = y.tab.o lex.yy.o

# Rules
all: parser

# Generate parser source files
$(YACC_C) $(YACC_H): $(YACC_SRC)
	$(YACC) $(YACC_SRC)

$(LEX_C): $(LEX_SRC) $(YACC_H)
	$(LEX) $(LEX_SRC)

# Compile object files
y.tab.o: $(YACC_C)
	$(CC) -c y.tab.c -o y.tab.o

lex.yy.o: $(LEX_C)
	$(CC) -c lex.yy.c -o lex.yy.o

# Link the final executable
parser: $(OBJ)
	$(CC) $(OBJ) -o parser

# Cleaning
clean:
	rm -f parser y.tab.* lex.yy.* *.o

