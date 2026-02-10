import 'package:flutter/material.dart';
import 'package:marketing_app/screens/main_screen.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        SizedBox(
          width: 60,
          child: Image.asset(
            'assets/images/coco_logo.png',
            width: 60,
            height: 40,
            fit: BoxFit.contain,
            errorBuilder: (c, o, s) =>
                const Icon(Icons.broken_image, color: Colors.green),
          ),
        ),

        SizedBox(
          width: 140,
          child: const ScreenHeadline(text: "Choose\ncontent"),
        ),

        // Menu Icon
        IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: const Icon(Icons.segment, size: 32, color: PageColors.textDark),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}

class ScreenHeadline extends StatelessWidget {
  final String text;

  const ScreenHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Open Sans Hebrew', // Using user's font
        fontSize: 22,
        height: 1.1,
        fontWeight: FontWeight.w900,
        color: PageColors.textDark,
      ),
    );
  }
}
