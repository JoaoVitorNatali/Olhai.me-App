import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shortlink/api/ResponseApi.dart';
import 'package:shortlink/preferences/User.dart';

class Items{

  static Future<ApiResponse<String>> criarItem(
      {color, content, page_id, title, type}) async {
    try {
      String _url = "https://api.olhai.me/v1/pages/items";
      Map params = {
        "color": color,
        "content": content,
        "page_id": int.parse(page_id),
        "title": title,
        "type": type,
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

        if(response.statusCode == 204) {
          return ApiResponse.ok(response.body, response: response);
        }
        return ApiResponse.error(response.body, response: response);
      });
    } catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }

  static Future<ApiResponse<String>> deletarItem(id, page_id) async {
    try {
      Map? usuario = await Usuario.obter();

      String _url = "https://api.olhai.me/v1/pages/items/status";
      final _uri = Uri.parse(_url);

      Map params = {
        "id": int.parse(id),
        "page_id": int.parse(page_id),
        "status": "del",
      };
      var body = json.encode(params);

      var response = await http.put(
        _uri, body: body, headers: {
        "Content-Type": "application/json",
        "Token": usuario?["token"],
      },
      );

      if(response.statusCode == 204){
        return ApiResponse.ok(response.body);
      }
      return ApiResponse.error(response.body);

    } catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }
}