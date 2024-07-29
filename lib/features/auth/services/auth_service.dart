// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_application/constants/error_handling.dart';
import 'package:e_commerce_application/constants/global_variables.dart';
import 'package:e_commerce_application/constants/utils.dart';
import 'package:e_commerce_application/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
