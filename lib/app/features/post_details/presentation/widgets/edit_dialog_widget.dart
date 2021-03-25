import 'package:flutter/material.dart';

import '../../../../core/utils/character_limit.dart';

class EditDialogWidget extends StatelessWidget {
  final Function(String) edit;
  final String content;
  final TextEditingController contentController = TextEditingController();

  EditDialogWidget({Key? key, required this.edit, required this.content})
      : super(key: key) {
    contentController.text = content;
    contentController.selection = TextSelection.fromPosition(
        TextPosition(offset: contentController.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: contentController,
              maxLength: kCharacterLimit,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: ' Type your text here ...',
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('CANCEL'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      edit(contentController.text);
                    },
                    child: const Text('EDIT POST'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
