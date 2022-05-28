import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';

main() {
  test('Canhar Jogo', () {
    Tabuleiro tabuleiro = Tabuleiro(
      linhas: 2,
      colunas: 2,
      qtdeBonbas: 0,
    );

    tabuleiro.blocos[0].minar();
    tabuleiro.blocos[3].minar();

    tabuleiro.blocos[0].alternarSinalizado();
    tabuleiro.blocos[3].alternarSinalizado();
    tabuleiro.blocos[1].abrir();
    tabuleiro.blocos[2].abrir();

    expect(tabuleiro.resolvido, true);
  });

  test('Perder Jogo', () {
    Tabuleiro tabuleiro = Tabuleiro(
      linhas: 2,
      colunas: 2,
      qtdeBonbas: 0,
    );

    tabuleiro.blocos[0].minar();
    tabuleiro.blocos[3].minar();

    tabuleiro.blocos[0].alternarSinalizado();
    tabuleiro.blocos[1].abrir();
    tabuleiro.blocos[2].abrir();
    tabuleiro.blocos[3].abrir();

    expect(tabuleiro.detonado, true);
  });

  test('Jogo Completo', () {
    Tabuleiro tabuleiro = Tabuleiro(
      linhas: 12,
      colunas: 12,
      qtdeBonbas: 25,
    );

    String linha = "";
    for (var i = 0; i < tabuleiro.blocos.length; i++) {
      if (i % 12 == 0) {
        linha += "\n";
      }

      if (tabuleiro.blocos[i].minado) {
        tabuleiro.blocos[i].alternarSinalizado();
        linha += "X ";
      } else {
        tabuleiro.blocos[i].abrir();
        linha += tabuleiro.blocos[i].qtdeMinasNaVizinhanca.toString() + " ";
      }
    }
    if (kDebugMode) {
      print(linha);
    }

    expect(tabuleiro.detonado, false);
  });
}
