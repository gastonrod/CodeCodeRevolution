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


int main(int argc, char* argv[]){
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
}

void hacer_adds(){

  double_b.a = 0;
  double_b.b = 0;
  single_b   = 0;
  single_n   = 0;
  quick_add(ipb, none);

  double_b.a = 1;
  double_b.b = 2;
  single_b   = 0;
  single_n   = 0;
  quick_add(add, BB);

}


void set_size(){
  board_size.a = 1;
  board_size.b = 2;
}
