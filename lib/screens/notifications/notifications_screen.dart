import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/screens/notifications/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  static const String routeName = "/notifications";
  Notifications({Key? key}) : super(key: key);

  List<Map<String, dynamic>> listNotification = [
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone old",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
    {
      "title": "Iphone",
      "description": "Your product send to delivery",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ));
    return Scaffold(
      appBar: appBar,
      body: Container(
        // width: double.infinity,
        padding: const EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child: ListView.builder(
          itemCount: listNotification.length,
          itemBuilder: (ctx, index)
          {
            return CustomCard(
              title: listNotification[index]['title'],
              description: listNotification[index]['description'],
            );
          }
        ),
      ),
    );
  }
}
