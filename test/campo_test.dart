import 'package:campo_minado/models/bloco.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  
  group(BlocoModel, () {

    test('Abrir Bloco COM Explosão', () {
      BlocoModel c= BlocoModel(linha: 0, coluna: 0);
      c.minar();
      
      expect(c.abrir, throwsException);

    });

    test('Abrir Bloco SEM Explosão', () {
      BlocoModel c= BlocoModel(linha: 0, coluna: 0);
      c.abrir();
      
      expect(c.aberto, isTrue);
    });

    test('Adicionar NÃO Vizinho', () {
      BlocoModel c1= BlocoModel(linha: 0, coluna: 0);
      BlocoModel c2= BlocoModel(linha: 1, coluna: 3);      
      c1.adicionarVizinho(c2);

      
      expect(c1.vizinhos.isEmpty, isTrue);
    });

    test('Adicionar Vizinho', () {
      BlocoModel c1= BlocoModel(linha: 3, coluna: 3);
      BlocoModel c2= BlocoModel(linha: 3, coluna: 4);    
      BlocoModel c3= BlocoModel(linha: 2, coluna: 2);
      BlocoModel c4= BlocoModel(linha: 4, coluna: 4);  
      BlocoModel c5= BlocoModel(linha: 10, coluna: 0);        

      c1.adicionarVizinho(c2);
      c1.adicionarVizinho(c3);
      c1.adicionarVizinho(c4);
      c1.adicionarVizinho(c5);

      expect(c1.vizinhos.length, 3);
    });

    test('Minas na vizinhança', () {
      BlocoModel c1= BlocoModel(linha: 3, coluna: 3);
      BlocoModel c2= BlocoModel(linha: 3, coluna: 4);    
      BlocoModel c3= BlocoModel(linha: 2, coluna: 2);
      BlocoModel c4= BlocoModel(linha: 4, coluna: 4);  
      BlocoModel c5= BlocoModel(linha: 10, coluna: 0);     
      c2.minar();
      c4.minar();
      c5.minar();   

      c1.adicionarVizinho(c2);
      c1.adicionarVizinho(c3);
      c1.adicionarVizinho(c4);
      c1.adicionarVizinho(c5);

      expect(c1.qtdeMinasNaVizinhanca, 2);
    });



  });

}