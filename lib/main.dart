import 'package:assignment/Views/Mainpage.dart';
import 'package:flutter/material.dart';

import 'Views/like_page.dart';
import 'Views/people_page.dart';
import 'Views/saved_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {


  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // Bottom navigation bar functioning
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    MainPage(),
    LikePage(),
    PeoplePage(),
    SavedPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(

        home:Scaffold(
          body: Stack(children: [
            _pages[_selectedIndex],
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
                    selectedItemColor: Color(0xFF0A66C2),
                    unselectedItemColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped,
                  ),
                ),
              ),
            ),

          ]),
        ));
  }
}

