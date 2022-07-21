import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/screens/auth/api/auth_api.dart';
import 'package:amazon_clone/screens/product/product_details_api.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/screens/home/widget/header.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/stars.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ProductDetailsAPI _productDetailsAPI = ProductDetailsAPI();
  final AuthAPI auth = AuthAPI();
  double avgRating = 0;
  double myRating = 0;

  @override
  initState() {
    super.initState();
    double totalRating = 0.0;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.userId == user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void addToCart() {
    _productDetailsAPI.addToCart(context: context, product: widget.product);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.product.id!), Stars(rating: avgRating)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Text(
                widget.product.name,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map((i) {
                return Builder(builder: (BuildContext context) {
                  return Image.network(
                    i,
                    fit: BoxFit.cover,
                    height: 300,
                  );
                });
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: 'Deal Price: ',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\$${widget.product.price}',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                title: 'Buy Now',
                onPressed: () {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                title: 'Add to Cart',
                onPressed: addToCart,
                color: const Color.fromRGBO(254, 216, 19, 1),
                textColor: Colors.black,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 3,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Rate The Product',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    ),
                onRatingUpdate: (rating) {
                  _productDetailsAPI.rateProduct(
                    context: context,
                    product: widget.product,
                    rating: rating,
                  );
                }),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
