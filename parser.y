%{
  #include <stdio.h>
  #include <string.h>
  #include "types.h"
  extern int yylex();
  struct point board_size;
%}

%union{
  #include "types.h"
  struct point pos;
  struct point double_b;
  int single_b;
  int single_n;
  char type[3];
}
%start Start
%token SIZE POINT
%token IPB DPB IPF DPF LOCATION
%token ADD SUB MUL DIV
%token RDC PTC
%token PLY IFZ
%token OP OPBB OPB OPN
%%
Start  : SIZE Rule{board_size.a = yylval.pos.a;board_size.b = yylval.pos.b;printf("Size: %d %d\n", yylval.pos.a,yylval.pos.b);}
  ;
Rule:   POINT Op Rule{printf("Rule: %d %d\n", yylval.pos.a, yylval.pos.b);}
       |LAMBDA {printf("Rule: Lambda\n");}
       ; 
Op:     IPB{printf("IPB en %d %d",yylval.pos.a, yylval.pos.b);}
       |DPB{printf("DPB");}
       |IPF{printf("IPF");} 
       |DPF{printf("DPF");}
       |RDC{printf("RDC");}
       |PTC{printf("PTC");}
       |PLY{printf("PLY");}
       |IFZ{printf("IFZ");}
       |ADD Tipo{printf("add");}
       |SUB Tipo{printf("sub");}
       |MUL Tipo{printf("mul");}
       |DIV Tipo{printf("div");}
       ;
Tipo:   OPBB{printf("OPBB");}
       |OPB {printf("OPB");}
       |OPN {printf("OPN");}
       ;
LAMBDA: {printf("\n-----Lambda-----\n");}
       ;
%%
#include <string.h>
#include <stdio.h>
char* progname;
#include "types.h"
main(int argc,char* argv[])
{
  progname = argv[0];
  yyparse();
}
 
yyerror( s )
char *s;
{
  warning( s , ( char * )0 );
  yyparse();
}
 
warning( s , t )
char *s , *t;
{
  fprintf( stderr ,"%s: %s\n" , progname , s );
  if ( t )
    fprintf( stderr , " %s\n" , t );
}
