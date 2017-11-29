%{
  #include <stdlib.h>
  #include <stdio.h>
  #include <string.h>
  #include "types.h"
  #include "list.h"
  #include "utilities.h"
  #include "board.h"
  #include "parser_utilities.h"
  extern int yylex();
  extern char* operation_type_string[];
  struct point board_size;
  struct point pos;
  struct point double_b;
  int single_b;
  int single_n;
  char type[3];
  void quick_add(operation_type ot, subtype_enum st);
  void quick_add_comp(subtype_enum st);
  ListADT list;
%}


%start Start
%token SIZE POINT
%token IPB DPB IPF DPF LOCATION
%token ADD SUB MUL DIV
%token RDC PTC
%token PLY IFZ
%token OP OPBB OPB OPN
%%
Start  : SIZE Rule{print_set_size();}
  ;
Rule:   POINT Op Rule
       |LAMBDA {}
       ; 
Op:     IPB{print_add_instruction(ipb,none,pos);quick_add(ipb, none);}
       |DPB{print_add_instruction(dpb,none,pos);quick_add(dpb, none);}
       |IPF{print_add_instruction(ipf,none,pos);quick_add(ipf, none);}
       |DPF{print_add_instruction(dpf,none,pos);quick_add(dpf, none);}
       |RDC{print_add_instruction(rdc,none,pos);quick_add(rdc, none);}
       |PTC{print_add_instruction(ptc,none,pos);quick_add(ptc, none);}
       |PLY{print_add_instruction(ply,none,pos);quick_add(ply, none);}
       |IFZ{print_add_instruction(ifz,none,pos);quick_add(ifz, none);}
       |ADD Tipo{}
       |SUB Tipo{}
       |MUL Tipo{}
       |DIV Tipo{}
       ;
Tipo:   OPBB{print_add_composite_instruction( BB,pos);double_b.a = 0;double_b.b = 0;quick_add_comp(BB);}
       |OPB {print_add_composite_instruction(  B,pos);single_b   = 0;quick_add_comp(B);}
       |OPN {print_add_composite_instruction(NUM,pos);single_n   = 0;quick_add_comp(NUM);}
       ;
LAMBDA: {}
       ;
%%
#include <string.h>
#include <stdio.h>
#include "types.h"
#include "list.h"
char* progname;
void print_instruction(struct instruction inst);
int warning(char* s, char* t);
int main(int argc,char* argv[])
{
  print_includes();
  print_main();
  list = new_list();
  progname = argv[0];
  yyparse();
  

  
  ListIteratorADT iterator = get_iterator(list);
  struct instruction inst;

  while(iter_has_next(iterator)){
    struct instruction inst = *iter_get_next(iterator);
    if((*inst.pos).a < 1 || (*inst.pos).a > board_size.a || (*inst.pos).b < 1 || (*inst.pos).b > board_size.a){
      fprintf(stderr, "Error! Index out of bounds. Fijate como estas armando la tabla\n");
      exit(0);
    }
  }
  return 1;  
}
 
int yyerror( s )
char *s;
{
  warning( s , ( char * )0 );
  yyparse();
}
 
int warning( s , t )
char *s , *t;
{
  fprintf( stderr ,"%s: %s\n" , progname , s );
  if ( t )
    fprintf( stderr , " %s\n" , t );
}
