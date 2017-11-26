%{
  // c code
  #include <string.h>
  #include <ctype.h>
  #define BUFFER_SIZE 1024
  char* code;
  int size = 0;
  int tags [BUFFER_SIZE];
  char* function[BUFFER_SIZE];
  int current_function;

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

void concat_code(){
  int len = strlen(yytext);
  for(int i = 0; i < len; i++, size++){
    if(size % BUFFER_SIZE == 0)
      code = realloc(code, (size + BUFFER_SIZE) * sizeof code[0]);
    code[size] = toupper(yytext[i]);
  }
}

void concat_function(){
  int len = strlen(yytext);
  for(int i = 0; i < len; i++, size++){
    if(size % BUFFER_SIZE == 0)
      function[current_function]= realloc(function[current_function], (size + BUFFER_SIZE) * sizeof function[current_function][0]);
    
    function[current_function][size] = toupper(yytext[i]);
  }


}
void add_tag(){
  char*num[2];
  strsplit(yytext,num,"}");
  tags[atoi(num[0]+1)-1]= size;
}

void add_goto(){
  int len = strlen(yytext);
  char*num[2];
  strsplit(yytext,num,"}");
  if(size % BUFFER_SIZE == 0)
    code = realloc(code, (size + BUFFER_SIZE) * sizeof code[0]);
  code[size++]='{';
  for(int i = 1; i < len; i++, size++){
    if(size % BUFFER_SIZE == 0)
      code = realloc(code, (size + BUFFER_SIZE) * sizeof code[0]);
    code[size] = yytext[i+4];
  }
}
void begin_function(){
  char*num[2];
  strsplit(yytext,num,"]");
  current_function = atoi(yytext+1)-1;
  size = 0;
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

<comentario>.               ;
<comentario>"\n"            BEGIN(codigo);
<codigo>{code}              concat_code();
<codigo>"\n"                ;
<codigo>"\t"                ;
<codigo>" "                 ;
<codigo>"{"{digit}"}"       add_tag();
<codigo>"{goto"{digit}"}"   add_goto();
<codigo>"//"                BEGIN(comentario);
<codigo>"["{digit}"]:"      begin_function();BEGIN(funcion);
<funcion>{code}             concat_function();
<funcion>"\n"               ;
<funcion>"\t"               ;
<funcion>" "                ;
<funcion>"["{digit}"]:"     begin_function();
<funcion>"//"               BEGIN(funcion_comentario);
<funcion_comentario>.       ;
<funcion_comentario>"\n"    BEGIN(funcion);
"//"                        BEGIN(comentario);
{code}                      BEGIN(codigo);concat_code();
"\n"                        ;
"\t"                        ;
" "                         ;
"{"{digit}"}"               add_tag();BEGIN(codigo);
%%

int main(void) { 
  current_function = -1;
  size = 0;
  code = malloc(BUFFER_SIZE);
  yylex(); 
  
  printf("#define BUFFER_SIZE 1024\n");
  printf("char* code= \"%s\";\n", code);
  printf("char* function[BUFFER_SIZE];\n", code);
  for(int i = 0; i < BUFFER_SIZE; i++){
  if(function[i] != NULL)
    printf("function[%d]: \"%s\";\n",i, function[i]);
  }

  return 0; 
}

