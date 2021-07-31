import 'package:core/widgets/button/button_widget.dart';
import 'package:flutter/material.dart';

class LogoutDialogWidget extends StatelessWidget {
  final Function() confirmation;

  const LogoutDialogWidget({
    Key? key,
    required this.confirmation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Do you really want to leave?",
        textAlign: TextAlign.center,
      ),
      actions: [
        ButtonWidget(
            onPressed: () {
              Navigator.pop(context);
            },
            text: "CANCEL",
            colorButton: Theme.of(context).primaryColor),
        ButtonWidget(
            onPressed: confirmation,
            text: "OK",
            colorButton: Theme.of(context).accentColor),
      ],
    );
  }
}
