import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shortlink/components/Button/BtnWhite.dart';

//components
import '../../components/Input/InputTexto.dart';
import '../../components/Button/BtnPrimary.dart';

//request
import 'package:shortlink/api/ResponseApi.dart';
import 'package:shortlink/api/Acessar/requisitarApi.dart';

//page
import 'package:shortlink/pages/VerificarCodigo/index.dart';

class FormularioCadastro extends StatefulWidget {
  const FormularioCadastro({required this.title});

  final String title;

  @override
  _FormularioCadastroState createState() => _FormularioCadastroState();
}

class _FormularioCadastroState extends State<FormularioCadastro> {
  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  bool _mostrar_progress = false;
  String _mensagemDeErro = "";

  bool validaEmail(String user) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(user);
  }

  bool validaTelefone(String user) {
    bool hasCharInvalid =
        RegExp(r'[a-zA-Z\u00C0-\u00FF\$\+\%\¨\& ]+', caseSensitive: false)
            .hasMatch(user);
    if (hasCharInvalid) {
      return false;
    }
    String telefone = user.replaceAll('(', '').replaceAll(')', '');

    return (telefone.length == 11);
  }

  String? validaTelefoneEmail(String? user) {
    if (user!.isEmpty)
      return "O campo é obrigatório";
    else if (!validaTelefone(user) && !validaEmail(user)) {
      return "E-mail ou telefone inválidos\nTelefone deve conter ddd (2 digitos) + 9 digitos";
    } else
      return null;
  }

  void realizarLogin(user, context) async {
    setState(() {
      _mostrar_progress = true;
      _mensagemDeErro = "";
    });

    String access_pass = user;
    if (validaTelefone(user)) {
      access_pass = "+55" + user.replaceAll('(', '').replaceAll(')', '');
    }

    ApiResponse response = await AcessoService.obterCodigoDeAcesso(access_pass);

    if (response.ok == false) {
      setState(() {
        _mensagemDeErro =
            "Não foi possível enviar o SMS, verifique o número digitado.";
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VerificarCodigo(title: widget.title, user: access_pass)));
    }

    setState(() {
      _mostrar_progress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: Container(
              child: Image.asset('assets/images/logo-Olhai-0.png'),
              width: 100,
              margin: const EdgeInsets.only(bottom: 10, top: 100),
            ),
          ),
          const Center(
            child: Text(
              'Olhai.me',
              style: TextStyle(fontSize: 40),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            child: InputTexto(
              'E-mail ou telefone',
              teclado: TextInputType.emailAddress,
              controlador: controlador1,
              validator: (String? user) {
                return validaTelefoneEmail(user);
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _mensagemDeErro,
            style: const TextStyle(color: Colors.red),
          ),
          BtnWhite(
            'Continuar',
            mostrar_progress: _mostrar_progress,
            ao_clicar: () {
              if (formkey.currentState?.validate() == true) {
                String user = controlador1.text;
                realizarLogin(user, context);
              }
            },
          )
        ],
      ),
    );
  }
}
