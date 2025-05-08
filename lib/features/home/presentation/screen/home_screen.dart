import 'package:flutter/material.dart';

import '../../../../core/constant.dart';
import '../widget/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    TestScreen(),
    TestScreenSecond(),
    TalScreen(),
    TolScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: _screens[_currentIndex], // 👈 ici tu changes juste ça
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTabChange: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}


class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Test Screen", style: TextStyle(color: Colors.white, fontSize: 20),),
    );
  }
}

class TestScreenSecond extends StatelessWidget {
  const TestScreenSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Test Screen Second", style: TextStyle(color: Colors.white, fontSize: 20),),
    );
  }
}

class TalScreen extends StatelessWidget {
  const TalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Test Screen Third", style: TextStyle(color: Colors.white, fontSize: 20),));
  }
}

class TolScreen extends StatelessWidget {
  const TolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Test Screen Fourth", style: TextStyle(color: Colors.white, fontSize: 20),));
  }
}

