import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shortlink/api/ResponseApi.dart';
import 'package:shortlink/preferences/User.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

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

  static Future? alterarImagem(id, XFile image) async{
    try {
      Map? usuario = await Usuario.obter();

      String _url = "https://api.olhai.me/v1/pages/$id/profile-image";
      final _uri = Uri.parse(_url);


      final request = http.MultipartRequest("PUT", _uri);
      Map<String, String> headers = {
        "Token": usuario?["token"],
        "Content-type": "multipart/form-data"
      };

      File imageFile = File(image.path);

      String filename = imageFile.path.split("/").last;
      String type = filename.split('.').last;

      FormData formdata = FormData();
      formdata.files.addAll([
        MapEntry(
            "image",
            await MultipartFile.fromFile(image.path, filename: filename,
            contentType: MediaType("image", type)
          )
        )
      ]);

      Dio dio = Dio();

      var response = await dio.put(_url, data: formdata, options: Options(headers: {
        'Token': usuario?["token"],
        'Content-Type': "multipart/form-data"
      }));

      return response;
    } catch (erro){
      return null;
    }
  }

  static Future<ApiResponse<String>> detalharPagina(id) async {
    try {
      Map? usuario = await Usuario.obter();

      String _url = "https://api.olhai.me/v1/pages/$id";
      final _uri = Uri.parse(_url);


      var response = await http.get(
        _uri, headers: {
          "Content-Type": "application/json",
          "Token": usuario?["token"],
        },
      );

      if(response.statusCode == 200){
        return ApiResponse.ok(response.body);
      }
      return ApiResponse.error(response.body);

    } catch (erro){
      return ApiResponse.error(erro.toString());
    }
  }

  static Future<ApiResponse<String>> atualizarDados(id, name, location, description) async {
    try {
      Map? usuario = await Usuario.obter();

      Map params = {
        "id": int.parse(id),
        "name": name,
        "location": location,
        "description": description
      };

      var body = json.encode(params);

      String _url = "https://api.olhai.me/v1/pages";
      final _uri = Uri.parse(_url);


      var response = await http.put(
        _uri, body: body, headers: {
          "Content-Type": "application/json",
          "Token": usuario?["token"],
        },
      );

      if(response.statusCode == 204){
        return ApiResponse.ok(response.body);
      }
      print(response.body);
      return ApiResponse.error(response.body);

    } catch (erro){
      print(erro);
      return ApiResponse.error(erro.toString());
    }
  }
}