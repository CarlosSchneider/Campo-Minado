
import 'package:flutter/material.dart';
import 'package:campo_minado/widgets/bloco.dart';
import 'package:campo_minado/models/bloco.dart';
import 'package:campo_minado/models/tabuleiro.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final void Function(BlocoModel) onAbrir;
  final void Function(BlocoModel) onAlternarMarcacao;

  TabuleiroWidget({
    @required this.tabuleiro,
    @required this.onAbrir,
    @required this.onAlternarMarcacao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: tabuleiro.colunas,
        children:tabuleiro.blocos.map((bloco) {
          return BlocoWidget(
            bloco: bloco, 
            onAbrir: onAbrir, 
            onAlternarMarcacao: onAlternarMarcacao
          );
        }).toList(),
      ),
    );
  }
}