%{
  // c code
%}
%option noyywrap
%x codigo
%x comentario
%x funcion
%x funcion_comentario
digit [1-9][0-9]*
code [uldrjULDRJ]
%%
"//"

{code}
