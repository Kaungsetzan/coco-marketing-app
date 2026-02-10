import 'package:flutter/material.dart';
import 'package:marketing_app/screens/main_screen.dart';

class InstructionLabel extends StatelessWidget {
  final String text;
  final double fontSize;

  const InstructionLabel({super.key, required this.text, this.fontSize = 15});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'CircularStd',
        fontSize: fontSize,
        color: PageColors.textLight,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
