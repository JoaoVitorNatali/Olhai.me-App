import 'package:flutter/material.dart';
import 'FormAlterarNome.dart';

class AlterarNome extends StatelessWidget {
  const AlterarNome({Key? key, required this.title}) : super(key: key);
  final String title;

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
                    SizedBox(
                        height: 100
                    ),

                    Center(
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

                    SizedBox(
                        height: 60
                    ),

                    FormAlterarNome(),
                    ]
                )
              )
          )
        )
    );
  }
}
