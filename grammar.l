%{
  #include "types.h"
  #include "grammar.tab.h"
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

void set_point(){
  char*coor[2];
  strsplit(yytext,coor,",");
  yylval.pos.a = atoi(coor[0]);
  yylval.pos.b=atoi(coor[1]);
}

void put_op(char* op){
  yylval.type[0] = op[0];
  yylval.type[1] = op[1];
  yylval.type[2] = op[2];
}

void double_b(){
  char*coor[2];
  strsplit(yytext,coor,",");
  yylval.double_b.a = atoi(coor[0]+1);
  yylval.double_b.b = atoi(coor[1]+1);
}

void single_b(){
  yylval.single_b = atoi(yytext+1);
}

void single_number(){
  yylval.single_n = atoi(yytext);
}
%}
%option noyywrap
%x rule
%x operador
%x tipo
digit [1-9][0-9]*
%%
\n                                ;
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
<operador>"ipb"                   BEGIN(rule);return IPB;
<operador>"dpb"                   BEGIN(rule);return DPB;
<operador>"ipf"                   BEGIN(rule);return IPF;
<operador>"dpf"                   BEGIN(rule);return DPF;
<operador>"rdc"                   BEGIN(rule);return RDC;
<operador>"ptc"                   BEGIN(rule);return PTC;
<operador>"ply"                   BEGIN(rule);return PLY;
<operador>"ifz"                   BEGIN(rule);return IFZ;
<tipo>"b"{digit}",b"{digit}       {
                                   printf("bb\n");
                                   BEGIN(rule);
                                   return OPBB;
                                  }
<tipo>"b"{digit}                  {
                                   printf("b\n");
                                   BEGIN(rule);
                                   return OPB;
                                   }
<tipo>{digit}                     {
                                   printf("num!\n");
                                   BEGIN(rule);
                                   return OPN;
                                  }
<rule>{digit}","{digit}" "        {
                                   set_point();
                                   BEGIN(operador);
                                   return POINT;
                                  }
{digit}","{digit}                 {
                                   set_point();
                                   BEGIN(rule);
                                   return SIZE;
                                  }
%%

