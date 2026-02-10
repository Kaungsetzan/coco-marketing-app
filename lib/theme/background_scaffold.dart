import 'package:flutter/material.dart';
import 'package:marketing_app/theme/theme.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;

  const BackgroundScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    final glows = Theme.of(context).extension<BrandGlows>()!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      endDrawer: drawer,
      body: Stack(
        children: [
          // 1. The #F5F5F5 base
          Container(color: Theme.of(context).scaffoldBackgroundColor),

          // 2. Top-Right Branding Object (The Greenish Square-Circle)
          Positioned(
            top: -50,
            right: -80,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    glows.topGlow!.withOpacity(0.9),
                    glows.topGlow!.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // 3. Bottom-Left Branding Object (The Yellowish Glow)
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    glows.bottomGlow!.withOpacity(0.8),
                    glows.bottomGlow!.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // 4. Content Layer
          SafeArea(child: body),
        ],
      ),
    );
  }
}
