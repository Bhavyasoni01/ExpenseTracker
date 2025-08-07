import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/add_page.dart';
import 'package:notes_app/pages/charts_page.dart';
import 'package:notes_app/pages/history_page.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/pages/profile_page.dart';

class Navigation extends StatefulWidget {
   const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _bottomNavIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ChartsPage(),
    HistoryPage(),
    ProfilePage(),
    AddPage()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          setState(() {
            _bottomNavIndex = 4;
          });
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          Icons.home,
          CupertinoIcons.chart_bar_alt_fill,
          Icons.receipt_long_rounded,
          CupertinoIcons.person_fill
        ], 
        gapLocation: GapLocation.center,
        backgroundColor: Colors.white,
        activeColor: Colors.deepPurple,
        inactiveColor: Colors.grey[500],
        shadow: Shadow(blurRadius: 0.3),
        notchSmoothness: NotchSmoothness.smoothEdge,
        activeIndex: _bottomNavIndex, 
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
      body: _bottomNavIndex == 4 ? AddPage() : _pages[_bottomNavIndex],
    );
  }
}