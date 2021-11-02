import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../api/ResponseApi.dart';


class AcessoService{

  late String message;

  AcessoService.fromJson(Map<dynamic, dynamic> map){
    message = map["message"];
  }

  static Future<ApiResponse<String>> obterCodigoDeAcesso(access_pass, context) async {
    try {
      String _url = "https://api.olhai.me/v1/verifications";
      Map params = {
        'access_pass': access_pass,
      };

      var body = json.encode(params);

      final _uri = Uri.parse(_url);
      var response = await http.post(
          _uri, body: body, headers: {"Content-Type": "application/json"});

      log(response.body);

      if(response.statusCode == 204) {
        return ApiResponse.ok(response.body);
      }
      else if(response.statusCode == 500){
        Map data = json.decode(response.body);
        AcessoService acesso = AcessoService.fromJson(data);

        return ApiResponse.error(acesso.message);
      }
      return ApiResponse.error(response.body);
    }
    on Exception catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }
}