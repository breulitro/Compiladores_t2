%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define DBG_TODO 1
#define DBG_FIXME 2
#define DBG_WARN 4

#define TODO(fmt, arg...) if (DBG_TODO & DEBUG_MASK) printf("[TODO] "fmt"\n", ## arg)
#define FIXME(fmt, ...) if (DBG_FIXME & DEBUG_MASK) printf("[FIXME] "fmt"\n", ##__VA_ARGS__)
#define WARN(fmt, arg...) if (DBG_WARN & DEBUG_MASK) printf("[WARN] "fmt"\n", ## arg)
#define DBG(fmt, arg...) if (DEBUG_MASK) printf(fmt"\n", ## arg)

extern int yylineno;
void yyerror(const char *str) {
	fprintf(stderr, "error: %s at line %d.\n", str, yylineno);
}

int yywrap()
{
	//FIXME: as vezes ele se perde e nao le o Ctrl+D
	return 1;
}
%}



%token NUM

%token OR "||"
%token AND "&&"
%token LE "<="
%token GE ">="
%token NE "!="
%token EQ "=="
%token PLUS_EQ "+="
%token MINUS_EQ "-="
%token DOT_EQ "*="
%token SLASH_EQ "/="
%token PERCENT_EQ "%="
%token CHAPEUZINHODOVOVO_EQ "^="
%token PLUS_PLUS "++"
%token MINUS_MINUS "--"

%left "||" "&&"
%nonassoc '!'
%left '<' '>' "<=" ">=" "!=" "=="
%left "=" "+=" "-=" "*=" "/=" "%=" "^="
%left '-' '+'
%left '*' '/' '%'
%right '^'
%nonassoc NEG
%nonassoc "--" "++"

%%
bc
	:/* vazio */
	| bc statement
	;

statement
	: '\n'
	| exp '\n'		{ printf("%d\n", $1);  }
	| error '\n'	{ yyerrok; }
	;

exp
	: NUM
	| exp '+' exp	{ $$ = $1 + $3; }
	| exp '-' exp	{ $$ = $1 - $3; }
	| exp '*' exp	{ $$ = $1 * $3; }
	| exp '/' exp	{ $$ = $1 / $3; }
	| exp '^' exp	{ $$ = $1 ^ $3; }
	| exp '%' exp	{ $$ = $1 % $3; }
	| '-' exp %prec NEG { $$ = -$2; }
	| exp "++"		{ $$ = $1; TODO("Suportar Variaveis"); }
	| exp "--"		{ $$ = $1; TODO("Suportar Variaveis"); }
	| "++" exp		{ $$ = $1 + 1; TODO("Suportar Variaveis"); }
	| "--" exp		{ $$ = $1 - 1; TODO("Suportar Variaveis"); }
	| '(' exp ')'	{ $$ = $2; }
	;
%%
void print_version() {
	printf("\nPUCRS - 2011-01\n"
			"Disciplina: Compiladores\n"
			"Professor: Alexandre Agustini\n");
	printf( "Aluno: %s\n\tMatricula: %s\n"
			"Aluno: %s\n\tMatricula: %s\n",
			"Cristiano Bolla Fernandes",
			"052800042-1",
			"Benito O.J.R.L.M.S.",
			"05202815-6");
	printf("\n\e[31mTODO:\e[0m Breve Descrição do trabalho\n");
	exit(-2);
}

void usage() {
	printf("Valid Options\n"
			"-v\tPrints Program Description\n");
	exit(-1);
}

main(int argc, char *argv[]) {
	if (argc == 2)
		if (!strcmp(argv[1], "-v"))
			print_version();
		else
			usage();

	yyparse();
	printf("Processed %d lines\n", yylineno);
}

