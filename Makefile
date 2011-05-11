LEX=flex
YACC=bison
YDBGFLAGS=--verbose
CC=gcc
CLIBS = -lfl

#DBG_TODO=1
#DBG_FIXME=2
#DBG_WARN=4
CFLAGS = -DDEBUG_MASK=7
#valores acima de 7 habilitam apenas a macro DBG

target = bc

all:
	$(YACC) -d $(target).y
	$(LEX) $(target).l
	$(CC) $(target).yy.c $(target).tab.c -o $(target) $(CLIBS) $(CFLAGS)

clean:
	rm -f $(target).yy.*
	rm -f $(target).tab.*
	rm -f $(target)
