%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "bc.tab.h"
void yyerror(char *);
%}
%option outfile="bc.yy.c" header-file="bc.yy.h"
%option yylineno
%%
"//".*\n
[ \t\r\v\f]+
"/*"([^*]|\*+[^*/])*\*+"/"
[0-9]+		{ yylval = atoi(yytext); return NUM; }
.|\n		{ return yytext[0]; }
%%
