import 'package:assignment/Services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assignment/Views/custom_card.dart';
import 'package:http/http.dart';
import '../DTO/post_dto.dart'; // Importing the separate class for cards

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<PostDTO>> futurePosts;
  TextEditingController search_controller= TextEditingController();

  @override
  void initState() {
    super.initState();
    futurePosts = PostService().fetchPosts(context);
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
          actions: [Icon(Icons.shopping_cart)], // Right most icon
        ),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 2),
                Container(
                  height: 67,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(left: 16, right: 14.5, top: 10.5, bottom: 12.5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: search_controller,
                          onChanged: (value){
                            setState(() {
                              // So as to change the UI when user types something in the textfield
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
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.slider_horizontal_3, size: 35, color: Color(0xFF0A66C2)),
                      ), // Replace with your asset
                    ],
                  ),
                ),
                Expanded(child: fetchcard(context)),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(16), // Distance from the bottom and sides
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10), // Circular radius
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.black,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        activeIcon: Icon(Icons.home, size: 32, color: Color(0xFF0A66C2)),
                        icon: Icon(Icons.home, size: 32, color: Colors.white),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(Icons.favorite, size: 32, color: Color(0xFF0A66C2)),
                        icon: Icon(Icons.favorite, size: 32, color: Colors.white),
                        label: 'Like',
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(Icons.people, size: 32, color: Color(0xFF0A66C2)),
                        icon: Icon(Icons.people, size: 32, color: Colors.white),
                        label: 'People',
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(Icons.save, size: 32, color: Color(0xFF0A66C2)),
                        icon: Icon(Icons.save, size: 32, color: Colors.white),
                        label: 'Saved',
                      ),
                    ],
                    selectedItemColor: Color(0xFF0A66C2), // Active label text color
                    unselectedItemColor: Colors.white, // Inactive label text color
                    type: BottomNavigationBarType.fixed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fetchcard(BuildContext context) {
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

          // Implementing the filer logic
          if(search_controller.text.isNotEmpty){
            posts = posts.where((posts)=> 
            // filetring by title
              posts.title.toLowerCase().contains(search_controller.text.toLowerCase()) || 
              posts.userId.toLowerCase().contains(search_controller.text.toLowerCase()) ||
                posts.eventCategory.toLowerCase().contains(search_controller.text.toLowerCase())
            ).toList(); 
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
