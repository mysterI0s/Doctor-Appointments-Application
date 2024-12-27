import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      this.minWidth = double.infinity,
      required this.text,
      required this.onPressed});

  final double minWidth;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      color: AppColors.primaryColor,
      minWidth: minWidth,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
      ),
    );
  }
}
