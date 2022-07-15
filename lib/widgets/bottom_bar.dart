import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/screens/cart/cart.dart';
import 'package:provider/provider.dart';

import '../constants/global_variables.dart';
import '../screens/account/account_screen.dart';
import '../screens/home/home_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    Home(),
    Account(),
    Cart(),
  ];
  void _updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: pages[_page],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _page,
            selectedItemColor: GlobalVariables.selectedNavBarColor,
            unselectedItemColor: GlobalVariables.unselectedNavBarColor,
            backgroundColor: GlobalVariables.backgroundColor,
            iconSize: 28,
            onTap: _updatePage,
            items: [
              //Home
              BottomBarItem(
                  page: _page,
                  pageNamber: 0,
                  child: const Icon(Icons.home_outlined)),
              //Account
              BottomBarItem(
                  page: _page,
                  pageNamber: 1,
                  child: const Icon(Icons.person_outline_outlined)),
              //Account
              BottomBarItem(
                  page: _page,
                  pageNamber: 2,
                  child: Badge(
                      elevation: 0,
                      badgeContent: Text('$userCartLen'),
                      badgeColor: Colors.white,
                      child: const Icon(Icons.shopping_cart_outlined))),
            ]),
      ),
    );
  }

  dynamic BottomBarItem({
    required int page,
    required int pageNamber,
    required dynamic child,
    String label = '',
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: bottomBarWidth,
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
              color: page == pageNamber
                  ? GlobalVariables.selectedNavBarColor
                  : GlobalVariables.backgroundColor,
              width: bottomBarBorderWidth),
        )),
        child: child,
      ),
      label: label,
    );
  }
}
