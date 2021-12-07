import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shortlink/api/ResponseApi.dart';
import 'package:shortlink/preferences/User.dart';

class Pages{

  static Future<ApiResponse<String>> criarPagina(nome) async {
    try {
      String _url = "https://api.olhai.me/v1/pages";
      Map params = {
        "pagename": nome,
      };
      var body = json.encode(params);
      final _uri = Uri.parse(_url);

      Future<Map?> usuario = Usuario.obter();
      return usuario.then( (value) async {
        var response = await http.post(
          _uri, body: body, headers: {
          "Content-Type": "application/json",
          "Token": value?["token"],
        },
        );

        if(response.statusCode == 200) {
          return ApiResponse.ok(response.body, response: response);
        }
        return ApiResponse.error(response.body, response: response);
      });
    } catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }

  static Future<List<dynamic>> listarPaginas() async {
    try {
      String _url = "https://api.olhai.me/v1/pages";

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

  static Future<ApiResponse<String>> excluirPagina(id) async{
    try {
      String _url = "https://api.olhai.me/v1/pages/status";
      Map params = {
        "id": id,
        "status": "del"
      };
      var body = json.encode(params);
      final _uri = Uri.parse(_url);


      Future<Map?> usuario = Usuario.obter();
      return usuario.then( (value) async {
        var response = await http.put(
          _uri, body: body, headers: {
            "Content-Type": "application/json",
            "Token": value?["token"],
          },
        );

        print(response.body);
        if(response.statusCode == 204){
          return ApiResponse.ok(response.body);
        }
        return ApiResponse.error(response.body);
      });
    } catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }

  static Future<ApiResponse<String>> ocultarPagina(id) async{
    try {
      String _url = "https://api.olhai.me/v1/pages/status";
      Map params = {
        "id": id,
        "status": "pri"
      };
      var body = json.encode(params);
      final _uri = Uri.parse(_url);

      Future<Map?> usuario = Usuario.obter();
      return usuario.then( (value) async {
        var response = await http.put(
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