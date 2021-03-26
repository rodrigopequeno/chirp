import 'package:flutter/material.dart';

class SpacerH extends StatelessWidget {
  final double height;

  const SpacerH(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class SpacerW extends StatelessWidget {
  final double width;

  const SpacerW(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
