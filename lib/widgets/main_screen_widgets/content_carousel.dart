import 'package:flutter/material.dart';

class ContentCarousel extends StatelessWidget {
  final PageController controller;
  final int itemCount;
  final Function(int) onPageChanged;
  final Widget Function(BuildContext, int) itemBuilder;

  const ContentCarousel({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.onPageChanged,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: itemCount,
      onPageChanged: onPageChanged,
      itemBuilder: itemBuilder,
    );
  }
}
