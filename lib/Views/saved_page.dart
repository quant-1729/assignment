import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
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
              "Saved post will appear here"
          ),
        ),
      ),
    );
  }
}
