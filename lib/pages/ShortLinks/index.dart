import 'package:flutter/material.dart';
import 'package:shortlink/components/Menu/index.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'novolink.dart';

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
      appBar: AppBar(title: Text('Minha coleção de links')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const NovoLink()
              ),
          );
        },
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(
                height: 20
            ),

            Text(
              'Não há nada por aqui no momento!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
