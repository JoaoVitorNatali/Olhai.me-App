import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: Icon(Icons.account_circle, size: 80),
                  accountName: Text('Teste'),
                  accountEmail: Text(''),
                ),
                ListTile(
                    leading: Icon(Icons.home),
                    title: Text('inicio'),
                    subtitle: Text('tela de inicio')
                ),
              ]
          )
      ),
      appBar: AppBar(),
    );
  }
}
