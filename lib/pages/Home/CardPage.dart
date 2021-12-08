import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shortlink/api/Pages/pages.dart';
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

  String _url_imagem_usuario = "";

  Future _trazerDetalhesPagina() async{
    var response = await Pages.detalharPagina(widget.id);

    if(response.ok == true){
      setState(() {
        if(response.body?["profile_image_url"] != "https://static.olhai.me/public/") _url_imagem_usuario = response.body?["profile_image_url"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _trazerDetalhesPagina();
  }

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
                  Expanded(
                    flex: 2,
                    child: _url_imagem_usuario == "" ?
                    const Center(
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 55,
                      ),
                    ) : Container(
                      height: 55,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            _url_imagem_usuario,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 8,
                    child: Column(
                        children: [
                          GestureDetector(
                            child: Text(
                              "@${widget.name}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      child: const Center(
                        child: Icon(
                          Icons.expand_more_outlined,
                          color: Colors.white,
                        ),
                      ),
                      onTap: (){
                        showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 36),
                              child: ListView(
                                children: [
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
                                    ],
                                  ),

                                  Row(
                                    children: [
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
                                    ],
                                  ),

                                  Row(
                                    children: [

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

                                    ],
                                  ),

                                  Row(
                                    children: [

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
                                  ),
                                ],
                              )
                            ),
                        );
                      },
                    ),
                  ),
                  ]
              ),
          ])
        ),
      ),
    );
  }
}
