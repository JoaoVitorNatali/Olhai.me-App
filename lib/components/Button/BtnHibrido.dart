import 'package:flutter/material.dart';

class BtnHibrido extends StatelessWidget {

  String texto;
  late VoidCallback ao_clicar;
  FocusNode? marcador_foco;
  bool mostrar_progress;
  Color color;

  BtnHibrido(
      this.texto,
      {
        required this.ao_clicar,
        this.marcador_foco = null,
        this.mostrar_progress = false,
        this.color = Colors.blue
      }
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ao_clicar,
      focusNode: marcador_foco,
      style: ElevatedButton.styleFrom(
          primary: color,
          minimumSize: const Size(115, 34)
      ),
      child: mostrar_progress
          ? const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ) : Text(texto),
    );
  }
}
