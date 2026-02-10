import 'package:flutter/material.dart';
import 'package:marketing_app/theme/background_scaffold.dart';
import 'package:marketing_app/widgets/green_button.dart';

// --- App Colors ---
class AppColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color textDark = Color(0xFF384335);
  static const Color textGreen = Color(0xFF5D7B54);
  static const Color accentOrange = Color(0xFFD9733E);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color buttonGreen = Color(0xFFD0E8B8);
  static const Color buttonShadow = Color(0xFF5D7B54);
  static const Color divider = Color(0xFFE0E0E0);
}

// --- Main Screen ---
class EstimateReachScreen extends StatelessWidget {
  final String radius;
  final String audience;
  final int dailyBudget; // Numeric for calculation
  final int durationDays; // Numeric for calculation

  const EstimateReachScreen({
    super.key,
    required this.radius,
    required this.audience,
    required this.dailyBudget,
    required this.durationDays,
  });

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: const BoostingAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            EstimateReachCard(
              radius: radius,
              audience: audience,
              dailyBudget: dailyBudget,
              durationDays: durationDays,
            ),
            const SizedBox(height: 24),
            const PaymentMethodCard(cardLastFour: "3367"),
            const SizedBox(height: 40),
            GreenButton(
              text: "Activate Boost",
              onPressed: () => {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Boost activated!"))),
                Navigator.of(context)
                  ..pop()
                  ..pop(),
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- UI Components ---

class ScreenHeadline extends StatelessWidget {
  final String text;

  const ScreenHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'CircularStd',
        fontSize: 26,
        height: 1.1,
        fontWeight: FontWeight.w900,
        color: AppColors.textDark,
      ),
    );
  }
}

class BoostingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BoostingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textDark,
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: const ScreenHeadline(text: "Boosting"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class OffsetCardContainer extends StatelessWidget {
  final Widget child;
  const OffsetCardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The 3D Orange Offset/Border

        // The Main Card
        Container(
          margin: const EdgeInsets.only(bottom: 4, right: 4),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                // #D76F36 with 60% opacity (0.6)
                color: const Color(0xD76F36).withValues(alpha: 0.6),
                // X = 4, Y = 4
                offset: const Offset(4, 4),
                // Adjust blurRadius to make it look "soft" or "sharp"
                // Usually 4 to 8 works well for this offset
                blurRadius: 0,
                spreadRadius: 0,
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}

class EstimateReachCard extends StatelessWidget {
  final String radius;
  final String audience;
  final int dailyBudget;
  final int durationDays;

  const EstimateReachCard({
    super.key,
    required this.radius,
    required this.audience,
    required this.dailyBudget,
    required this.durationDays,
  });

  @override
  Widget build(BuildContext context) {
    final int totalFees = dailyBudget * durationDays;

    return OffsetCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Estimate reach",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.textGreen,
              fontFamily: 'CircularStd',
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 16),
          EstimateRow(
            icon: Icons.location_on_outlined,
            label: "Radius",
            value: radius,
          ),
          const SizedBox(height: 16),
          EstimateRow(
            icon: Icons.person_search_outlined,
            label: "Target audiences",
            value: audience,
          ),
          const SizedBox(height: 16),
          EstimateRow(
            icon: Icons.monetization_on_outlined,
            label: "Daily budget",
            value: "\$$dailyBudget/day",
            highlightValue: true,
          ),
          const SizedBox(height: 16),
          EstimateRow(
            icon: Icons.watch_later_outlined,
            label: "Campaign duration",
            value: "${durationDays}days",
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total fees",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textGreen,
                ),
              ),
              Text(
                "$totalFees\$",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EstimateRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool highlightValue;

  const EstimateRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.highlightValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: AppColors.textGreen),
        const SizedBox(width: 12),
        Text(
          "$label: ",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: highlightValue
                ? AppColors.accentOrange
                : AppColors.textGreen,
          ),
        ),
      ],
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final String cardLastFour;

  const PaymentMethodCard({super.key, required this.cardLastFour});

  @override
  Widget build(BuildContext context) {
    return OffsetCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payment method",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.textGreen,
              fontFamily: 'CircularStd',
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "VISA card starting $cardLastFour ---- ---- ",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentOrange,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.textGreen),
            ],
          ),
        ],
      ),
    );
  }
}
