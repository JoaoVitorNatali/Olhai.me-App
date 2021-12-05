import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shortlink/components/Menu/index.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'novolink.dart';
import 'package:shortlink/api/ShortLink/link.dart';
import 'CardLink.dart';

class ShortLinksPage extends StatefulWidget {
  const ShortLinksPage({Key? key}) : super(key: key);

  @override
  _ShortLinksState createState() => _ShortLinksState();
}

class _ShortLinksState extends State<ShortLinksPage> {
  bool _nenhum_link = true;
  bool _loader_links = true;
  List<dynamic>? colecao;

  listarColecao() async{

    setState(() {
      _loader_links = true;
    });

    var response = await ShortLink.listarLinks();

    setState(() {
      _loader_links = false;
      colecao = response;
      if(colecao!.length > 0){
        _nenhum_link = false;
      } else {
        _nenhum_link = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listarColecao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(title: const Text('Minha coleção de links')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const NovoLink()
              ),
          );
        },
      ),
      body: Container(
        color: Colors.black87,
        child: ListView(
          padding: const EdgeInsets.all(16),
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
                height: 20
            ),

            !_loader_links ? (

              _nenhum_link ? const Text(
                'Não há nada por aqui no momento!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ) : ListView.builder(
                    itemCount: colecao != null ? colecao!.length : 0,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index){
                      return CardLink(
                        id: colecao![index]["id"].toString(),
                        name: colecao![index]["name"].toString(),
                        url: colecao![index]["url"].toString(),
                        listar: listarColecao,
                      );
                    }
                )
            ) : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
            )
          ],
        ),
      ),
    );
  }
}
