import 'package:flutter/material.dart';
import 'package:shortlink/api/Shortcut/shortcut.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/components/Input/InputTextoContraste.dart';

class AdicionarRede extends StatefulWidget {
  const AdicionarRede({Key? key, required this.id, required this.listar}) : super(key: key);
  final String id;
  final Function listar;

  @override
  _AdicionarRedeState createState() => _AdicionarRedeState();
}

class _AdicionarRedeState extends State<AdicionarRede> {
  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  String dropdownValue = 'Selecione';
  bool _loadAdicionarCut = false;
  String _mensagem_de_erro = "";

  bool isUrl(url){
    if(url.contains('www.') || url.contains('http://') || url.contains('https://')){
      return true;
    }
    else{
      return false;
    }
  }

  String formatUrl(name, rede){
    if(isUrl(name) == true) return name;
    else{
      if(rede == "linkedin") return "https://www.linkedin.com/in/$name";
      return "https://$rede.com/$name";
    }
  }


  String getTitle(String palavra) {
    String inicial = palavra.substring(0,1).toUpperCase();
    String fim = palavra.substring(1);
    return "$inicial$fim";
  }

  criarShortCut() async{

    setState(() {
      _loadAdicionarCut = true;
      _mensagem_de_erro = "";
    });

    if(controlador1.text == "" || dropdownValue == "Selecione"){
      setState(() {
        _mensagem_de_erro = "Digite seu username e selecione uma rede social";
      });
      return;
    }

    String url = formatUrl(controlador1.text, dropdownValue);

    var response = await Shortcut.criarShortcut(dropdownValue, widget.id, getTitle(dropdownValue), url);

    if(response.ok == true){
      widget.listar();
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 26),
        child: Form(
          key: formkey,
          child: ListView(
            children: [

              const Text(
                "Selecione uma rede social",
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 23
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40,),

              InputTextoContraste(
                "Username ou link completo",
                max_length: 120,
                controlador: controlador1,
              ),

              const SizedBox(height: 20,),

              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 26,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22
                ),

                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Selecione', 'facebook', 'instagram', 'github', 'youtube', 'linkedin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20,),

              BtnPrimary(
                "Adicionar",
                mostrar_progress: _loadAdicionarCut,
                ao_clicar: (){
                  criarShortCut();
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
