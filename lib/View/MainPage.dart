import 'package:flutter/material.dart';
import 'package:tmdb_testapp/View/NowPlayingScreen.dart';
import 'package:tmdb_testapp/View/TopRatedScreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Method to handle on tap event for bottom navigation bar items
  void _onTapBottomNavItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // // Method to provide different page for different selected items
  // final List<Widget> _screens = <Widget>[
  //   new NowPlaying(
  //     isNowPlaying: false,
  //   ),
  //   new NowPlaying(
  //     isNowPlaying: false,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1BA5E),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffF1BA5E),
        currentIndex: _selectedIndex,
        onTap: _onTapBottomNavItem,
        elevation: 5,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation),
            label: 'Now Playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Top Rated',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [new NowPlaying(), new TopRatedScreen()],
      ),
    );
  }
}
