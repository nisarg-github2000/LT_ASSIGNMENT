%{
    #include"y.tab.h"
	int count = 0;
%}

%%


log                                         {return LOG;}
ln                                          {return LN;}
print                                       {return PRINT;}
sinh                                        {return SINH;}
cosh                                        {return COSH;}
tanh                                        {return TANH;}
coth                                        {return COTH;}
sech                                        {return SECH;}
cosech     			                        {return COSECH;}
cosec                                       {return COSEC;}
sin                                         {return SIN;}
cos                                         {return COS;}
tan                                         {return TAN;}
sec                                         {return SEC;}
cot                                         {return COT;}
([0-9])+"."([0-9])*							{yylval.p=atof(yytext); return num; }
([0-9])*                                    {yylval.p=atoi(yytext); return num; }
inf										    {return infinite;}
neginf									    {return neginfinite;}
rmod										{return rmod;}
bool										{printf("%s - is boolean datatype\n",yytext);}
int										    {printf("%s - is integer datatype\n",yytext);}
float										{printf("%s - is float datatype\n",yytext);}
pi  										{return pi;}
"("                                         {return yytext[0];}
")"                                         {return yytext[0];}
"+"                                         {return yytext[0];}
"-"                                         {return yytext[0];}
"*"                                         {return yytext[0];}
"/"                                         {return yytext[0];}
"%"                                         {return yytext[0];}
"^"                                         {return yytext[0];}
"["                                         {return yytext[0];}
"]"                                         {return yytext[0];}
"<"                                         {return yytext[0];}
"<="                                        {return LE;}
">"                                         {return yytext[0];}
">="                                        {return GE;}
"!="                                        {return NE;}
"==="                                       {return TE;}
"=="                                        {return EE;}
"="                                         {return yytext[0];}
[a-z]                                       {yylval.p=(*yytext-'a'); return VAR; }

[ \t\n]										{;}
"#"                                         {return yytext[0];}
"@"                                         {return 0;}
.        									{printf("%s - is not a valid input \n",yytext);}
%%
int yywrap(){}

