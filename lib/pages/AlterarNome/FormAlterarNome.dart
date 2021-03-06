import 'package:flutter/material.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/api/Usuario/AlterarNome.dart';
import 'package:shortlink/preferences/User.dart';
import 'package:shortlink/routes/index.dart';

class FormAlterarNome extends StatefulWidget {
  const FormAlterarNome({Key? key, this.token}) : super(key: key);
  final String? token;

  @override
  _FormAlterarNomeState createState() => _FormAlterarNomeState();
}

class _FormAlterarNomeState extends State<FormAlterarNome> {

  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  bool _mostrarLoad = false;
  String _mensagemErro = "";

  _setar_mudancas_usuario(nome) async {
    Map? usuario = await Usuario.obter();

    usuario?["user"]?["name"] = nome;

    Usuario.salvar(usuario);

    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const Routes()
    ));
  }


  Future<void> enviarRequisicao(username) async {
    setState(() {
      _mostrarLoad = true;
    });
    var response = await AlterarNome.alterarNomeUsuario(username, widget.token);

    setState(() {
      _mostrarLoad = false;

      if(response.ok == true){
        _setar_mudancas_usuario(response.body?["name"]);
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
            controlador: controlador1,
          ),

          Center(
            child: Text(_mensagemErro),
          ),

          BtnPrimary(
            'Enviar',
            mostrar_progress: _mostrarLoad,
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
