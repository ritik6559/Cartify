import 'package:e_commerce_application/common/widgets/loader.dart';
import 'package:e_commerce_application/features/account/widgets/single_product.dart';
import 'package:e_commerce_application/features/admin/services/admin_services.dart';
import 'package:e_commerce_application/features/order_details/screens/order_details_screen.dart';
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
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final order = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailsScreen.routeName,
                    arguments: order,
                  );
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    image: order.products[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
