import 'package:flutter/material.dart';
import 'package:marketing_app/screens/boosting_screen.dart';
import 'package:marketing_app/screens/main_screen.dart';
import 'package:marketing_app/theme/background_scaffold.dart';
import 'package:marketing_app/widgets/green_button.dart';

// --- Configuration & Colors ---

class AppColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color textGray = Color(0xFF9E9E9E);
  static const Color textOrange = Color(0xFFE67E46);
  static const Color divider = Color(0xFFE0E0E0);

  // Green styling for Buttons/Cards
  static const Color greenPrimary = Color(0xFF5CA64D);
  static const Color greenShadow = Color(0xFF437A38);
  static const Color white = Colors.white;
}

// --- Main Screen ---

class PublishingScreen extends StatelessWidget {
  const PublishingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        title: ScreenHeadline(text: "Publishing"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppColors.textDark),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FormHeader(text: "Describe your content"),
              const SizedBox(height: 24),

              // Input Fields
              const ContentInputSection(),

              const SizedBox(height: 32),

              // Platform & Boost Section
              const PublishingOptionsRow(),

              const SizedBox(height: 35),

              // Footer Buttons
              const PostNowButton(),
              const SizedBox(height: 16),
              SaveDraftButton(
                onSave: () async {
                  // Firestore logic placeholder
                  debugPrint("Saving to Firestore...");
                  // Example: await FirebaseFirestore.instance.collection('drafts').add({...});
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 1. Header Widgets ---

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
        fontWeight: FontWeight.w800,
        color: AppColors.textDark,
      ),
    );
  }
}

class FormHeader extends StatelessWidget {
  final String text;
  const FormHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        color: AppColors.textDark,
        fontWeight: FontWeight.w500, // Slightly lighter than headline
      ),
    );
  }
}

// --- 2. Input Section Logic ---

class ContentInputSection extends StatefulWidget {
  const ContentInputSection({super.key});

  @override
  State<ContentInputSection> createState() => _ContentInputSectionState();
}

class _ContentInputSectionState extends State<ContentInputSection> {
  // Controllers to manage text
  final TextEditingController _whoController = TextEditingController();
  final TextEditingController _whatController = TextEditingController();
  final TextEditingController _feelingController = TextEditingController();

  @override
  void dispose() {
    _whoController.dispose();
    _whatController.dispose();
    _feelingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InteractiveInputRow(
          question: "Who is in the post?",
          placeholder:
              "“Barista making a cappuccino and smiling at a customer.”",
          controller: _whoController,
        ),
        const SizedBox(height: 24),
        InteractiveInputRow(
          question: "What they are doing?",
          placeholder: "“Chef plating a fresh dish with a proud smile.”",
          controller: _whatController,
        ),
        const SizedBox(height: 24),
        InteractiveInputRow(
          question: "The feeling or moment at the end?",
          placeholder: "“Waiter serving drinks and laughing with guests.”",
          controller: _feelingController,
        ),
        const SizedBox(height: 12),
        const Divider(
          color: AppColors.textDark,
          thickness: 0.5,
        ), // Bottom line of last item
      ],
    );
  }
}

class InteractiveInputRow extends StatefulWidget {
  final String question;
  final String placeholder;
  final TextEditingController controller;

  const InteractiveInputRow({
    super.key,
    required this.question,
    required this.placeholder,
    required this.controller,
  });

  @override
  State<InteractiveInputRow> createState() => _InteractiveInputRowState();
}

