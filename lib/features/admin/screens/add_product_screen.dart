import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce_application/common/widgets/custom_button.dart';
import 'package:e_commerce_application/common/widgets/custom_text_field.dart';
import 'package:e_commerce_application/constants/global_variables.dart';
import 'package:e_commerce_application/constants/utils.dart';
import 'package:e_commerce_application/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  List<File> images = [];
  final AdminServices adminServices = AdminServices();
  final _addProductKey = GlobalKey<FormState>();

  @override
  void dispose() {
    priceController.dispose();
    productController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  String category = 'Mobiles';
  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  void slectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_addProductKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProducts(
        context: context,
        name: productController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        images: images,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _addProductKey,
            child: Column(
              children: [
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                );
                              },
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction:
                              1, //to display across the width of the screen.
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: slectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [12, 6],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                                  'Select product images',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
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
                  controller: productController,
                  hintText: 'Product Name',
                  obsureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: productController,
                  hintText: 'Product Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Price',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: quantityController,
                  hintText: 'Quantity',
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    items: productCategories
                        .map(
                          (String item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        category = newValue.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Sell',
                  onTap: sellProduct,
                  color: GlobalVariables.secondaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
