import 'package:flutter/material.dart';

class BtnDanger extends StatelessWidget {

  String texto;
  late VoidCallback ao_clicar;
  FocusNode? marcador_foco;
  bool mostrar_progress;

  BtnDanger(
      this.texto,
      {
        required this.ao_clicar,
        this.marcador_foco = null,
        this.mostrar_progress = false
      }
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ao_clicar,
      focusNode: marcador_foco,
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
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
