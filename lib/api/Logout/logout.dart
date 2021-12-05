import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shortlink/api/ResponseApi.dart';
import 'package:shortlink/preferences/User.dart';

class LogoutApi{

  static Future<ApiResponse<String>> encerrarSessao() async {
    try {
      String _url = "https://api.olhai.me/v1/sessions";
      final _uri = Uri.parse(_url);

      Future<Map?> usuario = Usuario.obter();
      return usuario.then( (value) async {
        var response = await http.delete(
          _uri, headers: {
            "Content-Type": "application/json",
            "Token": value?["token"],
          },
        );

        log(response.body.toString());
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