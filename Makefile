LEX=flex
YACC=bison
YDBGFLAGS=--verbose
CC=gcc
CLIBS = -lfl
CFLAGS = -I.

#DBG_TODO=1
#DBG_FIXME=2
#DBG_WARN=4
#DBG_LEX=8
#DBG_YACC=16
MASK = 31
CFLAGS += -DDEBUG_MASK=$(MASK)
#valores acima de 31 habilitam apenas a macro DBG

target = bc

all:
	@echo -e "\e[31m\n\tFormar mascara de um jeito descente\n\e[0m"
	$(YACC) -d $(target).y
	$(LEX) $(target).l
	$(CC) $(target).yy.c $(target).tab.c -o $(target) $(CLIBS) $(CFLAGS)

clean:
	rm -f $(target).yy.*
	rm -f $(target).tab.*
	rm -f $(target)
