import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:shortlink/components/Button/BtnPrimary.dart';
import 'package:shortlink/components/Button/BtnDanger.dart';
import 'package:shortlink/components/Modal/CompartilharLink.dart';
import 'package:shortlink/pages/ShortLinks/ModalExcluirLink.dart';
import 'package:shortlink/pages/ShortLinks/modalOpcoesCard.dart';

import '../../constants/constants.dart';

class CardLink extends StatefulWidget {
  const CardLink({
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
  _CardLinkState createState() => _CardLinkState();
}

class _CardLinkState extends State<CardLink> {

  Function? _fowardListar(){
    widget.listar();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius)
        ),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Expanded(
                  flex: 38,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      children: [

                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "https://go.olhai.me/${widget.name}",
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),


                        const SizedBox(height: 16),

                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Para: ${widget.url}",
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),

                      ],
                    ),
                  )
              ),

              Expanded(
                flex: 4,
                child: GestureDetector(
                  child: const Center(
                    child: Icon(
                      Icons.expand_more_outlined,
                      color: Colors.white,
                    ),
                  ),
                  onTap: (){
                    showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => ModalOpcoesCard(id: widget.id, url: widget.url, name: widget.name, listar: _fowardListar)
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
