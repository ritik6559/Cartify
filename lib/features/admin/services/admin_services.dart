import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:e_commerce_application/constants/utils.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:flutter/material.dart';

class AdminServices {
  void sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('ddfhvzddv', 'rxfjvmid');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        //getting images path and uploading to cloudinary.
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path,
              folder:
                  name), //creating folder for each product and stroing product images in that folder.
        );
        imageUrls.add(res
            .secureUrl); //it's the same as download url that we get in firebase.
      }

      //we will be storing images in cloudinary and urls in mongodb as we are getting limited memory(512 Mb) that is not sufficient.
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
