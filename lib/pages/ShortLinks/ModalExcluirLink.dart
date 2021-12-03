import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shortlink/components/Button/BtnDanger.dart';
import 'package:shortlink/api/ShortLink/link.dart';

class ModalExcluirLink extends StatefulWidget {
  const ModalExcluirLink({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _ModalExcluirLinkState createState() => _ModalExcluirLinkState();
}

class _ModalExcluirLinkState extends State<ModalExcluirLink> {

  excluirLink() async{
    var response = await ShortLink.excluirLink(widget.id);

    if(response.ok == true){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 40),

            const Text(
              'Deseja mesmo continuar com a exclusão do link?',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            Center(
              child: BtnDanger('Confirmar', ao_clicar: (){
                excluirLink();
              }),
            ),

          ],
        ),
      ),
    );
  }
}