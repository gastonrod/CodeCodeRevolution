#include <stdio.h>
#include "types.h"
#include "list.h"
#include "board.h"
#include "utilities.h"
extern struct point board_size;
extern struct point pos;
extern struct point double_b;
extern int single_b;
extern int single_n;
extern char type[3];


extern ListADT list;
char* operation_type_string[] = {"ipb","dpb","ipf","dpf","add","mul","diV","sub","rdc","ptc","ply","ifz"};
char* subtype_string[] = {"none", "BB" , "B", "NUM"};

void print_instruction(struct instruction inst){
  printf("\nPrinting instruction:\n");
  printf("Position: %d %d \n", (*inst.pos).a,(*inst.pos).b);
  print_operation(*inst.op);
}

void print_operation(struct operation op){
  printf("Op_Type: %s | Subtype: %s\n",operation_type_string[op.op_type],subtype_string[op.subtype]);
  printf("bb: (%d;%d)   | b: %d | num: %d\n",op.bb.a, op.bb.b, op.b, op.num);
}

void print_board(Board board){
  for(int i = 0; i < board_size.a; i++){
    for(int j = 0; j < board_size.b; j++){
      printf("%s ", operation_type_string[board[i][j].op_type]);
    }
    printf("\n");
  }
}

void quick_add(operation_type ot, subtype_enum st){
  add_to_list(list,get_instruction(pos, ot, st, double_b, single_b, single_n));
  switch(st){
    case BB:
      double_b.a = 0;
      double_b.b = 0;
      break;
    case B:
      single_b   = 0;
      break;
    case NUM:
      single_n   = 0;
      break;
  }
}
void quick_add_comp(subtype_enum st){
  if     (type[0] == 'a')
    quick_add(add, st);
  else if(type[0] == 's')
    quick_add(sub, st);
  else if(type[0] == 'm')
    quick_add(mul, st);
  else if(type[0] == 'd')
    quick_add(diV, st);
}

