import 'package:flutter/material.dart';
import 'contador.dart';

import 'package:shortlink/components/Input/InputTexto.dart';

class VerificarCodigo extends StatefulWidget {
  const VerificarCodigo({Key? key, required this.title, required this.user}) : super(key: key);
  final String title;
  final String user;

  @override
  _VerificarCodigoState createState() => _VerificarCodigoState();
}

class _VerificarCodigoState extends State<VerificarCodigo> {

  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();

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
            child: Center(
              child: ListView(
                children: [

                  SizedBox(
                      height: 100
                  ),

                  Center(
                    child: Text(
                      'Informe o último código enviado para',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          overflow: TextOverflow.clip
                      ),
                    ),
                  ),

                  SizedBox(
                      height: 20
                  ),

                  Center(
                    child: Text(
                      "${widget.user}",
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          overflow: TextOverflow.clip
                      ),
                    ),
                  ),

                  SizedBox(
                      height: 60
                  ),

                  Form(
                    key:formkey,
                    child: Column(
                      children: [
                        InputTexto(
                          'Código',
                          teclado: TextInputType.number,
                          max_length: 6,
                          controlador: controlador1,
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                      height: 60
                  ),

                  Center(
                    child: Contador(user: widget.user),
                  ),

                ],
              ),
            )
        ),
      ),
    );
  }
}