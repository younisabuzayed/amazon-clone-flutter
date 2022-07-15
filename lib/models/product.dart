import 'dart:convert';

import 'package:amazon_clone/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final List<String> images;
  final String category;
  final String? id;
  final String? userId;
  final List<Rating>? rating;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.images,
    required this.category,
    required this.userId,
    this.id,
    this.rating
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'images': images,
      'category': category,
      'id': id,
      'userId': userId,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      id: map['_id'],
      userId: map['userId'],
      rating: map['ratings'] != null 
                ? List<Rating>.from(
                  map['ratings']?.map(
                    (x)=> Rating.fromMap(x)
                  )
                ): null,
    );
  }

  String toJson() => json.encode(toMap());
  factory Product.fromJson(String source) {
    return Product.fromMap(json.decode(source));
  }
}
