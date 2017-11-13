#include <stdlib.h> 
#include "types.h"

struct listCDT{
  Node * first;   // Para iterar y borrar
  Node * last;    // Para insercion O(1)
  size_t length;  // Tamaño O(1)
};
typedef struct node {
struct instruction * data;
struct node * next;
} Node;
ListADT new_list(){
  ListADT l = malloc(sizeof *l);
  l->first = NULL;
  l->last = NULL;
  l->length = 0;  // Empieza vacía
  return l;
}

void add_to_list(ListADT l, void* data){
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

