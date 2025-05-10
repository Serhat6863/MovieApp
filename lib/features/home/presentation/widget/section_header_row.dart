import 'package:flutter/material.dart';

import '../../../../core/constant.dart';

class SectionHeaderRow extends StatelessWidget {
  const SectionHeaderRow({super.key, required this.text, required this.textButton});

  final String text;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: kTextColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),

        Spacer(),

        TextButton(
          onPressed: (){},
          child: Text(
            textButton,
            style: TextStyle(
              color: kTextColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
