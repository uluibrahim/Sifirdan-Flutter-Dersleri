import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/common_widget/platform_duyarli_widgetler/platform_duyarli_widget.dart';

class PlatformDuyarliAlertDialog extends PlatformDuyarliWidget {
  final String title;
  final String contentText;
  final String basicButtonText;
  final String? cancelButtonText;
  PlatformDuyarliAlertDialog({
    required this.title,
    required this.contentText,
    required this.basicButtonText,
    this.cancelButtonText,
  });

  Future<bool> dialogGoster(BuildContext context) async {
    bool result = Platform.isIOS
        ? await showCupertinoDialog(
            context: (context),
            builder: (context) => this,
            barrierDismissible: false)
        : await showDialog(
            context: (context),
            builder: (context) => this,
            barrierDismissible: false);
    return result;
  }

  @override
  Widget builIOSWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(contentText),
      actions: _dialogButtonsActions(context),
    );
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(contentText),
      actions: _dialogButtonsActions(context),
    );
  }

  List<Widget> _dialogButtonsActions(BuildContext context) {
    final List<Widget> tumButonlar = <Widget>[];
    if (Platform.isAndroid) {
      if (cancelButtonText != null) {
        tumButonlar.add(
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(basicButtonText),
          ),
        );
        tumButonlar.add(
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(cancelButtonText!),
          ),
        );
      } else {
        tumButonlar.add(
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(basicButtonText),
          ),
        );
      }
    } else {
      if (cancelButtonText != null) {
        tumButonlar.add(
          CupertinoDialogAction(
            child: Text(basicButtonText),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        );
        tumButonlar.add(
          CupertinoDialogAction(
            child: Text(cancelButtonText!),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        );
      } else {
        tumButonlar.add(
          CupertinoDialogAction(
            child: Text(basicButtonText),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        );
      }
    }
    return tumButonlar;
  }
}
