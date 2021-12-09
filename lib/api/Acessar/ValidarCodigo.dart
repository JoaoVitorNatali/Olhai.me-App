import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shortlink/preferences/User.dart';
import '../../../api/ResponseApi.dart';


class ValidarCodigoService{

  static Future<ApiResponse<String>> validarCodigoAcesso(access, codigo) async {
    try{
      String _url = "https://api.olhai.me/v1/sessions/validations";
      Map params = {
        'access_pass': access,
        'code': codigo,
      };

      var body = json.encode(params);

      final _uri = Uri.parse(_url);
      var response = await http.post(_uri, body: body, headers: {"Content-Type": "application/json"});

      if(response.statusCode == 200) {
        Map data = json.decode(response.body);
        return ApiResponse.ok(response.body, response: response);
      }
      return ApiResponse.error(response.body);
    }
    on Exception catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }

  static Future<ApiResponse<String>>  adicionarPasseAcesso(access, codigo) async{
    try{
      String _url = "https://api.olhai.me/v1/users/access-passes";
      Map params = {
        'access_pass': access,
        'code': codigo,
      };

      var body = json.encode(params);

      final _uri = Uri.parse(_url);

      Map? usuario = await Usuario.obter();
      var response = await http.post(_uri, body: body, headers: {
        "Content-Type": "application/json",
        "Token": usuario?["token"],
      });

      if(response.statusCode == 204) {
        return ApiResponse.ok(response.body, response: response);
      }
      return ApiResponse.error(response.body, response: response);
    }
    on Exception catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }
}