import 'package:flutter/cupertino.dart';

Future<void> mostrarAviso(BuildContext context, String mensaje) {
  return showCupertinoDialog<void>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: Text(mensaje),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          isDefaultAction: true,
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
