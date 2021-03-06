import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shortlink/components/Button/BtnDanger.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/components/Modal/CompartilharLink.dart';
import 'package:shortlink/pages/ShortLinks/ModalExcluirLink.dart';
import 'package:url_launcher/url_launcher.dart';

class ModalOpcoesCard extends StatefulWidget {
  const ModalOpcoesCard({
    Key? key,
    required this.id,
    required this.name,
    required this.url,
    required this.listar,
  }) : super(key: key);

  final String id;
  final String name;
  final String url;
  final Function listar;

  @override
  _ModalOpcoesCardState createState() => _ModalOpcoesCardState();
}

class _ModalOpcoesCardState extends State<ModalOpcoesCard> {

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.only(top: 36, left: 16, right: 16, bottom: 16),
        child: ListView(
          children: [

            Center(
              child: Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 18
                ),
              ),
            ),

            const SizedBox(height: 18,),

            BtnPrimary("Compartilhar", ao_clicar: () {
              showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => CompartilharLink(
                        title: widget.name,
                        compartilhar: "go.olhai.me/${widget.name}",
                    ),
              );
            }),

            const SizedBox(height: 15,),

            BtnPrimary(
              "Visitar",
              ao_clicar: (){
                var url = "https://go.olhai.me/${widget.name}";
                _launchInBrowser(url);
              },
            ),

            const SizedBox(height: 18,),

            BtnDanger("Excluir", ao_clicar: (){
              showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => ModalExcluirLink(id: widget.id, listar: widget.listar)
              );
            }),
          ],
        )
    );
  }
}
