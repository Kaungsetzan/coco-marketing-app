import 'package:flutter/material.dart';

class AppColors {
  static const Color scaffoldBase = Color(0xFFF5F5F5); // The grey background
  static const Color primaryOrange = Color(0xFFD9733E);
  static const Color brandGreen = Color(0xFF51AE44);

  // The specific glow object colors from your branding
  static const Color topGlow = Color(0xFFE2F0D9);
  static const Color bottomGlow = Color(0xFFFFF2CC);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBase,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryOrange,
        primary: AppColors.primaryOrange,
        secondary: AppColors.brandGreen,
      ),
      primaryColor: AppColors.primaryOrange,
      extensions: [
        const BrandGlows(
          topGlow: AppColors.topGlow,
          bottomGlow: AppColors.bottomGlow,
        ),
      ],
      // This fixes your Card color issue globally
      cardTheme: const CardThemeData(
        color: AppColors.scaffoldBase,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}

class BrandGlows extends ThemeExtension<BrandGlows> {
  final Color? topGlow;
  final Color? bottomGlow;
  const BrandGlows({this.topGlow, this.bottomGlow});

  @override
  BrandGlows copyWith({Color? topGlow, Color? bottomGlow}) => BrandGlows(
    topGlow: topGlow ?? this.topGlow,
    bottomGlow: bottomGlow ?? this.bottomGlow,
  );

  @override
  BrandGlows lerp(ThemeExtension<BrandGlows>? other, double t) {
    if (other is! BrandGlows) return this;
    return BrandGlows(
      topGlow: Color.lerp(topGlow, other.topGlow, t),
      bottomGlow: Color.lerp(bottomGlow, other.bottomGlow, t),
    );
  }
}
