import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

abstract class LoadingIndicator {
  void show();
  Future<void> hide();
  bool get isShow;
}

class LoadingIndicatorImpl implements LoadingIndicator {
  late OverlayEntry _entry;
  late bool _isShow = false;

  LoadingIndicatorImpl() {
    _entry = OverlayEntry(
      builder: (context) {
        return Container(
          color: Colors.black.withOpacity(.3),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Future<void> hide() async {
    _entry.remove();
    _isShow = false;
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  void show() {
    FocusManager.instance.primaryFocus!.unfocus();
    _isShow = true;
    asuka.addOverlay(_entry);
  }

  @override
  bool get isShow => _isShow;
}
