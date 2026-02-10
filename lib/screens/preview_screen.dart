import 'package:flutter/material.dart';
import 'package:marketing_app/screens/publishing_screen.dart';
import 'package:marketing_app/theme/background_scaffold.dart';
import 'package:marketing_app/widgets/green_button.dart';
import 'package:marketing_app/widgets/orange_button.dart';

// --- Colors ---
class AppColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color textGrey = Color(0xFF616161);
  static const Color white = Color(0xFFFFFFFF);

  // Green Button (Next)
  static const Color greenTop = Color(0xFF73BC4D);
  static const Color greenShadow = Color(0xFF558B2F);

  // Orange Button (Professional)
  static const Color orangeTop = Color(0xFFF48E4B);
  static const Color orangeShadow = Color(0xFFBF622B);

  // Edit Button
  static const Color editBtnBg = Color(0xFFE0E0E0);
}

// Map user's requested PageColors to AppColors for the provided widget
class PageColors {
  static const Color textDark = AppColors.textDark;
}

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: PreviewScreen()),
  );
}

// --- Main Screen ---
class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        title: ScreenHeadline(text: "Preview"),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Column(
            children: [
              const MediaPreviewContainer(),
              const SizedBox(height: 18),
              NextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => PublishingScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              ProfessionalReviewButton(
                onPressed: () {
                  // Navigate to professional screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- UI Components ---

// class PreviewAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const PreviewAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenHeadline(text: "Preview");
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

class MediaPreviewContainer extends StatelessWidget {
  const MediaPreviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Image/Video Content
            Image.asset('assets/images/preview_image.png'),
            // Center Play Icon
            const CenterPlayIcon(),
            // Top Right Edit Button
            const Positioned(top: 16, right: 16, child: EditOverlayButton()),
          ],
        ),
      ),
    );
  }
}

class EditOverlayButton extends StatelessWidget {
  const EditOverlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Directed to Edit Page
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.editBtnBg.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit_outlined, size: 14, color: AppColors.textGrey),
            SizedBox(width: 4),
            Text(
              "Edit",
              style: TextStyle(
                color: AppColors.textGrey,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CenterPlayIcon extends StatelessWidget {
  const CenterPlayIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white.withOpacity(0.8), width: 2),
      ),
      child: const Icon(
        Icons.play_arrow_rounded,
        color: AppColors.white,
        size: 48,
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GreenButton(text: "Next", onPressed: onPressed);
  }
}

class ProfessionalReviewButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ProfessionalReviewButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OrangeButton(
      text: "Get Professional Review",
      onPressed: onPressed,
      icon: Icons.verified_outlined,
    );
  }
}
