import 'package:amazon_clone/screens/cart/api/cart_api.dart';
import 'package:amazon_clone/screens/product/product_details_api.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {

  final ProductDetailsAPI _productDetailsAPI = ProductDetailsAPI();
  final CartAPI _cartAPI = CartAPI();

  void increaseQuantity(Product product)
  {
    _productDetailsAPI.addToCart(
      context: context, 
      product: product,
    );
  }
  void decreaseQuantity(Product product)
  {
    _cartAPI.removeFromCart(
      context: context, 
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                width: 135,
                height: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      product.name,
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
                    child: Text(
                      '\$${product.price}',
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
                      style: TextStyle(),
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
                      style: TextStyle(color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseQuantity(product),
                      child: Container(
                        height: 35,
                        width: 35,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      ),
                      child: Container(
                        height: 35,
                        width: 35,
                        alignment: Alignment.center,
                        child: Text('$quantity'),
                      ),
                    ),
                    InkWell(
                      onTap: () => increaseQuantity(product),
                      child: Container(
                        height: 35,
                        width: 35,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
