import 'package:flutter/material.dart';
import 'package:marketing_app/screens/preview_screen.dart';

// --- App Colors ---
class AppColors {
  static const Color headerGreen = Color(0xFF1D2B1E);
  static const Color footerBrown = Color(0xFF6E3114);
  static const Color captureRed = Color(0xFFFF6E6E);
  static const Color gridLine = Color(0x33FFFFFF);
  static const Color backgroundBlack = Color(0xFF121212);
}

class CameraScreen extends StatefulWidget {
  final List<String> steps;

  const CameraScreen({super.key, required this.steps});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isCaptured = false;
  // Start at 1 (skipping intro text at index 0)
  int _currentStepIndex = 1;

  int get _totalSteps => widget.steps.length - 1;

  // Logic for the Back Button (Top Left or System Back)
  void _handleBack() {
    if (_currentStepIndex > 1) {
      setState(() {
        _currentStepIndex--;
        _isCaptured = false; // Reset view when going back
      });
    } else {
      // If at 1/3, go back to the previous screen (Main Screen)
      Navigator.of(context).pop();
    }
  }

  void _onCapture() {
    setState(() {
      _isCaptured = true;
    });
  }

  void _onRetake() {
    // Stays on the same instruction, just resets the view
    setState(() {
      _isCaptured = false;
    });
  }

  void _onNext() {
    if (_currentStepIndex < _totalSteps) {
      // Move to next instruction
      setState(() {
        _currentStepIndex++;
        _isCaptured = false;
      });
    } else {
      // At 3/3, move to next screen logic
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const PreviewScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // PopScope allows us to control the back button behavior
    return PopScope(
      canPop: false, // We handle the popping manually
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBack();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundBlack,
        body: Column(
          children: [
            // 1. TOP SECTION: Back button and Dynamic Instruction
            CameraHeader(
              currentStep: _currentStepIndex,
              totalSteps: _totalSteps,
              instruction: widget.steps[_currentStepIndex],
              onBack: _handleBack,
            ),

            // 2. MIDDLE SECTION: Camera Viewport (The Grey Box)
            Expanded(
              child: CameraViewport(
                isCaptured: _isCaptured,
                onCapture: _onCapture,
              ),
            ),

            // 3. BOTTOM SECTION: Retake and Next Buttons
            CameraFooter(
              isCaptured: _isCaptured,
              onRetake: _onRetake,
              onNext: _onNext,
            ),
          ],
        ),
      ),
    );
  }
}

// --- UI COMPONENTS ---

class CameraHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String instruction;
  final VoidCallback onBack;

  const CameraHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.instruction,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 24, left: 10, right: 20),
      color: AppColors.headerGreen,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: onBack,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    instruction.replaceAll('\n\n', '').trim(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ), // Balances the back button for centering
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class CameraViewport extends StatelessWidget {
  final bool isCaptured;
  final VoidCallback onCapture;

  const CameraViewport({
    super.key,
    required this.isCaptured,
    required this.onCapture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.camera_alt, color: Colors.white10, size: 80),
          if (!isCaptured) const CameraGridOverlay(),
          if (!isCaptured)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: CaptureCircle(onTap: onCapture),
              ),
            ),
          if (isCaptured)
            Container(
              color: Colors.white10,
              child: const Center(
                child: Text(
                  "PREVIEW MODE",
                  style: TextStyle(color: Colors.white38),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CameraFooter extends StatelessWidget {
  final bool isCaptured;
  final VoidCallback onRetake;
  final VoidCallback onNext;

  const CameraFooter({
    super.key,
    required this.isCaptured,
    required this.onRetake,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      color: AppColors.footerBrown,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Retake Button
          TextButton(
            onPressed: isCaptured
                ? onRetake
                : null, // Disabled until photo is taken
            child: Text(
              "Retake",
              style: TextStyle(
                color: isCaptured ? Colors.white : Colors.white24,
                fontSize: 18,
              ),
            ),
          ),
          // Next Button
          ElevatedButton(
            onPressed: () {
              onNext(); // For now, just pop back to the previous screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.footerBrown,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            child: const Text(
              "Next",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class CaptureCircle extends StatelessWidget {
  final VoidCallback onTap;
  const CaptureCircle({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.captureRed,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class CameraGridOverlay extends StatelessWidget {
  const CameraGridOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(width: 1, color: AppColors.gridLine),
            Container(width: 1, color: AppColors.gridLine),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height: 1, color: AppColors.gridLine),
            Container(height: 1, color: AppColors.gridLine),
          ],
        ),
      ],
    );
  }
}
