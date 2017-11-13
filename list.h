#ifndef LIST_H
#define LIST_H

#include "types.h"
typedef struct listCDT * ListADT;
ListADT new_list();
void add_to_list(ListADT l, struct instruction* data);
struct instruction* get_instruction(struct point pos, operation_type ot, subtype_enum st, struct point bb, int b, int num);
#endif
