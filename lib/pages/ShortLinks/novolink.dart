import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/api/ShortLink/link.dart';


class NovoLink extends StatefulWidget {
  const NovoLink({Key? key}) : super(key: key);

  @override
  _NovoLinkState createState() => _NovoLinkState();
}

class _NovoLinkState extends State<NovoLink> {
  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  final controlador2 = TextEditingController();
  bool _mostrar_progress = false;
  String _mensagem_de_erro = "";

  criarLinkEncurtado(chave, url) async {
    setState(() {
      _mostrar_progress = true;
      _mensagem_de_erro = "";
    });

    var response = await ShortLink.encurtarLink(chave, url);

    setState(() {
      _mostrar_progress = false;

      if(response.ok == true){
        Navigator.pushReplacementNamed(context, '/shortlinks');
      }
      else{
        if(response.body!["message"] != null){
          Map responseJson = json.decode(utf8.decode(response.response!.bodyBytes));
          _mensagem_de_erro = responseJson["message"];
        } else {
          _mensagem_de_erro = "Ocorreu um erro, tente novamente";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar link')),
      body: Form(
        key: formkey,
        child: Center(
          child: Container(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                const SizedBox(
                    height: 20
                ),

                const Text(
                  'Digite a chave para criação do seu novo link e uma url válida, iniciada com https:// ou http://',
                  style: TextStyle(color: Colors.white),
                ),

                const SizedBox(
                    height: 20
                ),

                InputTexto(
                  'Chave...',
                  controlador: controlador1,
                ),

                InputTexto(
                  'URL...',
                  controlador: controlador2,
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
                      criarLinkEncurtado(controlador1.text, controlador2.text);
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
