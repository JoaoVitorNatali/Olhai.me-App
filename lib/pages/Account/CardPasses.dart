import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shortlink/pages/Account/ModalExcluirPasse.dart';

import '../../constants/constants.dart';

class CardPasses extends StatefulWidget {
  const CardPasses({Key? key, required this.id, required this.pass, required this.listar}) : super(key: key);
  final String id;
  final String pass;
  final Function listar;

  @override
  _CardPassesState createState() => _CardPassesState();
}

class _CardPassesState extends State<CardPasses> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius)
        ),
        color: Colors.black,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [

              Expanded(
                flex: 6,
                child: Text(
                  widget.pass,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => ModalExcluirPasse(pass: widget.pass, listar: widget.listar,)
                    );
                  },
                  child: Container(
                    child: const Icon(
                      Icons.delete,
                      size: 28,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
