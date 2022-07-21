import 'package:amazon_clone/screens/admin/api/admin_api.dart';
import 'package:amazon_clone/models/product.dart';
import '../../../screens/account/widgets/product.dart';
import '../screens/add_product_screen.dart';
import '../../../widgets/loader.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<Product>? products;
  final AdminAPI _adminAPI = AdminAPI();

  void _navigateToAddProduct() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await _adminAPI.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    _adminAPI.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Loader()
        : Scaffold(
            body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                itemBuilder: (context, index) {
                  final productData = products![index];

                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(image: productData.images[0]),
                      ),
                      Container(
                        width: 180,
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                productData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  deleteProduct(productData, index);
                                },
                                icon: const Icon(Icons.delete_outline))
                          ],
                        ),
                      )
                    ],
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: _navigateToAddProduct,
              tooltip: 'Add a Product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
