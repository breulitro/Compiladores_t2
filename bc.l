%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <bc.tab.h>
#include <bcdebug.h>

void yyerror(char *);
%}
%option outfile="bc.yy.c" header-file="bc.yy.h"
%option yylineno

ID [a-zA-Z][a-zA-Z0-9]*
STRING [a-zA-Z_]?\"(\\.|[^\\"])*\"
NUM [0-9]+
COMMENT "/*"([^*]|\*+[^*/])*\*+"/"
LINE_COMMENT "//".*\n
UNACCEPTED [|@#$&]+
ESCAPED [ \t\r\v\f]+

%%

quit        { LDBG("Bye! :-)\n"); exit(0); }
if          { LDBG("IF "); return IF; }
else        { LDBG("ELSE "); return ELSE; }
while       { LDBG("WHILE "); return WHILE; }
for         { LDBG("FOR "); return FOR; }
define      { LDBG("DEFINE "); return DEFINE; }
auto        { LDBG("AUTO "); return AUTO; }
return      { LDBG("RETURN "); return RETURN; }
print       { LDBG("PRINT "); return PRINT; }
break       { LDBG("BREAK "); return BREAK; }
continue	{ LDBG("CONTINUE "); return CONTINUE; }
halt		{ LDBG("HALT "); return HALT; }
limits		{ LDBG("LIMITS "); return LIMITS; }
warrant		{ LDBG("WARRANTY "); return WARRANTY; }

sqrt        { LDBG("SQRT "); return SQRT; }
ibase       { LDBG("IBASE "); return IBASE; }
obase       { LDBG("OBASE "); return OBASE; }
"."         { LDBG(". "); return '.'; }
{ID}		{ /*yylval = getvar(yytext);*/ LDBG("ID "); return ID; }
{STRING}    { LDBG("STRING "); return STRING; }
{NUM}		{ yylval = atoi(yytext); LDBG("NUM "); return NUM; }
"++"		{ LDBG("++ "); return PLUS_PLUS; }
"--"		{ LDBG("-- "); return MINUS_MINUS; }
"||"		{ LDBG("|| "); return OR; }
"&&"		{ LDBG("&& "); return AND; }
"<="		{ LDBG("<= "); return LE; }
">="		{ LDBG(">= "); return GE; }
"=="		{ LDBG("== "); return EQ; }
"!="		{ LDBG("!= "); return NE; }
"+="		{ LDBG("+= "); return PLUS_EQ; }
"-="		{ LDBG("-= "); return MINUS_EQ; }
"*="		{ LDBG("*= "); return ASTERISK_EQ; }
"/="		{ LDBG("/= "); return SLASH_EQ; }
"%="		{ LDBG("%= "); return PERCENT_EQ; }
"^="		{ LDBG("^= "); return CHAPEUZINHODOVOVO_EQ; }
{COMMENT}
{LINE_COMMENT}
{ESCAPED}
{UNACCEPTED}	{ yyerror("unaccepted char"); }
.|\n		{ LDBG("%c ", yytext[0]); return yytext[0]; }
%%
