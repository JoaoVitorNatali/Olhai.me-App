import 'package:flutter/material.dart';
import 'FormAlterarNome.dart';

class AlterarNome extends StatelessWidget {
  const AlterarNome({Key? key, required this.title, required this.token}) : super(key: key);
  final String title;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.black,
              child: Center(
                child: ListView(
                  children: [
                    const SizedBox(
                        height: 100
                    ),

                    const Center(
                      child: Text(
                        "Informe o nome que deseja ser chamado:",
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            overflow: TextOverflow.clip,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(
                        height: 60
                    ),

                    FormAlterarNome(token: token),
                  ]
                )
              )
          )
        )
    );
  }
}
