import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter_share/flutter_share.dart';

class CompartilharLink extends StatefulWidget {
  const CompartilharLink({Key? key, required this.title, required this.compartilhar}) : super(key: key);

  final String title;
  final String compartilhar;

  @override
  _CompartilharLinkState createState() => _CompartilharLinkState();
}

class _CompartilharLinkState extends State<CompartilharLink> {

  Future<void> share() async {
    await FlutterShare.share(
      title: "Site",
      text: "Visite o site:",
      linkUrl: widget.compartilhar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: ListView(
              children: [
                const Center(
                  child: Text(
                    'Compartilhar',
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontSize: 24
                    ),
                  ),
                ),

                const SizedBox(height: 58),

                Center(
                  child: Text(
                    "go.olhai.me/${widget.title}",
                    style: const TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontSize: 20
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Center(
                  child: Column(
                    children: [
                      const Text(
                        "Copiar",
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 13
                        ),
                      ),
                      GestureDetector(
                        child: const Icon(Icons.paste, color: Colors.purple, size: 40,),
                        onTap: (){
                          FlutterClipboard.copy(widget.compartilhar).then(
                                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("${widget.title} copiado para a área de transferência"),
                                    behavior: SnackBarBehavior.floating
                                ),
                              )
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                Center(
                  child: Column(
                    children: [
                      const Text(
                        "Compartilhar",
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 13
                        ),
                      ),
                      GestureDetector(
                          child: const Icon(Icons.share, color: Colors.purple, size: 40,),
                          onTap: share
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
