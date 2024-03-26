import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/serial/serial_list_page.dart';
import 'package:flutter/material.dart';


class BottomNavPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/home';
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => __BottomNavPageStateState();
}

class __BottomNavPageStateState extends State<BottomNavPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = [
    HomeMoviePage(),
    SerialListPage(),
    
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kRichBlack,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.movie,
              color: kMikadoYellow,
            ),
            icon: Icon(Icons.movie),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.tv,
              color: kMikadoYellow,
            ),
            icon: Icon(Icons.tv),
            label: 'Serial',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: kDavysGrey,
        selectedItemColor: kMikadoYellow,
        onTap: _onItemTap,
      ),
    );
  }
}