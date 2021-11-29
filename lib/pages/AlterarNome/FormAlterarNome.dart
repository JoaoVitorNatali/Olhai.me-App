import 'package:flutter/material.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/api/Usuario/AlterarNome.dart';

class FormAlterarNome extends StatefulWidget {
  const FormAlterarNome({Key? key}) : super(key: key);

  @override
  _FormAlterarNomeState createState() => _FormAlterarNomeState();
}

class _FormAlterarNomeState extends State<FormAlterarNome> {

  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  bool _mostrarLoad = false;
  String _mensagemErro = "";

  Future<void> enviarRequisicao(username) async {
    setState(() {
      _mostrarLoad = true;
    });
    var response = await AlterarNome.alterarNomeUsuario(username, 'teste');

    setState(() {
      _mostrarLoad = false;

      if(response.ok == true){

      }
      else{
        _mensagemErro = "Ocorreu um erro, tente novamente";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          InputTexto(
            'Nome de usuário',
            max_length: 6,
            controlador: controlador1,
          ),

          Center(
            child: Text(_mensagemErro),
          ),

          BtnPrimary(
            'Enviar',
            ao_clicar: (){
              String username = controlador1.text;
              if(formkey.currentState?.validate() == true){
                enviarRequisicao(username);
              }
            }
          )

        ],
      ),
    );
  }
}
