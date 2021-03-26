import 'package:chirp/app/core/widgets/button/button_widget.dart';
import 'package:chirp/app/core/widgets/spacers/spacers.dart';
import 'package:chirp/app/core/widgets/text_field.dart/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/character_limit.dart';

class EditDialogWidget extends StatefulWidget {
  final Function(String) edit;
  final String content;

  const EditDialogWidget({Key? key, required this.edit, required this.content})
      : super(key: key);

  @override
  _EditDialogWidgetState createState() => _EditDialogWidgetState();
}

class _EditDialogWidgetState extends State<EditDialogWidget> {
  final TextEditingController contentController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    contentController.text = widget.content;
    contentController.selection = TextSelection.fromPosition(
        TextPosition(offset: contentController.text.length));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Edit post"),
              TextFieldWidget(
                controller: contentController,
                maxLength: kCharacterLimitCreation,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                label: ' Type your text here ...',
                border: InputBorder.none,
                validator: (value) {
                  const kRequired = "Required field";
                  if (value == null) {
                    return kRequired;
                  } else if (value.isEmpty) {
                    return kRequired;
                  }
                  return null;
                },
                onFieldSubmitted: (value) async {
                  await _submitted(context);
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonWidget(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'CANCEL',
                    ),
                  ),
                  const SpacerW(10),
                  Expanded(
                    child: ButtonWidget(
                      onPressed: () {
                        _submitted(context);
                      },
                      text: 'EDIT POST',
                      colorButton: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitted(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      await widget.edit(contentController.text);
    }
  }
}
