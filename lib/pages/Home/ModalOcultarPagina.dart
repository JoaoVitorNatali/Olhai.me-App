import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shortlink/components/Button/BtnDanger.dart';

import 'package:shortlink/api/Pages/pages.dart';

class ModalOcultarPagina extends StatefulWidget {
  const ModalOcultarPagina({Key? key, required this.id, required this.listar}) : super(key: key);
  final String id;
  final Function listar;

  @override
  _ModalOcultarPaginaState createState() => _ModalOcultarPaginaState();
}

class _ModalOcultarPaginaState extends State<ModalOcultarPagina> {

  bool _loader = false;

  ocultarPagina() async{
    setState(() {
      _loader = true;
    });
    var response = await Pages.ocultarPagina(widget.id);

    print(response.body.toString());

    setState(() {
      _loader = false;
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
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 40),

            const Text(
              'Deseja mesmo ocultar a página?',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            Center(
              child: BtnDanger('Confirmar', mostrar_progress: _loader, ao_clicar: (){
                ocultarPagina();
              }),
            ),

          ],
        ),
      ),
    );
  }
}
