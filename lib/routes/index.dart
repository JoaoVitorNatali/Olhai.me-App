import 'package:flutter/material.dart';

//routes
import 'package:shortlink/pages/Home/index.dart';
import 'package:shortlink/pages/ShortLinks/index.dart';
import 'package:shortlink/pages/Logout/index.dart';
import 'package:shortlink/pages/Account/index.dart';


class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key );

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  final title = "ShortLink";

  Map<int, Color> color =
  {
    50:const Color.fromRGBO(136,14,79, .1),
    100:const Color.fromRGBO(136,14,79, .2),
    200:const Color.fromRGBO(136,14,79, .3),
    300:const Color.fromRGBO(136,14,79, .4),
    400:const Color.fromRGBO(136,14,79, .5),
    500:const Color.fromRGBO(136,14,79, .6),
    600:const Color.fromRGBO(136,14,79, .7),
    700:const Color.fromRGBO(136,14,79, .8),
    800:const Color.fromRGBO(136,14,79, .9),
    900:const Color.fromRGBO(136,14,79, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: MaterialColor(0x64518900FF, color),
          focusColor: MaterialColor(0x64518900aa, color),
          hoverColor: MaterialColor(0x64518900aa, color),
          foregroundColor: MaterialColor(0x64518900aa, color),
          splashColor: Colors.white,
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/shortlinks': (context) => const ShortLinksPage(),
        '/logout': (context) => const Logout(),
        '/account': (context) => const Account(),
      },
    );
  }
}
