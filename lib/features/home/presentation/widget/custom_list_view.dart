import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            );
          },
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
