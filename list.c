#include <stdlib.h> 
#include <stdio.h>
#include "list.h"

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

struct instruction* get_instruction(struct point pos, operation_type ot, subtype_enum st, struct point bb, int b, int num){
  struct operation* op = malloc(sizeof *op);
  op->op_type = ot;
  op->subtype = st;
  op->bb      = bb;
  op->b       = b;
  op->num     = num;
  struct point* position = malloc(sizeof *position);
  position->a = pos.a;
  position->b = pos.b;
  struct instruction* inst = malloc(sizeof *inst);
  inst->op = op;
  inst->pos= position;
  return inst;
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

