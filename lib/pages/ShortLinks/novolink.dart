import 'package:flutter/material.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';


class NovoLink extends StatefulWidget {
  const NovoLink({Key? key}) : super(key: key);

  @override
  _NovoLinkState createState() => _NovoLinkState();
}

class _NovoLinkState extends State<NovoLink> {
  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  final controlador2 = TextEditingController();
  bool _mostrar_progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar link')),
      body: Form(
        key: formkey,
        child: Center(
          child: Container(
            color: Colors.black,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                const SizedBox(
                    height: 20
                ),


                InputTexto(
                  'Chave...',
                  controlador: controlador1,
                ),

                InputTexto(
                  'URL...',
                  controlador: controlador2,
                ),

                const SizedBox(
                    height: 10
                ),

                BtnPrimary(
                  'Encurtar link',
                  ao_clicar: (){
                    if(formkey.currentState?.validate() == true){

                    }
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
