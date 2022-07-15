import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/data/apis/search_api.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/screens/home/widget/address_box.dart';
import 'package:amazon_clone/screens/home/widget/header.dart';
import 'package:amazon_clone/screens/search/widgets/searched_product.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  static const routeName = '/search-screen';
  final String searchQuery;
  const Search({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Product>? products;
  final SearchAPI _searchAPI = SearchAPI();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await _searchAPI.fetchSearchedProduct(
      context: context,
      searchQuery: widget.searchQuery,
    );
    setState(() {});
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
      body: products == null
          ? const Loader()
          : products!.isEmpty
              ? const Center(child: Text('No find any product'))
              : Column(
                  children: [
                    const AddressBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric( vertical: 5),
                            child: SearchedProduct(
                              product: products![index],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
    );
  }
}
