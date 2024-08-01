import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        tooltip: "Add Products",
        onPressed: () {},
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        ),
      ),
      body: const Center(
        child: Text('Products'),
      ),
    );
  }
}
