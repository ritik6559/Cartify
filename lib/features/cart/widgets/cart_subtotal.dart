import 'package:e_commerce_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int subtotal = 0;
    user.cart.forEach(
        (e) => subtotal += e['quantity'] * e['product']['price'] as int);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'SubTotal:- ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            "\$$subtotal",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
