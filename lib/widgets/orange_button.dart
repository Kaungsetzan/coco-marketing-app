import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  const OrangeButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
  });

  final IconData? icon;
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,

      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFD9733E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  // #D76F36 with 60% opacity (0.6)
                  color: const Color(0xffD76F36).withValues(alpha: 0.6),
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
