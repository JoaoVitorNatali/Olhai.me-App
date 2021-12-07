
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shortlink/api/Pages/editar.dart';

class EditarPagina extends StatefulWidget {
  const EditarPagina({Key? key, required this.nome, required this.id}) : super(key: key);
  final String nome;
  final String id;

  @override
  _EditarPaginaState createState() => _EditarPaginaState();
}

class _EditarPaginaState extends State<EditarPagina> {
  final formkey = GlobalKey<FormState>();

  _salvarFotoUsuario(XFile? image) async {
    if(image != null) {

      var response = await EditarPage.alterarImagem(widget.id, image);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Editar página')),
        body: Form(
          key: formkey,
          child: Container(
            color: Colors.black,
            child: ListView(
              children: [

                const SizedBox(height: 30,),

                const Center(
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 250,
                  ),
                ),


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




              ],
            ),
          ),
        )
    );
  }
}
