// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/widgets/bottom_bar.dart';

import '../../constants/error_handling.dart';
import '../../constants/global_variables.dart';
import '../../constants/utils/shown_snack_bar.dart';
import '../../provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class AuthAPI {
  //Sign Up Calling API
  final String tokenKey = 'x-auth-token';
  void SignUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // User user = User(
      //   id: '',
      //   name: name,
      //   email: email,
      //   password: password,
      //   address: '',
      //   type: '',
      //   token: '',
      // );
      http.Response res = await http.post(Uri.parse('$uri/api/v1/user/signup'),
          body:
              jsonEncode({'email': email, 'password': password, 'name': name}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandling(
          respense: res,
          context: context,
          onSucess: () async {
            ShownSnackBar(context, 'Account created!');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(tokenKey, jsonDecode(res.body)['tokenJwt']);
            Navigator.pushNamed(context, BottomBar.routeName);
          });
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }
  }

  // Sign In calling API
  void SignInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/v1/user/signIn'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandling(
          respense: res,
          context: context,
          onSucess: () async {
            // ShownSnackBar(context, 'Account created! Login please');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(tokenKey, jsonDecode(res.body)['tokenJwt']);
            Navigator.pushNamed(context, BottomBar.routeName);
          });
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }
  }

  //Get Data from API using Token
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(tokenKey);
      if (token == null) {
        prefs.setString(tokenKey, '');
      }
      http.Response resToken = await http.post(
          Uri.parse('$uri/api/v1/user/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!,
          });
      var response = jsonDecode(resToken.body);
      if (response == true) {
        http.Response userRes = await http
            .get(Uri.parse('$uri/api/v1/user/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        // print(jsonDecode(userRes.body)['total'] as double);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      ShownSnackBar(context, e.toString());
    }
  }
}
