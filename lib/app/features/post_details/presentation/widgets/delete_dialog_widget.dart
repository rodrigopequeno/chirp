import 'package:chirp/app/core/widgets/button/button_widget.dart';
import 'package:flutter/material.dart';

class DeleteDialogWidget extends StatelessWidget {
  final Function() delete;
  const DeleteDialogWidget({Key? key, required this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Do you really want to delete?",
        textAlign: TextAlign.center,
      ),
      actions: [
        ButtonWidget(
            onPressed: () {
              Navigator.pop(context);
            },
            text: "CANCEL"),
        ButtonWidget(
          onPressed: delete,
          text: "OK",
          colorButton: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}
