%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    FILE* yyin;
    using namespace std;

    int errores = 0;
    int id = 1;
%}

/*OPCIONES*/
%option c++
%option outfile="LAB01.yy.cpp"

/*TOKENS*/

/*COMANDOS*/
CREATETABLE "CREATE TABLE"|"CREATE table"
DROPTABLE "DROP TABLE"|"DROP table"
SELECT "SELECT"
WHERE "WHERE"
GROUPBY "GROUP BY"
ORDERBY "ORDER BY"
INSERT "INSERT"
DELETE "DELETE"
UPDATE "UPDATE"
MAX "MAX"
MIN "MIN"
AVG "AVG"
COUNT "COUNT"
INTO "INTO"
VALUES "VALUES"
FROM "FROM"
SET "SET"
ASC "ASC"
DESC "DESC"

/*TIPOS DE DATOS*/
DATO_INTEGER "INTEGER"
DATO_DECIMAL "DECIMAL"
DATO_VARCHAR "VARCHAR"

/*OPERADORES*/
SUMA "+"
RESTA "-"
MULT "*"
DIV "/"
IGUALDAD "=="
DIFERENCIA "<>"
MAYORQ ">"
MENORQ "<"
MAYORIQ ">="
MENORIQ "<="
AND "AND"
OR "OR"

/*SEPARADORES*/
PARENTA "("
PARENTC ")"
COMA ","
PUNTOYCOMA ";"
ASIGNACION "="

/*CARACTERES ESPECIALES*/
ASTERISCO "*"

/*IDENTIFICADORES, NUMEROS Y CADENAS*/
DIGITO [0-9]
LETRA [a-zA-ZñÑ]|á|é|í|ó|ú
GUIIONES [-_]
PUNTO "."
DOSPUNTOS ":"
CONST_ENTERO (-?[1-9][0-9]*)|0
CONST_FLOAT {DIGITO}+{PUNTO}{DIGITO}+
NUMERO {CONST_ENTERO}|{CONST_FLOAT}
IDENTIFICADOR {LETRA}({LETRA}|{NUMERO}|{GUIIONES})*
CONST_CADENA \"[^\n"]*\"|\'[^\n']*\'

ERROR {DIGITO}+{LETRA}+({DIGITO}|{LETRA})*|[^{NUMERO}]{PUNTO}[^{NUMERO}]

/*REGLAS*/
%%

{CREATETABLE}    {printf("CREATE TABLE",yytext);}
{DROPTABLE}      {printf("DROP TABLE",yytext);}
{SELECT}         {printf("SELECT",yytext);}
{WHERE}          {printf("WHERE",yytext);}
{GROUPBY}        {printf("GROUP BY",yytext);}
{ORDERBY}        {printf("ORDER BY",yytext);}    
{INSERT}         {printf("INSERT",yytext);}
{DELETE}         {printf("DELETE",yytext);}
{UPDATE}         {printf("UPDATE",yytext);}
{MAX}            {printf("MAX",yytext);}
{MIN}            {printf("MIN",yytext);}
{AVG}            {printf("AVG",yytext);}
{COUNT}          {printf("COUNT",yytext);}
{INTO}           {printf("INTO",yytext);}
{VALUES}         {printf("VALUES",yytext);}
{FROM}           {printf("FROM",yytext);}
{SET}            {printf("SET",yytext);}
{ASC}            {printf("ASC",yytext);}
{DESC}           {printf("DESC",yytext);}
{DATO_INTEGER}   {printf("INTEGER",yytext);}
{DATO_DECIMAL}   {printf("DECIMAL",yytext);}
{DATO_VARCHAR}   {printf("VARCHAR",yytext);}
{SUMA}           {printf("suma=%s",yytext);}
{RESTA}          {printf("resta=%s",yytext);}
{MULT}           {printf("multiplicación=%s",yytext);}
{DIV}            {printf("división=%s",yytext);}
{IGUALDAD}       {printf("igualdad=%s",yytext);}
{DIFERENCIA}     {printf("diferencia=%s",yytext);}
{MAYORQ}         {printf("mayorq=%s",yytext);}
{MENORQ}         {printf("menorq=%s",yytext);}
{MAYORIQ}        {printf("mayorigualq",yytext);}
{MENORIQ}        {printf("menorigualq",yytext);}
{AND}            {printf("y=%s",yytext);}
{OR}             {printf("o=%s",yytext);}
{PARENTA}        {printf("parabre=%s",yytext);}
{PARENTC}        {printf("parcierr=%s",yytext);}
{COMA}           {printf("coma=%s",yytext);}
{PUNTOYCOMA}     {printf("puntcoma=%s",yytext);}
{ASIGNACION}     {printf("asign=%s",yytext);}
[^({NUMERO}|{PARENTA})]{ASTERISCO}[^({NUMERO}|{PARENTC})] {printf("asterisco=%s",yytext);}
{CONST_ENTERO}   {printf("entero=%s",yytext);}
{CONST_FLOAT}    {printf("decimal=%s",yytext);}
{IDENTIFICADOR}  {printf("id%s",yytext);
                  id++;}
{CONST_CADENA}   {printf("cadena='%s'",yytext);}

{ERROR}          {printf("ERROR: %s ", yytext);
                 errores++;}

%%

/*CODIGO*/
int yywrap(){return 1;}

int main( int argc, char **argv ){
    ++argv, --argc;
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;

    yylex();

    printf("\n");
    printf("%d identificadores", id);

    printf("%d Errores léxicos", errores);
}