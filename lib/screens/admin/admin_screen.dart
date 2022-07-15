import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/screens/admin/screens/analytics_screen.dart';
import 'package:amazon_clone/screens/admin/screens/orders_screen.dart';
import 'package:amazon_clone/screens/admin/screens/posts_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  static const String routeName = '/admin';
  Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int _page = 0;
  double bottomBarWidth = 42; 
  double bottomBarBorderWidth = 5; 

  List<Widget> pages = [
    Posts(),
    Analytics(),
    const Orders(),
  ];
  void _updatePage(int page)
  {
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  height: 45,
                  width: 120,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Admin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ]
          ),
        )
      ),
      bottomNavigationBar:  BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          backgroundColor: GlobalVariables.backgroundColor,
          iconSize: 28,
          onTap: _updatePage,
          items: [
            //Post
            BottomBarItem(
              page: _page,
              pageNamber: 0,
              child: const Icon(Icons.home_outlined)
            ),
            //Analytics
            BottomBarItem(
              page: _page,
              pageNamber: 1,
              child: const Icon(Icons.analytics_outlined),
            ),
            //Orders
            BottomBarItem(
              page: _page,
              pageNamber: 2,
              child: const Icon(Icons.all_inbox_outlined),
            ),
          ]
        ),
      body: pages[_page]
    );
  }
  dynamic BottomBarItem({
    required int page, 
    required int pageNamber,
    required dynamic child,
    String label = '',
  })
  {
    return BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border( 
                  bottom: BorderSide(
                    color: page == pageNamber 
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth
                  ),
                )
              ),
              child: child,
            ),
            label: label,
          );
  }
}