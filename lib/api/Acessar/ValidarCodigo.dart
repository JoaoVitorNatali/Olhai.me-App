import 'dart:convert';
import 'package:http/http.dart' as http;
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
        return ApiResponse.ok(response.body);
      }
      return ApiResponse.error(response.body);
    }
    on Exception catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }
}