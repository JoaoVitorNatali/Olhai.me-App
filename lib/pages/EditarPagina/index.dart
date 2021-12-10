
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shortlink/api/Pages/pages.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/pages/EditarPagina/AdicionarItem.dart';
import 'package:shortlink/pages/EditarPagina/AdicionarRede.dart';
import 'package:shortlink/pages/EditarPagina/CardItems.dart';
import 'package:shortlink/pages/EditarPagina/CardShortCut.dart';

class EditarPagina extends StatefulWidget {
  const EditarPagina({Key? key, required this.nome, required this.id}) : super(key: key);
  final String nome;
  final String id;

  @override
  _EditarPaginaState createState() => _EditarPaginaState();
}

class _EditarPaginaState extends State<EditarPagina> {
  final formkey = GlobalKey<FormState>();
  final _nome_pagina = TextEditingController();
  final _localizacao = TextEditingController();
  final _descricao = TextEditingController();
  bool _load = false;
  bool _load_items = false;
  bool _loadNovoItem = false;
  bool _load_redes_sociais = false;
  bool _loadNovaRede = false;

  List<dynamic>? shortcuts;
  List<dynamic>? items;

  String _url_imagem_usuario = "";

  _salvarFotoUsuario(XFile? image) async {
    if(image != null) {

      var response = await Pages.alterarImagem(widget.id, image);
      var data = json.decode(response.toString());

      if(response.statusCode == 200){
        setState(() {
          if(data?["path"] != ""){
            _url_imagem_usuario = data?["path"];
          }
        });
      }
    }
  }

  _atualizarDados() async {
    setState(() {
      _load = true;
    });
    var response = await Pages.atualizarDados(widget.id, _nome_pagina.text, _localizacao.text, _descricao.text);
    setState(() {
      _load = false;
    });
  }

  Future _trazerDetalhesPagina() async{
    setState(() {
      _load_redes_sociais = true;
      _load_items = true;
    });
    var dataRequisicao = await Pages.detalharPagina(widget.id);
    Map? response = json.decode(utf8.decode(dataRequisicao.response!.bodyBytes));

    setState(() {
      _load_redes_sociais = false;
      _load_items = false;
    });

    if(dataRequisicao.ok == true){
      setState(() {
        if(response?["description"] != "") _descricao.text = response?["description"];

        if(response?["name"] != "") _nome_pagina.text = response?["name"];

        if(response?["location"] != "") _localizacao.text = response?["location"];

        if(response?["profile_image_url"] != "https://static.olhai.me/public/") _url_imagem_usuario = response?["profile_image_url"];

        if(response?["shortcuts"] != null) shortcuts = response?["shortcuts"];

        if(response?["items"] != null) items = response?["items"];
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
    return Scaffold(
        appBar: AppBar(title: const Text('Editar página')),
        body: RefreshIndicator(
          onRefresh: _trazerDetalhesPagina,
          child: Form(
            key: formkey,
            child: Container(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [

                  const SizedBox(height: 30,),

                  _url_imagem_usuario == "" ?
                  const Center(
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 250,
                    ),
                  ) : Container(
                    height: 250,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.network(
                            _url_imagem_usuario,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Column(
                              children: [
                                FloatingActionButton(
                                  heroTag: "BotaoCamera",
                                  child: const Icon(Icons.add_a_photo_outlined, color: Colors.white,),
                                  onPressed: () async {
                                    var image = await ImagePicker().pickImage(
                                        source: ImageSource.camera, imageQuality: 5, maxWidth: 334, maxHeight: 334
                                    );
                                    _salvarFotoUsuario(image);
                                  },
                                ),
                              ]
                          )
                      ),

                      const SizedBox(width: 20,),

                      Center(
                          child: Column(
                              children: [
                                FloatingActionButton(
                                  heroTag: "BotaoGaleria",
                                  child: const Icon(Icons.image_search_outlined, color: Colors.white,),
                                  onPressed: () async {
                                    var image = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 100
                                    );
                                    _salvarFotoUsuario(image);
                                  },
                                ),
                              ]
                          )
                      ),
                    ],
                  ),

                  const SizedBox(height: 25,),

                  InputTexto(
                    "Nome da página",
                    controlador: _nome_pagina,
                    validar: false,
                  ),

                  InputTexto(
                    "Localização",
                    controlador: _localizacao,
                    validar: false,
                  ),

                  InputTexto(
                    "Descrição",
                    controlador: _descricao,
                    max_lines: 8,
                    max_length: 200,
                    validar: false,
                  ),

                  const SizedBox(height: 14,),

                  BtnPrimary(
                    "Salvar",
                    mostrar_progress: _load,
                    ao_clicar: (){
                      if(formkey.currentState?.validate() == true){
                        _atualizarDados();
                      }
                    },
                  ),

                  const SizedBox(height: 38,),

                  _load_redes_sociais ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ) : Container(
                    child: shortcuts == null || shortcuts?.length == 0 ? const Center(
                      child: Text(
                        "Você não possue nenhuma rede social adicionada!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ) : ListView.builder(
                        itemCount: shortcuts != null ? shortcuts!.length : 0,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index){
                          return CardShortCut(
                              id: shortcuts![index]["id"].toString(),
                              page_id: shortcuts![index]["page_id"].toString(),
                              name: shortcuts![index]["name"].toString(),
                              url: shortcuts![index]["url"].toString(),
                              listar: _trazerDetalhesPagina
                          );
                        }
                    ),
                  ),

                  const SizedBox(height: 20,),

                  BtnPrimary(
                    "Adicionar rede",
                    mostrar_progress: _loadNovaRede,
                    ao_clicar: (){
                      showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            color: Colors.white,
                            child: AdicionarRede(id: widget.id, listar: _trazerDetalhesPagina),
                          )
                      );
                    },
                  ),

                  const SizedBox(height: 38,),



                  _load_items ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ) : Container(
                    child: items == null || items?.length == 0 ? const Center(
                      child: Text(
                        "Você não possue nenhum item!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ) : ListView.builder(
                        itemCount: items != null ? items!.length : 0,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index){
                          return CardItems(
                              id: items![index]["id"].toString(),
                              page_id: items![index]["page_id"].toString(),
                              name: items![index]["title"].toString(),
                              url: items![index]["content"].toString(),
                              listar: _trazerDetalhesPagina
                          );
                        }
                    ),
                  ),

                  const SizedBox(height: 20,),

                  BtnPrimary(
                    "Adicionar Item",
                    mostrar_progress: _loadNovoItem,
                    ao_clicar: (){
                      showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            color: Colors.white,
                            child: AdicionarItem(id: widget.id, listar: _trazerDetalhesPagina),
                          )
                      );
                    },
                  ),

                  const SizedBox(height: 38,),
                ],
              ),
            ),
          ),
        )
    );
  }
}
