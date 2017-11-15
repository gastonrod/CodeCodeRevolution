#ifndef LIST_H
#define LIST_H

#include "types.h"
typedef struct listCDT * ListADT;
typedef struct iteratorCDT * ListIteratorADT;


ListADT new_list();

void add_to_list(ListADT l, struct instruction* data);

struct instruction* get_instruction(struct point pos, operation_type ot, subtype_enum st, struct point bb, int b, int num);

ListIteratorADT get_iterator(ListADT l);

int iter_has_next(ListIteratorADT iter);

struct instruction * iter_get_next(ListIteratorADT iter);

void destroy_iterator(ListIteratorADT iter);


#endif
