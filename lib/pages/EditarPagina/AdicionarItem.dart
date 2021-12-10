import 'package:flutter/material.dart';
import 'package:shortlink/api/Items/items.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/components/Input/InputTextoContraste.dart';

class Item{
  const Item(this.value, this.name);
  final String value;
  final String name;
}

class Cor{
  const Cor(this.value, this.name);
  final String value;
  final String name;
}

class AdicionarItem extends StatefulWidget {
  const AdicionarItem({Key? key, required this.id, required this.listar}) : super(key: key);
  final String id;
  final Function listar;

  @override
  _AdicionarItemState createState() => _AdicionarItemState();
}

class _AdicionarItemState extends State<AdicionarItem> {

  final formkey = GlobalKey<FormState>();
  final controlador1 = TextEditingController();
  final controlador2 = TextEditingController();
  Item dropdownValue = const Item("", "Selecione");
  Cor dropdownCorValue = const Cor("transparent", "Padrão");
  bool _loadAdicionarItem = false;
  String _mensagem_de_erro = "";

  List<Item> itemsMap = <Item>[
    const Item("", "Selecione"),
    const Item("link", "Link"),
    const Item("mail", "E-mail"),
    const Item("phone", "Telefone"),
    const Item("youtube-video", "Vídeo do YouTube"),
  ];

  List<Cor> coresMap = <Cor>[
    const Cor("transparent", "Padrão"),
    const Cor("azul", "Azul"),
    const Cor("vermelho", "Vermelho"),
    const Cor("chocolate", "Chocolate"),
    const Cor("verde", "Verde"),
    const Cor("rosa", "Rosa"),
  ];


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

  criarItem() async{

    setState(() {
      _loadAdicionarItem = true;
      _mensagem_de_erro = "";
    });

    if(controlador1.text == "" || dropdownValue.value == "" || controlador2.text == ""){
      setState(() {
        _mensagem_de_erro = "Digite o título, link e selecione o tipo.";
        _loadAdicionarItem = false;
      });
      return;
    }

    String url = formatUrl(controlador1.text, dropdownValue);

    var response = await Items.criarItem(
      color: dropdownCorValue.value,
      content: controlador2.text,
      page_id: widget.id,
      title: controlador1.text,
      type: dropdownValue.value
    );

    setState(() {
      _loadAdicionarItem = false;
    });

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

              const SizedBox(height: 40,),

              InputTextoContraste(
                "Titulo",
                max_length: 60,
                controlador: controlador1,
              ),

              InputTextoContraste(
                "Link do conteúdo",
                max_length: 360,
                controlador: controlador2,
              ),

              const SizedBox(height: 20,),

              DropdownButton<Item>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 26,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22
                ),
                onChanged: (Item? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: itemsMap.map((Item value) {
                  return DropdownMenuItem<Item>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20,),

              DropdownButton<Cor>(
                value: dropdownCorValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 26,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22
                ),
                onChanged: (Cor? newValue) {
                  setState(() {
                    dropdownCorValue = newValue!;
                  });
                },
                items: coresMap.map((Cor value) {
                  return DropdownMenuItem<Cor>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),

              Text(
                _mensagem_de_erro,
                style: const TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.none,
                    fontSize: 15
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20,),

              BtnPrimary(
                "Adicionar",
                mostrar_progress: _loadAdicionarItem,
                ao_clicar: (){
                  criarItem();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
