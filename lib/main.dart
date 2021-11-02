import 'package:flutter/material.dart';
import 'pages/Acessar/index.dart';
import 'pages/VerificarCodigo/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final title = "ShortLink";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/verificar-codigo',
      routes: {
        '/acesso': (context) => Cadastro(title: title),
        '/verificar-codigo': (context) => VerificarCodigo(
            title: title, user: 'joao.vitornatali0@gmail.com'
        ),
      },
    );
  }
}