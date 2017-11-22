#include <stdio.h>
#include <stdlib.h>
#include "types.h"
#include "board.h"
#include "list.h"
#include "utilities.h"


void hacer_adds();
void set_size();


ListADT list;
extern char* operation_type_string[];
extern char* subtype_string[];
struct point board_size;
struct point pos;
struct point double_b;
int single_b;
int single_n;
char type[3];


int main(){
  list = new_list();
  hacer_adds();
  set_size();
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
  printf("tablero armado, a partir de aca es lectura de lrjs y to2 eso\n");
}

void hacer_adds(){

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 0;
  pos.a      = 1;
  pos.b      = 1;
  quick_add(ipb, none);

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 0;
  pos.a      = 1;
  pos.b      = 2;
  quick_add(ply, none);

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 0;
  pos.a      = 1;
  pos.b      = 3;
  quick_add(ipb, none);

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 0;
  pos.a      = 1;
  pos.b      = 4;
  quick_add(dpb, none);

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 0;
  pos.a      = 2;
  pos.b      = 1;
  quick_add(ipf, none);

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 0;
  pos.a      = 2;
  pos.b      = 2;
  quick_add(dpf, none);

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 0;
  pos.a      = 2;
  pos.b      = 3;
  quick_add(rdc, none);

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 0;
  pos.a      = 2;
  pos.b      = 4;
  quick_add(ptc, none);

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 1;
  single_n   = 0;
  pos.a      = 3;
  pos.b      = 1;
  quick_add(add, B);

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 1;
  pos.a      = 3;
  pos.b      = 2;
  quick_add(sub, NUM);

  double_b.a = 1;
  double_b.b = 2;
  single_b   = 0;
  single_n   = 0;
  pos.a      = 3;
  pos.b      = 3;
  quick_add(diV, BB);

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 178;
  pos.a      = 3;
  pos.b      = 4;
  quick_add(mul, NUM);

}


void set_size(){
  board_size.a = 4;
  board_size.b = 3;
}
