import 'dart:developer';

import "package:flutter/material.dart";
import 'package:shortlink/api/Acessar/ValidarCodigo.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/preferences/User.dart';

//page
import 'package:shortlink/pages/AlterarNome/index.dart';
import 'package:shortlink/routes/index.dart';

class EnviarCodigo extends StatefulWidget {
  const EnviarCodigo({Key? key, required this.title, required this.user}) : super(key: key);
  final String title;
  final String user;

  @override
  _EnviarCodigoState createState() => _EnviarCodigoState();
}

class _EnviarCodigoState extends State<EnviarCodigo> {

  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  bool _mostrarLoad = false;
  String _mensagemErro = "";

  Future<void> validarCodigo(texto) async {
    setState(() {
      _mostrarLoad = true;
    });

    var response = await ValidarCodigoService.validarCodigoAcesso(widget.user, texto);

    setState(() {
      _mostrarLoad = false;
    });

    if(response.ok == true){
      Usuario.salvar(response.body);

      if(response.body?["is_new_user"] == true){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => AlterarNome(title: widget.title)
        ));
      } else {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const Routes()
        ));
      }
    } else {
      setState(() {
        _mensagemErro = "Código inválido";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          InputTexto(
            'Código',
            teclado: TextInputType.number,
            max_length: 6,
            controlador: controlador1,
            onChanged: (texto){
              if(texto.length == 6){
                validarCodigo(texto);
              }
            },
          ),

          Center(
            child: _mostrarLoad ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ) : null
          ),

          Center(
            child: Text(_mensagemErro),
          ),

        ],
      ),
    );
  }
}
