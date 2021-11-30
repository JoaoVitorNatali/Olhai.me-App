import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(

        child: Column(
            children: [
              const UserAccountsDrawerHeader(
                currentAccountPicture: Icon(Icons.account_circle, size: 80),
                accountName: Text('Teste'),
                accountEmail: Text(''),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('inicio'),
                subtitle: Text('tela de inicio'),
                onTap: () {
                  Navigator.pushNamed(context, "/");
                }
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Encurtador'),
                subtitle: Text('Encurtador de links'),
                onTap: () {
                  Navigator.pushNamed(context, "/shortlinks");
                }
              ),
              ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Minha Conta'),
                  subtitle: Text('Configurar perfil'),
              )
            ]
        )
    );
  }
}
