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
extern int tags [BUFFER_SIZE];
struct point op_numbers;
int function_pointer;
int bucket[BUFFER_SIZE] = {0};
int bucket_pointer;
int pos_i;
int pos_j;
int board_length;
int board_width;

void run_code(){
  bucket_pointer = 0;
  function_pointer = 0;
  pos_i = 0;
  pos_j = 0;
  board_length = board_size.b;
  board_width = board_size.a;
  fill_functions();
  fill_tags();
  run(code);
}

void run(char* actual_code) {
  for(int code_pointer = 0; actual_code[code_pointer] != 0; code_pointer++){
    switch(actual_code[code_pointer]){
      case 'R':
          pos_j++;
          break;
      case 'L':
          pos_j--;
          break;
      case 'U':
          pos_i--;
          break;
      case 'D':
          pos_i++;
          break;
      case 'J':
          execute(pos_i,pos_j, actual_code, &code_pointer);
          break;
      }
    if (pos_i< 0 || pos_i >= board_width || pos_j < 0 || pos_j >= board_length){
      fprintf(stderr, "Te fuiste de los limites\n");
      exit(0);
    }
  }
}

void execute(int pos_i, int pos_j, char* actual_code, int *code_pointer){
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
        bucket[bucket_pointer] = getchar();
        break;
    case ptc:
        putchar(bucket[bucket_pointer]);
        break;
    case ply:
        run(function[function_pointer]);
        break;
    case ifz:
        if(actual_code[*code_pointer + 1] != '{') {
          fprintf(stderr, "No se encontro un goto\n");
          exit(0);
        }
        int tag_num = 0;
        int i;
        for(i = 2; actual_code[*code_pointer + i] != '}'; i++){
          tag_num = tag_num * 10 + (actual_code[*code_pointer + i] - '0');
        }
        if (bucket[bucket_pointer] != 0) {
          *code_pointer = tags[tag_num - 1] - 1;
        } else {
          *code_pointer += i;
        }
        break;
    case add:
        extract_numeric_op(pos_i, pos_j);
        bucket[bucket_pointer] = op_numbers.a + op_numbers.b;
        break;
    case sub:
        extract_numeric_op(pos_i, pos_j);
        bucket[bucket_pointer] = op_numbers.a - op_numbers.b;
        break;
    case mul:
        extract_numeric_op(pos_i, pos_j);
        bucket[bucket_pointer] = op_numbers.a * op_numbers.b;
        break;
    case diV:
        extract_numeric_op(pos_i, pos_j);
        bucket[bucket_pointer] = op_numbers.a / op_numbers.b;
        break;
  }
}

void extract_numeric_op(int pos_i, int pos_j){
  switch(board[pos_i][pos_j].subtype){
    case BB:
      op_numbers.a = bucket[board[pos_i][pos_j].bb.a];
      op_numbers.b = bucket[board[pos_i][pos_j].bb.b];
      break;
    case B:
      op_numbers.a = bucket[bucket_pointer];
      op_numbers.b = bucket[board[pos_i][pos_j].b];
      break;
    case NUM:
      op_numbers.a = bucket[bucket_pointer];
      op_numbers.b = board[pos_i][pos_j].num;
      break;
    default:

      break;
  }
}