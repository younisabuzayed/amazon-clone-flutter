import 'package:flutter/material.dart';

void ShownSnackBar(BuildContext context, String text)
{
  ScaffoldMessenger
    .of(context)
    .showSnackBar(
      SnackBar(
        content: Text(text),
      )
    );
}