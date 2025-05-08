import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:movie_app/core/constant.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChange;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(16),
        ),
        child: GNav(
          color: Colors.white,
          selectedIndex: currentIndex,
          onTabChange: onTabChange,
          activeColor: kPrimaryColor,
          padding: const EdgeInsets.all(16),
          gap: 8,
          tabs: const [
            GButton(icon: Iconsax.home, text: "home"),
            GButton(icon: Iconsax.search_normal, text: "search"),
            GButton(icon: Iconsax.heart, text: "favorite"),
            GButton(icon: Iconsax.setting, text: "setting"),
          ],
        ),
      ),
    );
  }

}
