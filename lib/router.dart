import 'package:e_commerce_application/common/widgets/bottom_bar.dart';
import 'package:e_commerce_application/features/address/screens/address_screen.dart';
import 'package:e_commerce_application/features/admin/screens/add_product_screen.dart';
import 'package:e_commerce_application/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_application/features/home/screens/category_deals_screen.dart';
import 'package:e_commerce_application/features/home/screens/home_screen.dart';
import 'package:e_commerce_application/features/order_details/screens/order_details_screen.dart';
import 'package:e_commerce_application/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_application/features/search/screens/search_screen.dart';
import 'package:e_commerce_application/models/order.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );

    case AddressScreen.routeName:
      var totalPrice = routeSettings.arguments as String;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalPrice,
        ),
      );
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreen(
          order: order,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (contetx) => const Scaffold(
          body: Center(
            child: Text('Screen not found'),
          ),
        ),
      );
  }
}
