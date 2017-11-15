#ifndef UTILITIES_H
#define UTILITIES_H

#include "board.h"

void print_instruction(struct instruction inst);
void print_operation(struct operation op);
void quick_add(operation_type ot, subtype_enum st);
void quick_add_comp(subtype_enum st);
void print_board(Board board);
#endif

