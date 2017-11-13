#ifndef TYPES_H
#define TYPES_H

typedef enum {
  IPB,
  DPB,
  IPF,
  DPF,
  ADD,
  SUB,
  MUL,
  DIV,
  RDC,
  PTC,
  PLY,
  IFZ
} operations_enum;

typedef enum{
  BB,
  B,
  NUM
} subtype_enum;

struct point{
  unsigned int a;
  unsigned int b;
};

struct op{
  operations_enum op_type;
  subtype_enum    sub_type;
  struct point bb;
  int b;
  int num; 
};

struct instruction{
  struct op operation;
  struct point pos;
};
#endif
