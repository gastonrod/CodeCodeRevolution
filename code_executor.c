#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "code_executor.h"
#include "types.h"
#include "board.h"

extern Board board;
extern char* code;
extern char* function[BUFFER_SIZE];
extern struct point board_size;
int function_pointer;
int bucket[BUFFER_SIZE] = {0};
int bucket_pointer;

void run_code(){
  bucket_pointer = 0;
  function_pointer = 0;
  int pos_i = 0;
  int pos_j = 0;
  int code_pointer = 0; // Nombre mdio choto, no le queria poner i
  int len = strlen(code);
  int board_length = board_size.b;
  int board_width = board_size.a;
  while(code_pointer < len){
    switch(code[code_pointer]){
      case 'R':
          pos_j++;
          break;
      case 'L':
          pos_j--;
          break;
      case 'U':
          pos_i++;
          break;
      case 'D':
          pos_i--;
          break;
      case 'J':
          execute(pos_i,pos_j);
          break;
      }
    if (pos_i< 0 || pos_i >= board_length || pos_j < 0 || pos_j >= board_width){
      fprintf(stderr, "La cagaste perro, te fuiste de los limites\n");
      exit(0);
    }

    code_pointer++;
  }
}

void execute(int pos_i, int pos_j){
  switch(board[pos_i][pos_j].op_type){
    case ipb:
        bucket_pointer++; 
        break;
    case dpb:
        bucket_pointer--;
        break;
    case ipf:
        function_pointer++;
        break;
    case dpf:
        function_pointer--;
        break;
    case rdc:
        //readchar
        break;
    case ptc:
        //putchar
        break;
    case ply:
        //execute current function
        break;
    case ifz:
        //ifz jump to tag
        break;
    case add:
        //add
        break;
    case sub:
        //sub
        break;
    case mul:
        //mul
        break;
    case diV:
        //div
        break;
  }
}








