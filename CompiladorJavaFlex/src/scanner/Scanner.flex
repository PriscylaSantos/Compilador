package scanner;
import java_cup.runtime.Symbol;
import parser.SymbolCodes;
import erros.ListaErros;

%%

%class Scanner
%cupsym SymbolCodes
%cup
%unicode   // permite usar caracteres unicode
%line      // permite usar yyline
%column    // permite usar yycolumn
%public

%eofval{
	return criaSimbolo(SymbolCodes.EOF);
%eofval}

//codigo inserido na classe
%{
	private ListaErros listaErros;

	public Scanner(java.io.InputStream in, ListaErros listaErros)
	{
		this(in);
		this.listaErros = listaErros;
	}

	public ListaErros getListaErros()
	{
		return listaErros;
	}

	public void defErro(int linha, int coluna, String texto)
	{
		listaErros.defErro(linha,coluna,texto);
	}

	public void defErro(int linha, int coluna)
	{
		listaErros.defErro(linha,coluna);
	}

	public void defErro(String texto)
	{
		listaErros.defErro(texto);
	}

	private Symbol criaSimbolo(int code, Object value)
	{
		return new Symbol(code, yyline, yycolumn, value);
	}

	private Symbol criaSimbolo(int code)
	{
		return new Symbol(code, yyline, yycolumn, null);
	}
%}


/********************PALAVRAS RESERVADAS********************/

Programa = "program"
Classe = "class"
If = "if"
Else = "else"
While = "while"
Read = "read"
Escreva = "print"
Retorno = "return"
Keyword_void = "void"
Keyword_final = "final"
Keyword_novo = "new"

/********************OPERADORES********************/

Operador_soma = "+"
Operador_subtracao = "-"
Operador_multiplicacao = "*"
Operador_divisao = "/"
Operador_mod = "%"
Operador_igual = "=="
Operador_diferente = "!="
Operador_maior = ">"
Operador_menor = "<"
Operador_maiorigual = ">="
Operador_menorigual = "<="
Operador_abreparenteses = "("
Operador_fechaparenteses = ")"
Operador_abrecolchete = "["
Operador_fechacolchete = "]"
Operador_abrechave = "{"
Operador_fechachave = "}"
Operador_recebe = "="
Operador_pontoevirgula = ";"
Operador_virgula = ","
Operador_ponto = "."

/********************CLASSE DE CARACTER********************/

FimdeLinha = \r|\n|\r\n
Espaco = {FimdeLinha} | [ \t\f]
Letra   = [a-zA-Z]
Digito  = 0 | [1-9][0-9]*

/********************COMENTARIO********************/

CharTexto   =  [^\r\n] /*O QUE É "^" ?*/
Barras = "//"
ComentLinha  = {Barras}{CharTexto}* {FimdeLinha}

/********************TERMINAIS********************/
Separador = "_"
Palavra   = {Letra} ({Letra} | {Digito})*
Variavel = {Palavra} ({Separador}{Palavra})*
Identificador = {Palavra} | {Variavel}
Numinteiro = {Digito} ({Digito})*
Numdouble = {Numinteiro}{Operador_ponto}{Numinteiro}

Aspas = "'"
Cconst = "char"
Charconst = {Aspas}{Cconst}{Aspas}

%%
{Espaco} {/*despreza*/}
{ComentLinha} {/*despreza*/}

{Numinteiro} {
	int aux = Integer.parseInt (yytext());
	return criaSimbolo (SymbolCodes.INTEIRO, new Integer(aux));
}

{Numdouble} {
	Double aux = Double.parseDouble (yytext());
	return criaSimbolo (SymbolCodes.FLOAT, new Double (aux));
}

{Charconst} {return criaSimbolo (SymbolCodes.CHARCONST);}
    

/********************PALAVRAS RESERVADAS********************/

{Programa} { return criaSimbolo (SymbolCodes.KWPROGRAMA);} 

{Classe} { return criaSimbolo (SymbolCodes.KWCLASS);}

{If} { return criaSimbolo (SymbolCodes.KWIF);}

{Else} { return criaSimbolo (SymbolCodes.KWELSE);}

{While} { return criaSimbolo (SymbolCodes.KWWHILE);}

{Read} { return criaSimbolo (SymbolCodes.KWREAD);}

{Escreva} { return criaSimbolo (SymbolCodes.KWPRINT);}

{Retorno} { return criaSimbolo (SymbolCodes.KWRETURN);}

{Keyword_void} { return criaSimbolo (SymbolCodes.KWVOID);}

{Keyword_final} { return criaSimbolo (SymbolCodes.KWFINAL);}

{Keyword_novo} { return criaSimbolo (SymbolCodes.KWNEW);}

{Identificador} {return criaSimbolo (SymbolCodes.IDENTIFICADOR);}

/********************OPERADORES********************/

{Operador_soma} { return criaSimbolo (SymbolCodes.OP_MAIS);}

{Operador_subtracao} { return criaSimbolo (SymbolCodes.OP_MENOS);}

{Operador_multiplicacao} { return criaSimbolo (SymbolCodes.OP_MULT);}

{Operador_divisao} { return criaSimbolo (SymbolCodes.OP_DIV);}

{Operador_mod} { return criaSimbolo (SymbolCodes.OP_MOD);}

{Operador_igual} { return criaSimbolo (SymbolCodes.OP_IGUAL);}

{Operador_diferente} { return criaSimbolo (SymbolCodes.OP_DIFERENTE);}

{Operador_maior} { return criaSimbolo (SymbolCodes.OP_MAIOR);}

{Operador_menor} { return criaSimbolo (SymbolCodes.OP_MENOR);}

{Operador_maiorigual} { return criaSimbolo (SymbolCodes.OP_MAIORIGUAL);}

{Operador_menorigual} { return criaSimbolo (SymbolCodes.OP_MENORIGUAL);}

{Operador_abreparenteses} { return criaSimbolo (SymbolCodes.ABRE_PARENTESES);}

{Operador_fechaparenteses} { return criaSimbolo (SymbolCodes.FECHA_PARENTESES);}

{Operador_abrecolchete} { return criaSimbolo (SymbolCodes.ABRE_COLCHETE);}

{Operador_fechacolchete} { return criaSimbolo (SymbolCodes.FECHA_COLCHETE);}

{Operador_abrechave} { return criaSimbolo (SymbolCodes.ABRE_CHAVE);}

{Operador_fechachave} { return criaSimbolo (SymbolCodes.FECHA_CHAVE);}

{Operador_recebe} { return criaSimbolo (SymbolCodes.OP_RECEBE);}

{Operador_pontoevirgula} { return criaSimbolo (SymbolCodes.OP_PONTOEVIRGULA);}

{Operador_virgula} { return criaSimbolo (SymbolCodes.OP_VIRGULA);}

{Operador_ponto} { return criaSimbolo (SymbolCodes.OP_PONTO);}
