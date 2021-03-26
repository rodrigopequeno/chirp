import 'package:chirp/app/core/widgets/button/button_widget.dart';
import 'package:flutter/material.dart';

class LeaveWithoutSavingDialogWidget extends StatelessWidget {
  const LeaveWithoutSavingDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure?"),
      content: const Text("All unsaved changes would be lost"),
      actions: [
        ButtonWidget(
          onPressed: () {
            Navigator.pop(context, false);
          },
          text: 'NO',
        ),
        ButtonWidget(
          onPressed: () {
            Navigator.pop(context, true);
          },
          text: 'YES',
          colorButton: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}
