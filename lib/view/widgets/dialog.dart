import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sns_auth_demo/helper/global_context.dart';

Future<void> showBarrierAlert({
  required String title,
  required String content,
  required String buttonText,
}) async {
  await showDialog<void>(
    barrierDismissible: false,
    context: globalContext,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(height: 1.5),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.blue),
                ),
                onPressed: () async {
                  Navigator.of(globalContext).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
