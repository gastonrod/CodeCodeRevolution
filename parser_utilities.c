#include <stdio.h>
#include "types.h"
extern char* operation_type_string[];
extern char* subtype_string[];
struct point board_size;
struct point pos;
struct point double_b;
int single_b;
int single_n;
char type[3];
void quick_add(operation_type ot, subtype_enum st);
void quick_add_comp(subtype_enum st);


void print_add_instruction(operation_type ot, subtype_enum st, struct point pos){
  printf("  double_b.a = %d;\n"
         "  double_b.b = %d;\n"
	 "  single_b   = %d;\n"
	 "  single_n   = %d;\n"
	 "  pos.a      = %d;\n"
	 "  pos.b      = %d;\n"
	 "  quick_add(%s, %s);\n", double_b.a, double_b.b, single_b, single_n, pos.a, pos.b, operation_type_string[ot], subtype_string[st]);
}

void print_add_composite_instruction(subtype_enum st, struct point pos){
  if     (type[0] == 'a')
    print_add_instruction(add, st, pos);
  else if(type[0] == 's')
    print_add_instruction(sub, st, pos);
  else if(type[0] == 'm')
    print_add_instruction(mul, st, pos);
  else if(type[0] == 'd')
    print_add_instruction(diV, st, pos);
}

void print_includes(){
  printf("#include <stdio.h>\n"
	 "#include <stdlib.h>\n"
	 "#include \"types.h\"\n"
	 "#include \"board.h\"\n"
         "#include \"list.h\"\n"
	 "#include \"utilities.h\"\n"
	 "\n\n"
	 "#define BUFFER_SIZE 1024\n"
	 "\n\n"
	 "void hacer_adds();\n"
	 "void set_size();\n"
         "void yylex();\n"
	 "\n\n"
	 "ListADT list;\n"
         "extern char* operation_type_string[];\n"
         "extern char* subtype_string[];\n"
	 "extern char* code;\n"
         "struct point board_size;\n"
         "struct point pos;\n"
         "struct point double_b;\n"
         "int single_b;\n"
         "int single_n;\n"
         "char type[3];\n"
	 "\n\n"
);
}

void print_main(){
  char porcentaje_s[3] = "%s\0";
  printf("int main(){\n"
         "  list = new_list();\n"
         "  hacer_adds();\n"
	 "  set_size();\n"
	 "  ListIteratorADT iterator = get_iterator(list);\n"
	 "  struct instruction inst;\n"
	 "  Board board;\n"
	 "  // Esto deberia ser new_board, pero no lo se hacer andar\n"
	 "  // new_board(board);\n"
	 "  board = malloc((sizeof *board) * board_size.a);\n"
	 "  for(int i = 0; i < board_size.a; i++)\n"
	 "    board[i] = malloc((sizeof *board) * board_size.b);\n"
	 "  while(iter_has_next(iterator)){\n"
	 "    struct instruction inst = *iter_get_next(iterator);\n"
	 "    //print_instruction(inst);\n"
	 "    add_instruction_to_board(board, inst);\n"
	 "  }\n"
	 "  print_board(board);\n"
	 "  printf(\"tablero armado, a partir de aca es lectura de lrjs y to2 eso\\n\");\n"
	 "  code = malloc(BUFFER_SIZE);\n"
	 "  yylex();\n"
	 "  printf(\"%s\\n\",code);\n"
	 "  printf(\"Codigo recibido, aca hay que armar la maquina de estados y eso\\n\");\n"
         "}\n\n"
	 
	 "void hacer_adds(){\n", porcentaje_s);

}

void print_set_size(){
  printf("}\n"
         "\n\n"
         "void set_size(){\n"
	 "  board_size.a = %d;\n"
	 "  board_size.b = %d;\n"
	 "}\n", board_size.a, board_size.b);
}
