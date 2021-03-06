import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shortlink/api/Pages/pages.dart';
import 'package:shortlink/components/Button/BtnHibrido.dart';
import 'package:shortlink/components/Modal/CompartilharLink.dart';
import 'package:shortlink/constants/constants.dart';
import 'package:shortlink/pages/EditarPagina/index.dart';
import 'package:shortlink/pages/Home/ModalEstatisticasPage.dart';
import 'package:shortlink/pages/Home/ModalOcultarPagina.dart';
import 'package:shortlink/pages/Home/WebViewPage.dart';

import '../../components/Button/BtnDanger.dart';
import '../../components/Button/BtnPrimary.dart';
import 'ModalExcluirPagina.dart';

class CardPage extends StatefulWidget {
  const CardPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.listar,
      required this.status})
      : super(key: key);

  final String id;
  final String name;
  final Function listar;
  final String status;

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  String _url_imagem_usuario = "";

  Future _trazerDetalhesPagina() async {
    var response = await Pages.detalharPagina(widget.id);

    if (response.ok == true) {
      setState(() {
        if (response.body?["profile_image_url"] !=
            "https://static.olhai.me/public/")
          _url_imagem_usuario = response.body?["profile_image_url"];
      });
    }
  }

  voltarPaginaPosModal() async {
    widget.listar();
    Navigator.pop(context);
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius)),
        color: Colors.black,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Row(children: [
                Expanded(
                  flex: 2,
                  child: _url_imagem_usuario == ""
                      ? const Center(
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 55,
                          ),
                        )
                      : Container(
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
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "@${widget.name}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 23),
                        ),
                      ),
                    )
                  ]),
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
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.6,
                            padding: const EdgeInsets.only(
                                top: 36, left: 20, right: 20, bottom: 20),
                            child: ListView(
                              children: [
                                Visibility(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              child: BtnPrimary("Visitar",
                                                  ao_clicar: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          WebViewPage(
                                                              link:
                                                                  "https://${widget.name}.olhai.me")),
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              child: BtnPrimary("Compartilhar",
                                                  ao_clicar: () {
                                                showCupertinoModalBottomSheet(
                                                  context: context,
                                                  builder: (context) =>
                                                      CompartilharLink(
                                                          title: widget.name,
                                                          compartilhar:
                                                              "https://${widget.name}.olhai.me"),
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  visible: widget.status != "pri",
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        child: BtnPrimary("Estat??sticas",
                                            ao_clicar: () {
                                          showCupertinoModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  ModalEstatisticasPage(
                                                      id: widget.id));
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        child:
                                            BtnPrimary("Editar", ao_clicar: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        EditarPagina(
                                                            nome: widget.name,
                                                            id: widget.id)),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        child:
                                            BtnDanger("Excluir", ao_clicar: () {
                                          showCupertinoModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  ModalExcluirPagina(
                                                      id: widget.id,
                                                      listar:
                                                          voltarPaginaPosModal));
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        child: BtnHibrido(
                                            widget.status == "pub"
                                                ? "Ocultar"
                                                : "Publicar",
                                            color: widget.status == "pub"
                                                ? Colors.red
                                                : Colors.blueAccent,
                                            ao_clicar: () {
                                          showCupertinoModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  ModalOcultarPagina(
                                                      id: widget.id,
                                                      listar:
                                                          voltarPaginaPosModal,
                                                      status: widget.status));
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ),
              ]),
            ])),
      ),
    );
  }
}
