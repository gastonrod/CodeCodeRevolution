#include <stdlib.h>
#include <stdio.h>
#include "types.h"
#include "board.h"

void new_board(Board board, struct point size){
  board = malloc((sizeof *board) * size.a);
  for(int i = 0; i < size.a; i++)
    board[i] = malloc((sizeof *board) * size.b);
}


void add_instruction_to_board(Board board, int i, int j, struct instruction inst){
  board[i][j] = *inst.op;
}