class _InteractiveInputRowState extends State<InteractiveInputRow> {
  bool _isEditing = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && widget.controller.text.isEmpty) {
        setState(() {
          _isEditing = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _activateEdit() {
    setState(() {
      _isEditing = true;
    });
    // Slight delay to allow rebuild before requesting focus
    Future.delayed(const Duration(milliseconds: 50), () {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_isEditing && widget.controller.text.isEmpty)
          GestureDetector(
            onTap: _activateEdit,
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.question,
                  style: const TextStyle(
                    color: AppColors.textOrange,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.placeholder,
                  style: const TextStyle(
                    color: AppColors.textGray,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          )
        else
          TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            style: const TextStyle(color: AppColors.textDark, fontSize: 16),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              hintText: widget.question,
              hintStyle: TextStyle(color: AppColors.textGray.withOpacity(0.5)),
              border: InputBorder.none,
            ),
            maxLines: null,
          ),
        const SizedBox(height: 8),
        // Only show divider here if it's not the last one in the parent list,
        // but for reusable isolation, we usually put the divider below.
        // Based on screenshot, the line exists below every section.
        const Divider(color: AppColors.textDark, thickness: 0.5),
      ],
    );
  }
}

// --- 3. Platform & Boost Layout ---

class PublishingOptionsRow extends StatelessWidget {
  const PublishingOptionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 4, child: PlatformSelectionList()),
        SizedBox(width: 46),
        Expanded(flex: 5, child: BoostCard()),
      ],
    );
  }
}

// --- Updated Platform Selection List (Stateful) ---

class PlatformSelectionList extends StatefulWidget {
  const PlatformSelectionList({super.key});

  @override
  State<PlatformSelectionList> createState() => _PlatformSelectionListState();
}

class _PlatformSelectionListState extends State<PlatformSelectionList> {
  // Track selection state for each platform
  // Initialized to 'false' so they start as grey boxes,
  // allowing you to test the "turn green" interaction immediately.
  final Map<String, bool> _selectedPlatforms = {
    "Tiktok": false,
    "Facebook": false,
    "Instagram": false,
  };

  void _togglePlatform(String key) {
    setState(() {
      _selectedPlatforms[key] = !(_selectedPlatforms[key] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Post to:",
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        _buildPlatformItem("Tiktok"),
        const SizedBox(height: 8),
        _buildPlatformItem("Facebook"),
        const SizedBox(height: 8),
        _buildPlatformItem("Instagram"),
      ],
    );
  }

  Widget _buildPlatformItem(String name) {
    final isChecked = _selectedPlatforms[name] ?? false;

    return GestureDetector(
      // Allow clicking the text OR the box to toggle
      onTap: () => _togglePlatform(name),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF4D4D4D),
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          PlatformCheckbox(
            isChecked: isChecked,
            onTap: () => _togglePlatform(name),
          ),
        ],
      ),
    );
  }
}

// --- Updated Checkbox Widget ---

class PlatformCheckbox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onTap;

  const PlatformCheckbox({
    super.key,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          // Grey border when unchecked, Green when checked
          border: Border.all(
            color: isChecked ? AppColors.greenPrimary : AppColors.textGray,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          // Only show icon if checked
          child: isChecked
              ? const Icon(Icons.check, size: 14, color: AppColors.greenPrimary)
              : null,
        ),
      ),
    );
  }
}

class BoostCard extends StatelessWidget {
  const BoostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Boosting Screen
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const BoostingScreen()));
      },
      child: Stack(
        children: [
          // 3D Shadow effect
          Positioned(
            bottom: 0,
            right: 0,
            left: 4,
            top: 4,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greenShadow.withAlpha(150),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          // Main Card
          Container(
            margin: const EdgeInsets.only(bottom: 4, right: 4),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.greenPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.rocket_launch_outlined,
                    color: AppColors.textOrange,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  "Boost",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Reach more local customers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, // Slightly transparent white
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- 4. Footer Buttons ---

class PostNowButton extends StatelessWidget {
  const PostNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GreenButton(
      text: "Post now",
      onPressed: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Post Published!")));
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false,
        );
      },
    );
  }
}

class SaveDraftButton extends StatelessWidget {
  final VoidCallback onSave;

  const SaveDraftButton({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onSave,
        child: const Text(
          "Save draft",
          style: TextStyle(
            color: AppColors.textOrange,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
