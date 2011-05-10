LEX=flex
YACC=bison
YDBGFLAGS=--verbose
CC=gcc
CLIBS = -lfl
CFLAGS = -DDEBUG
target = bc

all:
	$(YACC) -d $(target).y
	$(LEX) $(target).l
	$(CC) $(target).yy.c $(target).tab.c -o $(target) $(CLIBS) $(CFLAGS)

clean:
	rm -f $(target).yy.*
	rm -f $(target).tab.*
	rm -f $(target)
