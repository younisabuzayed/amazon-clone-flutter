import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/screens/product/product_details.dart';
import 'package:amazon_clone/widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedProduct extends StatefulWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<SearchedProduct> createState() => _SearchedProductState();
}

class _SearchedProductState extends State<SearchedProduct> {
  double avgRating = 0;
  void _navigateToProductDetail() {
    Navigator.pushNamed(
      context, 
      ProductDetails.routeName,
      arguments: widget.product,
    );
  }
  @override
  void initState() {
    super.initState();
    double totalRating = 0.0;
    for (int i = 0; i < widget.product.rating!.length; i++)
    {
      totalRating += widget.product.rating![i].rating;
    }
    if (totalRating != 0)
    {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap:_navigateToProductDetail,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: mediaQuery.size.width * 0.3,
                  child: Image.network(
                    widget.product.images[0],
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 135,
                  ),
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.64,
                  child: Column(
                    children: [
                      Container(
                        width: 235,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 5,
                        ),
                        child: Stars(rating: avgRating)
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 5,
                        ),
                        child: Text(
                          '\$${widget.product.price}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: const Text(
                          'Eligible for FREE Shipping',
                          style: TextStyle(
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: const Text(
                          'In Stock',
                          style: TextStyle(
                            color: Colors.teal
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
