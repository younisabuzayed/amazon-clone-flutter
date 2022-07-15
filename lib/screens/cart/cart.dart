import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/screens/address/address_screen.dart';
import 'package:amazon_clone/screens/cart/widget/cart_product.dart';
import 'package:amazon_clone/screens/cart/widget/cart_subtotal.dart';
import 'package:amazon_clone/screens/home/widget/address_box.dart';
import 'package:amazon_clone/screens/home/widget/header.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}
void navigateToAddress(
    BuildContext context,
    User user
    ) {
    Navigator.pushNamed(
      context, 
      Address.routeName,
      arguments: user,
    );
  }

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
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
          child: Column(
        children: [
          AddressBox(),
          CartSubtotal(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              title: 'Proceed to Buy (${user.cart.length}) items',
              onPressed: () => navigateToAddress(context, user),
              color: Colors.yellow[700],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            itemCount: user.cart.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CartProduct(index: index,);
            },
          )
        ],
      )),
    );
  }
}
