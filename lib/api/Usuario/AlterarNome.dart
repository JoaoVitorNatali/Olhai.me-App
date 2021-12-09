import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../api/ResponseApi.dart';


class AlterarNome{

  static Future<ApiResponse<String>> alterarNomeUsuario(username, token) async {
    try {
      String _url = "https://api.olhai.me/v1/users/name";
      Map params = {
        'name': username,
      };
      var body = json.encode(params);
      final _uri = Uri.parse(_url);
      var response = await http.put(
          _uri, body: body, headers: {
            "Content-Type": "application/json",
            "Token": token,
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
}