
import 'package:flutter/material.dart';

class BtnPrimary extends StatelessWidget {

  String texto;
  VoidCallback? ao_clicar;
  FocusNode? marcador_foco;
  bool mostrar_progress;

  BtnPrimary(
    this.texto,
    {
      this.ao_clicar,
      this.marcador_foco = null,
      this.mostrar_progress = false
    }
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ao_clicar,
      focusNode: marcador_foco,
      child: mostrar_progress
        ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
      ) : Text(texto)
    );
  }
}
