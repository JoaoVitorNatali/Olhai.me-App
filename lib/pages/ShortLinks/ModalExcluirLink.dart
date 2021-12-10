import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shortlink/components/Button/BtnDanger.dart';
import 'package:shortlink/api/ShortLink/link.dart';

class ModalExcluirLink extends StatefulWidget {
  const ModalExcluirLink({Key? key, required this.id, required this.listar})
      : super(key: key);
  final String id;
  final Function listar;

  @override
  _ModalExcluirLinkState createState() => _ModalExcluirLinkState();
}

class _ModalExcluirLinkState extends State<ModalExcluirLink> {
  bool _loader_excluir = false;

  excluirLink() async {
    setState(() {
      _loader_excluir = true;
    });
    var response = await ShortLink.excluirLink(widget.id);

    setState(() {
      _loader_excluir = false;
      if (response.ok == true) {
        widget.listar();
        Navigator.pop(context);
      }
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
            BtnDanger('Confirmar', mostrar_progress: _loader_excluir,
                ao_clicar: () {
              excluirLink();
            }),
          ],
        ),
      ),
    );
  }
}
