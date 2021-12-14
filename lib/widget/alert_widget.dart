import 'package:flutter/material.dart';

class AlerWidget extends StatelessWidget {
  const AlerWidget({Key? key, this.message, this.title}) : super(key: key);
  final String? message;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("$title"),
      content: Text("$message"),
      actions: [
        TextButton(
          child: Text("Cancle"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
