import 'package:flutter/material.dart';
import 'package:campo_minado/widgets/titulo.dart';
import 'package:campo_minado/widgets/tabuleiro.dart';
import 'package:campo_minado/models/bloco.dart';
import 'package:campo_minado/models/tabuleiro.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({Key? key}) : super(key: key);

  @override
  _CampoMinadoAppState createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  late Tabuleiro _tabuleiro = Tabuleiro(linhas: 0, colunas: 0, qtdeBonbas: 0);
  late int _qntBombas = 0;
  Situacao _situacao = Situacao.jogando;
  Dificuldade _dificuldade = Dificuldade.facil;
  BlocoModel bloco = BlocoModel(linha: 0, coluna: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: ResultadoWidget(
            qntBombas: _qntBombas,
            situacao: _situacao,
            dificuldade: _dificuldade,
            onReiniciar: _reiniciar,
            onDificuldade: _mudarDificuldade,
          ),
          body: Container(
            color: Colors.grey.shade600,
            child: LayoutBuilder(
              builder: (context, constraints) => TabuleiroWidget(
                tabuleiro: _loadTabuleiro(
                  altura: constraints.maxHeight,
                  largura: constraints.maxWidth,
                ),
                onAbrir: _abrir,
                onAlternarMarcacao: _alternarSinalizado,
              ),
            ),
          )),
    );
  }

  Tabuleiro _loadTabuleiro({required double altura, required double largura}) {
    if (!_tabuleiro.inicializado) {
      _tabuleiro = getTabuleiro(
        altura: altura,
        largura: largura,
        dificuldade: _dificuldade,
      );
      _qntBombas = _tabuleiro.quantidadeDeBombas;
      _situacao = _tabuleiro.situacao;
    }
    return _tabuleiro;
  }

  void _reiniciar() {
    setState(() {
      _tabuleiro.reiniciar();
      _situacao = Situacao.jogando;
      _qntBombas = _tabuleiro.quantidadeDeBombas;
    });
  }

  void _mudarDificuldade() {
    if (_dificuldade == Dificuldade.dificil) {
      _dificuldade = Dificuldade.facil;
    } else if (_dificuldade == Dificuldade.media) {
      _dificuldade = Dificuldade.dificil;
    } else {
      _dificuldade = Dificuldade.media;
    }
    _tabuleiro.dificuldade(dificuldade: _dificuldade);
    _reiniciar();
  }

  void _abrir(BlocoModel bloco) {
    if (_situacao != Situacao.jogando || bloco.sinalizado) {
      return;
    }

    setState(() {
      bloco.abrir();
      _situacao = _tabuleiro.situacao;

      if (_situacao == Situacao.perdeu) {
        _tabuleiro.revelarBombas();
      }
    });
  }

  void _alternarSinalizado(BlocoModel bloco) {
    if (_situacao != Situacao.jogando || bloco.aberto) {
      return;
    }
    setState(() {
      bloco.alternarSinalizado();
      _situacao = _tabuleiro.situacao;
      _qntBombas = bloco.sinalizado ? _qntBombas - 1 : _qntBombas + 1;
    });
  }
}
