import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shortlink/components/Modal/CompartilharLink.dart';

import '../../components/Button/BtnDanger.dart';
import '../../components/Button/BtnPrimary.dart';
import 'ModalExcluirPagina.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key, required this.id, required this.name, required this.listar}) : super(key: key);

  final String id;
  final String name;
  final Function listar;

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text(
                        "@${widget.name}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                )
              ),


              Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            BtnPrimary("Compartilhar", ao_clicar: (){
                              showCupertinoModalBottomSheet(
                                  context: context,
                                  builder: (context) => Scaffold(
                                    body: CompartilharLink(title: widget.name, compartilhar: "go.olhai.me/${widget.name}"),
                                  )
                              );
                            }),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                BtnDanger("Excluir", ao_clicar: (){
                                  showCupertinoModalBottomSheet(
                                      context: context,
                                      builder: (context) => ModalExcluirPagina(id: widget.id, listar: widget.listar)
                                  );
                                }),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ),




            ],
          ),
        ),
      ),
    );
  }
}
