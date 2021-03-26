import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color colorButton;
  final double radius;
  final double? width;
  const ButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.colorButton,
      this.radius = 4,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorButton),
        shadowColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)))),
      ),
      child: SizedBox(
        width: width,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
