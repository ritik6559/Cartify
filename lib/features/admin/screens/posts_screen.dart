import 'package:e_commerce_application/common/widgets/loader.dart';
import 'package:e_commerce_application/features/account/widgets/single_product.dart';
import 'package:e_commerce_application/features/admin/screens/add_product_screen.dart';
import 'package:e_commerce_application/features/admin/services/admin_services.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  void navigateToProductScreen() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  final AdminServices adminServices = AdminServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
      },
    );
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  } //When no return type is specified before the function name, Dart infers the return type as Future<void>.

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              tooltip: "Add Products",
              onPressed: () {},
              child: IconButton(
                onPressed: navigateToProductScreen,
                icon: const Icon(Icons.add),
              ),
            ),
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteProduct(productData,index),
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
  }
}
