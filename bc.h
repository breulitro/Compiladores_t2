#include <bcdebug.h>

extern void yyerror(char const*);

typedef struct symrec {
	struct symrec *proximo;
	char *nome;
	double val;
} symrec;

symrec *var_table = NULL;

symrec *_procura_pelo_nome(struct symrec *v, char *n) {
	if (v) {
		if (!strcmp(v->nome, n)) {
			return v;
		} else {
			return _procura_pelo_nome(v->proximo, n);
		}
	} else {
		return NULL;
	}
}

symrec *procura_pelo_nome(char *n) {
	if (n)
		return _procura_pelo_nome(var_table, n);
	else
		yyerror("\n\tNão era prá ter chegado aqui...\n"
				"\n\tSenta e chora!\n\n");
}

symrec *getsym(char *n) {
	symrec *i = NULL;
	if (!var_table) {
		struct symrec *novavar = malloc(sizeof(struct symrec *));
		if (!novavar)
			yyerror("Out of Memory");

		novavar->nome = n;
		novavar->proximo = NULL;
		var_table = novavar;
		i = var_table;
	} else {
		if (!(i = procura_pelo_nome(n))) {
			struct symrec *novavar = malloc(sizeof(struct symrec *));
			if (!novavar)
				yyerror("Out of Memory");

			novavar->nome = n;
			novavar->proximo = var_table;
			var_table = novavar;
			i = var_table;
		} else {
			return i;
		}
	}
	return i;
}

void symrec_cleanup() {
	struct symrec *aux = var_table;

	while (var_table) {
		free(var_table->nome);
		free(var_table);
		var_table = aux;
	}
	printf("Cleaned\n");
}

char *gambiarra(int n, char *s) {
	char *varname = malloc(100);
	memset(varname, 0, 100);
	FIXME("liberar tamanho da variavel");
	WARN("Memory leak no $1");
	sprintf(varname, "%d%s", n, s);
	DBG("Criando Variavel %s", varname);
	return varname;
}
