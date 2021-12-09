import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shortlink/api/Acessar/ValidarCodigo.dart';
import 'package:shortlink/components/Input/InputTextoContraste.dart';

class VerificarCodigoModal extends StatefulWidget {
  const VerificarCodigoModal({Key? key, required this.user, required this.listar}) : super(key: key);
  final String user;
  final Function listar;

  @override
  _VerificarCodigoModalState createState() => _VerificarCodigoModalState();
}

class _VerificarCodigoModalState extends State<VerificarCodigoModal> {
  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  bool _mostrarLoad = false;
  String _mensagemErro = "";

  Future<void> validarCodigo(texto) async {
    setState(() {
      _mostrarLoad = true;
      _mensagemErro = "";
    });

    var response = await ValidarCodigoService.adicionarPasseAcesso(widget.user, texto);

    setState(() {
      _mostrarLoad = false;
    });

    if(response.ok == true){
      Navigator.pop(context);
      widget.listar();
    } else {
      setState(() {
        if(response.body!["message"] != null){
          Map responseJson = json.decode(utf8.decode(response.response!.bodyBytes));
          _mensagemErro = responseJson["message"];
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        color: Colors.white,
        child: Form(
          key: formkey,
          child: ListView(
            children: [

              const Center(
                child: Text(
                  "Digite o código enviado para",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                  ),
                ),
              ),

              const SizedBox(height: 18,),

              Center(
                child: Text(
                    widget.user,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 23
                  ),
                ),
              ),

              const SizedBox(height: 18,),

              InputTextoContraste(
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ) : null
              ),

              Center(
                child: Text(
                  _mensagemErro,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
