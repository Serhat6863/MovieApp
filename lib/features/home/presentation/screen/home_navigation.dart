import 'package:flutter/material.dart';
import 'package:movie_app/features/home/presentation/screen/home_screen.dart';

import '../../../../core/constant.dart';
import '../widget/bottom_navigation.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {

  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    TestScreenSecond(),
    TalScreen(),
    TolScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTabChange: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
