import 'package:flutter/cupertino.dart';

class TextSplash extends StatelessWidget {
  final String text;

  const TextSplash(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
