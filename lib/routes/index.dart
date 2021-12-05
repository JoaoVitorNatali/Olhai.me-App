import 'package:flutter/material.dart';

//routes
import 'package:shortlink/pages/Home/index.dart';
import 'package:shortlink/pages/ShortLinks/index.dart';
import 'package:shortlink/pages/Logout/index.dart';


class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key );

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  final title = "ShortLink";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/shortlinks': (context) => ShortLinksPage(),
        '/logout': (context) => Logout(),
      },
    );
  }
}
