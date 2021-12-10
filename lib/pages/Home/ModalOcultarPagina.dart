import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shortlink/components/Button/BtnDanger.dart';

import 'package:shortlink/api/Pages/pages.dart';

class ModalOcultarPagina extends StatefulWidget {
  const ModalOcultarPagina(
      {Key? key, required this.id, required this.listar, required this.status})
      : super(key: key);
  final String id;
  final Function listar;
  final String status;

  @override
  _ModalOcultarPaginaState createState() => _ModalOcultarPaginaState();
}

class _ModalOcultarPaginaState extends State<ModalOcultarPagina> {
  bool _loader = false;
  String _texto = "";

  ocultarPagina() async {
    setState(() {
      _loader = true;
    });
    String _status_oposto = widget.status == "pub" ? "pri" : "pub";
    var response = await Pages.ocultarPagina(widget.id, _status_oposto);

    setState(() {
      _loader = false;
      if (response.ok == true) {
        widget.listar();
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.status == "pub")
        _texto = "ocultar";
      else
        _texto = "publicar";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Text(
              'Deseja mesmo $_texto a página?',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            BtnDanger('Confirmar', mostrar_progress: _loader, ao_clicar: () {
              ocultarPagina();
            }),
          ],
        ),
      ),
    );
  }
}
