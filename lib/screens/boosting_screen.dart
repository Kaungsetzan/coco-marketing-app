import 'package:flutter/material.dart';
import 'package:marketing_app/screens/estimate_reach_screen.dart';
import 'package:marketing_app/theme/background_scaffold.dart';

// --- Constants & Colors ---
class AppColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color brandOrange = Color(0xFFEC8B42); // New requested color
  static const Color white = Colors.white;
  static const Color divider = Color(0xFFE0E0E0);

  // Shadow color for the orange buttons
  static Color shadowColor = const Color(0xffD76F36).withOpacity(0.6);
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BoostingScreen(),
    ),
  );
}

// --- Main Screen ---
class BoostingScreen extends StatefulWidget {
  const BoostingScreen({super.key});

  @override
  State<BoostingScreen> createState() => _BoostingScreenState();
}

class _BoostingScreenState extends State<BoostingScreen> {
  // Data State
  bool _showAllPosts = false;
  String _selectedRadius = "5.7km";
  String _selectedAudience = "Cafe lovers";
  String _selectedBudget = "20\$/day";
  String _selectedDuration = "7 days";

  // Selection State (Track if user has clicked/selected)
  bool _hasSelectedRadius = false;
  bool _hasSelectedAudience = false;
  bool _hasSelectedBudget = false;
  bool _hasSelectedDuration = false;

  // Data Options
  final List<String> _postImages = [
    'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=300&q=80',
    'https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=300&q=80',
    'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=300&q=80',
    'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?auto=format&fit=crop&w=300&q=80',
    'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=300&q=80',
    'https://images.unsplash.com/photo-1507133750069-bef72f3707a9?auto=format&fit=crop&w=300&q=80',
  ];

  final List<String> _radiusOptions = [
    "1.0km",
    "3.0km",
    "5.7km",
    "10km",
    "25km",
  ];
  final List<String> _audienceOptions = [
    "Cafe lovers",
    "Students",
    "Locals",
    "Tourists",
    "Foodies",
  ];
  final List<String> _budgetOptions = [
    "10\$/day",
    "20\$/day",
    "30\$/day",
    "50\$/day",
    "100\$/day",
  ];
  final List<String> _durationOptions = [
    "1 day",
    "3 days",
    "7 days",
    "14 days",
    "30 days",
  ];

  // Logic
  void _togglePosts() {
    setState(() {
      _showAllPosts = !_showAllPosts;
    });
  }

  void _showSelectionSheet(
    String title,
    List<String> options,
    Function(String) onSelect,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SelectionBottomSheet(
          title: title,
          options: options,
          onSelect: onSelect,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        title: const ScreenHeadline(text: "Boosting"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeadline(text: "Select a post to boost"),
              const SizedBox(height: 16),

              PostGrid(images: _postImages, showAll: _showAllPosts),

              const SizedBox(height: 12),
              Center(
                child: ViewAllButton(
                  isExpanded: _showAllPosts,
                  onTap: _togglePosts,
                ),
              ),

              const SizedBox(height: 16),
              const SectionDivider(),
              const SizedBox(height: 24),

              // Selection Widgets
              RadiusSelector(
                value: _selectedRadius,
                isSelected: _hasSelectedRadius,
                onTap: () => _showSelectionSheet(
                  "Select Radius",
                  _radiusOptions,
                  (val) => setState(() {
                    _selectedRadius = val;
                    _hasSelectedRadius = true; // Mark as selected
                  }),
                ),
              ),
              const SizedBox(height: 16),

              AudienceSelector(
                value: _selectedAudience,
                isSelected: _hasSelectedAudience,
                onTap: () => _showSelectionSheet(
                  "Select Audience",
                  _audienceOptions,
                  (val) => setState(() {
                    _selectedAudience = val;
                    _hasSelectedAudience = true; // Mark as selected
                  }),
                ),
              ),
              const SizedBox(height: 16),

              BudgetSelector(
                value: _selectedBudget,
                isSelected: _hasSelectedBudget,
                onTap: () => _showSelectionSheet(
                  "Select Budget",
                  _budgetOptions,
                  (val) => setState(() {
                    _selectedBudget = val;
                    _hasSelectedBudget = true; // Mark as selected
                  }),
                ),
              ),
              const SizedBox(height: 16),

              DurationSelector(
                value: _selectedDuration,
                isSelected: _hasSelectedDuration,
                onTap: () => _showSelectionSheet(
                  "Select Duration",
                  _durationOptions,
                  (val) => setState(() {
                    _selectedDuration = val;
                    _hasSelectedDuration = true; // Mark as selected
                  }),
                ),
              ),
              const SizedBox(height: 40),

              // Bottom Action
              Align(
                alignment: Alignment.centerRight,
                child: ReviewReachButton(
                  radius: _selectedRadius,
                  audience: _selectedAudience,
                  budget: int.parse(
                    _selectedBudget.replaceAll(RegExp(r'[^0-9]'), ''),
                  ),
                  duration: int.parse(_selectedDuration.split(' ')[0]),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 1. Headlines & Text ---

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
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      ),
    );
  }
}

class SectionHeadline extends StatelessWidget {
  final String text;
  const SectionHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
        fontFamily: 'CircularStd',
      ),
    );
  }
}

