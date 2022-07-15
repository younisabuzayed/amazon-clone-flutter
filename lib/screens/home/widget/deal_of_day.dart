import 'package:amazon_clone/data/apis/home_api.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/screens/product/product_details.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeAPI _homeAPI = HomeAPI();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async 
  {
    product = await _homeAPI.fetchDealOfDay(context: context);
    setState(() {});
  }
  void _navigateToProductDetail() {
      Navigator.pushNamed(
        context, 
        ProductDetails.routeName,
        arguments: product,
      );
    }
  @override
  Widget build(BuildContext context) {
    return product == null 
      ? const Loader()
      : product!.name.isEmpty ? const SizedBox()
      : Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: const Text(
            'Deal of Day',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        GestureDetector(
          onTap: _navigateToProductDetail,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Image.network(
              product!.images[0],
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            "\$${product!.price}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            left: 15,
            top: 5,
            right: 40,
          ),
          child: const Text(
            'Younis',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: 
            product!.images.map((e) {
              return Image.network(
                e,
                fit: BoxFit.contain,
                width: 100,
                height: 100,
              );
            }).toList(),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            'See all deals',
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        ),
      ],
    );
  }
}
