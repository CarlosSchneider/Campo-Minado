import 'package:flutter/foundation.dart';

class BlocoModel {
  final int linha;
  final int coluna;
  final List<BlocoModel> vizinhos = [];

  bool _aberto;
  bool _sinalizado;
  bool _minado;
  bool _detonado;

  BlocoModel({
    @required this.linha,
    @required this.coluna,
  }) {
    iniciar();
  }

  void iniciar() {
    _aberto = false;
    _sinalizado = false;
    _minado = false;
    _detonado = false;
  }  

  void adicionarVizinho(BlocoModel vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();
    
    if(deltaLinha == 0 && deltaColuna == 0)
      return;

    if(deltaLinha <= 1 && deltaColuna <= 1)
      vizinhos.add(vizinho);
  }

  void abrir() {
    if(_aberto) 
      return;

    _aberto = true;

    if(_minado) {
      _detonado = true;
      return;
    }

    if(vizinhancaLimpa)
      vizinhos.forEach((element) => element.abrir());
  }

  void refelarBomba() {
    if(_minado && !_aberto) 
      _aberto = true;
  }

  void minar() {
    _minado = true;
  }

  void alternarSinalizado() {
    _sinalizado = !_sinalizado;
  }

  bool get minado => _minado;

  bool get sinalizado => _sinalizado;

  bool get detonado => _detonado;

  bool get aberto => (_aberto && !_minado);

  bool get revelado => (_aberto && _minado && !_detonado);

  bool get resolvido => (_minado && _sinalizado);

  bool get finalizado => resolvido || aberto;

  bool get vizinhancaLimpa => vizinhos.every( (element) => !element._minado );

  int get qtdeMinasNaVizinhanca => vizinhos.where((element) => element.minado).length;
}
