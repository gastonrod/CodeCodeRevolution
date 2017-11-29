#include <stdlib.h>
#include <stdio.h>
#include "types.h"
#include "board.h"


void add_instruction_to_board(Board board, int i, int j, struct instruction inst){
  board[i][j] = *inst.op;
}
