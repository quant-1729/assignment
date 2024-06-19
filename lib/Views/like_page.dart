import 'package:flutter/material.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAFB),
        leading: Icon(Icons.menu), // Three line icon
        title: Text('DEMO APP'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ), // Right most icon
        ],
      ),
      body: Container(
        child: Center(
          child: Text(
            "Liked post will appear here"
          ),
        ),
      ),
    );
  }
}
