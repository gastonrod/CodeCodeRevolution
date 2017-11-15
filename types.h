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
diV,  // Con V mayuscula xq bison define una func div y jode
sub,
rdc,
ptc,
ply,
ifz
} operation_type;
//char* operation_type_string[] = {"ipb","pb","ipf","dpf","add","mul","diV","sub","rdc","ptc","ply","ifz"};
//typedef yytokentype operation_type;
typedef enum{
  none = 0,
  BB,
  B,
  NUM
} subtype_enum;

//char* subtype_string[] = {"none", "BB" , "B", "NUM"};
struct point{
  unsigned int a;
  unsigned int b;
};

struct operation{
  operation_type  op_type;
  subtype_enum    subtype;
  struct point bb;
  int b;
  int num; 
};

struct instruction{
  struct operation* op;
  struct point* pos;
};
#endif
