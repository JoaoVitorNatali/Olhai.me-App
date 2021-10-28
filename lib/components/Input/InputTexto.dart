import "package:flutter/material.dart";

class InputTexto extends StatelessWidget {

  late String texto_label;
  late String texto_dica;
  late bool password;
  TextEditingController? controlador;
  FormFieldValidator<String>? validator;
  late TextInputType teclado;
  FocusNode? marcador_foco;
  FocusNode? recebedor_foco;


  InputTexto(
      this.texto_label,
      {
        this.texto_dica = "",
        this.password = false,
        this.controlador = null,
        this.validator = null,
        this.teclado = TextInputType.text,
        this.marcador_foco = null,
        this.recebedor_foco = null
      }
  ){
    if(this.validator == null){
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
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: texto_label,
        labelStyle: TextStyle(
          fontSize: 20,
          color: Colors.grey,
        )
      ),
    );
  }
}
