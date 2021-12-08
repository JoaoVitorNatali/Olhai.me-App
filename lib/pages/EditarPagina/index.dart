
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shortlink/api/Pages/pages.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/components/Input/InputTexto.dart';

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
    var response = await Pages.detalharPagina(widget.id);

    if(response.ok == true){
      setState(() {
        if(response.body?["description"] != "") _descricao.text = response.body?["description"];

        if(response.body?["name"] != "") _nome_pagina.text = response.body?["name"];

        if(response.body?["location"] != "") _localizacao.text = response.body?["location"];

        if(response.body?["profile_image_url"] != "") _url_imagem_usuario = response.body?["profile_image_url"];
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
              color: Colors.black87,
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
                                  child: const Icon(Icons.add_a_photo_outlined),
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
                                  child: const Icon(Icons.image_search_outlined),
                                  onPressed: () async {
                                    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
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

                  BtnPrimary(
                    "Salvar",
                    mostrar_progress: _load,
                    ao_clicar: (){
                      if(formkey.currentState?.validate() == true){
                        _atualizarDados();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
