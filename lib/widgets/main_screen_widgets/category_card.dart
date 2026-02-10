import 'package:flutter/material.dart';
import 'package:marketing_app/screens/main_screen.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(
              30,
            ), // Slight asymmetry matching visual style
          ),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [PageColors.cardOrangeTop, PageColors.cardOrangeBottom],
          ),
          boxShadow: [
            BoxShadow(
              color: PageColors.cardOrangeBottom.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Bubble
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: PageColors.iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: PageColors.cardOrangeBottom),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 16,
                  height: 1.4,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
