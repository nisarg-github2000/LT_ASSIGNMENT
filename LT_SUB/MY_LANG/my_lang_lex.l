%{
	int count = 0;
%}

%%
sin|cos|tan|sec|cot|cosec|log|ln|print|sinh|cosh|tanh|coth|sech|cosech     	{printf("%s - is a function\n",yytext);}
([0-9])+"."([0-9])*								{printf("%s- is a floating point number",yytext);}
([0-9])+									{printf("%s - is a simple number\n",yytext);}
[ \t\n]										{printf("%s - is a whitespace\n",yytext);}
inf										{printf("%s - is  infinity\n",yytext);}
neginf										{printf("%s - is negative infinity\n",yytext);}
nan										{printf("%s - is not a number\n",yytext);}
rmod										{printf("%s - is radians mode or degrees\n",yytext);}
bool										{printf("%s - is boolean datatype\n",yytext);}
int										{printf("%s - is integer datatype\n",yytext);}
float										{printf("%s - is float datatype\n",yytext);}
true										{printf("%s - is bool true value\n",yytext);}
false										{printf("%s - is bool false value\n",yytext);}
"_"[a-z][a-zA-Z0-9]*								{printf("%s - is equation name\n",yytext);}
"+"										{printf("%s - is plus mathematical operator\n",yytext);}
"-"										{printf("%s - is minus mathematical operator\n",yytext);}
"/"										{printf("%s - is div mathematical operator\n",yytext);}
"*"										{printf("%s - is mul mathematical operator\n",yytext);}
"%"										{printf("%s - is modulo mathematical operator\n",yytext);}
"^"										{printf("%s - is power mathematical operator\n",yytext);}
">="										{printf("%s - is greater equal operator\n",yytext);}
"<="										{printf("%s - is less equal operator\n",yytext);}
"!="										{printf("%s - is not equal operator\n",yytext);}
">"										{printf("%s - is greater than operator\n",yytext);}
"<"										{printf("%s - is less than operator\n",yytext);}
"==="										{printf("%s - is eqvivalent on simplification operator\n",yytext);}
"=="										{printf("%s - is equals operator\n",yytext);}
"="										{printf("%s - is assignment operator\n",yytext);}
","										{printf("%s - is comma operator\n",yytext);}
"("										{printf("%s - is opening bracket\n",yytext);}
")"										{printf("%s - is closing bracket\n",yytext);}
"["										{printf("%s - is opening square bracket\n",yytext);}
"]"										{printf("%s - is closing square bracket\n",yytext);}
[a-z]([a-z]|[0-9]|[A-Z])*							{printf("%s - is an identifier\n",yytext);} 			
"'"[^\n]*"'"									{printf("%s - is a string\n",yytext);}
.        									{printf("%s - is not a valid input \n",yytextz);}
%%
int yywrap(){}

int main(argc, argv)
int argc;
char **argv;
{	 
	++argv;
	 --argc; 
         if (argc>0)
                     yyin = fopen( argv[0], "r" );
             else
                     yyin = stdin;
         yylex();
         printf("Completed scanning");
             return 0;
}

