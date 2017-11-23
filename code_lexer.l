%{
  // c code
  #include <string.h>
  #include <ctype.h>
  #define BUFFER_SIZE 1024
  char* code;
  int size = 0;

  void concat(){
    //printf("%s", yytext);
    int len = strlen(yytext);
    for(int i = 0; i < len; i++, size++){
      if(size % BUFFER_SIZE == 0)
        code = realloc(code, (size + BUFFER_SIZE) * sizeof code[0]);
      code[size] = toupper(yytext[i]);
    }
  }
%}
%option noyywrap
%x codigo
%x comentario
%x funcion
%x funcion_comentario
digit [1-9][0-9]*
code [uldrjULDRJ]
%%

<comentario>. ;
<comentario>"\n"  {BEGIN(codigo);}
<codigo>{code} concat();
<codigo>"\n"   ;
<codigo>"\t"   ;
<codigo>" "    ;
<codigo>"{"{digit}"}" concat();
<codigo>"{goto"{digit}"}"  concat();
<codigo>"//" BEGIN(comentario);
<codigo>"["{digit}"]:"  concat();
"//"          BEGIN(comentario);
{code}        BEGIN(codigo);concat();

%%
/*
int main(void) { 
  size = 0;
  code = malloc(BUFFER_SIZE);
  yylex(); 
  printf("%s\n", code);
  return 0; 
}
*/
