import 'dart:convert';

import 'package:e_commerce_application/constants/error_handling.dart';
import 'package:e_commerce_application/constants/global_variables.dart';
import 'package:e_commerce_application/constants/utils.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:e_commerce_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeService {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return productList;
  }

  Future<Product> fetchDealOfTheDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(// we are declaring an empty product beacause if the deal of the day is not present then it will show an infinite loader to prevent we are using this say if name is empty then we will show a sizedbox.
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return product;
  }
}
