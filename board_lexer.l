%{
  #include "types.h"
  #include "grammar.tab.h"
  #include "stdbool.h"
int
strsplit (const char *str, char *parts[], const char *delimiter) {
  char *pch;
  int i = 0;
  char *copy = NULL, *tmp = NULL;

  copy = strdup(str);
  if (! copy)
    goto bad;

  pch = strtok(copy, delimiter);

  tmp = strdup(pch);
  if (! tmp)
    goto bad;

  parts[i++] = tmp;

  while (pch) {
    pch = strtok(NULL, delimiter);
    if (NULL == pch) break;

    tmp = strdup(pch);
    if (! tmp)
      goto bad;

    parts[i++] = tmp;
  }

  free(copy);
  return i;

 bad:
  free(copy);
  for (int j = 0; j < i; j++)
    free(parts[j]);
  return -1;
}
extern struct point board_size;
extern struct point pos;
extern struct point double_b;
extern int single_b;
extern int single_n;
extern char type[3];

void set_point(bool is_size){
  char*coor[2];
  strsplit(yytext,coor,",");
  if(is_size){
  board_size.a = atoi(coor[0]);
  board_size.b = atoi(coor[1]);
  }else{
  pos.a = atoi(coor[0]);
  pos.b = atoi(coor[1]);
  }
}

void put_op(char* op){
  type[0] = op[0];
  type[1] = op[1];
  type[2] = op[2];
}

void set_double_b(){
  char*coor[2];
  strsplit(yytext,coor,",");
  double_b.a = atoi(coor[0]+1);
  double_b.b = atoi(coor[1]+1);
}

void set_single_b(){
  single_b = atoi(yytext+1);
}

void set_single_number(){
  single_n = atoi(yytext);
}

void yyerror(char*);
%}
%option noyywrap
%x rule
%x operador
%x tipo
digit [1-9][0-9]*
%%
<operador>"add "                  {
                                   put_op("add");
                                   BEGIN(tipo);
                                   return ADD;
                                  }
<operador>"sub "                  {
                                   put_op("sub");
                                   BEGIN(tipo);
                                   return SUB;
                                  }
<operador>"mul "                  {
                                   put_op("mul");
                                   BEGIN(tipo);
                                   return MUL;
                                  }
<operador>"div "                  {
                                   put_op("div");
                                   BEGIN(tipo);
                                   return DIV;
                                  }
<operador>"ipb\n"                 BEGIN(rule);return IPB;
<operador>"dpb\n"                 BEGIN(rule);return DPB;
<operador>"ipf\n"                 BEGIN(rule);return IPF;
<operador>"dpf\n"                 BEGIN(rule);return DPF;
<operador>"rdc\n"                 BEGIN(rule);return RDC;
<operador>"ptc\n"                 BEGIN(rule);return PTC;
<operador>"ply\n"                 BEGIN(rule);return PLY;
<operador>"ifz\n"                 BEGIN(rule);return IFZ;
<tipo>"b"{digit}",b"{digit}"\n"   {
                                   set_double_b();
                                   BEGIN(rule);
                                   return OPBB;
                                  }
<tipo>"b"{digit}"\n"              {
                                   set_single_b();
                                   BEGIN(rule);
                                   return OPB;
                                  }
<tipo>{digit}"\n"                 {
                                   set_single_number();
                                   BEGIN(rule);
                                   return OPN;
                                  }
<rule>{digit}","{digit}" "        {
                                   set_point(false);
                                   BEGIN(operador);
                                   return POINT;
                                  }
<operador>.|\n                    {
                                   yyerror("fallo de operador"); 
                                   exit(1);
                                  }
<tipo>.|\n                        {
                                   yyerror("fallo de tipo"); 
                                   exit(2);
                                  }
<rule>.|\n                        {
                                    yyerror("fallo de regla");
                                    exit(3);
                                  }
{digit}","{digit}"\n"             {
                                   set_point(true);
                                   BEGIN(rule);
                                   return SIZE;
                                  }
.|\n                              {
                                    yyerror("al principio del archivo");
                                    exit(4);
                                  }

%%

