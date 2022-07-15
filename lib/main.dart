import 'package:amazon_clone/data/apis/auth_api.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/screens/admin/admin_screen.dart';
import 'package:amazon_clone/screens/auth/auth_screen.dart';
import 'package:amazon_clone/widgets/bottom_bar.dart';
import 'package:provider/provider.dart';

import '../constants/global_variables.dart';
import '../route/route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthAPI auth = AuthAPI();
  @override
  void initState() {
    super.initState();
    AuthAPI().getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ))),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
          ? BottomBar()
          : Admin()
          : Auth(),
    );
  }
}
