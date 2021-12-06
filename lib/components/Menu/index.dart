import 'dart:developer';

import 'package:flutter/material.dart';

import '../../preferences/User.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  late String _userName = "";
  late String _email = "";

  carregarUsuario() async {
    final Map? usuario = await Usuario.obter();

    setState(() {
      _userName = usuario?["user"]?["name"];
      _email = usuario?["user"]?["access_pass"]?[0]?["pass"];
    });
  }

  @override
  void initState() {
    super.initState();

    carregarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(

        child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: const Icon(Icons.account_circle, size: 80),
                accountName: Text(_userName),
                accountEmail: Text(_email),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('inicio'),
                subtitle: const Text('tela de inicio'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/");
                }
              ),
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Encurtador'),
                subtitle: const Text('Encurtador de links'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/shortlinks");
                }
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Minha Conta'),
                subtitle: const Text('Configurar perfil'),
                onTap: (){
                  Navigator.pushReplacementNamed(context, "/account");
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sair'),
                subtitle: const Text('Deslogar usuário'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/logout");
                },
              ),
            ]
        )
    );
  }
}
