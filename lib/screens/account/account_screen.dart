// ignore_for_file:

import 'package:amazon_clone/screens/account/widgets/orders.dart';
import 'package:amazon_clone/screens/account/widgets/top_buttons.dart';

import '../../constants/global_variables.dart';
import './widgets/below_app_bar.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget
{
  Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15
                ),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15
                      ),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search_outlined),
                  ],
                ),
              )
            ]
          ),
        )
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const BelowAppBar(),
          const SizedBox(height: 10),
          TopButtons(),
          const SizedBox(height: 20),
          Orders(),
        ],
      )
    );
  }
}