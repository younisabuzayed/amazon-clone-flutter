import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils/shown_snack_bar.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchAPI {
  Future<List<Product>> fetchSearchedProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(
            Uri.parse('$uri/api/v1/products/search/$searchQuery'),
           headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': user.token,
            }
          );
      httpErrorHandling(
        respense: res,
        context: context,
        onSucess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ));
          }
        },
      );
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }
    return productList;
  }
}
