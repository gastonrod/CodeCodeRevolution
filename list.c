#include <stdlib.h> 
#include "list.h"

typedef struct node {
struct instruction * data;
struct node * next;
} Node;

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
  struct op* operation = malloc(sizeof *operation);
  operation->op_type = ot;
  operation->subtype = st;
  operation->bb      = bb;
  operation->b       = b;
  operation->num     = num;
  struct instruction* inst = malloc(sizeof *inst);
  inst->operation = operation;
  inst->pos       = &pos;
  return inst;
}
