import 'package:flutter/material.dart';


class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
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
              "People will appear here"
          ),
        ),
      ),
    );
  }
}
