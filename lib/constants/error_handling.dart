import 'dart:convert';

import 'package:amazon_clone/constants/utils/shown_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandling({
  required http.Response respense,
  required BuildContext context,
  required VoidCallback onSucess,
}) {
  switch (respense.statusCode) {
    case 200:
      onSucess();
      break;
    case 400:
      ShownSnackBar(context, jsonDecode(respense.body)['msg']);
      break;
    case 500:
      ShownSnackBar(context, jsonDecode(respense.body)['error']);
      break;
    default:
      ShownSnackBar(context,respense.body);
      
  }
}
