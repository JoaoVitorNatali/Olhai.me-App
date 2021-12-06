import 'package:flutter/material.dart';

class EditarPagina extends StatefulWidget {
  const EditarPagina({Key? key, required this.nome}) : super(key: key);
  final String nome;

  @override
  _EditarPaginaState createState() => _EditarPaginaState();
}

class _EditarPaginaState extends State<EditarPagina> {
  final formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Editar página')),
        body: Form(
          key: formkey,
          child: Container(
            color: Colors.black,
            child: ListView(
              children: [
                Center(
                  
                )
              ],
            ),
          ),
        )
    );
  }
}
