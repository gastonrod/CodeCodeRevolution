#ifndef TYPES_H
#define TYPES_H

typedef enum 
{
ipb = 0,
dpb,
ipf,
dpf,
add,
mul,
diV,
sub,
rdc,
ptc,
ply,
ifz
} operation_type;

//typedef yytokentype operation_type;
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
  operation_type  op_type;
  subtype_enum    subtype;
  struct point bb;
  int b;
  int num; 
};

struct instruction{
  struct op* operation;
  struct point* pos;
};
#endif
