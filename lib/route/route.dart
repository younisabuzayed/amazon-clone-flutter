import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/screens/address/address_screen.dart';
import 'package:amazon_clone/screens/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/screens/home/screens/category_screen.dart';
import 'package:amazon_clone/screens/notifications/notifications_screen.dart';
import 'package:amazon_clone/screens/order-details/order_details.dart';
import 'package:amazon_clone/screens/product/product_details.dart';
import 'package:amazon_clone/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/error/error_screen.dart';
import '../widgets/bottom_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Auth.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Auth(),
      );
    case Home.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Home(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProduct(),
      );
    case Address.routeName:
      var user = routeSettings.arguments as User;
      
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Address(
          user: user,
        ),
      );
    case Category.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Category(
          category: category,
        ),
      );
    case Search.routeName:
      var search = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Search(
          searchQuery: search,
        ),
      );
    case ProductDetails.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetails(
          product: product,
        ),
      );
    case OrderDetails.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetails(
          order: order,
        ),
      );
    case Notifications.routeName:
      return MaterialPageRoute(
        builder: (_) => Notifications(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Error(),
      );
  }
}
