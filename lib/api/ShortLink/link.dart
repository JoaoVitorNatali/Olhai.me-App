import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shortlink/api/ResponseApi.dart';
import 'package:shortlink/preferences/User.dart';

class ShortLink{

  static Future<ApiResponse<String>> encurtarLink(name, url) async {
    try {
      String _url = "https://api.olhai.me/v1/shortlinks";
      Map params = {
        "name": name,
        "url": url
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
            return ApiResponse.ok(response.body);
          }
          return ApiResponse.error(response.body, response: response);
      });
    } catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }

  static Future<List<dynamic>> listarLinks() async{
    try {
      String _url = "https://api.olhai.me/v1/shortlinks";
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
}