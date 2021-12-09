import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shortlink/api/Pages/pages.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/components/Input/InputTexto.dart';

class NovaPagina extends StatefulWidget {
  const NovaPagina({Key? key}) : super(key: key);

  @override
  _NovaPaginaState createState() => _NovaPaginaState();
}

class _NovaPaginaState extends State<NovaPagina> {
  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  bool _mostrar_progress = false;
  String _mensagem_de_erro = "";

  criarNovaPagina(inputText) async {

    setState(() {
      _mostrar_progress = true;
      _mensagem_de_erro = "";
    });

    var response = await Pages.criarPagina(inputText);

    setState(() {
      _mostrar_progress = false;

      print(response.body.toString());

      if(response.ok == true){
        Navigator.pop(context);
      }
      else{
        if(response.body!["message"] != null) {
          Map responseJson = json.decode(
              utf8.decode(response.response!.bodyBytes));
          _mensagem_de_erro = responseJson["message"];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar página')),
      body: Form(
        key: formkey,
        child: Center(
          child: Container(
            color: Colors.black87,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                const SizedBox(
                    height: 20
                ),

                const Text(
                  'Crie sua página',
                  style: TextStyle(color: Colors.white),
                ),

                const SizedBox(
                    height: 20
                ),

                InputTexto(
                  'Escolha um @criativo...',
                  controlador: controlador1,
                ),

                const SizedBox(
                    height: 10
                ),

                Text(
                  _mensagem_de_erro,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),

                const SizedBox(
                    height: 10
                ),

                BtnPrimary(
                  'Encurtar link',
                  mostrar_progress: _mostrar_progress,
                  ao_clicar: (){
                    if(formkey.currentState?.validate() == true){
                      criarNovaPagina(controlador1.text);
                    }
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
