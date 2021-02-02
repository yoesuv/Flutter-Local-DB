import 'package:flutter/cupertino.dart';

class TextSplash extends StatelessWidget {

  final String text;

  TextSplash(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold
    ));
  }

}