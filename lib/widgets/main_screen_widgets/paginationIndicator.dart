import 'package:flutter/material.dart';
import 'package:marketing_app/screens/main_screen.dart';

class PaginationIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const PaginationIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final bool isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? PageColors.dotActive : PageColors.dotInactive,
          ),
        );
      }),
    );
  }
}
