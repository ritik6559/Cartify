import 'package:e_commerce_application/features/account/widgets/single_product.dart';
import 'package:e_commerce_application/features/admin/services/admin_services.dart';
import 'package:e_commerce_application/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final AdminServices adminServices = AdminServices();
  List<Order>? orders = [];

  @override
  void initState() {
    super.initState();
    getAllOrders();
  }

  void getAllOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: orders!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final order = orders![index];
        return SizedBox(
          height: 140,
          child: SingleProduct(
            image: order.products[0].images[0],
          ),
        );
      },
    );
  }
}
