import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/screens/home/api/home_api.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/screens/product/product_details.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  static const String routeName = '/category';
  final String category;
  Category({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<Product>? products;
  final HomeAPI _homeAPI = HomeAPI();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async
  {
    products = await _homeAPI.fetchCategoryProducts(
      context: context, 
      category: widget.category
    );
    setState(() {
      
    });
  }
  void _navigateToProductDetail(Product product) {
    Navigator.pushNamed(
      context, 
      ProductDetails.routeName,
      arguments: product,
    );
  }
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
      title: Text(
        widget.category,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar,
      ),
      body: products == null 
       ? Loader() 
       : products!.isEmpty ? const Center(
        child: Text('Not find Products'),
       )
       : Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: Text(
              'Keep shopping for ${widget.category}',
              style: const TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          Container(
            height: 170,
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product = products![index];
                  return GestureDetector(
                    onTap: () => _navigateToProductDetail(product),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.network(product.images[0]),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                            left: 0,
                            top: 5,
                            right: 15,
                          ),
                          child: Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

/*
 (MediaQuery.of(context).size.height
              - MediaQuery.of(context).padding.top
              - appBar.preferredSize.height) * .95, */