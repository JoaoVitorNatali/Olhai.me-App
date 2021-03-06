import 'dart:async';
import 'package:flutter/material.dart';

//components
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/api/Acessar/requisitarApi.dart';

//api
import '../../api/ResponseApi.dart';

class Contador extends StatefulWidget {
  const Contador({Key? key, required this.user}) : super(key: key);
  final String user;

  @override
  _ContadorState createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {

  int minutes = 5;
  int seconds = 0;
  late Timer _timer;
  bool showTimer = true;
  bool mostrarLoadEnviarCodigo = false;

  void diminuirTimer(){
    if(this.seconds > 0){
      this.seconds = this.seconds - 1;
    }
    else if(this.minutes > 0){
      this.minutes = this.minutes - 1;
      this.seconds = 59;
    }
  }

  String getTimeFormated(){
    String min = "0" + minutes.toString();
    String sec;
    if(seconds < 10) sec = "0" + seconds.toString();
    else sec = seconds.toString();

    return "$min:$sec";
  }

  void _startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      setState((){
        if(this.minutes > 0 || this.seconds > 0){
          diminuirTimer();
        }else{
          _timer.cancel();
          showTimer = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _startTimer());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: showTimer ? Text(
          'Reenviar em ${getTimeFormated()}',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ) : BtnPrimary(
          'Reenviar código',
          mostrar_progress: mostrarLoadEnviarCodigo,
          ao_clicar: () async {

            setState((){
              mostrarLoadEnviarCodigo = true;
            });

            var response = await AcessoService.obterCodigoDeAcesso(widget.user);

            setState((){
              mostrarLoadEnviarCodigo = false;
              showTimer = true;
              this.minutes = 5;
              _startTimer();
            });
          },
        ),
    );
  }
}
