#include <stdio.h>
#include "types.h"
#include "board.h"
#include "utilities.h"
extern struct point board_size;
extern struct point pos;
extern struct point double_b;
extern int single_b;
extern int single_n;
extern char type[3];


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

struct instruction* get_instruction(struct point pos, operation_type ot, subtype_enum st, struct point bb, int b, int num){
  struct operation* op = malloc(sizeof *op);
  op->op_type = ot;
  op->subtype = st;
  op->bb      = bb;
  op->b       = b;
  op->num     = num;
  struct point* position = malloc(sizeof *position);
  position->a = pos.a;
  position->b = pos.b;
  struct instruction* inst = malloc(sizeof *inst);
  inst->op = op;
  inst->pos= position;
  return inst;
}

