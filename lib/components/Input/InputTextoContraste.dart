import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class InputTextoContraste extends StatelessWidget {

  late String texto_label;
  late String texto_dica;
  late bool password;
  TextEditingController? controlador;
  FormFieldValidator<String>? validator;
  late TextInputType teclado;
  FocusNode? marcador_foco;
  FocusNode? recebedor_foco;
  late int max_length;
  late int max_lines;
  Function(String)? onChanged;
  late bool validar;


  InputTextoContraste(
      this.texto_label,
      {
        this.texto_dica = "",
        this.password = false,
        this.controlador = null,
        this.validator = null,
        this.teclado = TextInputType.text,
        this.marcador_foco = null,
        this.recebedor_foco = null,
        this.max_length = 80,
        this.onChanged = null,
        this.max_lines = 1,
        this.validar = true
      }
      ){
    if(this.validator == null && this.validar == true){
      this.validator = (String? text){
        if(text!.isEmpty)
          return "O campo $texto_label é obrigatório";
        return null;
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: password,
      controller: controlador,
      keyboardType: teclado,
      textInputAction: TextInputAction.next,
      focusNode: marcador_foco,
      onFieldSubmitted: (String text){
        FocusScope.of(context).requestFocus(recebedor_foco);
      },
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        counterStyle: const TextStyle(
            color: Colors.black
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        labelText: texto_label,
        hintStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        labelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      maxLength: max_length,
      maxLines: max_lines,
    );
  }
}
