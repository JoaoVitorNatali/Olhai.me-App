import 'package:flutter/material.dart';
import 'formulario.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.black,
            child: ListView(
              children: [
                FormularioCadastro(title: widget.title),
              ],
            )
        ),
      ),
    );
  }
}
