#ifndef UTILITIES_H
#define UTILITIES_H

#include "board.h"

void print_instruction(struct instruction inst);
void print_operation(struct operation op);
void print_board(Board board);
struct instruction* get_instruction(struct point pos, operation_type ot, subtype_enum st, struct point bb, int b, int num);

#endif

