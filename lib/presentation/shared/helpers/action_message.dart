import 'package:flutter/material.dart';

void showActionMessage(BuildContext context, String action) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(action)));
}
