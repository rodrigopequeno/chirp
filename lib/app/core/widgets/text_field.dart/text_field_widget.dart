import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Widget? prefixIcon;
  final TextInputAction textInputAction;
  final Color colorBorder;
  final Color? fillColor;
  final int? maxLength;
  final Function(String) onFieldSubmitted;
  final TextInputType? keyboardType;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final InputBorder? border;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.textInputAction,
    required this.label,
    required this.onFieldSubmitted,
    this.prefixIcon,
    this.colorBorder = const Color(0xFF000000),
    this.fillColor,
    this.maxLength,
    this.keyboardType,
    this.maxLengthEnforcement,
    this.maxLines,
    this.border,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        filled: fillColor != null,
        fillColor: fillColor,
        border: border ??
            OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(color: colorBorder),
            ),
        enabledBorder: border ??
            OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(color: colorBorder),
            ),
        focusedBorder: border ??
            OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(color: colorBorder, width: 2),
            ),
      ),
    );
  }
}
