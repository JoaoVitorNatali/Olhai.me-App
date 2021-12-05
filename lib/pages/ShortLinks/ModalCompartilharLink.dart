import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter_share/flutter_share.dart';

class ModalCompartilharLink extends StatefulWidget {
  const ModalCompartilharLink({Key? key, required this.name, required this.url}) : super(key: key);

  final String name;
  final String url;

  @override
  _ModalCompartilharLinkState createState() => _ModalCompartilharLinkState();
}

class _ModalCompartilharLinkState extends State<ModalCompartilharLink> {

  Future<void> share() async {
    await FlutterShare.share(
        title: "Site",
        text: "Visite o site:",
        linkUrl: "go.olhai.me/${widget.name}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
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
                "go.olhai.me/${widget.name}",
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
                      FlutterClipboard.copy("go.olhai.me/${widget.name}").then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Link copiado"),
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
    );
  }
}
