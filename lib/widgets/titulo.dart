import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:campo_minado/models/tabuleiro.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final Situacao situacao;
  final Dificuldade dificuldade;
  final int qntBombas;
  final Function onReiniciar;
  final Function onDificuldade;

  ResultadoWidget({
    @required this.situacao,
    @required this.qntBombas,
    @required this.onReiniciar,
    @required this.dificuldade,
    @required this.onDificuldade,
  });

  Color _getCor() {
    if(situacao == Situacao.jogando) {
      return Colors.yellow;
    } else if(situacao == Situacao.venceu) {
      return Colors.green;
    } else {
      return Colors.redAccent;
    }
  }

  IconData _getIcon() {
    if(situacao == Situacao.jogando) {
      return Icons.sentiment_satisfied;
    } else if(situacao == Situacao.venceu) {
      return Icons.sentiment_very_satisfied;
    } else 
      return Icons.sentiment_very_dissatisfied;
  }

  Image _getDificuldade() {
     if( this.dificuldade == Dificuldade.dificil) {
      return Image.asset('assets/icons/hard.png', 
        width: 85, 
        height: 50, 
        fit: BoxFit.fill,
        );
    } else if( this.dificuldade == Dificuldade.media) {
      return Image.asset('assets/icons/medium.png', 
        width: 85,
        height: 50, 
        fit: BoxFit.fill,
      );
    } else
      return Image.asset('assets/icons/easy.png', 
        width: 85, 
        height: 50, 
        fit: BoxFit.fill, 
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Card(
          color: Colors.grey[600],
          elevation: 20,
          margin: EdgeInsets.all(2),
          child: Row(children: <Widget>[
            Text("Bombas: ${qntBombas == null ? '' : qntBombas.toString()}",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            Spacer(flex: 1,),
            CircleAvatar(
              backgroundColor: _getCor(),
              child: IconButton(
                padding: EdgeInsets.all(1),
                icon: Icon( _getIcon(),
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: this.onReiniciar,
              ),
            ),
            Spacer(flex: 2,),
            FlatButton(
              padding: EdgeInsets.all(2),
              onPressed: this.onDificuldade, 
              child: _getDificuldade(),
            ),
          ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
