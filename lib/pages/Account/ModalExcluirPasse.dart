import 'package:flutter/material.dart';
import 'package:shortlink/api/Usuario/Usuario.dart';
import 'package:shortlink/components/Button/BtnDanger.dart';

class ModalExcluirPasse extends StatefulWidget {
  const ModalExcluirPasse({Key? key, required this.pass, required this.listar}) : super(key: key);
  final String pass;
  final Function listar;

  @override
  _ModalExcluirPasseState createState() => _ModalExcluirPasseState();
}

class _ModalExcluirPasseState extends State<ModalExcluirPasse> {
  bool _mostra_progress = false;

  excluirPasse() async {
    setState(() {
      _mostra_progress = true;
    });
    var response = await User.excluirPasse(widget.pass);

    setState(() {
      _mostra_progress = false;
      if(response.ok == true){
        widget.listar();
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:46, horizontal: 16),
        child: ListView(

          children: [
            const Center(
              child: Text('Tem certeza que deseja excluir:', style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 18,
              ),),
            ),

            const SizedBox(height: 28,),

            Center(
              child: Text(
                widget.pass,
                style: const TextStyle(
                  color: Colors.purple,
                  decoration: TextDecoration.none,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 28,),

            Center(
              child: BtnDanger(
                "Confirmar",
                mostrar_progress: _mostra_progress,
                ao_clicar: (){
                  excluirPasse();
                },
              ),
            )

          ]
        ),
      ),
    );
  }
}
