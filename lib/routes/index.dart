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
        primarySwatch: MaterialColor(0xff5c5cb1, color),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: MaterialColor(0x885c5cb1, color),
          backgroundColor: MaterialColor(0xff5c5cb1, color),
          hoverColor: MaterialColor(0x005c5cb1, color),
          extendedTextStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
          ),
        ),
        primaryIconTheme: const IconThemeData(
          color: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xff181818),
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
