import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortlink/components/Menu/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(title: Text('Home'),),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.black,
        child: ListView(
          children: [

            SizedBox(
                height: 20
            ),

            Text(
              'Minhas páginas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            )
          ],
        ),
      ),
    );
  }
}