// --- 2. Structure & Layout Widgets ---

class BoostingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BoostingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: AppColors.textDark,
        ),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const ScreenHeadline(text: "Boosting"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(color: AppColors.divider, thickness: 1.5);
  }
}

// --- 3. Post Selection Widgets ---

class PostGrid extends StatelessWidget {
  final List<String> images;
  final bool showAll;

  const PostGrid({super.key, required this.images, required this.showAll});

  @override
  Widget build(BuildContext context) {
    final displayCount = showAll ? images.length : 3;
    final displayImages = images.take(displayCount).toList();

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: displayImages.map((url) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = (MediaQuery.of(context).size.width - 48 - 24) / 3;
            return PostThumbnail(imageUrl: url, size: width);
          },
        );
      }).toList(),
    );
  }
}

class PostThumbnail extends StatelessWidget {
  final String imageUrl;
  final double size;

  const PostThumbnail({super.key, required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ViewAllButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;

  const ViewAllButton({
    super.key,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            isExpanded ? "View less" : "View all",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: AppColors.textDark,
            size: 24,
          ),
        ],
      ),
    );
  }
}

// --- 4. Configuration Buttons (Selectors) ---

// Base visual for the selector buttons with dynamic color logic
class _SelectorBase extends StatelessWidget {
  final String label;
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectorBase({
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Logic:
    // If selected: BG = White, Text = Orange
    // If NOT selected: BG = Orange, Text = White
    final Color bgColor = isSelected ? AppColors.white : AppColors.brandOrange;
    final Color textColor = isSelected
        ? AppColors.brandOrange
        : AppColors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(00),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              offset: const Offset(4, 4),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadiusSelector extends StatelessWidget {
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const RadiusSelector({
    super.key,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _SelectorBase(
      label: "Select radius",
      value: value,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

class AudienceSelector extends StatelessWidget {
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const AudienceSelector({
    super.key,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _SelectorBase(
      label: "Select audience",
      value: value,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

class BudgetSelector extends StatelessWidget {
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const BudgetSelector({
    super.key,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _SelectorBase(
      label: "Select budget",
      value: value,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

class DurationSelector extends StatelessWidget {
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const DurationSelector({
    super.key,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _SelectorBase(
      label: "Select duration",
      value: value,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

// --- 5. Footer & Bottom Sheet ---

class ReviewReachButton extends StatelessWidget {
  final String radius;
  final String audience;
  final int budget;
  final int duration;

  const ReviewReachButton({
    super.key,
    required this.radius,
    required this.audience,
    required this.budget,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          0xFF5CA64D,
        ), // Assuming primary color for action button
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(0),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigation logic to EstimateReachScreen
            // Using placeholder print for single file output
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EstimateReachScreen(
                  radius: radius,
                  audience: audience,
                  dailyBudget: budget,
                  durationDays: duration,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 18),
            child: Text(
              "Review reach",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectionBottomSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final Function(String) onSelect;

  const SelectionBottomSheet({
    super.key,
    required this.title,
    required this.options,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          ...options.map(
            (option) => ListTile(
              title: Text(option),
              onTap: () {
                onSelect(option);
                Navigator.pop(context);
              },
              trailing: const Icon(Icons.chevron_right),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
