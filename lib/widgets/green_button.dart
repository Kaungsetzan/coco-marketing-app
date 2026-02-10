import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {
  const GreenButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
  });

  final Function onPressed;
  final IconData? icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),

      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFF51AE44),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  // #D76F36 with 60% opacity (0.6)
                  color: const Color(0xFF5f8347),
                  // X = 4, Y = 4
                  offset: const Offset(4, 4),
                  // Adjust blurRadius to make it look "soft" or "sharp"
                  // Usually 4 to 8 works well for this offset
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: "Open Sans Hebrew",
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  icon ?? Icons.arrow_forward,
                  color: Colors.white,
                  size: 22,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
