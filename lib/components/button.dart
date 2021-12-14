import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const Button({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.7,
      // height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(
            Radius.circular(10.0) //                 <--- border radius here
            ),
      ),
      child: MaterialButton(
        elevation: 0,
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          "$text",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xffFFFFFF),
            fontSize: 19.0,
          ),
        ),
        onPressed: onPressed,
        textColor: Color(0xffFFFFFF),
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
