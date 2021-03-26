import 'package:flutter/material.dart';

class DeleteDialogWidget extends StatelessWidget {
  final Function() delete;
  const DeleteDialogWidget({Key? key, required this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Do you really want to delete?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("CANCEL")),
        ElevatedButton(onPressed: delete, child: const Text("OK")),
      ],
    );
  }
}
