%{
  #include <stdio.h>
  #include <string.h>
  #include "types.h"
  #include "list.h"
  #include "utilities.h"
  #include "board.h"
  extern int yylex();
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
Start  : SIZE Rule{printf("Size: %d %d\n\n", board_size.a,board_size.b);}
  ;
Rule:   POINT Op Rule
       |LAMBDA {printf("Rule: Lambda\n");}
       ; 
Op:     IPB{quick_add(ipb, none);printf("IPB en %d %d",pos.a, pos.b);}
       |DPB{quick_add(dpb, none);printf("DPB en %d %d",pos.a, pos.b);}
       |IPF{quick_add(ipf, none);printf("IPF en %d %d",pos.a, pos.b);}
       |DPF{quick_add(dpf, none);printf("DPF en %d %d",pos.a, pos.b);}
       |RDC{quick_add(rdc, none);printf("RDC en %d %d",pos.a, pos.b);}
       |PTC{quick_add(ptc, none);printf("PTC en %d %d",pos.a, pos.b);}
       |PLY{quick_add(ply, none);printf("PLY en %d %d",pos.a, pos.b);}
       |IFZ{quick_add(ifz, none);printf("IFZ en %d %d",pos.a, pos.b);}
       |ADD Tipo{printf("add");}
       |SUB Tipo{printf("sub");}
       |MUL Tipo{printf("mul");}
       |DIV Tipo{printf("div");}
       ;
Tipo:   OPBB{quick_add_comp(BB);printf("OPBB %s", type);}
       |OPB {quick_add_comp(B);printf("OPB");}
       |OPN {quick_add_comp(NUM);printf("OPN");}
       ;
LAMBDA: {printf("\n-----Lambda-----\n");}
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
  list = new_list();
  progname = argv[0];
  yyparse();
  ListIteratorADT iterator = get_iterator(list);
  struct instruction inst;
  Board board;


// Esto deberia ser new_board, pero no lo se hacer andar
  // new_board(board);
  board = malloc((sizeof *board) * board_size.a);
  for(int i = 0; i < board_size.a; i++)
    board[i] = malloc((sizeof *board) * board_size.b);



  while(iter_has_next(iterator)){
    struct instruction inst = *iter_get_next(iterator);
    //print_instruction(inst);
    add_instruction_to_board(board, inst);
  }
  print_board(board);
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
