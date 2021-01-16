import 'package:flutter/material.dart';
import 'package:gitrepo/src/widgets/feedback_bottom_sheet.dart';

extension BuildContextExtensions on BuildContext {
  void showSnackError(
    String msg, {
    String title,
  }) {
    try {
      FeedbackBottomSheet.show(
        this,
        message: msg,
        shadowColor: Colors.red,
      );
    } catch (e) {
      print(e);
    }
  }

  void showSnackBar({Widget child}) {
    try {
      FeedbackBottomSheet.show(
        this,
        child: child,
      );
    } catch (e) {
      print(e);
    }
  }
}
