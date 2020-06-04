%{
    #include<stdio.h>
    #include<math.h> 
    #include<stdbool.h>
    #include<limits.h>
    bool TRUE=true;
    bool FALSE=false;
    int MODE=0;
    int sym[26];
    double ND=LONG_MIN+1;
    double INF=LONG_MAX;
    double NEGINF=LONG_MIN;
    double PI=M_PI;

    double check[9]={0, M_PI, 3*M_PI_2, M_PI_2, 1, 2, 4, 5, -1};
    bool flag=1;
%}

%union
{double p;}

%token<p>num
%token SIN COS TAN COT SEC COSEC LOG LN PRINT SINH COSH TANH COTH SECH COSECH LE NE EE GE TE
%token infinite neginfinite rmod pi 
%token<p>VAR
%left '+' '-'
%left '*' '/' '%'
%left '^'
%right '='
%type<p>exp
%%
stmt:line stmd
    ;
stmd:line stmd
    |'#'
    ;

line:PRINT'('exp')'{ 
                    if($3==INF)
                        printf("Infinite\n");
                    else if($3==NEGINF)
                        printf("Negative Infinite\n");
                    else
                        printf("%g\n",$3);
                    }
    |rmod{
            if(MODE==0)
            {
                MODE=1;
            }
            else
            {
                MODE=0;
            }
        }
    |VAR'='exp{sym[(int)$1]=$3;}
    |exp'<'exp{
                if($1<$3)
                    printf("True\n");
                else
                    printf("False\n");
                }
    |exp'>'exp{
                if($1>$3)
                    printf("True\n");
                else
                    printf("False\n");
                }
    |exp GE exp{
                if($1>=$3)
                    printf("True\n");
                else
                    printf("False\n");
                }
    |exp LE exp{
                if($1<=$3)
                    printf("True\n");
                else
                    printf("False\n");
                }
    |exp EE exp{
                if($1==$3)
                    printf("True\n");
                else
                    printf("False\n");
                }
    |exp TE exp{ 
                flag=0;
                int i;
                if($1==$3)
                    printf("Equivalent \n");
                else
                    printf("Not Equivalent\n");
    
                }

    ;

