import 'dart:convert';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/screens/auth/api/auth_api.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/utils/shown_snack_bar.dart';
import 'package:http/http.dart' as http;

class AddressAPI {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/user/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );
      httpErrorHandling(
          respense: res,
          context: context,
          onSucess: () {
            User user = UserProvider().user.copyWith(
                  address: jsonDecode(res.body)['address'],
                );
            UserProvider().setUserFromModel(user);
            AuthAPI().getUserData(context: context);

          });
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalPrice,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/v1/user/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token,
          },
          body: jsonEncode({
            'cart': user.cart,
            'address': address,
            'totalPrice': user.total,
          }));
      httpErrorHandling(
          respense: res,
          context: context,
          onSucess: () {
            ShownSnackBar(context, 'Your order hase been placed!');
            User user = UserProvider().user.copyWith(cart: []);
            UserProvider().setUserFromModel(user);
            AuthAPI().getUserData(context: context);

          });
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }
  }
}
