import 'dart:io';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils/pick_images.dart';
import 'package:amazon_clone/data/apis/admin_api.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/custom_textfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _procductNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quntityNameController = TextEditingController();

  final AdminAPI _adminAPI = AdminAPI();
  final _addProductFormKey = GlobalKey<FormState>();
  String category = 'Mobiles';
  List<File> images = [];
  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  @override
  void dispose() {
    super.dispose();
    _procductNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quntityNameController.dispose();
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      _adminAPI.sellProduct(
          context: context,
          name: _procductNameController.text,
          description: _descriptionController.text,
          price: double.parse(_priceController.text),
          quantity: double.parse(_quntityNameController.text),
          category: category,
          images: images,
        );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Text(
              "Add Product",
              style: TextStyle(color: Colors.black),
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            key: _addProductFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) {
                          return Builder(builder: (BuildContext context) {
                            return Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            );
                          });
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          radius: const Radius.circular(10),
                          borderType: BorderType.RRect,
                          dashPattern: const [10, 5],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Select Product Image',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: _procductNameController,
                  label: 'Product Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _priceController,
                  label: 'Price',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _quntityNameController,
                  label: 'Quntity',
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      items: productCategories.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          category = newVal!;
                        });
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  title: 'Sell', 
                  onPressed: sellProduct,
                ),
              ],
            )),
      ),
    );
  }
}
