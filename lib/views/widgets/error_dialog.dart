import 'package:flutter/material.dart';

void showErrorDialog({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('An Error Occurred!'),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text('Okay'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
