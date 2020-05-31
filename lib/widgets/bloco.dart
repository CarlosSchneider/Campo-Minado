import 'package:flutter/material.dart';
import 'package:campo_minado/models/bloco.dart';

class BlocoWidget extends StatelessWidget {

  final BlocoModel bloco;
  final void Function(BlocoModel) onAbrir;
  final void Function(BlocoModel) onAlternarMarcacao;

  BlocoWidget({
    @required this.bloco,
    @required this.onAbrir,
    @required this.onAlternarMarcacao,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAbrir(bloco),
      onLongPress: () => onAlternarMarcacao(bloco),
      child: _getImage(),
    );
  }

  Image _getImage() {
    int qntMinias = bloco.qtdeMinasNaVizinhanca;
    if(bloco.sinalizado) {
      return Image.asset('assets/images/bandeira.jpeg');      
    } else if(bloco.detonado) {
      return Image.asset('assets/images/bomba_detonada.jpeg');
    } else if(bloco.revelado) {
      return Image.asset('assets/images/bomba.jpeg');
    } else if( bloco.aberto) {
      return Image.asset('assets/images/alerta_$qntMinias.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }
}