import 'package:flutter/material.dart';
import 'package:campo_minado/models/tabuleiro.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final Situacao situacao;
  final Dificuldade dificuldade;
  final int qntBombas;
  final void Function()? onReiniciar;
  final void Function()? onDificuldade;

  const ResultadoWidget({
    Key? key,
    required this.situacao,
    required this.qntBombas,
    required this.onReiniciar,
    required this.dificuldade,
    required this.onDificuldade,
  }) : super(key: key);

  Color _getCor() {
    if (situacao == Situacao.jogando) {
      return Colors.yellow;
    } else if (situacao == Situacao.venceu) {
      return Colors.green;
    } else {
      return Colors.redAccent;
    }
  }

  IconData _getIcon() {
    if (situacao == Situacao.jogando) {
      return Icons.sentiment_satisfied;
    } else if (situacao == Situacao.venceu) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  Image _getDificuldade() {
    if (dificuldade == Dificuldade.dificil) {
      return Image.asset(
        'assets/icons/hard.png',
        width: 85,
        height: 50,
        fit: BoxFit.fill,
      );
    } else if (dificuldade == Dificuldade.media) {
      return Image.asset(
        'assets/icons/medium.png',
        width: 85,
        height: 50,
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        'assets/icons/easy.png',
        width: 85,
        height: 50,
        fit: BoxFit.fill,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Card(
          color: Colors.grey.shade600,
          elevation: 20,
          margin: const EdgeInsets.all(2),
          child: Row(
            children: <Widget>[
              Text(
                // ignore: unnecessary_null_comparison
                "Bombas: ${qntBombas == null ? '' : qntBombas.toString()}",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              CircleAvatar(
                backgroundColor: _getCor(),
                child: IconButton(
                  padding: const EdgeInsets.all(1),
                  icon: Icon(
                    _getIcon(),
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: onReiniciar,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              TextButton(
                onPressed: onDificuldade,
                child: _getDificuldade(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
