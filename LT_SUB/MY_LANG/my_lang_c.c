#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
int main(int argc, char **argv)
{
    //++argv, --argc;
    argc=1;
    argv[0]="f.c";
    if(argc>0)
	{
	    FILE *filePointer ;
        char input[1000];
        filePointer = fopen(argv[0], "r") ;
        if ( filePointer == NULL )
        {
            printf( "file error\n" ) ;
        }
        else
        {
            while( fgets ( input, 1000, filePointer ) != NULL )
            {
                scan(input);
            }

             fclose(filePointer) ;
        }
	}
	else
    {
        printf("Give file name as command line input\n");
    }
	return 0;
}
void scan(char a[])
{
    int l=strlen(a);
    int i=0,isFloat=0;
    char ch=a[i];
    printf("%s ---",a);
    while(i<l)
    {
        char token[1000]="";
        int j=0;
        token[j]=ch;
        if(isdigit(ch))
        {
            isFloat=0;
            while(i<l)
            {
                i++;
                ch=a[i];
                if(isdigit(ch))
                {
                    j++;
                    token[j]=ch;
                }
                else if(ch=='.')
                {
                    isFloat=1;
                    j++;
                    token[j]=ch;
                }
                else
                {
                    i--;
                    break;
                }

            }
            j++;
            token[j]='\0';
            if(isFloat==1)
                printf("%s - This is float number\n",token);
            else
                printf("%s - This is integer\n",token);
        }
        else if(isalpha(ch))
        {
            while(i<l)
            {
                i++;
                ch=a[i];
                if(isalpha(ch))
                {
                    j++;
                    token[j]=ch;
                }
                else if(ch=='(')
                {
                    j++;
                    token[j]='\0';
                    i--;
                    if(!strcmp(token,"sin"))
                    {
                        printf("%s is sin function\n",token);
                        break;
                    }
                    else if(!strcmp(token,"cos"))
                    {
                        printf("%s is cos function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"tan"))
                    {
                        printf("%s is tan  function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"cot"))
                    {
                        printf("%s is cot function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"sec"))
                    {
                        printf("%s is sec function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"cosec"))
                    {
                        printf("%s is cosec function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"sinh"))
                    {
                        printf("%s is sinh function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"cosh"))
                    {
                        printf("%s is cosh function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"tanh"))
                    {
                        printf("%s is tanh function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"coth"))
                    {
                        printf("%s is coth function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"sech"))
                    {
                        printf("%s is sech function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"cosech"))
                    {
                        printf("%s is cosech function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"log"))
                    {
                        printf("%s is log function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"ln"))
                    {
                        printf("%s is ln function\n",token);
                         break;
                    }
                    else if(!strcmp(token,"print"))
                    {
                        printf("%s is print function\n",token);
                         break;
                    }
                    else
                    {
                        printf("%s is invalid token\n",token);
                         break;
                    }
                }
                else
                {
                    i--;
                    j++;
                    token[j]='\0';
                    if(!strcmp(token,"int"))
                    {
                        printf("%s is int datatype\n",token);
                    }
                    else if(!strcmp(token,"float"))
                    {
                        printf("%s is float datatype\n",token);
                    }
                    else if(!strcmp(token,"rmod"))
                    {
                        printf("%s is rmod\n",token);
                    }
                    else if(!strcmp(token,"bool"))
                    {
                        printf("%s is bool datatype\n",token);
                    }
                    else if(!strcmp(token,"true"))
                    {
                        printf("%s is true value\n",token);
                    }
                    else if(!strcmp(token,"inf"))
                    {
                        printf("%s is infinity\n",token);
                    }
                    else if(!strcmp(token,"neginf"))
                    {
                        printf("%s is negative infinity\n",token);
                    }
                    else if(!strcmp(token,"nan"))
                    {
                        printf("%s is Not a Number\n",token);
                    }
                    else
                    {
                        printf("%s - This is a variable\n",token);
                    }
                    break;
                }
            }

        }
        else if(isspace(ch))
        {

        }
        else if(ch=='_')
        {
            while(i<l)
            {
                i++;
                ch=a[i];
                if(isalpha(ch))
                {
                    j++;
                    token[j]=ch;
                }
                else
                {
                    i--;
                    break;
                }
            }
            j++;
            token[j]='\0';
            printf("%s is equation name\n",token);
        }
        else if(ch=='=')
        {

            if(a[i+1]=='=')
            {
                j++;
                token[j]='=';
                if(a[i+2]=='=')
                {
                    j++;
                    token[j]='=';
                    i+=2;
                    j++;
                    token[j]='\0';
                    printf("%s is eqv operator\n",token);
                }
                else
                {
                    i+=1;
                    j++;
                    token[j]='\0';
                    printf("%s is eql operator\n",token);
                }
            }
            else
            {
                printf("%c is assign operator\n",token[0]);
            }
        }
        else if(ch=='+')
        {
            printf("%c is plus operator\n",token[0]);
        }
        else if(ch=='-')
        {
            printf("%c is minus operator\n",token[0]);
        }
        else if(ch=='!')
        {
            if(a[i+1]=='=')
            {
                i+=1;
                j++;
                token[j]='=';
                j++;
                token[j]='\0';
                printf("%s is ne operator\n",token);
            }
            else
            {
                j++;
                token[j]='\0';
                printf("%s is invalid token\n",token);
            }
        }
        else if(ch=='*')
        {
            printf("%c is mul operator\n",token[0]);
        }
        else if(ch=='/')
        {
            printf("%c is div operator\n",token[0]);
        }
        else if(ch=='%')
        {
            printf("%c is mod operator\n",token[0]);
        }
        else if(ch=='<')
        {
            if(a[i+1]=='=')
            {
                i++;
                j++;
                token[j]='=';
                j++;
                token[j]='\0';
                printf("%s is le operator\n",token);
            }
            else
            {
                printf("%c is lt operator\n",token[0]);
            }
        }
        else if(ch=='>')
        {
            if(a[i+1]=='=')
            {
                i++;
                j++;
                token[j]='=';
                printf("%c is ge operator\n",token[0]);
            }
            else
            {
                printf("%c is gt operator\n",token[0]);
            }
        }
        else if(ch=='('||ch==')')
        {
             printf("%c is bracket\n",token[0]);
        }
        else if(ch=='['||ch==']')
        {
            printf("%c is square bracket\n",token[0]);
        }
        else if(ch=='^')
        {
            printf("%c is pow operator\n",token[0]);
        }
        else if(ch=='"')
        {
            printf("%c is string operator\n",token[0]);
        }
        else
        {
            printf("%c is invalid\n",ch);
        }
        i++;
        ch=a[i];
    }
}


