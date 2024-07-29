import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess, //Function()?
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
    
  }
}
