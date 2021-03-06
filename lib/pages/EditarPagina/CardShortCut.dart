import 'package:flutter/material.dart';
import 'package:shortlink/api/Shortcut/shortcut.dart';

import '../../constants/constants.dart';

class CardShortCut extends StatefulWidget {
  const CardShortCut({
    Key? key,
    required this.id,
    required this.page_id,
    required this.name,
    required this.url,
    required this.listar
  }) : super(key: key);

  final String id;
  final String page_id;
  final String name;
  final String url;
  final Function listar;

  @override
  _CardShortCutState createState() => _CardShortCutState();
}

class _CardShortCutState extends State<CardShortCut> {

  bool _load_icon = false;

  apagarShortCut() async{
    setState(() {
      _load_icon = true;
    });

    var response = await Shortcut.deletarShortcut(widget.id, widget.page_id);

    setState(() {
      _load_icon = false;
    });

    widget.listar();
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                              widget.name,
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),


                          const SizedBox(height: 16),

                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              widget.url,
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
                    child: Center(
                      child: !_load_icon ? const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ) : const Center(
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                      )
                    ),
                    onTap: (){
                      apagarShortCut();
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