exp :num
    |VAR      {
                if(flag)
                    $$=sym[(int)$1];
                else
                {
                    $$=ND;
                }
                
                }
    |'['exp']'{
                if(flag)
                    $$=$2;
                else
                    $$=ND;
                }
    |'('exp')'{
                if(flag)
                    $$=$2;
                else
                    $$=ND;
                }
    |exp'+'exp{
                if(flag)
                    $$=$1+$3;
                else
                {
                    int i;
                    $$=0;
                    if($1!=ND)
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=$1+check[i];
                            $$+=check[i];
                        }
                    }
                    else if($3!=ND)
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=check[i]+$3;
                            $$+=check[i];
                        }
                    }
                    else
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=check[i]+check[i];
                            $$+=check[i];
                        }
                    }
                }
                }
    |exp'-'exp{
                
                if(flag)
                    $$=$1-$3;
                else
                {
                    int i;
                    $$=0;
                    if($1!=ND)
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=$1-check[i];
                            $$+=check[i];
                        }
                    }
                    else if($3!=ND)
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=check[i]-$3;
                            $$+=check[i];
                        }
                    }
                    else
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=0;
                        }
                    }
                }

                }
    |exp'*'exp{
                if(flag)
                    $$=$1*$3;
                else
                {
                    int i;
                    $$=0;
                    if($1!=ND)
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=$1*check[i];
                            $$+=check[i];
                        }
                    }
                    else if($3!=ND)
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=check[i]*$3;
                            $$+=check[i];
                        }
                    }
                    else
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=check[i]*check[i];
                            $$+=check[i];
                        }
                    }
                }
                }
    |exp'^'exp{
                if(flag)
                    $$=pow($1,$3);
                else
                {
                    int i;
                    $$=0;
                    if($1!=ND)
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=pow($1,check[i]);
                            $$+=check[i];
                        }
                    }
                    else if($3!=ND)
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=pow(check[i],$3);
                            $$+=check[i];
                        }
                    }
                    else
                    {
                        for(i=0;i<9;i++)
                        {
                            check[i]=pow(check[i],check[i]);
                            $$+=check[i];
                        }
                    }
                }
                }
    |exp'/'exp{
                if(flag)
                {
                    if($3==0)
                        $$=INF;
                    else
                        $$=$1/$3;
                }
                else
                {
                    int i;
                    $$=0;
                    if($1!=ND)
                    {
                        for(i=1;i<9;i++)
                        {
                            check[i]=$1/check[i];
                            $$+=check[i];
                        }
                        check[0]=INF;
                    }
                    else if($3!=ND)
                    {
                        if($3==0)
                        {
                            for(i=0;i<9;i++)
                            {
                                check[i]=INF;
                            }
                            $$=INF;
                        }
                        else
                        {
                            for(i=0;i<9;i++)
                            {
                                check[i]=check[i]/$3;
                                $$+=check[i];
                            }
                        }
                    }
                    else
                    {
                        for(i=1;i<9;i++)
                        {
                            check[i]=1;
                            $$+=check[i];
                        }
                        check[0]=ND;
                    }
                }
                }


    |'-'exp{
                if(flag)
                    $$=-$2;
                else
                {
                    int i;
                    $$=0;
                    for(i=0;i<9;i++)
                    {
                        check[i]=-check[i];
                        $$+=check[i];
                    }
            }

            }
    |SIN'('exp')'{
                    if(flag)
                    {
                        if(MODE==0)
                            $$=sin($3);
                        else
                            $$=sin($3*PI/180);
                    }
                    else
                    {
                        int i;
                        $$=0;
                        for(i=0;i<9;i++)
                        {
                            check[i]=sin(check[i]);
                            $$+=check[i];
                        }
                    }
                    
                }
    |COS'('exp')'{
                    if(flag)
                    {
                        if(MODE==0)
                            $$=sin($3);
                        else
                            $$=sin($3*PI/180);
                    }
                    else
                    {
                        int i;
                        $$=0;
                        for(i=0;i<9;i++)
                        {
                            check[i]=sin(check[i]);
                            $$+=check[i];
                        }
                    }
                    
                }
    |TAN'('exp')'{
                    if(MODE==0)
                    {
                        if(cos($3)==0)
                            $$=INF;
                        else 
                            $$=tan($3);
                    }
                        
                    else
                    {
                        if(cos($3*PI/180)==0)
                            $$=INF;
                        else
                            $$=tan($3*PI/180);
                    }
                        
                }

    |COT'('exp')'{
                    if(MODE==0)
                    {
                        if(sin($3)==0)
                            $$=INF;
                        else 
                            $$=1/(tan($3));
                    }
                        
                    else
                    {
                        if(sin($3*PI/180)==0)
                            $$=INF;
                        else
                            $$=1/(tan($3*PI/180));
                    }
                        
                }
    |SEC'('exp')'{
                    if(MODE==0)
                    {
                        if(cos($3)==0)
                            $$=INF;
                        else 
                            $$=1/(cos($3));
                    }
                        
                    else
                    {
                        if(cos($3*PI/180)==0)
                            $$=INF;
                        else
                            $$=tan($3*PI/180);
                    }
                        
                }
    |COSEC'('exp')'{
                    if(MODE==0)
                    {
                        if(sin($3)==0)
                            $$=INF;
                        else 
                            $$=1/(sin($3));
                    }
                        
                    else
                    {
                        if(sin($3*PI/180)==0)
                            $$=INF;
                        else
                            $$=1/(sin($3*PI/180));
                    }
                        
                }
    |SINH'('exp')'{
                    if(MODE==0)
                        $$=sinh($3);
                    else
                        $$=sinh($3*PI/180);
                }
    |COSH'('exp')'{
                    if(MODE==0)
                        $$=cosh($3);
                    else
                        $$=cosh($3*PI/180);
                }
    |TANH'('exp')'{
                    if(MODE==0)
                    {
                        if(cosh($3)==0)
                            $$=INF;
                        else 
                            $$=tanh($3);
                    }
                        
                    else
                    {
                        if(cosh($3*PI/180)==0)
                            $$=INF;
                        else
                            $$=tanh($3*PI/180);
                    }
                        
                }
    |COTH'('exp')'{
                    if(MODE==0)
                    {
                        if(sinh($3)==0)
                            $$=INF;
                        else 
                            $$=1/(tanh($3));
                    }
                        
                    else
                    {
                        if(sinh($3*PI/180)==0)
                            $$=INF;
                        else
                            $$=1/(tanh($3*PI/180));
                    }
                        
                }
    |SECH'('exp')'{
                    if(MODE==0)
                    {
                        if(cosh($3)==0)
                            $$=INF;
                        else 
                            $$=1/(cosh($3));
                    }
                        
                    else
                    {
                        if(cosh($3*PI/180)==0)
                            $$=INF;
                        else
                            $$=1/(cosh($3*PI/180));
                    }
                        
                }
    |COSECH'('exp')'{
                    if(MODE==0)
                    {
                        if(sinh($3)==0)
                            $$=INF;
                        else 
                            $$=1/(sinh($3));
                    }
                        
                    else
                    {
                        if(sinh($3*PI/180)==0)
                            $$=INF;
                        else
                            $$=1/(sinh($3*PI/180));
                    }
                        
                }
    |neginfinite{$$=NEGINF;}
    |infinite{$$=INF;}
    |pi{$$=PI;}
    ;

%%


main()
{
    printf("Enter:");
    yyparse();
    return 0;
}
 void yyerror(char * s)
 {
    printf("Error - %s\n",s);
 }
 