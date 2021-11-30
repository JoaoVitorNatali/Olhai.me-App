import 'package:flutter/material.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';


class NovoLink extends StatefulWidget {
  const NovoLink({Key? key}) : super(key: key);

  @override
  _NovoLinkState createState() => _NovoLinkState();
}

class _NovoLinkState extends State<NovoLink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar link')),
      body: Center(
        child: Container(
          color: Colors.black,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [

              SizedBox(
                  height: 20
              ),


              InputTexto('Chave...'),

              InputTexto('URL...'),

              SizedBox(
                  height: 10
              ),

              BtnPrimary(
                'Encurtar link',
                ao_clicar: (){

                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
