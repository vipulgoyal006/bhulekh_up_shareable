import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool?> showAppAlertDialog(
    {String title = '',
    String? description,
    String positiveText = 'Ok',
    String negativeText = 'Cancel',
    bool barrierDismissible = true}) async {
  if (Platform.isIOS) {
    if (Get.key.currentContext != null) {
      return showCupertinoModalPopup<bool>(
        barrierDismissible: barrierDismissible,
        context: Get.key.currentContext!,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(title),
          message: description == null ? null : Text(description),
          actions: <Widget>[
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Get.back(result: true);
              },
              child: Text(positiveText),
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(negativeText),
            onPressed: () {
              Get.back(result: false);
            },
          ),
        ),
      );
    } else {
      return Get.dialog(CupertinoAlertDialog(
        title: Text(title),
        content: description != null ? Text(description) : null,
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(negativeText),
            onPressed: () {
              Get.back(result: false);
            },
          ),
          CupertinoDialogAction(
            child: Text(positiveText),
            onPressed: () => Get.back(result: true),
          ),
        ],
      ));
    }
  }

  return Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: description != null ? Text(description) : null,
        actions: <Widget>[
          TextButton(
            child: Text(negativeText),
            onPressed: () {
              Get.back(result: false);
            },
          ),
          TextButton(
            child: Text(positiveText),
            onPressed: () => Get.back(result: true),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible);
}

Future<bool?> showAppSuggestionDialog(
    {String title = '',
    String? description,
    String positiveText = 'Ok',
    String negativeText = 'Cancel'}) async {
  return Get.dialog<bool>(
    AlertDialog(
      title: Text(title),
      content: description != null ? Text(description) : null,
      actions: [
        TextButton(
          child: Text(positiveText),
          onPressed: () => Get.back(result: true),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
