import 'package:flutter/material.dart';

void showActionMessage(BuildContext context, String action) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(content: Text(action)));
}
