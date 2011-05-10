%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define TODO(fmt, arg...) printf("[TODO] "fmt, ## arg)
#define FIXME(fmt, ...) printf("[FIXME] "fmt, ##__VA_ARGS__)

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
%left '-' '+'
%left '*' '/' '%'
%left NEG
%right '^'

%%
bc
	:/* vazio */
	| bc linha
	;

linha
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

