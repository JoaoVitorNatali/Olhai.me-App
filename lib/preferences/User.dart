import 'dart:convert';
import 'Prefs.dart';

class Usuario{

  static void salvar(Map<dynamic, dynamic>? user){
    String usuario_string = json.encode(user);

    Prefs.setString("user.prefs", usuario_string);
  }

  static Future<Map?> obter() async {
    String usuario_string = await Prefs.getString("user.prefs");
    if(usuario_string.isEmpty) return null;

    Map user = json.decode(usuario_string);
    return user;
  }

  void limpar(){
    Prefs.setString("user.prefs", "");
  }
}