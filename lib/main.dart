import 'package:flutter/material.dart';

//routes
import 'pages/Acessar/index.dart';
import 'pages/Home/index.dart';
import 'pages/ShortLinks/index.dart';

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
      initialRoute: '/',
      routes: {
        '/acesso': (context) => Cadastro(title: title),
        '/': (context) => HomePage(),
        '/shortlinks': (context) => ShortLinks(),
      },
    );
  }
}