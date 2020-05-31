import 'dart:math';
import 'package:flutter/material.dart';
import 'package:campo_minado/models/bloco.dart';

enum Dificuldade {facil, media, dificil}
enum Situacao {jogando, venceu, perdeu}

Tabuleiro getTabuleiro({double altura, double largura, Dificuldade dificuldade = Dificuldade.facil}) {
  double tamanhoBloco = 0;
  int qntBase    = 12;
  int qntLinhas  = 1; 
  int qntColunas = 1;
  int qntBombas  = 1;

  if(altura > largura) {
    qntColunas = qntBase;
    tamanhoBloco = largura / qntBase;
    qntLinhas = (altura / tamanhoBloco).floor();
  } else {
    qntLinhas = qntBase;
    tamanhoBloco = altura / qntBase;
    qntColunas = (largura / tamanhoBloco).floor();
  }

  qntBombas = getQuantidadeBombas(
    dificuldade: dificuldade, 
    linhas: qntLinhas,
    colunas: qntColunas);

  Tabuleiro tabuleiro = Tabuleiro(
    linhas: qntLinhas, 
    colunas: qntColunas, 
    qtdeBonbas: qntBombas);
  return tabuleiro;
}

int getQuantidadeBombas({Dificuldade dificuldade, int linhas, int colunas}){
  int qntBombas = 0;
  if (dificuldade == Dificuldade.dificil) {
    qntBombas = ((colunas * linhas) / 6).round();
  } else if (dificuldade == Dificuldade.media) {
    qntBombas = ((colunas * linhas) / 9).round();
  } else {
    qntBombas = ((colunas * linhas) / 16).round();
  }
  return qntBombas;
}


class Tabuleiro {
  final int linhas;
  final int colunas;
  int qtdeBonbas;

  final List<BlocoModel> _blocos = [];

  Tabuleiro({
    @required this.linhas,
    @required this.colunas,
    @required this.qtdeBonbas,
  }) {
    _criarBlocos();
    _relacionarVizinhos();
    _sortearMinhas();
  }

  void reiniciar(){
    _blocos.forEach((element) => element.iniciar());
    _sortearMinhas();
  }

  void revelarBombas(){
    _blocos.forEach((element) => element.refelarBomba());
  }

  void _criarBlocos() {
    for(int l = 0; l < linhas; l++) {
      for(int c = 0; c < colunas; c++) {
        _blocos.add(BlocoModel(linha: l, coluna: c));
      }      
    }
  }

  void _relacionarVizinhos() {
    for(var bloco in _blocos) {
      for(var vizinho in _blocos) {
        bloco.adicionarVizinho(vizinho);
      }
    }
  }

  void _sortearMinhas() {
    int plantadas = 0;
    int x = 0;
    int max = _blocos.length;
    while(plantadas < qtdeBonbas) {
      x = Random().nextInt(max);
      x = ((plantadas % 2) == 0) ? x : max - x; 
      if(!_blocos[x].minado) {
        plantadas++;
        _blocos[x].minar();
      }
    }
  }
  
  void dificuldade({Dificuldade dificuldade}){
    qtdeBonbas = getQuantidadeBombas(
      dificuldade: dificuldade,
      linhas: linhas,
      colunas: colunas);
  }

  List<BlocoModel> get blocos => _blocos;

  bool get resolvido => _blocos.every((element) => element.finalizado);

  bool get detonado => !_blocos.every((element) => !element.detonado);

  Situacao get situacao {
    if(detonado) 
      return Situacao.perdeu;
    if(resolvido)
      return Situacao.venceu;
    return Situacao.jogando;
  }

  int get quantidadeDeBombas => qtdeBonbas;
}