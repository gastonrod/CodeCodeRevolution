#ifndef CODE_EXECUTOR_H
#define CODE_EXECUTOR_H

#define BUFFER_SIZE 1024

void run_code();
void run(char* actual_code);
void execute(int pos_i, int pos_j, char* actual_code, int *code_pointer);
void extract_numeric_op(int pos_i, int pos_j);
extern void fill_functions();
extern void fill_tags();
#endif
