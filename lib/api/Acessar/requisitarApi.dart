import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../api/ResponseApi.dart';


class AcessoService{

  static Future<ApiResponse<String>> obterCodigoDeAcesso(access_pass) async {
    try {
      String _url = "https://api.olhai.me/v1/verifications";
      Map params = {
        'access_pass': access_pass,
      };
      var body = json.encode(params);
      final _uri = Uri.parse(_url);
      var response = await http.post(
          _uri, body: body, headers: {"Content-Type": "application/json"});


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