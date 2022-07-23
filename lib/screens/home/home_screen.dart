import 'package:amazon_clone/screens/home/widget/address_box.dart';
import 'package:amazon_clone/screens/home/widget/carousel_image.dart';
import 'package:amazon_clone/screens/home/widget/categories.dart';
import 'package:amazon_clone/screens/home/widget/deal_of_day.dart';
import 'package:flutter/material.dart';
import '../../constants/global_variables.dart';
import '../../provider/user_provider.dart';
import './widget/header.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
          ),
          title: Header(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const AddressBox(),
              const SizedBox(
                height: 10,
              ),
              const Categories(),
              const SizedBox(
                height: 10,
              ),
              CarouselImage(),
              DealOfDay(),
              // Text(
              //   user.toJson(),
              //   style: const TextStyle(fontSize: 20),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
