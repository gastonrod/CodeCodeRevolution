#ifndef BOARD_H
#define BOARD_H

typedef struct operation** Board;
void new_board(Board board, struct point size);
void add_instruction_to_board(Board board, int i, int j, struct instruction inst);

#endif
