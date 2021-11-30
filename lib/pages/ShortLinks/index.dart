import 'package:flutter/material.dart';
import 'package:shortlink/components/Menu/index.dart';

class ShortLinks extends StatefulWidget {
  const ShortLinks({Key? key}) : super(key: key);

  @override
  _ShortLinksState createState() => _ShortLinksState();
}

class _ShortLinksState extends State<ShortLinks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(),
      body: Center(

      ),
    );
  }
}
