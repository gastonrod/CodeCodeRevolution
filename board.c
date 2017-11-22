#include <stdlib.h>
#include <stdio.h>
#include "types.h"
#include "board.h"

void new_board(Board board, struct point size){
  board = malloc((sizeof *board) * size.a);
  for(int i = 0; i < size.a; i++)
    board[i] = malloc((sizeof *board) * size.b);
}


void add_instruction_to_board(Board board, struct instruction inst){
  printf("ESTE PRINTF ESTA PORQUE SINO POR ALGUN MOTIVO SE ROMPE, HAY QUE ARREGLAR\n"/*, (*inst.pos).a-1, (*inst.pos).b-1*/);
  board[(*inst.pos).a-1][(*inst.pos).b-1] = *inst.op;
}
