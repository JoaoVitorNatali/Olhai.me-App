import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shortlink/api/ResponseApi.dart';
import 'package:shortlink/preferences/User.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:async/async.dart';

class EditarPage{
  static Future? alterarImagem(id, XFile image) async{
    try {
      Map? usuario = await Usuario.obter();

      String _url = "https://api.olhai.me/v1/pages/$id/profile-image";
      final _uri = Uri.parse(_url);


      final request = http.MultipartRequest("PUT", _uri);
      Map<String, String> headers = {
        "Token": usuario?["token"],
        "accept": "application/json, text/plain, */*",
        "Content-Type": "multipart/form-data",
      };

      File imageFile = File(image.path);

      request.files.add(
        http.MultipartFile('image', imageFile.readAsBytes().asStream(), imageFile.lengthSync(), filename: imageFile.path.split("/").last)
      );

      var teste = await imageFile.readAsBytes().asStream();

      request.headers.addAll(headers);

      inspect(request);

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });

      if(response.statusCode == 204){
        return response;
      }
      return response;

    } catch (erro){
      print(erro);
      return null;
    }
  }
}