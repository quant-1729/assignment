import 'package:assignment/Views/like_page.dart';
import 'package:assignment/Views/people_page.dart';
import 'package:assignment/Views/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:assignment/Services/api_services.dart';
import 'package:assignment/Views/custom_card.dart';
import '../DTO/post_dto.dart'; // Importing the separate class for cards

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<PostDTO>> futurePosts;

  // For Advanced Task one
  TextEditingController searchController = TextEditingController();

  // For Advanced Task two
  // Assuming some categories by our own
  final List<String> categories = ['All', 'Sports', 'Appliances', 'People', 'Clothing'];
  // Declaring the initial category as ALL as default
  String selectedCategory = 'All';




  @override
  void initState() {
    super.initState();
    futurePosts = ApiServices().fetchPosts(context); // Corrected to ApiService
  }

   showCategorySelectionMenu(BuildContext context) {
     return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: categories.map((category) {
            return ListTile(
              title: Text(category),
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      home: Scaffold(
        backgroundColor: Color(0xFFC6C4C4),
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
        body: Column(
          children: [
            SizedBox(height: 2),
            Container(
              height: 67,
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          // To update UI based on text input
                        });
                      },
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Search messages',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF99A2AD),
                        ),
                        prefixIcon: Icon(Icons.search, size: 22, color: Color(0xFF99A2AD)), // Internal search icon
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFEBF2FA),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Spacing between text field and image icon
                  IconButton(
                    onPressed: () {
                      // Implementing the categories feature through this icon
                      showCategorySelectionMenu(context);
                    },
                    icon: Icon(CupertinoIcons.slider_horizontal_3, size: 35, color: Color(0xFF0A66C2)),
                  ), // Replace with your asset
                ],
              ),
            ),
            Expanded(child: fetchCard(context)), // Flexible to Expanded
          ],
        ),
      ),
    );
  }

  Widget fetchCard(BuildContext context) {
    return FutureBuilder<List<PostDTO>>(
      future: futurePosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No posts found'));
        } else {
          var posts = snapshot.data!;

          // Implementing the filter logic
          if (searchController.text.isNotEmpty) {
            posts = posts.where((post) =>
            post.title.toLowerCase().contains(searchController.text.toLowerCase()) ||
                post.userId.toLowerCase().contains(searchController.text.toLowerCase()) ||
                post.eventCategory.toLowerCase().contains(searchController.text.toLowerCase())).toList();
          }

          // Implementing the category filter
          if (selectedCategory != 'All') {
            posts = posts.where((post) => post.eventCategory == selectedCategory).toList();
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return CustomCard(post: posts[index]);
            },
          );
        }
      },
    );
  }
}
