import 'package:amazon_clone/screens/admin/api/admin_api.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/screens/account/widgets/product.dart';
import 'package:amazon_clone/screens/order-details/order_details.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AdminAPI _adminAPI = AdminAPI();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  fetchOrders() async
  {
    orders = await _adminAPI.fetchAllOrders(context);
    setState(() {
      
    });
  }
  navigatorToDetails(Order order)
  {
    Navigator.pushNamed(
      context, 
      OrderDetails.routeName, 
      arguments: order
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( 
        top: 10,
        left: 10,
        right: 10,
      ),
      child: orders == null
        ? const Loader()
        : GridView.builder(
          itemCount: orders!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
          ),
          itemBuilder: (context, index)
          {
            final orderData = orders![index];
            return GestureDetector(
              onTap: () => navigatorToDetails(orderData),
              child: SizedBox(
                height: 140,
                child: SingleProduct(
                  image: orderData.products[0].images[0],
                ),
              ),
            );
          },
      ),
    );
  }
}
