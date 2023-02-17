// import section
import java_cup.runtime.*;

%%
// declaration section
%class MPLexer
%function next_token
%line
%column
%debug
%eofval{
return new Symbol(sym.EOF);
%eofval}

%{
   public int getLine()
   {
      return yyline;
   }
%}

//states
%state COMMENT
//macros
slovo = [a-zA-Z]
cifra = [0-9]
oc16 = [0-9A-F]
%%

// rules section
\/\/ { yybegin( COMMENT ); }
<COMMENT>~\n { yybegin( YYINITIAL ); }

[\t\n\r ] { ; }

//operators
\+	 { return new Symbol( sym.PLUS ); }
\*	 { return new Symbol( sym.MUL );  }
-    { return new Symbol( sym.MINUS ); }
\/   {  return new Symbol( sym.DIV ); }
\<   {  return new Symbol( sym.LESS ); }
\<=  {  return new Symbol( sym.LESSEQ ); }
==   {  return new Symbol( sym.EQ ); }
\<\> {  return new Symbol( sym.NOTEQ ); }
\>   {  return new Symbol( sym.GREATER ); }
\>=  {  return new Symbol( sym.GREATEREQ ); }

//separators
;				{ return new Symbol( sym.SEMI );	}
,				{ return new Symbol( sym.COMMA );	}
\(				{ return new Symbol( sym.LEFTPAR ); }
\)				{ return new Symbol( sym.RIGHTPAR ); }
=           { return new Symbol( sym.ASSIGN ); }

//key words
"program"		{ return new Symbol( sym.PROGRAM );	}	
"int"			{ return new Symbol( sym.INT );	}
"real"			{ return new Symbol( sym.REAL );	}
"bool"			{return new Symbol( sym.BOOL );	}
"read"			{ return new Symbol( sym.READ );	}
"write"			{ return new Symbol( sym.WRITE );	}
"begin"			{ return new Symbol( sym.BEGIN );	}
"for"          {return new Symbol( sym.FOR ); }
"AND"          { return new Symbol( sym.AND ); }
"OR"          { return new Symbol( sym.OR ); }
"end"			{ return new Symbol( sym.END );	}

//id-s
({slovo} | _)({slovo}|{cifra}| _ )* { return new Symbol(sym.ID); }
//constants
{cifra}+ { return new Symbol( sym.CONST ); }
\${oc16}+ { return new Symbol( sym.CONST); }
0\.{cifra}+(E[+\-]{cifra}+)? { return new Symbol( sym.CONST);}
'[^]' { return new Symbol( sym.CONST);}
true  { return new Symbol( sym.CONST);}
false { return new Symbol( sym.CONST);}	
//error symbol
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }
