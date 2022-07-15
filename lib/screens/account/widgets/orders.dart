import 'package:amazon_clone/data/apis/account_api.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/screens/order-details/order_details.dart';
import 'package:amazon_clone/widgets/loader.dart';

import '../../../constants/global_variables.dart';
import './product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountAPI _accountAPI = AccountAPI();
  // List listImage = [
  //   'https://images.unsplash.com/photo-1655387446926-2dd64e408dcc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
  //   'https://images.unsplash.com/photo-1655329943539-1297fbd0923f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
  //   'https://images.unsplash.com/photo-1655393002598-a97a97273210?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
  //   'https://images.unsplash.com/photo-1655432884529-1730575579d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
  //   'https://images.unsplash.com/photo-1655338520540-4b29300e2b36?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
  // ];
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await _accountAPI.fetchMyOrder(context: context);
    setState(() {
      
    });
  }

  void NavigatorToOrder(Order order)
  {
    Navigator.pushNamed(
      context, 
      OrderDetails.routeName,
      arguments: order
    );
  }
  @override
  Widget build(BuildContext context) {
    return orders == null 
     ? const Loader()
     : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'Your Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: Text(
                'See All',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.take(2).length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap:() =>  NavigatorToOrder(orders![index]),
                child: SingleProduct(
                  image: orders![index].products[0].images[0],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
