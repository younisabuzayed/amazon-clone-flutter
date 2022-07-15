import 'package:amazon_clone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  final List<Widget> items = GlobalVariables.carouselImages.map((i) {
    return Builder(builder: (BuildContext context) {
      return Image.network(
        i,
        fit: BoxFit.cover,
        height: 200,
      );
    });
  }).toList();
  CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items, 
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
