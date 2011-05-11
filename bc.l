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
"++"		{ return PLUS_PLUS; }
"--"		{ return MINUS_MINUS; }
"||"		{ return OR; }
"&&"		{ return AND; }
"<="		{ return LE; }
">="		{ return GE; }
"=="		{ return EQ; }
"!="		{ return NE; }
"+="		{ return PLUS_EQ; }
"-="		{ return MINUS_EQ; }
"*="		{ return ASTERISK_EQ; }
"/="		{ return SLASH_EQ; }
"%="		{ return PERCENT_EQ; }
"^="		{ return CHAPEUZINHODOVOVO_EQ; }
[|@#$&]+
.|\n		{ return yytext[0]; }
%%
