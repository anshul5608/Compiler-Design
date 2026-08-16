/*
 * lexer.l  -  Lexical Analyzer for our C-like source language
 *
 * Build: flex + gcc (see ../Makefile)
 * Usage: ./lexer <source-file>
 *
 * Behavior:
 *   - Scans the whole input file.
 *   - For every valid token found, prints a row to a Lexeme/Token
 *     table (in the order the tokens appear in the source).
 *   - For every invalid character / malformed lexeme, records a
 *     lexical error (with line number) instead of aborting, so
 *     that scanning continues and ALL errors in the file are
 *     eventually reported.
 *   - Prints an error summary at the end if any errors were found.
*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

/* simple growable list of error messages */
static char **errorList = NULL;
static int errorCount = 0;
static int errorCap = 0;

static void recordError(const char *fmt, ...) {
    char buf[512];
    va_list args;
    va_start(args, fmt);
    vsnprintf(buf, sizeof(buf), fmt, args);
    va_end(args);

    if (errorCount == errorCap) {
        errorCap = errorCap == 0 ? 8 : errorCap * 2;
        errorList = (char **)realloc(errorList, errorCap * sizeof(char *));
    }
    errorList[errorCount++] = strdup(buf);
}

/* print one row of the Lexeme / Token table */
static void emit(const char *lexeme, const char *token) {
    printf("| %-25s | %-35s |\n", lexeme, token);
}

static int tokenCount = 0;
#define TOK(name) do { tokenCount++; emit(yytext, name); } while (0)
%}

%option noyywrap
%option yylineno

DIGIT   [0-9]
LETTER  [A-Za-z_]
ID      {LETTER}({LETTER}|{DIGIT})*
INT     {DIGIT}+
WS      [ \t\r]+

%%

"//".*                      { /* single-line comment: skip */ }
"/*"([^*]|\*+[^*/])*\*+"/"  { /* multi-line comment: skip */ }
"/*"([^*]|\*+[^*/])*        { recordError("Line %d: unterminated block comment", yylineno); }

 /* ---- keywords ---- */
"int"       { TOK("keyword"); }
"char"      { TOK("keyword"); }
"void"      { TOK("keyword"); }
"struct"    { TOK("keyword"); }
"union"     { TOK("keyword"); }
"typedef"   { TOK("keyword"); }
"enum"      { TOK("keyword"); }
"if"        { TOK("keyword"); }
"else"      { TOK("keyword"); }
"for"       { TOK("keyword"); }
"while"     { TOK("keyword"); }
"do"        { TOK("keyword"); }
"until"     { TOK("keyword"); }
"switch"    { TOK("keyword"); }
"case"      { TOK("keyword"); }
"default"   { TOK("keyword"); }
"break"     { TOK("keyword"); }
"continue"  { TOK("keyword"); }
"goto"      { TOK("keyword"); }
"return"    { TOK("keyword"); }
"printf"    { TOK("keyword"); }
"scanf"     { TOK("keyword"); }
"static"    { TOK("keyword"); }

 /* ---- OOP & Advanced memory keywords ---- */
"class"     { TOK("keyword"); }
"public"    { TOK("keyword"); }
"private"   { TOK("keyword"); }
"protected" { TOK("keyword"); }
"new"       { TOK("keyword"); }
"delete"    { TOK("keyword"); }
"auto"      { TOK("keyword"); }
"FILE"      { TOK("keyword"); }

 /* ---- identifiers & numeric literal ---- */
{ID}        { TOK("identifier"); }
{INT}       { TOK("integer literal"); }

 /* ---- character literal: 'a' , '\n' , etc. ---- */
\'(\\.|[^\\'\n])\'   { TOK("character literal"); }
\'(\\.|[^\\'\n])*    { recordError("Line %d: unterminated character literal '%s'", yylineno, yytext); }

 /* ---- string literal: "..." (must close on same line) ---- */
\"(\\.|[^\\"\n])*\"  { TOK("string literal"); }
\"(\\.|[^\\"\n])*    { recordError("Line %d: unterminated string literal starting '%s'", yylineno, yytext); }

 /* ---- punctuation / separators ---- */
"("   { TOK("left parenthesis"); }
")"   { TOK("right parenthesis"); }
"{"   { TOK("left brace"); }
"}"   { TOK("right brace"); }
"["   { TOK("left bracket"); }
"]"   { TOK("right bracket"); }
";"   { TOK("semicolon"); }
","   { TOK("comma"); }
"."   { TOK("dot"); }
":"   { TOK("colon"); }
"..." { TOK("ellipsis"); }

 /* ---- operators ---- */
"=="  { TOK("relational operator"); }
"!="  { TOK("relational operator"); }
"<="  { TOK("relational operator"); }
">="  { TOK("relational operator"); }
"<"   { TOK("relational operator"); }
">"   { TOK("relational operator"); }

"&&"  { TOK("logical operator"); }
"||"  { TOK("logical operator"); }
"!"   { TOK("logical operator"); }

"="   { TOK("assignment operator"); }

"+"   { TOK("arithmetic operator"); }
"-"   { TOK("arithmetic operator"); }
"*"   { TOK("arithmetic operator / pointer"); }
"/"   { TOK("arithmetic operator"); }
"%"   { TOK("arithmetic operator"); }

"&"   { TOK("address-of / reference operator"); }

 /* ---- whitespace / newline ---- */
\n    { /* yylineno auto-increments */ }
{WS}  { /* skip */ }

 /* ---- preprocessor directives ---- */
"#".* { TOK("preprocessor directive"); }

 /* ---- anything else is a lexical error ---- */
.     { recordError("Line %d: unexpected character '%s'", yylineno, yytext); }

%%

int main(int argc, char **argv) {
    FILE *f = NULL;

    if (argc >= 2) {
        f = fopen(argv[1], "r");
        if (!f) {
            fprintf(stderr, "Error: could not open file '%s'\n", argv[1]);
            return 1;
        }
        yyin = f;
    } else {
        yyin = stdin; /* read from stdin if no file given */
    }

    printf("==================================================================\n");
    printf("Lexical Analysis of: %s\n", argc >= 2 ? argv[1] : "<stdin>");
    printf("==================================================================\n");
    printf("| %-25s | %-35s |\n", "Lexeme", "Token");
    printf("|---------------------------|-------------------------------------|\n");

    yylex();

    printf("------------------------------------------------------------------\n");
    printf("Total valid tokens recognized: %d\n", tokenCount);

    if (errorCount > 0) {
        printf("\n==================================================================\n");
        printf("LEXICAL ERRORS FOUND: %d\n", errorCount);
        printf("==================================================================\n");
        for (int i = 0; i < errorCount; i++) {
            printf("  [%d] %s\n", i + 1, errorList[i]);
        }
    } else {
        printf("No lexical errors found.\n");
    }

    if (f) fclose(f);
    return errorCount > 0 ? 1 : 0;
}
