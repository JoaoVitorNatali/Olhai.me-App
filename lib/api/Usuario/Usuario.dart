import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shortlink/preferences/User.dart';
import '../../../api/ResponseApi.dart';


class User{

  static Future<ApiResponse<String>> alterarNome(username) async {
    try {
      String _url = "https://api.olhai.me/v1/users/name";
      Map params = {
        'name': username,
      };

      var body = json.encode(params);
      final _uri = Uri.parse(_url);

      Map? usuario = await Usuario.obter();


      var response = await http.put(
          _uri, body: body, headers: {
        "Content-Type": "application/json",
        "Token": usuario?["token"],
      });


      if(response.statusCode == 204) {
        return ApiResponse.ok(response.body);
      }

      return ApiResponse.error(response.body);
    }
    on Exception catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }

  static Future<List<dynamic>> listarPasses() async{
    try {
      String _url = "https://api.olhai.me/v1/users/access-passes";
      final _uri = Uri.parse(_url);

      Future<Map?> usuario = Usuario.obter();
      return usuario.then( (value) async {
        var response = await http.get(
          _uri, headers: {
            "Content-Type": "application/json",
            "Token": value?["token"],
          },
        );

        return json.decode(response.body);
      });
    } catch (erro){
      return json.decode(erro.toString());
    }
  }

  static Future<ApiResponse<String>> excluirPasse(id) async{
    try {
      String _url = "https://api.olhai.me/v1/users/access-passes";
      final _uri = Uri.parse(_url);

      Map params = {
        "access_pass": id,
      };
      var body = json.encode(params);

      Future<Map?> usuario = Usuario.obter();
      return usuario.then( (value) async {
        var response = await http.delete(
          _uri, body: body, headers: {
          "Content-Type": "application/json",
          "Token": value?["token"],
        },
        );

        if(response.statusCode == 204){
          return ApiResponse.ok(response.body);
        }
        return ApiResponse.error(response.body);
      });
    } catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }
}