// INICIALIZAÇÃO
%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

// COMUNICAÇÃO COM O LEXER
%token NUM FLOAT_NUM
%token STRING CHAR_LIT
%token EQUAL DIFF LESS_EQ GREAT_EQ LESSER GREATER
%token UPDT_PLUS UPDT_MINUS UPDT_TIMES UPDT_DIVIDE
%token UPDT_INC UPDT_DEC
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

programa:
    comandos
    ;

comandos:
    comando
    | comandos comando
    ;

comando:
    declaracao
    | atribuicao
    | atualizacao
    ;
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

atribuicao: // x = 10;
    ID INITVAR expressao SEMICOLON
    ;

atualizacao: // x += 5; x++;
    ID UPDT_PLUS expressao SEMICOLON
    | ID UPDT_MINUS expressao SEMICOLON
    | ID UPDT_TIMES expressao SEMICOLON
    | ID UPDT_DIVIDE expressao SEMICOLON
    | ID UPDT_INC SEMICOLON
    | ID UPDT_DEC SEMICOLON
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
  | FLOAT_NUM
  | ID
  | STRING
  | CHAR_LIT
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