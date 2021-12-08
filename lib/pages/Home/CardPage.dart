import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shortlink/components/Button/BtnHibrido.dart';
import 'package:shortlink/components/Modal/CompartilharLink.dart';
import 'package:shortlink/pages/EditarPagina/index.dart';
import 'package:shortlink/pages/Home/ModalEstatisticasPage.dart';
import 'package:shortlink/pages/Home/ModalOcultarPagina.dart';
import 'package:shortlink/pages/Home/WebViewPage.dart';

import '../../components/Button/BtnDanger.dart';
import '../../components/Button/BtnPrimary.dart';
import 'ModalExcluirPagina.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key, required this.id, required this.name, required this.listar, required this.status}) : super(key: key);

  final String id;
  final String name;
  final Function listar;
  final String status;

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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                      children: [
                        GestureDetector(
                          child: Text(
                            "@${widget.name}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ]),
                  ]
              ),

              const SizedBox(height: 30,),

              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      child:
                        BtnPrimary("Visitar", ao_clicar: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => WebViewPage(link: "https://${widget.name}.olhai.me")
                            ),
                          );
                        }),

                    ),
                  ),

                  const SizedBox(width: 10,),

                  Expanded(
                    flex: 6,
                    child: Container(
                      child:
                        BtnPrimary("Compartilhar", ao_clicar: (){
                          showCupertinoModalBottomSheet(
                              context: context,
                              builder: (context) => Scaffold(
                                body: CompartilharLink(title: widget.name, compartilhar: "go.olhai.me/${widget.name}"),
                              )
                          );
                        }),

                    ),
                  ),
                ],
              ),

              Row(
                children: [

                  Expanded(
                    flex: 6,
                    child: Container(
                      child: BtnPrimary("Estatísticas", ao_clicar: (){
                        showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => ModalEstatisticasPage(id: widget.id)
                        );
                      }),
                    ),
                  ),

                  const SizedBox(width: 10,),

                  Expanded(
                    flex: 6,
                    child: Container(
                      child: BtnPrimary("Editar", ao_clicar: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => EditarPagina(nome: widget.name, id: widget.id)
                          ),
                        );
                      }),
                    ),
                  ),


                ],
              ),

              Row(
                children: [

                  Expanded(
                    flex: 6,
                    child: Container(
                      child: BtnDanger("Excluir", ao_clicar: (){
                        showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => ModalExcluirPagina(id: widget.id, listar: widget.listar)
                        );
                      }),
                    ),
                  ),

                  const SizedBox(width: 10,),

                  Expanded(
                    flex: 6,
                    child: Container(
                      child: BtnHibrido(
                        widget.status == "pub" ? "Ocultar" : "Publicar",
                        color: widget.status == "pub" ? Colors.red : Colors.blueAccent,
                        ao_clicar: (){
                        showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => ModalOcultarPagina(id: widget.id, listar: widget.listar, status: widget.status)
                        );
                      }),
                    ),
                  ),


                ],
              )
          ])
        ),
      ),
    );
  }
}
