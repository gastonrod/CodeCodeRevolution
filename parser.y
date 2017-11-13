%{
  #include <stdio.h>
  #include <string.h>
  #include "types.h"
  extern int yylex();
  struct point board_size;
  struct point pos;
  struct point double_b;
  int single_b;
  int single_n;
  char type[3];
%}

%start Start
%token SIZE POINT
%token IPB DPB IPF DPF LOCATION
%token ADD SUB MUL DIV
%token RDC PTC
%token PLY IFZ
%token OP OPBB OPB OPN
%%
Start  : SIZE Rule{printf("Size: %d %d\n", board_size.a,board_size.b);}
  ;
Rule:   POINT Op Rule
       |LAMBDA {printf("Rule: Lambda\n");}
       ; 
Op:     IPB{printf("IPB en %d %d",pos.a, pos.b);}
       |DPB{printf("DPB en %d %d",pos.a, pos.b);}
       |IPF{printf("IPF en %d %d",pos.a, pos.b);}
       |DPF{printf("DPF en %d %d",pos.a, pos.b);}
       |RDC{printf("RDC en %d %d",pos.a, pos.b);}
       |PTC{printf("PTC en %d %d",pos.a, pos.b);}
       |PLY{printf("PLY en %d %d",pos.a, pos.b);}
       |IFZ{printf("IFZ en %d %d",pos.a, pos.b);}
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
#include "types.h"

char* progname;
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
