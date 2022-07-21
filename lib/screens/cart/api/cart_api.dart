import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils/shown_snack_bar.dart';
import 'package:amazon_clone/screens/auth/api/auth_api.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartAPI {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
      // print('res');
    try {
      http.Response res =
          await http.delete(
            Uri.parse('$uri/api/v1/user/remove-from-cart'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': user.token,
              },
              body: jsonEncode({
                'id': product.id!,
              }));
      // print(res);
      
      httpErrorHandling(
        respense: res,
        context: context,
        onSucess: () {
          User userCart = UserProvider().user.copyWith(
                cart: jsonDecode(res.body)['cart'],
              );
          UserProvider().setUserFromModel(userCart);
          AuthAPI().getUserData(context: context);
        },
      );
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }
  }
}
