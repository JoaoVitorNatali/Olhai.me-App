import 'package:flutter/material.dart';
import 'package:shortlink/components/Menu/index.dart';

import 'package:shortlink/api/Logout/logout.dart';
import 'package:shortlink/preferences/User.dart';
import 'package:shortlink/routes/controleTelaAbertura.dart';

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {

  deslogarUsuario () async {
    var response = await LogoutApi.encerrarSessao();

    Usuario.limpar();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => const TelaAbertura())
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    deslogarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(title: const Text('Logout'),),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
            )
          ]
        ),
      ),
    );
  }
}
