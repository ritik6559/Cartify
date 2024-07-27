import 'package:e_commerce_application/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_application/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon',
      theme: ThemeData(

      ),
      home: const AuthScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
