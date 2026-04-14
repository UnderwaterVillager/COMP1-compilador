// INICIALIZAÇÃO
%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

// COMUNICAÇÃO COM O LEXER
%token NUM
%token EQUAL DIFF LESS_EQ GREAT_EQ LESSER GREATER
%token UPDT_PLUS UPDT_MINUS UPDT_TIMES UPDT_DIVIDE
%token INITVAR
%token PLUS MINUS TIMES DIVIDE INTDIVIDE MOD
%token L_PAREN R_PAREN L_SQBRACKET R_SQBRACKET L_CRLRBRACKET R_CRLRBRACKET
%token AND OR NOT
%token TYPE_INT TYPE_FLOAT TYPE_DOUBLE TYPE_CHAR TYPE_BOOL TYPE_VOID
%token ID
%token SEMICOLON
%token COMMA
%token ADDR

// PRECEDÊNCIA
%left PLUS MINUS
%left TIMES DIVIDE INTDIVIDE MOD

// GRAMÁTICA
%%
tipo: 
    TYPE_INT 
    | TYPE_FLOAT 
    | TYPE_DOUBLE 
    | TYPE_CHAR 
    | TYPE_BOOL 
    | TYPE_VOID 
    ;

declarador: // x
    ID
    | ID INITVAR expressao
    ;

declaradores: // x, y, z
    declarador 
    | declaradores COMMA declarador 
    ;

declaracao: // int x, y = 10;
    tipo declaradores SEMICOLON 
    ;

expressao: // regras que definem operações que produzem valores
    expressao PLUS expressao
  | expressao MINUS expressao
  | expressao TIMES expressao
  | expressao DIVIDE expressao
  | expressao INTDIVIDE expressao
  | expressao MOD expressao
  | L_PAREN expressao R_PAREN
  | NUM
  ;

%%

// CASO DÊ ERRO
void yyerror(const char *s) {
    fprintf(stderr, "Erro sintático: %s\n", s);
}

// MAIN
int main(void) {
    yyparse();
    return 0;
}