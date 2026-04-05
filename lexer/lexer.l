%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

#define RETURN_TOKEN(tok) \
    do { \
        printf("TOKEN: %s | VALUE: %s\n", #tok, yytext); \
        return tok; \
    } while(0)
%}

%%

[0-9]+          { 
    //yylval = atoi(yytext); 
    RETURN_TOKEN(NUM); }

"=="            { RETURN_TOKEN(EQUAL); }
"!="            { RETURN_TOKEN(DIFF); }
"<="            { RETURN_TOKEN(LESS_EQ); }
">="            { RETURN_TOKEN(GREAT_EQ); }
"<"             { RETURN_TOKEN(LESSER); }
">"             { RETURN_TOKEN(GREATER); }

"+="            { RETURN_TOKEN(UPDT_PLUS); }
"-="            { RETURN_TOKEN(UPDT_MINUS); }
"*="            { RETURN_TOKEN(UPDT_TIMES); }
"/="            { RETURN_TOKEN(UPDT_DIVIDE); }
"="             { RETURN_TOKEN(INITVAR); }

"+"             { RETURN_TOKEN(PLUS); }
"-"             { RETURN_TOKEN(MINUS); }
"*"             { RETURN_TOKEN(TIMES); }
"//"            { RETURN_TOKEN(INTDIVIDE); }
"/"             { RETURN_TOKEN(DIVIDE); }
"%"             { RETURN_TOKEN(MOD); }

"("             { RETURN_TOKEN(L_PAREN); }
")"             { RETURN_TOKEN(R_PAREN); }
"["             { RETURN_TOKEN(L_SQBRACKET); }
"]"             { RETURN_TOKEN(R_SQBRACKET); }
"{"             { RETURN_TOKEN(L_CRLRBRACKET); }
"}"             { RETURN_TOKEN(R_CRLRBRACKET); }

"&&"            { RETURN_TOKEN(AND); }
"||"            { RETURN_TOKEN(OR); }
"!"             { RETURN_TOKEN(NOT); }

"int"           { RETURN_TOKEN(INT); }
"float"         { RETURN_TOKEN(FLOAT); }
"double"        { RETURN_TOKEN(DOUBLE); }
"char"          { RETURN_TOKEN(CHAR); }
"bool"          { RETURN_TOKEN(BOOL); }
"void"          { RETURN_TOKEN(VOID); }
"&"             { RETURN_TOKEN(ADDR); }

[ \t\n]+        { /* Ignorar espaços em branco */ }
";"             { RETURN_TOKEN(SEMICOLON); }
.               { printf("\nCaractere inválido: %s\n\n", yytext); }
%%

int yywrap(void) {
    return 1;
}