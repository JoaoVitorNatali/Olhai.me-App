import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../components/Input/InputTexto.dart';

class FormularioCadastro extends StatefulWidget {
  const FormularioCadastro();

  @override
  _FormularioCadastroState createState() => _FormularioCadastroState();
}

class _FormularioCadastroState extends State<FormularioCadastro> {

  final formkey = GlobalKey<FormState>();


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
                  teclado: TextInputType.emailAddress
              ),
            )
          ],
        ),
      ),
    );
  }
}
