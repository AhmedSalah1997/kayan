import 'package:flutter/cupertino.dart';

class MyAlertDialog {
  static void showAlertDialog({
    required BuildContext context,
    required String title,
    required String descri,
    required Function() tapNo,
    required Function() tapYes,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(descri),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: tapNo,
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: tapYes,
            child: const Text('Yes'),
          ),
        ],
      ),
    );

  }
}