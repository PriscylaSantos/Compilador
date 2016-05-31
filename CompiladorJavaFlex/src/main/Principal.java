package main;
import java.io.FileInputStream;

import java_cup.runtime.Symbol;
import erros.ListaErros;
import scanner.Scanner;
import parser.Parser;

public class Principal {

	public static void main(String[] args)
	throws Exception {
		FileInputStream in = new FileInputStream("teste01.txt");
		ListaErros listaErros = new ListaErros();
		
		Scanner scanner = new Scanner(in, listaErros);
		//Scanner scanner = new Scanner(System.in);
		Parser parser = new Parser(scanner);
		
		parser.parse();
		if (listaErros.tamanho() == 0)
		{
			System.out.println("Sintaxe Correta! PARABÉNS, VOCÊ É DEMAIS! :D ");
		}
		else
		{
			System.out.println("Sintaxe Incorreta! RETORNE AO SEU CÓDIGO E CONSERTE, VOCÊ CONSEGUE! :) ");
			listaErros.dump();
		}
		
		/*try {
			parser.parse();
			System.out.println("Arquivo sem erros de sintaxe!");
		} catch (Exception e) {
			System.out.println(e);
		}*/
	}

}
/*
    try {
      parser p = new parser(new Yylex(System.in));
      Object result = p.parse().value;      
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}*/