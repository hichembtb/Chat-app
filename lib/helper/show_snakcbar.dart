// Show Snackbar on error
import 'package:flutter/material.dart';

void SnackBarError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
