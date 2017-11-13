#ifndef LIST_H
#define LIST_H


typedef struct listCDT * ListADT;
ListADT new_list(int(*cmp_fn)(void*, void*), void(*destroy_fn)(void*));
void add_to_list(ListADT l, void* data);
#endif
