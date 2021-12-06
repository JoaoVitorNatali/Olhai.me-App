import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shortlink/preferences/User.dart';

class Visitas{
  static Future<List<dynamic>> listarVisitas(id) async {
    try {
      String _url = "https://api.olhai.me/v1/pages/statistics/$id";

      final _uri = Uri.parse(_url);

      Future<Map?> usuario = Usuario.obter();
      return usuario.then( (value) async {
        var response = await http.get(
          _uri, headers: {
            "Content-Type": "application/json",
            "Token": value?["token"],
          },
        );

        if(response.statusCode == 200) {
          return json.decode(response.body);
        }
        return json.decode(response.body);
      });
    } catch (erro){
      return json.decode(erro.toString());
    }
  }
}