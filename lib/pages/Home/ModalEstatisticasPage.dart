import 'package:flutter/material.dart';
import 'package:shortlink/api/Pages/visitas.dart';

class ModalEstatisticasPage extends StatefulWidget {
  const ModalEstatisticasPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _ModalEstatisticasPageState createState() => _ModalEstatisticasPageState();
}

class _ModalEstatisticasPageState extends State<ModalEstatisticasPage> {
  String _data_inicial = "";
  String _data_final = "";
  int _visitas = 0;
  int _usuarios = 0;
  bool _load = false;

  listarVisitas() async {
    var response = await Visitas.listarVisitas(widget.id);

    setState(() {
      _load = false;
      for (var element in response) {
        _visitas += int.parse(element["visits"].toString());
        _usuarios = int.parse(element["unique_visits"].toString());
      }

      _data_inicial = (response[0]["date"].toString()).replaceAll('-', '/');
      _data_final = (response[response.length - 1]["date"].toString()).replaceAll('-', '/');
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _load = true;
      listarVisitas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: _load ? const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ) : ListView(

        children: [
          Center(
            child: Text(
              "$_data_inicial até $_data_final",
              style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 18
              ),
            ),
          ),

          const SizedBox(height: 80,),

          Center(
            child: Text(
              _visitas.toString(),
              style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 58
              ),
            ),
          ),


          const Center(
            child: Text(
              "Visitas",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 18
              ),
            ),
          ),

          const SizedBox(height: 40,),

          Center(
            child: Text(
              _usuarios.toString(),
              style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 58
              ),
            ),
          ),

          const Center(
            child: Text(
              "Usuários",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 18
              ),
            )
          ),
        ],
      ),
    );
  }
}
