import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shortlink/pages/Acessar/index.dart';
import 'package:shortlink/preferences/User.dart';
import 'package:shortlink/routes/index.dart';

class TelaAbertura extends StatefulWidget {
  const TelaAbertura({Key? key}) : super(key: key);

  @override
  _TelaAberturaState createState() => _TelaAberturaState();
}

class _TelaAberturaState extends State<TelaAbertura> {
  void iniciarAplicacao(){

    Future<Map?> usuario = Usuario.obter();
    
    usuario.then((value) => {
      if(value?["token"] != null){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => const Routes())
        )
      }
      else{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const Cadastro(title: 'Olhai.me'))
        )
      }
    });
  }

  @override
  void initState(){
    super.initState();
    iniciarAplicacao();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
