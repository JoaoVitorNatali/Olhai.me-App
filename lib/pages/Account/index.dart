import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shortlink/api/Usuario/Usuario.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/components/Input/InputTexto.dart';
import 'package:shortlink/components/Menu/index.dart';
import 'package:shortlink/pages/Account/CardPasses.dart';
import 'package:shortlink/pages/Account/ModalAdicionarPasse.dart';
import 'package:shortlink/preferences/User.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  bool _mostrar_progress = false;
  bool _loadPasses = false;
  List<dynamic>? passes = null;

  Future listarPasses() async {
    var response = await User.listarPasses();

    setState(() {
      _loadPasses = false;
      passes = response;
    });
  }

  _setar_mudancas_usuario(nome) async {
    Map? usuario = await Usuario.obter();

    usuario?["user"]?["name"] = nome;
    
    Usuario.salvar(usuario);
  }

  atualizarNomeUsuario(nomeUsuario) async {

    setState(() {
      _mostrar_progress = true;
    });

    var response = await User.alterarNome(nomeUsuario);

    setState(() {
      _mostrar_progress = false;
      if(response.ok == true) _setar_mudancas_usuario(nomeUsuario);
    });
  }

  obterUsuario() async {
    Map? usuario = await Usuario.obter();
    controlador1.text = usuario!["user"]["name"].toString();
  }

  foreignListar(){
    setState(() {
      _loadPasses = true;
      listarPasses();
    });
  }

  @override
  void initState() {
    super.initState();
    obterUsuario();
    foreignListar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(title: const Text('Minha conta')),
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: RefreshIndicator(
            onRefresh: listarPasses,
            child: ListView(
              children: [

                InputTexto(
                  "Alterar nome",
                  controlador: controlador1,
                ),

                const SizedBox(height: 15,),

                BtnPrimary(
                    "Atualizar",
                    mostrar_progress: _mostrar_progress,
                    ao_clicar: (){
                      if(formkey.currentState?.validate() == true){
                        atualizarNomeUsuario(controlador1.text);
                      }
                    }
                ),


                const SizedBox(height: 40,),

                const Center(
                  child: Text(
                    "Meus passes de acesso",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                    ),
                  ),
                ),

                const SizedBox(height: 20,),


                !_loadPasses ?
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: passes != null ? passes?.length : 0,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index){
                      return CardPasses(
                        id: passes![index]["id"].toString(),
                        pass: passes![index]["pass"].toString(),
                        listar: foreignListar,
                      );
                    }
                ) : const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                ),


                
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: BtnPrimary(
                    "Adicionar passe de acesso",
                    ao_clicar: (){
                      showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => ModalAdicionarPasse(listar: listarPasses)
                      );
                    },
                  ),
                ),

              ]
            ),
          ),
        ),
      ),
    );
  }
}
