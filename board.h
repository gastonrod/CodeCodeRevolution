#ifndef BOARD_H
#define BOARD_H

#include "types.h"

typedef struct operation** Board;
void add_instruction_to_board(Board board, int i, int j, struct instruction inst);

#endif
