import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../components/Input/InputTexto.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../api/ResponseApi.dart';

class FormularioCadastro extends StatefulWidget {
  const FormularioCadastro();

  @override
  _FormularioCadastroState createState() => _FormularioCadastroState();
}

class _FormularioCadastroState extends State<FormularioCadastro> {

  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();

  bool validaEmail(String user){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(user);
  }

  bool validaTelefone(String user){
    bool hasCharInvalid = RegExp(r'[a-zA-Z\u00C0-\u00FF\$\+\%\¨\& ]+', caseSensitive: false).hasMatch(user);
    if(hasCharInvalid){
      return false;
    }
    String telefone = user.replaceAll('(', '').replaceAll(')', '');

    return (telefone.length == 11);
  }

  String? validaTelefoneEmail(String? user){
    if(user!.isEmpty) return "O campo é obrigatório";
    else if(!validaTelefone(user) && !validaEmail(user)){
      return "E-mail ou telefone inválidos\nTelefone deve conter ddd (2 digitos) + 9 digitos";
    }
    else return null;
  }

  static Future<ApiResponse<String>> obterCodigoDeAcesso(access_pass) async {
    try {
      String _url = "https://api.olhai.me/v1/verifications";
      Map params = {
        'access_pass': access_pass,
      };

      var body = json.encode(params);

      final _uri = Uri.parse(_url);
      var response = await http.post(
          _uri, body: body, headers: {"Content-Type": "application/json"});

      if(response.statusCode == 200) return ApiResponse.ok(response.body);
      return ApiResponse.error(response.body);
    }
    on Exception catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }

  void realizarLogin(user){
    String access_pass = user;
    if(validaTelefone(user)){
      access_pass = "+55" + user.replaceAll('(', '').replaceAll(')', '');
    }

    obterCodigoDeAcesso(access_pass);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/images/logo_login.png'),
              width: 100,
              margin: EdgeInsets.only(bottom: 100, top: 100),
            ),
            Container(
              alignment: Alignment.center,
              child: InputTexto(
                'E-mail ou telefone',
                teclado: TextInputType.emailAddress,
                controlador: controlador1,
                validator: (String? user){
                  return validaTelefoneEmail(user);
                },
              ),
            ),
            SizedBox(
              height: 20
            ),
            Center(
              child: ElevatedButton(
                child: Text('Continuar'),
                onPressed: (){
                  if(formkey.currentState?.validate() != null){
                    String user = controlador1.text;
                    realizarLogin(user);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
