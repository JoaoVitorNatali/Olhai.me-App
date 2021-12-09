import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortlink/api/Pages/pages.dart';
import 'package:shortlink/components/Menu/index.dart';
import 'package:shortlink/pages/Home/NovaPagina.dart';

import 'CardPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _nenhum_link = false;
  bool _loader_links = true;

  List<dynamic>? paginas;

  Future listarPaginas() async{

    var response = await Pages.listarPaginas();

    setState(() {
      _loader_links = false;
      if(response != null) {
        if (response.length == 0) {
          _nenhum_link = true;
        }
        else {
          _nenhum_link = false;
          paginas = response.toList();
        }
      }
      else{
        _nenhum_link = true;
      }
    });

  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _loader_links = true;
    });
    listarPaginas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(title: const Text('Listagem de páginas'),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const NovaPagina()
            ),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: listarPaginas,
        child: Container(
          padding: const EdgeInsets.all(16),

          child: ListView(
            children: [

              const SizedBox(
                  height: 20
              ),

              !_loader_links ? (

                  _nenhum_link ? const Text(
                    'Nenhuma página por enquanto:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ) : ListView.builder(
                      itemCount: paginas != null ? paginas!.length : 0,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index){
                        return CardPage(
                          id: paginas![index]["id"].toString(),
                          name: paginas![index]["name"].toString(),
                          status: paginas![index]["status"].toString(),
                          listar: listarPaginas
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
      ),
    );
  }
}
