import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/components/Button/BtnDanger.dart';

class CardLink extends StatefulWidget {
  const CardLink({Key? key, required this.id, required this.name, required this.url}) : super(key: key);
  final String id;
  final String name;
  final String url;

  @override
  _CardLinkState createState() => _CardLinkState();
}

class _CardLinkState extends State<CardLink> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Text(
                      "https://go.olhai.me/${widget.name}",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),

                    const SizedBox(height: 16),

                    Text("Para: ${widget.url}", style: const TextStyle(color: Colors.white),),
                  ],
                )
            ),


            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(right: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        BtnPrimary("Compartilhar", ao_clicar: (){

                        }),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            BtnDanger("Excluir", ao_clicar: (){

                            }),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
