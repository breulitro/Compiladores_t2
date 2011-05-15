#include <bcdebug.h>

extern void yyerror(char const*);

typedef struct symrec {
	struct symrec *proximo;
	char *nome;
	int val; //com float funciona, mas double da merda...
} symrec;

symrec *var_table = NULL;

symrec *_procura_pelo_nome(struct symrec *v, char *n) {
	DBG("Procurando por %s", n);
	if (v) {
		if (!strcmp(v->nome, n)) {
			DBG("Encontrado");
			return v;
		} else {
			return _procura_pelo_nome(v->proximo, n);
		}
	} else {
		DBG("Nao Encontrado");
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

void debug_symtable() {
#if DEBUG_MASK
	symrec *s;
	int i = 0;
	for(s = var_table; s; s = s->proximo)
		DBG("Variavel[%d]:\n\tNome: %s\n\tValor: %d", ++i, s->nome, s->val);
	DBG("%d variaveis na tabela", i);
#endif
}

symrec *getsym(char *n) {
	TODO("REFACTORING");
	symrec *i = NULL;
	if (!var_table) {
		struct symrec *novavar = malloc(sizeof(struct symrec *));
		if (!novavar)
			yyerror("Out of Memory");

		novavar->nome = n;
		novavar->val = 0;
		novavar->proximo = NULL;
		var_table = novavar;
		i = var_table;
		DBG("Primeira variavel: %s", novavar->nome);
	} else {
		if (!(i = procura_pelo_nome(n))) {
			struct symrec *novavar = malloc(sizeof(struct symrec *));
			if (!novavar)
				yyerror("Out of Memory");

			novavar->nome = n;
			novavar->proximo = var_table;
			var_table = novavar;
			i = var_table;
			DBG("Mais uma variavel");
		}
	}
	debug_symtable();
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
	DBG("Retornando Variavel %s", varname);
	return varname;
}
