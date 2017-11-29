#ifndef LIST_H
#define LIST_H

#include "types.h"
typedef struct listCDT * ListADT;
typedef struct iteratorCDT * ListIteratorADT;


ListADT new_list();

void add_to_list(ListADT l, struct instruction* data);

ListIteratorADT get_iterator(ListADT l);

int iter_has_next(ListIteratorADT iter);

struct instruction * iter_get_next(ListIteratorADT iter);

void destroy_iterator(ListIteratorADT iter);

void quick_add(operation_type ot, subtype_enum st);

void quick_add_comp(subtype_enum st);

#endif
