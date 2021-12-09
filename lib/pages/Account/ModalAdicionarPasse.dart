import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shortlink/api/Acessar/requisitarApi.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/components/Input/InputTextoContraste.dart';
import 'package:shortlink/functions/validations.dart';
import 'package:shortlink/pages/Account/VerificarCodigoModal.dart';

class ModalAdicionarPasse extends StatefulWidget {
  const ModalAdicionarPasse({Key? key, required this.listar}) : super(key: key);
  final Function listar;

  @override
  _ModalAdicionarPasseState createState() => _ModalAdicionarPasseState();
}

class _ModalAdicionarPasseState extends State<ModalAdicionarPasse> {
  final formkey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _mostrar_progress = false;
  String _mensagemDeErro = "";

  Function? fowardListar(){
    Navigator.pop(context);
    widget.listar();
  }

  enviarCodigo() async{

    setState(() {
      _mostrar_progress = true;
    });

    String user = _email.text;
    String access_pass = user;

    if(validaTelefone(user)){
      access_pass = "+55" + user.replaceAll('(', '').replaceAll(')', '');
    }
    var response = await AcessoService.obterCodigoDeAcesso(access_pass);

    setState(() {
      _mostrar_progress = false;
      if(response.ok == false){
        _mensagemDeErro = "Não foi possível enviar o SMS, verifique o número digitado.";
      }
      else{
        showCupertinoModalBottomSheet(
            context: context,
            builder: (context) => VerificarCodigoModal(user: access_pass, listar: fowardListar)
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formkey,
          child: ListView(
            children: [

              const SizedBox(height: 40,),

              const Center(
                child: Text(
                  "Novo passe de acesso",
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontSize: 23
                  ),
                ),
              ),

              const SizedBox(height: 40,),

              InputTextoContraste(
                "E-mail ou telefone",
                controlador: _email,
                teclado: TextInputType.emailAddress,
                validator: (String? user){
                  return validaTelefoneEmail(user);
                },
              ),

              Text(_mensagemDeErro,
                style: const TextStyle(color: Colors.red),
              ),

              const SizedBox(height: 10,),

              BtnPrimary(
                "Enviar código",
                mostrar_progress: _mostrar_progress,
                ao_clicar: (){
                  enviarCodigo();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
