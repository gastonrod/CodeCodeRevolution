#include <stdlib.h> 
#include <stdio.h>
#include "list.h"
#include "utilities.h"
extern ListADT list;
extern struct point board_size;
extern struct point pos;
extern struct point double_b;
extern int single_b;
extern int single_n;
extern char type[3];

typedef struct node {
struct instruction * data;
struct node * next;
} Node;
struct iteratorCDT {
//Iterador. ptr apunta al siguiente nodo cuyo valor debe ser retornado 
  Node * ptr;
};


typedef struct listCDT{
  Node * first;   // Para iterar y borrar
  Node * last;    // Para insercion O(1)
  size_t length;  // Tamaño O(1)
}listCDT;

ListADT new_list(){
  ListADT l = malloc(sizeof *l);
  l->first = NULL;
  l->last = NULL;
  l->length = 0;  // Empieza vacía
  return l;
}

void add_to_list(ListADT l, struct instruction* data){
  if(l->first == NULL){
    l->first = malloc(sizeof *l->first);
    l->last = l->first;
  } else {
  l->last->next = malloc(sizeof *l->last->next);
  l->last = l->last->next;
  }
  l->last->data = data;
  l->last->next = NULL;
  l->length++;
}


ListIteratorADT get_iterator(ListADT l){
  ListIteratorADT iter = malloc(sizeof *iter);
  if(iter == NULL){
    return NULL;
  }
  iter->ptr = l->first;
  return iter;
}


int iter_has_next(ListIteratorADT iter)
{
  return iter->ptr != NULL;
}


struct instruction * iter_get_next(ListIteratorADT iter){
  if(!iter_has_next(iter)){
    printf("La cagaste perri\n");
    exit(13);
  }
  struct instruction* r = iter->ptr->data;
  iter->ptr = iter->ptr->next;    // Avanzo en la lista
  return r;
}


void destroy_iterator(ListIteratorADT iter){
  free(iter);
}


void quick_add(operation_type ot, subtype_enum st){
  add_to_list(list,get_instruction(pos, ot, st, double_b, single_b, single_n));
  switch(st){
    case BB:
      double_b.a = 0;
      double_b.b = 0;
      break;
    case B:
      single_b   = 0;
      break;
    case NUM:
      single_n   = 0;
      break;
    default:
      break;
  }
}
void quick_add_comp(subtype_enum st){
  if     (type[0] == 'a')
    quick_add(add, st);
  else if(type[0] == 's')
    quick_add(sub, st);
  else if(type[0] == 'm')
    quick_add(mul, st);
  else if(type[0] == 'd')
    quick_add(diV, st);
}

