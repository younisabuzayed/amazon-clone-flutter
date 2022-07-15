import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/models/admin/sales.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/utils/shown_snack_bar.dart';
import 'package:http/http.dart' as http;

class AdminAPI {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final cloudinary = CloudinaryPublic('api-flutter-app', 'k8mfxo1t');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res =
            await cloudinary.uploadFile(CloudinaryFile.fromFile(
          images[i].path,
          folder: name,
        ));
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        images: imageUrls,
        category: category,
        id: '',
        userId: user.id,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandling(
          respense: res,
          context: context,
          onSucess: () {
            ShownSnackBar(context, 'Add Product is Sucsess');
            Navigator.pop(context);
          });
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/v1/admin/get-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );
      httpErrorHandling(
          respense: res,
          context: context,
          onSucess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }

    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response res =
          await http.post(Uri.parse('$uri/api/v1/admin/delete-product'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': user.token,
              },
              body: jsonEncode({
                'id': product.id,
              }));
      httpErrorHandling(
          respense: res, context: context, onSucess: () => onSuccess());
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/v1/admin/get-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );
      httpErrorHandling(
          respense: res,
          context: context,
          onSucess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList.add(
                Order.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }

    return orderList;
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response res =
          await http.post(Uri.parse('$uri/api/v1/admin/change-order-status'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': user.token,
              },
              body: jsonEncode({
                'id': order.id,
                'status': status,
              }));
      httpErrorHandling(
        respense: res,
        context: context,
        onSucess: () => onSuccess(),
      );
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/v1/admin/analytics'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );
      // print(res.body);
      httpErrorHandling(
          respense: res,
          context: context,
          onSucess: () {
            var response = jsonDecode(res.body);
            totalEarning = response['totalEarnings'];
            sales = [
              Sales('Mobiles', response['mobileEarnings']),
              Sales('Essentials', response['essentialsEarnings']),
              Sales('Appliances', response['appliancesEarnings']),
              Sales('Books', response['booksEarnings']),
              Sales('Fashion', response['fashionEarnings']),
            ];

          });
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }

    return {
      'sales': sales,
      'totalEarning': totalEarning,
    };
  }
}
