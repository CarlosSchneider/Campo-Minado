import 'package:flutter/material.dart';
import 'package:campo_minado/models/bloco.dart';

class BlocoWidget extends StatelessWidget {
  final BlocoModel bloco;
  final void Function(BlocoModel) onAbrir;
  final void Function(BlocoModel) onAlternarMarcacao;

  const BlocoWidget({
    Key? key,
    required this.bloco,
    required this.onAbrir,
    required this.onAlternarMarcacao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAbrir(bloco),
      onLongPress: () => onAlternarMarcacao(bloco),
      child: _getImage(),
    );
  }

  Image _getImage() {
    int qntMinas = bloco.qtdeMinasNaVizinhanca;
    if (bloco.sinalizado) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else if (bloco.detonado) {
      return Image.asset('assets/images/bomba_detonada.jpeg');
    } else if (bloco.revelado) {
      return Image.asset('assets/images/bomba.jpeg');
    } else if (bloco.aberto) {
      return Image.asset('assets/images/alerta_$qntMinas.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }
}
