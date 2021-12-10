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

  Future<Map?>? user;

  Future<Map?> iniciarAplicacao() async{

    return Usuario.obter();


    // if(usuario?["token"] != null){
    //   Navigator.pushReplacement(context,
    //       MaterialPageRoute(builder: (BuildContext context) => const Routes())
    //   );
    // }
    // else{
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (BuildContext context) => const Cadastro(title: 'Olhai.me'))
    //   );
    // }

  }

  @override
  void initState(){
    super.initState();
    user = iniciarAplicacao();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user,
      builder: (context, AsyncSnapshot snapshot){
        if(!(snapshot.connectionState == ConnectionState.waiting)){
          if(snapshot.data?["token"] != null){
            return const Routes();
          }
          return const Cadastro(title: 'Olhai.me');
        }
        else{
          return Container(
            color: const Color(0xff5c5cb1),
          );
        }
      }
    );
  }
}
